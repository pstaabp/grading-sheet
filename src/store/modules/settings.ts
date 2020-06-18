import {
  Module, VuexModule, Mutation, Action,
} from "vuex-module-decorators";

import axios from "axios";

// without the next line, it won't compile.  Even though there is a dependency cycle, this works.
// eslint-disable-next-line
import { app_state_store } from "@/store";

import { GradeCategory, GradeSubcategory } from "../models";

interface SettingsState {
  grade_categories: GradeCategory[];
  grade_subcategories: GradeSubcategory[];
}

@Module({ name: "SettingsModule", namespaced: true })
export default class SettingsModule extends VuexModule {
  public settings_state: SettingsState = {
    grade_categories: [],
    grade_subcategories: [],
  }

  public get grade_categories(): GradeCategory[] {
    return this.settings_state.grade_categories;
  }

  public get grade_subcategories(): GradeSubcategory[] {
    return this.settings_state.grade_subcategories;
  }

  // public get grade_subcategories():

  @Action
  public async fetchGradeCategories(): Promise<GradeCategory[]> {
    const response = await axios.get(`${app_state_store.api_prefix}/grades/categories`);
    this.setGradeCategories(response.data as GradeCategory[]);
    return response.data as GradeCategory[];
  }

  // fetch all grade subcategories associated with a course
  @Action async fetchGradeSubcategories(): Promise<GradeSubcategory[]> {
    const response = await axios.get(`${app_state_store.api_prefix}/grades/subcategories`);
    this.setGradeSubcategories(response.data as GradeSubcategory[]);
    return response.data as GradeSubcategory[];
  }

  @Action
  public async addCategory(category: GradeCategory): Promise<GradeCategory> {
    const response = await axios.post(`${app_state_store.api_prefix}/grades/categories`, { category });
    this.newCategory(response.data as GradeCategory);
    return response.data as GradeCategory;
  }

  @Action async addSubcategory(subcategory: GradeSubcategory): Promise<GradeSubcategory> {
    const response = await axios.post(`${app_state_store.api_prefix}/grades/subcategories`, { subcategory });
    this.newSubcategory(response.data as GradeSubcategory);
    return response.data as GradeSubcategory;
  }

  @Action async updateSubcategory(subcategory: GradeSubcategory): Promise<GradeSubcategory> {
    const response = await axios.put(`${app_state_store.api_prefix}/grades/subcategories`, { subcategory });
    this.setSubcategory(response.data as GradeSubcategory);
    return response.data as GradeSubcategory;
  }

  @Mutation
  private setGradeCategories(_categories: GradeCategory[]): void {
    this.settings_state.grade_categories = _categories;
  }

  @Mutation
  private setGradeSubcategories(_subcategories: GradeSubcategory[]): void {
    this.settings_state.grade_subcategories = _subcategories;
  }

  @Mutation
  private setSubcategory(_subcategory: GradeSubcategory): void {
    const index = this.settings_state.grade_subcategories
      .findIndex(
        (_sub: GradeSubcategory) => (
          _sub.course_grade_subcategory_id === _subcategory.course_grade_subcategory_id
        ),
      );
    if (index > -1) {
      this.settings_state.grade_subcategories[index] = _subcategory;
    }
  }

  @Mutation
  private newCategory(_category: GradeCategory) {
    const cat = this.settings_state.grade_categories
      .find((_cat: GradeCategory) => _cat.category === _category.category);
    if (typeof cat === "undefined") {
      this.settings_state.grade_categories.push(_category);
    }
  }

  @Mutation
  private newSubcategory(_sub: GradeSubcategory) {
    const sub = this.settings_state.grade_subcategories
      .find((_cat: GradeSubcategory) => _cat.subcategory === _sub.subcategory);
    console.log(sub); // eslint-disable-line no-console
    if (typeof sub !== "undefined") {
      this.settings_state.grade_subcategories.push(_sub);
    }
  }
}
