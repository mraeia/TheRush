import React from "react";

import ArrowUpIcon from "../images/sorting-arrow-up.svg";
import ArrowDownIcon from "../images/sorting-arrow-down.svg";
import { SORTING_OPTIONS } from "../config/table";
import styles from "./Table.module.scss";

export default (props) => {
  const { columns, records, sort, sortBy, sortOrder } = props;

  return (
    <table className={styles.tableContainer}>
      <colgroup>
        {columns.map((column, index) => (
          <col
            key={index}
            span="1"
            className={column.sortable ? styles.sortableCol : ""}
          />
        ))}
      </colgroup>
      <thead className={styles.header}>
        <tr>
          {columns.map((column) => {
            return (
              <th
                onClick={() => sort(column.key)}
                className={styles.columnName}
                key={column.key}
              >
                <div className={styles.container}>
                  <div
                    className={`${styles.text} ${
                      column.sortable ? styles.sortable : ""
                    }`}
                  >
                    {column.label}
                  </div>
                  {column.sortable && (
                    <div className={styles.icon}>
                      <img
                        className={
                          sortBy === column.key &&
                          sortOrder === SORTING_OPTIONS.DESCENDING
                            ? styles.show
                            : ""
                        }
                        src={ArrowDownIcon}
                      />
                      <img
                        className={
                          sortBy === column.key &&
                          sortOrder === SORTING_OPTIONS.ASCENDING
                            ? styles.show
                            : ""
                        }
                        src={ArrowUpIcon}
                      />
                    </div>
                  )}
                </div>
              </th>
            );
          })}
        </tr>
      </thead>
      <tbody className={styles.body}>
        {records.map((row, index) => (
          <tr key={index}>
            {row.map((cell, index) => (
              <td key={index}>{cell}</td>
            ))}
          </tr>
        ))}
      </tbody>
    </table>
  );
};
