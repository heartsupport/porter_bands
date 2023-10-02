import { ajax } from "discourse/lib/ajax";
export default Ember.Controller.extend({
  loadingBands: true,
  actions: {
    createBand() {
      this.transitionToRoute('adminPlugins.bands.new');
    },
    deleteBand(band) {
      // make ajax call and route to index
      // make ajax post request
      ajax(`/admin/plugins/porter/bands/${band.id}`, {
        type: 'DELETE',
        contentType: 'application/json',
        headers: {
          'X-CSRF-Token': Discourse.get('csrfToken'),
          'Content-Type': 'application/json'
        },
        data: JSON.stringify({ band_id: band.id })
      }).then((response) => {
        // refresh current route
        this.send('refreshRoute');
      }).catch((error) => {
        console.log(error);
      });
    }
  }
});
