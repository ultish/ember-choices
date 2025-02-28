import Route from 'ember-route-template';

import Hello from 'ember-choices/components/hello';

export default Route(
  <template>
    <h2 id="title">Welcome to Ember</h2>

    {{outlet}}

    <Hello />
  </template>,
);
