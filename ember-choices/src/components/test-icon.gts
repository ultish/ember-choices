import Component from '@glimmer/component';

import PhHeart from 'ember-phosphor-icons/components/ph-heart';

interface Signature {
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}

export default class TestIcon extends Component<Signature> {
  get test() {
    return 'test';
  }
  <template><PhHeart /></template>
}
