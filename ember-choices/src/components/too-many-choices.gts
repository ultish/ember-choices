import Component from '@glimmer/component';
import Choices, { type EventChoice, type InputChoice } from 'choices.js';
import { modifier } from 'ember-modifier';
import { runTask } from 'ember-lifeline';

// it even works for things that are in the node_modules
// import 'choices.js/public/assets/styles/choices.css';
// embroider is based on "pull" mechanics you must import things you need. you can just import css like this and embroider will package it for you. as long as your rollup.config.mjs defines addon.keepAssets()
// import '../styles/too-many-choices.css';
import './too-many-choices.css';

import PhHeart from 'ember-phosphor-icons/components/ph-heart';

interface X {
  group?: string | undefined | null;
}

interface Choice<T> {
  choice: T;
  selected: boolean;
}

interface Signature<T> {
  Args: {
    choices: Choice<T>[];
    items?: InputChoice[];
    onAdd?: (detail: EventChoice) => void;
    onRemove?: (detail: EventChoice) => void;
    outerClass?: string;
    placeholder?: string;
  };
  Blocks: {
    default: [Choice<T>];
  };
  Element: HTMLSelectElement;
}

export default class TooManyChoices<T extends X> extends Component<
  Signature<T>
> {
  CHOICES_CLASS_NAMES = {
    containerOuter: ['choices', 'too-many-choices'],
    containerInner: ['choices__inner', 'custom_choices__inner'], // custom class
    input: ['choices__input'],
    inputCloned: ['choices__input--cloned'],
    list: ['choices__list', 'custom_choices__list'], // custom class, background
    listItems: ['choices__list--multiple'],
    listSingle: ['choices__list--single'],
    listDropdown: ['choices__list--dropdown'],
    item: ['choices__item', 'custom_item'],
    itemSelectable: ['choices__item--selectable'],
    itemDisabled: ['choices__item--disabled'],
    itemChoice: ['choices__item--choice'],
    description: ['choices__description'],
    placeholder: ['choices__placeholder'],
    group: ['choices__group'],
    groupHeading: ['choices__heading'],
    button: ['choices__button'],
    activeState: ['is-active'],
    focusState: ['is-focused'],
    openState: ['is-open'],
    disabledState: ['is-disabled'],
    highlightedState: ['is-highlighted'],
    selectedState: ['is-selected'],
    flippedState: ['is-flipped'],
    loadingState: ['is-loading'],
    notice: ['choices__notice'],
    addChoice: ['choices__item--selectable', 'add-choice'],
    noResults: ['has-no-results'],
    noChoices: ['has-no-choices'],
  };

  instance: Choices | undefined;
  ele: HTMLSelectElement | undefined;

  makeChoices = modifier((e: HTMLSelectElement) => {
    if (this.instance) {
      return;
    }

    this.ele = e;

    const outerClass = {
      containerOuter: [
        ...(this.args.outerClass?.split(' ') ?? []),
        ...this.CHOICES_CLASS_NAMES.containerOuter,
      ],
    };

    this.instance = new Choices(e, {
      // choices: this.choices,
      items: this.args.items,
      removeItemButton: true,
      classNames: Object.assign(this.CHOICES_CLASS_NAMES, outerClass),
    });

    const addListener = (p: CustomEvent<EventChoice>) => {
      const { detail } = p;
      this.args.onAdd?.(detail);
    };
    const removeListener = (p: CustomEvent<EventChoice>) => {
      const { detail } = p;
      this.args.onRemove?.(detail);
    };

    this.ele?.addEventListener('addItem', addListener as EventListener);
    this.ele?.addEventListener('removeItem', removeListener as EventListener);

    return () => {
      this.ele?.removeEventListener('addItem', addListener as EventListener);
      this.ele?.removeEventListener(
        'removeItem',
        removeListener as EventListener,
      );
    };
  });

  get choices() {
    const groups = this.args.choices.reduce(
      (acc, c) => {
        const { choice } = c;
        // Check if group already exists
        const group = choice.group ?? 'Ungrouped';
        if (!acc[group]) {
          acc[group] = { name: group, choices: [] };
        }
        // Push the choice to the corresponding group
        acc[group].choices.push(c);

        return acc;
      },
      {} as Record<string, { name: string; choices: Choice<T>[] }>,
    );

    runTask(this, () => this.instance?.refresh());
    const groupedChoices = Object.values(groups);

    return groupedChoices;
  }

  <template>
    <style></style>
    <PhHeart />

    <select
      {{this.makeChoices}}
      data-placeholder={{@placeholder}}
      aria-label="select choices"
    >
      {{#each this.choices as |group|}}
        <optgroup label="{{group.name}}">
          {{#each group.choices as |c|}}
            {{yield c}}
          {{/each}}
        </optgroup>
      {{/each}}
    </select>
  </template>
}
