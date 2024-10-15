<template>
  <div>
    <el-card class="box-card">
      <el-form
        :inline="true"
        :model="form"
        class="demo-form-inline"
        size="small"
      >
        <el-form-item label="订单编号">
          <el-input v-model="form.orderSn" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="汇款人">
          <el-input v-model="form.userNameA" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="收款人">
          <el-input v-model="form.userNameZ" placeholder=""></el-input>
        </el-form-item>
        <el-form-item label="出金时间">
          <el-date-picker
            v-model="form.time"
            type="datetimerange"
            value-format="yyyy-MM-dd HH:mm:ss"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          >
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmit">查询</el-button>
          <!-- <el-button type="success" @click="export2Excel">导出当前页数据</el-button> -->
        </el-form-item>
      </el-form>
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
            prop="orderSn"
            label="订单编号">
          </el-table-column>
          <el-table-column
            prop="userNameA"
            label="汇款人">
          </el-table-column>
          <el-table-column
            prop="transferAmp"
            label="转账金额($)">
          </el-table-column>
          <el-table-column
            prop="userNameZ"
            label="收款人">
          </el-table-column>
          <!-- <el-table-column
            prop="rate"
            label="转账说明">
          </el-table-column> -->
          <el-table-column
            prop="transferTime"
            label="转账时间">
          </el-table-column>
          <!-- <el-table-column
            fixed="right"
            label="操作">
            <template slot-scope="scope">
              <el-button type="primary" plain size="small" @click="tochangeChannel(scope.row)">修改</el-button>
            </template>
          </el-table-column> -->
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
    let nowDate = new Date()
    let beforeDate = new Date(new Date().getTime() - 7 * 24 * 60 * 60 * 1000)
    return {
      nowDate: nowDate,
      beforeDate: beforeDate,
      form: {
        orderSn: '',
        userNameA: '',
        userNameZ: '',
        time: '',
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
      let opts = {
        pageNum:this.form.pageNum,
        pageSize:  this.form.pageSize,
        orderSn: this.form.orderSn,
        userNameA: this.form.userNameA,
        userNameZ: this.form.userNameZ,
        beginTime: this.form.time ? this.form.time[0] : '',
        endTime: this.form.time ? this.form.time[1] : ''
      }
      this.loading = true
      let data = await api.userTransferList(opts)
      if (data.status === 0) {
        this.list = data.data.list
        this.list.forEach(item => {
          var date = new Date(item.transferTime);
          item.transferTime = date.toLocaleDateString()+ " " + date.toLocaleTimeString(); // 返回格式化后的日期字符串
        })
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
