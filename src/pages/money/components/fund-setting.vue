<template>
  <div>
    <div class="table">
      <el-table
        :data="list"
        style="width: 100%">
        <el-table-column
          prop="frRatio"
          label="比例">
          <template slot-scope="scope">
            <span>{{ scope.row.frRatio }}%</span>
          </template>
        </el-table-column>
        <el-table-column
          fixed="right"
          width="60px"
          label="操作">
          <template slot-scope="scope">
            <el-button type="text" title="修改" size="small" @click="toEdit(scope.row)">修改</el-button>
          </template>
        </el-table-column>
      </el-table>
      <SettingDialog :info='detail' :getDate="getList" ref="detailDialog"></SettingDialog>
    </div>
  </div>
</template>

<script>
import * as api from '@/axios/api'
import SettingDialog from './setting-dialog.vue'

export default {
  components: {
    SettingDialog
  },
  data() {
    return {
      list: [],
      detail: {}
    }
  },
  mounted() {
    this.getList()
  },
  methods: {
    async getList() {
      let opts = {
        frType: 1
      }
      let data = await api.settings2(opts)
      if (data.status === 0) {
        this.list = data.data
      } else {
        this.$message.error(data.msg)
      }
    },
    toEdit(val) {
      this.detail = val
      this.$refs.detailDialog.dialogVisible = true
    }
  }
}
</script>
