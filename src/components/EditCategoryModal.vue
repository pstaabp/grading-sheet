<script lang="ts">
import {
  Component, Vue, Prop, Watch,
} from "vue-property-decorator";

// import { BIconPersonCircle } from "bootstrap-vue";
import { settings_store } from "@/store";
import { newGradeSubcategory } from "@/common";
// import { GradeSubcategory } from "../store/models";

@Component({})
export default class EditCategoryModal extends Vue {
  @Prop() private subcategory; // !: GradeSubcategory;
  private editable_subcategory = newGradeSubcategory();

  @Watch("subcategory")
  private subcategoryChanged() {
    Object.assign(this.editable_subcategory, this.subcategory);
  }

  private async saveCategory() {
    console.log(this.editable_subcategory); // eslint-disable-line no-console
    await settings_store.updateSubcategory(this.editable_subcategory);
  }
}
</script>

<template>
  <b-modal
    size="lg"
    id="edit-category-modal"
    title="Edit a Category"
    @ok="saveCategory"
    >
    <b-form-group label="Subcategory" label-cols="3">
      <b-input v-model="editable_subcategory.subcategory" disabled/>
    </b-form-group>
    <b-form-group label="Description">
      <b-input v-model="editable_subcategory.subcategory_description" />
    </b-form-group>
  </b-modal>
</template>
