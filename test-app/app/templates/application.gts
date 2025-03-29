import Route from 'ember-route-template';
import Component from '@glimmer/component';

import TooManyChoices from 'ember-choices/components/too-many-choices';

import PhHeart from 'ember-phosphor-icons/components/ph-heart';

class MyRouteComponent extends Component {
  get choices() {
    return [
      {
        selected: false,
        chargeCode: {
          id: '1',
          name: 'Charge Code 1',
        },
      },
    ];
  }
  <template>
    <h2 id="title">Welcome to Ember</h2>

    {{outlet}}

    <PhHeart />

    <TooManyChoices @choices={{this.choices}} as |cc|>
      <option selected={{if cc.selected "selected"}} value={{cc.chargeCode.id}}>
        {{cc.chargeCode.name}}
      </option>
    </TooManyChoices>
  </template>
}

export default Route(MyRouteComponent);
