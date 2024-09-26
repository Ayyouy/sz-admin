<template>
  <div>
    <!--  基金列表  -->
    <el-card class="box-card">
      <strong style="font-size: 18px;font-weight: bold;margin-bottom: 20px">基金列表</strong>
      <div class="table">
        <div class="table-top-btn">
          <el-row class="text-right">
            <el-button type="text" size="small" @click="showAddFundDialog">
              <i class="iconfont icon-add"></i>添加基金
            </el-button>
          </el-row>
        </div>
        <el-table
          v-loading="loading"
          :data="list.list"
          style="width: 100%">
          <el-table-column
            prop="name"
            label="标题">
            <template slot-scope="scope">
              <p>
                {{ scope.row.name }}
              </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="totalNum"
            label="发行总分数">
            <template slot-scope="scope">
              <p> {{ scope.row.totalNum }}</p>
            </template>
          </el-table-column>
          <el-table-column
            prop="perValue"
            label="每份净值">
            <template slot-scope="scope">
              <p> {{ scope.row.perValue }}</p>
            </template>
          </el-table-column>
          <el-table-column
            prop="maxNum"
            label="每人限购">
            <template slot-scope="scope">
              <p class="red">{{ scope.row.maxNum }}份</p>
            </template>
          </el-table-column>
          <el-table-column
            prop="oneIncome"
            label="一期收益率">
            <template slot-scope="scope">
              <p>{{ scope.row.oneIncome }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="twoIncome"
            label="二期收益率">
            <template slot-scope="scope">
              <p>{{ scope.row.twoIncome }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="threeIncome"
            label="三期收益率">
            <template slot-scope="scope">
              <p>{{ scope.row.threeIncome }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="fourIncome"
            label="四期收益率">
            <template slot-scope="scope">
              <p>{{ scope.row.fourIncome }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="blackoutPeriod"
            label="每期天数">
            <template slot-scope="scope">
              <p> {{ scope.row.blackoutPeriod }}天 </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="purchaseRates"
            label="申购费率">
            <template slot-scope="scope">
              <p> {{ scope.row.purchaseRates }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="redemptionRate"
            label="赎回费率">
            <template slot-scope="scope">
              <p> {{ scope.row.redemptionRate }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="recommendScale"
            label="直推奖比例">
            <template slot-scope="scope">
              <p> {{ scope.row.recommendScale }}% </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="state"
            label="状态">
            <template slot-scope="scope">
              <div class="lock-status">
                <a v-if="scope.row.state == 0" class="hide-td" title="显示">
                  <i class="iconfont icon-xianshi"></i>显示
                </a>
                <a v-if="scope.row.state == 1" class="hide-td" title="隐藏">
                  <i class="iconfont icon-yanjing"></i>隐藏
                </a>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            fixed="right"
            width="120px"
            prop="isLock"
            label="详情">
            <template slot-scope="scope">
              <el-button type="text" title="编辑" size="small" @click="showEditDialog(scope.row)">编辑</el-button>
              <el-button type="text" title="隐藏" size="small" @click="showStateDialog(scope.row)">
                {{ scope.row.state == 0 ? "隐藏" : "显示" }}
              </el-button>
            </template>
          </el-table-column>
        </el-table>
        <div class="page-box">
          <el-pagination
            class="pull-right"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="list.pageNum"
            :page-sizes="[10, 20, 30, 40,50]"
            :page-size="list.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="list.total">
          </el-pagination>
        </div>
      </div>
    </el-card>
    <addFundDialog :getDate='getList' ref="addFundDialog"></addFundDialog>
    <editFundDialog :info='detail' :getDate='getList' ref="editFundDialog"></editFundDialog>
    <stateFundDialog :info='detail' :getDate='getList' ref="stateFundDialog"></stateFundDialog>
  </div>
</template>

<script>
import * as api from '@/axios/api'
import addFundDialog from './components/add-fund-dialog.vue'
import editFundDialog from './components/edit-fund-dialog.vue'
import stateFundDialog from './components/state-fund-dialog.vue'

export default {
  components: {
    addFundDialog,
    editFundDialog,
    stateFundDialog
  },
  data() {
    return {
      form: {
        pageNum: 1,
        pageSize: 10
      },
      list: {
        list: []
      },
      detail: {},
      loading: false
    }
  },
  mounted() {
    this.getList()
  },
  methods: {
    handleSizeChange(val) {
      this.form.pageSize = val
      this.getList()
    },
    handleCurrentChange(val) {
      this.form.pageNum = val
      this.getList()
    },
    async getList() {
      if (this.loading) {
        return
      }
      this.loading = true
      // 获取表格数据
      let opts = {
        pageSize: this.form.pageSize,
        pageNum: this.form.pageNum
      }
      let data = await api.fund(opts)
      if (data.status === 0) {
        this.list = data.data
      } else {
        this.$message.error(data.msg)
      }
      this.loading = false
    },
    async showAddFundDialog() {
      this.$refs.addFundDialog.dialogVisible = true
    },
    async showEditDialog(val) {
      this.detail = val
      this.$refs.editFundDialog.dialogVisible = true
    },
    async showStateDialog(val) {
      this.detail = val
      this.$refs.stateFundDialog.dialogVisible = true
    }
  }
}
</script>
<style lang="less" scoped>
.table .el-table .warning-row {
  background: rgba(245, 108, 108, .1);
}

.table {
  .show {
    border: 1px solid #2196F3;
    margin-right: 8px;
    padding: 0 2px;
    font-size: 12px;
    border-radius: 4px;
    color: #2196F3;

    &.red {
      border-color: #ff0000;
      color: #ff0000;
    }
  }
}
</style>
