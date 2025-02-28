import Component from '@glimmer/component';

// import styles from './hello.css';

export default class HelloComponent extends Component {
  get message() {
    return 'Hello, Ember!';
  }

  <template>
    <p>
      {{this.message}}
    </p>
  </template>
}
