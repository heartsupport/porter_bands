import { ajax } from "discourse/lib/ajax";
import DiscourseRoute from "discourse/routes/discourse";
import EmberObject from "@ember/object";

export default DiscourseRoute.extend({
  model() {
    return ajax("/admin/plugins/bands.json").then((data) => {
      console.log(data);
      return data.bands.map((band) => EmberObject.create(band));
    });
  }
});
