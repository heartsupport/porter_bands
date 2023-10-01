import { ajax } from "discourse/lib/ajax";

export default Ember.Controller.extend({
  bandName: '',
  path: '',
  groupId: '',
  categoryId: '',
  actions: {
    saveBand() {
      const bandName = this.get('bandName');
      const groupId = this.get('groupId');
      const categoryId = this.get('categoryId');
      const path = this.get('path');
      const data = {
        name: bandName,
        group_id: groupId,
        category_id: categoryId,
        path: path
      };

      console.log(data);

      // make ajax post request
      ajax('/admin/plugins/bands', {
        type: 'POST',
        data: JSON.stringify(data),
        contentType: 'application/json',
        headers: {
          'X-CSRF-Token': Discourse.get('csrfToken'),
          'Content-Type': 'application/json'
        }
      }).then((response) => {

        console.log('success');
        // reset the variables
        clearForm(this);

        // redirect to index
        this.transitionToRoute('adminPlugins.bands.index');

      })
        .catch((error) => {
          console.log(error);
        });

    }
  }
});

const clearForm = (form) => {
  form.set('bandName', '');
  form.set('path', '');
  form.set('groupId', '');
  form.set('categoryId', '');
};
