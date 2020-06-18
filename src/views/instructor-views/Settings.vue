<script lang="ts">
import {
  Component, Vue,
} from "vue-property-decorator";
import intersection from "lodash-es/intersection";

import { settings_store, app_state_store } from "@/store";
import AddCategoryModal from "@/components/AddCategoryModal.vue";
import EditCategoryModal from "@/components/EditCategoryModal.vue";
import { newGradeSubcategory } from "@/common";
import { GradeCategory } from "../../store/models";

// @Component({ name: "AddNewUser" })
@Component({
  components: {
    AddCategoryModal,
    EditCategoryModal,
  },
})
export default class Settings extends Vue {
  private selected_subcategory = newGradeSubcategory();
  // private categories: GradeCategory[] = [];
  // private subcategories: GradeSubcategory[] = [];

  private fields = [
    { key: "grade_name" },
    { key: "subcategory_description" },
  ]
  private get category_names() {
    return intersection(this.categories.map((_cat) => _cat.category));
  }

  private get categories() {
    return settings_store.grade_categories;
  }

  private get subcategories() {
    return settings_store.grade_subcategories
      .filter((_cat: GradeSubcategory) => _cat.course_id === app_state_store.current_course_id);
  }

  private getSubcategory(cat_name: string) {
    const cat = this.categories.find((_cat: GradeCategory) => _cat.category === cat_name);
    return cat ? this.subcategories
      .filter((_cat) => _cat.course_grade_category_id === cat.course_grade_category_id) : newGradeSubcategory();
  }

  private getCategoryDescription(cat_name: string) {
    const cat = this.categories.find((_cat: GradeCategory) => _cat.category === cat_name);
    return cat ? cat.category_description : "";
  }

  private onRowSelected(items) {
    this.selected_subcategory = items[0] as GradeSubcategory;
    console.log(this.selected_subcategory); // eslint-disable-line no-console
  }

  // private beforeMount() {
  //   this.categories = Array.from(settings_store.grade_categories);
  //   this.subcategories = Array.from(settings_store.grade_subcategories);
  //
  //   this.$store.subscribe((mutation) => {
  //     if (mutation.type === "SettingsModule/newCategory" || mutation.type === "SettingsModule/setGradeCategories") {
  //       this.categories = Array.from(settings_store.grade_categories);
  //     }
  //
  //     if (["SettingsModule/newSubcategory", "SettingsModule/setGradeSubcategories"].includes(mutation.type)) {
  //       this.subcategories = Array.from(settings_store.grade_subcategories);
  //     }
  //   });
  // }
}
</script>

<template>
  <div>
    <b-container>
      <b-row>
        <b-col cols="9">
          <b-card no-body>
            <b-tabs card>
              <b-tab v-for="name in category_names" :title="name" :key="name">
                <h5>{{getCategoryDescription(name)}}</h5>
                <b-table
                  :items="getSubcategory(name)"
                  :fields="fields"
                  selectable
                  selectMode="single"
                  @row-selected="onRowSelected"
                  >
                  <template v-slot:cell(grade_name)="data">
                     {{ name }}{{data.item.subcategory}}
                   </template>
                </b-table>
              </b-tab>
            </b-tabs>
          </b-card>
        </b-col>
        <b-col cols="3">
          <b-card title="Options">
            <b-btn v-b-modal.add-category-modal size="sm" variant="primary">Add New Category</b-btn>
          </b-card>
          <b-card title="Edit Table">
            <b-btn v-b-modal.edit-category-modal size="sm" variant="primary">Edit Selected Rows</b-btn>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
    <add-category-modal />
    <edit-category-modal :subcategory="selected_subcategory"/>
  </div>
</template>
