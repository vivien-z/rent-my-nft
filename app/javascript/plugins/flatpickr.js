import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"
import 'flatpickr/dist/themes/airbnb.css'

const initFlatpickr = () => {
  flatpickr("#start_date", {
    "plugins": [new rangePlugin({ input: "#end_date"})]
  });
}

export { initFlatpickr };