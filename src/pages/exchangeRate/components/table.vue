<template>
  <div>
    <el-card class="box-card">
      <div class="table">
        <!-- <div class="table-top-btn">
          <el-row class="text-right">
            <el-button type="text" size="small" @click="addAccount">
              <i class="iconfont icon-add"></i>添加支付通道
            </el-button>
          </el-row>
        </div> -->
        <el-table
          v-loading="loading"
          :data="list"
          style="width: 100%">
          <el-table-column
            prop="country"
            label="国家">
          </el-table-column>
          <el-table-column
            prop="currency"
            label="货币">
          </el-table-column>
          <el-table-column
            prop="code"
            label="简称">
          </el-table-column>
          <el-table-column
            prop="symbol"
            label="货币符号">
          </el-table-column>
          <el-table-column
            prop="rate"
            label="汇率">
          </el-table-column>
          <el-table-column
            fixed="right"
            label="操作">
            <template slot-scope="scope">
              <el-button type="primary" plain size="small" @click="tochangeChannel(scope.row)">修改</el-button>
              <!-- <el-button type="darge" plain size="small" @click="deleteChannel(scope.row)">删除</el-button> -->
            </template>
          </el-table-column>
        </el-table>
        <div class="page-box">
          <el-pagination
            class="pull-right"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="list.pageNum"
            :page-sizes="[10, 20, 30, 40]"
            :page-size="list.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="list.total">
          </el-pagination>
        </div>
        <addDialog :getDate='getList' ref="addDialog"></addDialog>
        <changeDialog :info="detail" :getDate='getList' ref="changeDialog"></changeDialog>
      </div>
    </el-card>
  </div>

</template>

<script>
import * as api from '@/axios/api'
import addDialog from './add-dialog'
import changeDialog from './change-dialog'

export default {
  components: {
    addDialog,
    changeDialog
  },
  props: {},
  data () {
    return {
      form: {
        channelType: '',
        pageNum: 1,
        pageSize: 10
      },
      list: [],
      loading: false, // 表格加载
      detail: null
    }
  },
  watch: {},
  computed: {},
  created () {},
  mounted () {
    this.getList()
  },
  methods: {
    handleSizeChange (val) {
      this.form.pageSize = val
      this.getList()
    },
    handleCurrentChange (val) {
      this.form.pageNum = val
      this.getList()
    },
    onSubmit () {
      // 查询表格
      this.getList()
    },
    async getList () {
      // 获取表格数据
      let opts = {}
      this.loading = true
      let data = await api.exchangeRateList(opts)
      if (data.status === 0) {
        this.list = data.data.list
      } else {
        this.$message.error(data.msg)
      }
      this.loading = false
    },
    tochangeChannel (row) {
      // 查看详情
      this.detail = row
      this.$refs.changeDialog.dialogVisible = true
    },
    addAccount () {
      this.$refs.addDialog.dialogVisible = true
    },
    deleteChannel (row) {
      // 删除
      this.$confirm('确认删除该通道？此操作不可恢复', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        let data = await api.delChannel({ cId: row.id })
        if (data.status === 0) {
          this.$message.success(data.msg)
          this.getList()
        } else {
          this.$message.error(data.msg)
        }
      }).catch(() => {

      })
    }
  }
}
</script>
