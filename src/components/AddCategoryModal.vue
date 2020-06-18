<script lang="ts">
import {
  Component, Vue,
} from "vue-property-decorator";

import intersection from "lodash-es/intersection";

// import { BIconPersonCircle } from "bootstrap-vue";
import { settings_store } from "@/store";
import { newGradeCategory, newGradeSubcategory } from "@/common";
import { GradeCategory } from "../store/models";

@Component({})
export default class AddCategoryModal extends Vue {
  private selected_category = "";
  private category = newGradeCategory();
  private subcategory = newGradeSubcategory();

  private get category_options() {
    return intersection(settings_store.grade_categories // intersection returns the unique elements.
      .map((_cat:GradeCategory) => _cat.category));
  }

  private async saveCategory() {
    console.log(this.selected_category); // eslint-disable-line no-console
    if (this.selected_category === "__NEW__") {
      const cat = await settings_store.addCategory(this.category);
      console.log(cat); // eslint-disable-line no-console
      this.subcategory.course_grade_category_id = cat.course_grade_category_id;
    } else {
      const cat = settings_store.grade_categories.find((_cat) => _cat.category === this.selected_category);
      this.subcategory.course_grade_category_id = cat.course_grade_category_id;
    }
    await settings_store.addSubcategory(this.subcategory);
  }
}
</script>

<template>
  <b-modal
    size="lg"
    id="add-category-modal"
    title="Add a New Category"
    @ok="saveCategory"
    >
    <b-form-group label="Category" label-cols="3">
      <b-select v-model="selected_category" :options="category_options">
        <template v-slot:first>
          <b-form-select-option :value="''" disabled>Select a Category...</b-form-select-option>
        </template>
        <b-form-select-option value="__NEW__">New Grade Category</b-form-select-option>
      </b-select>
    </b-form-group>
    <b-form-group  v-if="selected_category === '__NEW__'" label="New Category" label-cols="3">
      <b-input v-model="category.category" />
    </b-form-group>
    <b-form-group  v-if="selected_category === '__NEW__'" label="New Description" label-cols="3">
      <b-input v-model="category.category_description" />
    </b-form-group>

    <b-form-group label="Subcategory" label-cols="3">
      <b-input v-model="subcategory.subcategory" />
    </b-form-group>
    <b-form-group label="Description">
      <b-input v-model="subcategory.subcategory_description" />
    </b-form-group>
  </b-modal>
</template>
