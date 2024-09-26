<template>
  <div class="wrapper">
    <!-- 代理收益设置   -->
    <el-tabs v-model="active" type="border-card">
      <el-tab-pane label="用户奖条件设置" name="first">
        <UserSetting/>
      </el-tab-pane>
      <el-tab-pane label="代理奖条件设置" name="second">
        <FundSetting/>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import UserSetting from './components/user-setting.vue'
import FundSetting from './components/fund-setting.vue'

export default {
  components: {
    UserSetting,
    FundSetting
  },
  props: {},
  data() {
    return {
      active: 'first'
    }
  }
}
</script>
