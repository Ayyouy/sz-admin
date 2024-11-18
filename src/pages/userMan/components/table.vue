<template>
  <div>
    <el-card class="box-card">
      <el-form :inline="true" :model="form" class="demo-form-inline" size="small">
        <el-form-item label="下级代理">
          <el-select clearable filterable v-model="form.agentId" placeholder="下级代理">
            <el-option v-for="i in agentList" :key="i.key" :label="i.agentName" :value="i.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="真实姓名">
          <el-input v-model="form.realName" placeholder="真实姓名"></el-input>
        </el-form-item>
        <el-form-item label="用户手机">
          <el-input v-model="form.phone" placeholder="用户手机"></el-input>
        </el-form-item>
        <el-form-item label="认证信息">
          <el-select clearable filterable v-model="form.active" placeholder="所有">
            <el-option label="所有" :value="-1">所有</el-option>
            <el-option label="未认证" :value="0">未认证</el-option>
            <el-option label="认证中" :value="1">认证中</el-option>
            <el-option label="已认证" :value="2">已认证</el-option>
            <el-option label="认证失败" :value="3">认证失败</el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="注册时间">
          <el-date-picker
            v-model="form.rangeTime"
            :picker-options="pickerOptions"
            value-format="yyyy-MM-dd"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="small" @click="onSubmit">查询</el-button>
        </el-form-item>
      </el-form>
      <el-alert
        v-if="list.list.length>0 && list.list[0].now_price == 0"
        style="margin-bottom:10px"
        title="集合竞价中，'现价'、'浮动盈亏'、'总盈亏'暂不能查看"
        type="warning"
        close-text="知道了">
      </el-alert>
      <div class="table">
        <div class="table-top-btn">
          <el-row class="text-right">
            <el-button type="text" size="small" @click="addAccount">
              <i class="iconfont icon-add"></i>添加账户
            </el-button>
          </el-row>
        </div>
        <el-table
          v-loading="loading"
          :data="list.list"
          show-summary
          :summary-method="getSummaries"
          :row-class-name="tableRowClassName"
          :default-expand-all='true'
          style="width: 100%">
          <el-table-column type="expand">
            <template slot-scope="props">
              <el-row style="margin-top: 10px;margin-bottom: 10px">
                <el-col :span="4" class="text-center">现金账户总资产</el-col>
                <el-col :span="4" class="text-center">持仓市值</el-col>
                <el-col :span="4" class="text-center">可用余额</el-col>
                <el-col :span="3" class="text-center">平仓盈亏</el-col>
                <el-col :span="3" class="text-center">未平仓盈亏</el-col>
                <el-col :span="3" class="text-center">手续费</el-col>
                <el-col :span="3"></el-col>
              </el-row>
              <el-row style="margin-top: 10px;margin-bottom: 10px">
                <el-col :span="4" class="text-center"><span class="explain-item"> {{props.row.userAmt}} </span></el-col>
                <el-col :span="4" class="text-center"><span class="explain-item"> {{props.row.userAmt}} </span></el-col>
                <el-col :span="4" class="text-center"><span class="explain-item"> {{props.row.userAmt}} </span></el-col>
                <el-col :span="3" class="text-center"><span class="explain-item"> {{props.row.userAmt}} </span></el-col>
                <el-col :span="3" class="text-center"><span class="explain-item"> {{props.row.userAmt}} </span></el-col>
                <el-col :span="3" class="text-center"><span class="explain-item"> {{props.row.userAmt}} </span></el-col>
                <el-col :span="3"></el-col>
              </el-row>
              <el-row style="margin-top: 10px;margin-bottom: 10px">
                <el-col :span="4" class="text-center">基金账户总资产</el-col>
                <el-col :span="4" class="text-center">持仓金额</el-col>
                <el-col :span="4" class="text-center">可用余额</el-col>
                <el-col :span="3" class="text-center">已获得收益</el-col>
                <el-col :span="3" class="text-center">手续费</el-col>
                <el-col :span="6"></el-col>
              </el-row>
              <el-row style="margin-top: 10px;margin-bottom: 10px">
                <el-col :span="4" class="text-center"><span class="explain-item"> {{props.row.userAmt}}</span></el-col>
                <el-col :span="4" class="text-center"><span class="explain-item"> {{props.row.userAmt}}</span></el-col>
                <el-col :span="4" class="text-center"><span class="explain-item"> {{props.row.userAmt}}</span></el-col>
                <el-col :span="3" class="text-center"><span class="explain-item"> {{props.row.userAmt}}</span></el-col>
                <el-col :span="3" class="text-center"><span class="explain-item"> {{props.row.userAmt}}</span></el-col>
                <el-col :span="6"></el-col>
              </el-row>
            </template>
          </el-table-column>
          <el-table-column
            width="150px"
            prop="agentName"
            label="所属代理/id">
            <template slot-scope="scope">
              <p>
                {{ scope.row.agentName }}<span class="small">/{{ scope.row.agentId }}</span>
              </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="realName"
            width="150px"
            label="真实姓名">
            <template slot-scope="scope">
              <p>
                {{ scope.row.realName }}<span class="small">/{{ scope.row.id }}</span>
                <span class="small" v-if="scope.row.accountType == 1">(模拟)</span>
              </p>
            </template>
          </el-table-column>
          <el-table-column
            prop="phone"
            width="129px"
            label="手机号">
          </el-table-column>
          <el-table-column
            prop="userAmt"
            width="155px"
            label="现金账户总资产">
            <template slot-scope="scope">
              <p class="number proColor bounceIn">
                {{
                  (Number(scope.row.userAmt) + Number(scope.row.userIndexAmt) +
                    Number(scope.row.userFutAmt)).toFixed(2)
                }}
              </p>
            </template>
          </el-table-column>
          <el-table-column
            width="150px"
            prop="userAmt"
            label="基金账户余额">
            <template slot-scope="scope">
              <p class="number proColor bounceIn">
                -
              </p>
            </template>
          </el-table-column>
          <el-table-column
            width="120px"
            prop="isActive"
            label="认证信息">
            <template slot-scope="scope">
              <div>
                <!-- 0 ==》 注册 1==》 提交激活 2==》 成功 3==》 激活打回 -->
                <a v-if="scope.row.isActive == 0" class="blue" title="待认证"><i
                  class="iconfont icon-iconfontweitongguo"></i>待认证</a>
                <a v-if="scope.row.isActive == 1" class="red" title="待审核"><i class="iconfont icon-dengdai"></i>待审核</a>
                <a v-if="scope.row.isActive == 2" class="green" title="认证成功"><i
                  class="iconfont icon-tongguo4"></i>成功</a>
                <a v-if="scope.row.isActive == 3" class="yellow" title="驳回"><i class="iconfont icon-audi1Reject"></i>驳回</a>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            width="80px"
            prop="isLock"
            label="交易状态">
            <template slot-scope="scope">
              <div class="lock-status">
                <span v-if="scope.row.isLock == 0" class="green">可交易</span>
                <span v-if="scope.row.isLock == 1" class="red">不可交易</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            width="80px"
            prop="isLogin"
            label="登录状态">
            <template slot-scope="scope">
              <div class="lock-status">
                <span v-if="scope.row.isLogin == 0" class="green">可登陆</span>
                <span v-if="scope.row.isLogin == 1" class="red">不可登陆</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column
            width="150px"
            prop="parentName"
            label="推荐人">
            <template slot-scope="scope">
              <p v-show="scope.row.parentId>0">
                {{ scope.row.parentName }}<span class="small">/{{ scope.row.parentId }}</span>
              </p>
            </template>
          </el-table-column>
          <el-table-column
            width="170px"
            prop="regTime"
            label="注册时间">
            <template slot-scope="scope">{{ scope.row.regTime | timeFormat }}</template>
          </el-table-column>
          <el-table-column
            fixed="right"
            width="210px"
            prop="isLock"
            label="操作">
            <template slot-scope="scope">
              <el-button style="color:#606262;" type="text" title="查看详情" size="small" @click="toDetail(scope.row)">
                <i
                  class="iconfont icon-chakan"></i></el-button>
              <el-button type="text" title="修改用户信息" size="small" @click="toEditInfo(scope.row)"><i
                class="iconfont icon-xiugai"></i></el-button>
              <el-button type="text" title="修改银行卡" size="small" @click="toEditBankInfo(scope.row)"><i
                class="iconfont icon-xiugaiyinhangqia- "></i></el-button>
              <el-button type="text" title="修改资金" size="small" @click="toEditAmt(scope.row)"><i
                class="iconfont icon-zijinguanli2"></i></el-button>
              <el-button style="color:red;" type="text" title="审核" size="small" @click="toChange(scope.row)"><i
                class="iconfont icon-shenhe_shangpinfenlei"></i></el-button>
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
    <addDialog :agentList='agentList' :getDate='getList' ref="addSimulatedAccountDialog"></addDialog>
    <DetailDialog :info='detail' ref="detailDialog"></DetailDialog>
    <EditDialog :info='detail' :getDate='getList' ref="editDialog"></EditDialog>
    <EditInfoDialog :info='detail' :agentList='agentList' :getDate='getList' ref="editInfoDialog"></EditInfoDialog>
    <ChangeAuthDialog :info='detail' :getDate='getList' ref="changeAuthDialog"></ChangeAuthDialog>
    <EditBankInfoDialog :info='detail' :getDate='getList' ref="editBankInfoDialog"></EditBankInfoDialog>
  </div>

</template>

<script>
import * as api from '@/axios/api'
import addDialog from './add-dialog'
import DetailDialog from './detail-dialog'
import EditDialog from './amt-dialog'
import EditInfoDialog from './update-dialog'
import ChangeAuthDialog from './auditing-dialog'
import EditBankInfoDialog from './updatebank-dialog'

export default {
  components: {
    addDialog,
    DetailDialog,
    EditDialog,
    EditInfoDialog,
    ChangeAuthDialog,
    EditBankInfoDialog
  },
  data () {
    return {
      pickerOptions: {
        shortcuts: [{
          text: '最近一个月',
          onClick (picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
            picker.$emit('pick', [start, end])
          }
        }, {
          text: '最近三个月',
          onClick (picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90)
            picker.$emit('pick', [start, end])
          }
        }, {
          text: '最近六个月',
          onClick (picker) {
            const end = new Date()
            const start = new Date()
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 180)
            picker.$emit('pick', [start, end])
          }
        }]
      },
      form: {
        realName: '',
        userId: '',
        phone: '',
        type: '0',
        active: -1,
        rangeTime: '',
        agentId: '',
        pageNum: 1,
        pageSize: 10
      },
      list: {
        list: []
      },
      agentList: [
        {
          'id': 2,
          'agentName': '下级1',
          'agentRealName': '下级1',
          'agentPhone': '18888888888',
          'agentCode': '8888'
        }
      ],
      detail: {},
      loading: false,
      timer: null,
      refresh: false,
      usertype: 0,
      changeTextClass: {} // 表格中的数据变化
    }
  },
  watch: {
    $route () {
      this.usertype = this.$route.query.type
    },
    usertype () {
      this.getList()
    }
  },
  beforeDestroy () {
    clearInterval(this.timer)
  },
  mounted () {
    this.getList()
    this.getAgentList()
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
    async refreshList () {
      if (this.refresh || this.loading) {
        return
      }
      this.refresh = true
      // 获取表格数据
      let opts = {
        userId: this.form.userId,
        realName: this.form.realName,
        phone: this.form.phone,
        agentId: this.form.agentId,
        accountType: this.usertype,
        active: this.form.active,
        buyTimeStart: this.form.rangeTime ? this.form.rangeTime[0] : null,
        buyTimeEnd: this.form.rangeTime ? this.form.rangeTime[1] : null,
        pageSize: this.form.pageSize,
        pageNum: this.form.pageNum
      }
      this.changeTextClass = {}
      let data = await api.getUserManList(opts)
      this.refresh = false
      if (data.status === 0) {
        data.data.list.forEach((element, i) => {
          // 判断刷新需要刷新的值
          this.changeTextClass[i] = ''
          if (this.list.list[i].profitAndLose !== data.data.list[i].profitAndLose) {
            this.changeTextClass[i] = true // 设置对应的动画过滤
            this.list.list[i].profitAndLose = data.data.list[i].profitAndLose
            this.list.list[i].userAmt = data.data.list[i].userAmt
          }
        })
      } else {
        this.$message.error(data.msg)
      }
    },
    onSubmit () {
      // 查询表格
      this.getList()
    },
    async getAgentList () {
      // 获取下级代理数据
      let opts = {
        pageNum: 1,
        pageSize: 100
      }
      let data = await api.getSecondAgent(opts)
      if (data.status === 0) {
        this.agentList = data.data.list
      } else {
        this.$message.error(data.msg)
      }
    },
    async getList () {
      // 获取表格数据
      let opts = {
        userId: this.form.userId,
        realName: this.form.realName,
        phone: this.form.phone,
        agentId: this.form.agentId,
        active: this.form.active,
        buyTimeStart: this.form.rangeTime ? this.form.rangeTime[0] : null,
        buyTimeEnd: this.form.rangeTime ? this.form.rangeTime[1] : null,
        accountType: this.usertype,
        pageSize: this.form.pageSize,
        pageNum: this.form.pageNum
      }
      this.loading = true
      let data = await api.getUserManList(opts)
      if (data.status === 0) {
        this.list = data.data
      } else {
        this.$message.error(data.msg)
      }
      this.loading = false
    },
    addAccount () {
      // 添加模拟账户
      this.$refs.addSimulatedAccountDialog.dialogVisible = true
      this.$refs.addSimulatedAccountDialog.select = '+1'
    },
    toDetail (row) {
      this.detail = row
      this.$refs.detailDialog.dialogVisible = true
    },
    toChange (row) {
      // 审核信息
      this.detail = row
      this.$refs.changeAuthDialog.dialogVisible = true
    },
    async toLockUser (val) {
      // 锁定用户
      let data = await api.updateLock({userId: val})
      if (data.status === 0) {
        await this.getList()
        this.$message.success('锁定成功！')
      } else {
        this.$message.error(data.msg)
      }
    },
    async toUnlockUser (val) {
      // 解锁用户
      let data = await api.updateLock({userId: val})
      if (data.status === 0) {
        await this.getList()
        this.$message.success('解除锁定成功！')
      } else {
        this.$message.error(data.msg)
      }
    },
    toEditAmt (row) {
      // 修改口入款
      this.detail = row
      this.$refs.editDialog.dialogVisible = true
    },
    toEditInfo (row) {
      // 修改用户信息
      this.detail = row
      this.$refs.editInfoDialog.dialogVisible = true
    },
    toEditBankInfo (row) {
      // 修改银行卡信息
      this.detail = row
      this.$refs.editBankInfoDialog.dialogVisible = true
    },
    tableRowClassName ({row, rowIndex}) {
      // 设置表格行高亮
      if (row.allProfitAndLose < 0 && ((-row.allProfitAndLose) / row.forceLine) >= 0.8) {
        return 'warning-row'
      }
      return ''
    },
    getSummaries (param) {
      // 底部计算
      const {columns, data} = param
      const sums = []
      columns.forEach((column, index) => {
        // 第一行 不统计
        if (index === 0) {
          sums[index] = '统计'
          return
        }
        if (column.property === 'userAmt' || column.property === 'enableAmt' || column.property === 'allFreezAmt' || column.property === 'allProfitAndLose') {
          // 需要计算列 ==>    userAmt enableAmt  allFreezAmt allProfitAndLose forceLine
          const values = data.map(item => Number(item[column.property]))
          if (!values.every(value => isNaN(value))) {
            sums[index] = values.reduce((prev, curr) => {
              const value = Number(curr)
              if (!isNaN(value)) {
                let num = prev + curr
                return num
              } else {
                return prev
              }
            }, 0)
            sums[index] = sums[index].toFixed(2)
          } else {
            sums[index] = 'N/A'
          }
        }
      })
      return sums
    },
    deleteUser (val) {
      // 删除用户所有信息
      this.$confirm('确认删除该用户吗？此操作不可恢复，将删除该用户所有的充值、提现与持仓记录！', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        let data = await api.deleteDetail({userId: val})
        if (data.status === 0) {
          await this.getList()
          this.$message.success('删除成功！')
        } else {
          this.$message.error(data.msg)
        }
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消'
        })
      })
    }
  }
}
</script>
<style lang="less" scoped>
.table .el-table .warning-row {
  background: rgba(245, 108, 108, .1);
}

.table .demo-table-expand {
  /deep/ label {
    display: block;
    text-align: center;
    line-height: 20px;
    width: 100%;
  }

  /deep/ .el-form-item {
    width: 16.6%;
    text-align: center;
  }
}

.explain-item{
  padding: 2px 5px;
  border: 1px solid #ffffff;
  border-radius: 5px;
  background-color: #87CEFA;
  font-size: 14px;
}
</style>
