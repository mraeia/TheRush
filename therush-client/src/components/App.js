import React, { useEffect, useState } from "react";
import ReactPaginate from "react-paginate";
import download from "downloadjs";

import useDebouncer from "../hooks/useDebouncer";
import Table from "./Table";
import { PER_PAGE_OPTIONS, SORTING_OPTIONS } from "../config/table";
import { BASE_SEARCH_URL, PARAMS } from "../config/search";
import axiosClient from "../lib/axiosClient";

import styles from "./App.module.scss";

const App = (props) => {
  const { history } = props;

  const queryParams = new URLSearchParams(props.location.search);

  const [records, setRecords] = useState(null);
  const [name, setName] = useState(
    queryParams.has(PARAMS.NAME) ? queryParams.get(PARAMS.NAME) : ""
  );
  const [sortBy, setSortBy] = useState(queryParams.get(PARAMS.SORT_BY));
  const [sortOrder, setSortOrder] = useState(
    queryParams.get(PARAMS.SORT_ORDER)
  );
  const [page, setPage] = useState(
    queryParams.has(PARAMS.PAGE) ? queryParams.get(PARAMS.PAGE) : 1
  );
  const [columns, setColumns] = useState(null);
  const [perPage, setPerPage] = useState(
    queryParams.has(PARAMS.PAGE)
      ? queryParams.get(PARAMS.PER_PAGE)
      : PER_PAGE_OPTIONS[0]
  );
  const [totalPages, setTotalPages] = useState(null);
  const [loading, setLoading] = useState(true);

  const debouncedName = useDebouncer(name);

  const sort = (columnKey) => {
    if (sortBy !== columnKey) {
      setSortBy(columnKey);
      setSortOrder(SORTING_OPTIONS.ASCENDING);
    } else {
      if (sortOrder === SORTING_OPTIONS.ASCENDING) {
        setSortOrder(SORTING_OPTIONS.DESCENDING);
      } else {
        setSortBy(null);
        setSortOrder(null);
      }
    }
    setPage(1);
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const baseUrl = BASE_SEARCH_URL;
        let search = `?${PARAMS.PAGE}=${page}&${PARAMS.PER_PAGE}=${perPage}`;

        if (sortBy && sortOrder) {
          search += `&${PARAMS.SORT_BY}=${sortBy}&${PARAMS.SORT_ORDER}=${sortOrder}`;
        }
        if (debouncedName) {
          search += `&${PARAMS.NAME}=${debouncedName}`;
        }

        history.replace({ search });
        const response = await axiosClient.get(baseUrl + search);

        setRecords(response.data.records);
        setColumns(response.data.columns);
        setTotalPages(response.data.total_pages);
        setLoading(false);
      } catch (err) {
        console.error(err);
      }
    };

    fetchData();
  }, [debouncedName, perPage, page, sortBy, sortOrder, history]);

  const onPageChange = (e) => {
    setPage(e.selected + 1);
  };

  const onNameChange = (e) => {
    setPage(1);
    setName(e.target.value);
  };

  const onPerPageChange = (e) => {
    setPerPage(e.target.value);
    setPage(1);
  };

  const downloadCSV = async () => {
    const regex = new RegExp(`${PARAMS.PAGE}=\\d*&${PARAMS.PER_PAGE}=\\d*`);
    const search = history.location.search.replace(regex, "");

    const response = await axiosClient.get(`/rush_stats/download/csv${search}`);

    download(response.data, `RushStat_${Date.now()}.csv`);
  };

  return (
    <div className={styles.container}>
      <div className={styles.header}>NFL Rushing</div>
      {columns && records && (
        <div className={styles.body}>
          <div className={styles.filtersDownloadContainer}>
            <div className={styles.nameInput}>
              <input
                type="text"
                value={name}
                onChange={onNameChange}
                placeholder="Filter by name"
              />
            </div>
            <div className={styles.perPageSelect}>
              <select onChange={onPerPageChange}>
                {PER_PAGE_OPTIONS.map((option) => (
                  <option key={option} value={option}>
                    {option}
                  </option>
                ))}
              </select>
            </div>
            <div className={styles.download}>
              <button onClick={downloadCSV}>Download CSV</button>
            </div>
          </div>
          <div className={styles.paginationContainer}>
            <ReactPaginate
              pageCount={totalPages}
              pageRangeDisplayed={5}
              marginPagesDisplayed={2}
              containerClassName={styles.pagination}
              pageClassName={styles.page}
              previousClassName={styles.previous}
              nextClassName={styles.next}
              onPageChange={onPageChange}
              breakClassName={styles.break}
              activeClassName={styles.active}
              forcePage={page - 1}
              pageLinkClassName={styles.anchor}
              previousLinkClassName={styles.anchor}
              nextLinkClassName={styles.anchor}
              breakLinkClassName={styles.anchor}
            />
          </div>
          {loading ? (
            <div className={styles.loader} />
          ) : (
            <div className={styles.table}>
              <Table
                columns={columns}
                records={records}
                sort={sort}
                sortBy={sortBy}
                sortOrder={sortOrder}
              />
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default App;
