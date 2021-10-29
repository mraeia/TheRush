import { useState, useEffect } from "react";

export default (value) => {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const timeoutId = setTimeout(() => {
      setDebouncedValue(value);
    }, 500);

    return () => {
      clearTimeout(timeoutId);
    };
  }, [value]);

  return debouncedValue;
};
