<template>
  <div class="nav-left" :unique-opened='true' :style="contentStyleObj">
    <el-scrollbar style="height: 100%">
      <el-menu :default-openeds="menus.open" :default-active="menus.index" :collapse="isCollapse"
               background-color="#1f2636"
               text-color="rgb(191, 203, 217)" active-text-color="#409eff">
        <el-menu-item index="1" @click="toOtherVue(['1'],'/home')">
          <i class="iconfont icon-yemian" :style="menus.index==='1'?'color: #409eff':'color:#ffffff'"></i>
          <span slot="title">首页</span>
        </el-menu-item>
        <el-submenu index="2">
          <template slot="title">
            <i class="iconfont icon-yonghuguanli"></i>
            <span slot="title">用户管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="2-1" @click="toOtherVue(['2','2-1'],'/userMan/list?type=0')">用户列表</el-menu-item>
            <el-menu-item index="2-2" @click="toOtherVue(['2','2-2'],'/userMan/list?type=1')">模拟用户</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="3">
          <template slot="title">
            <i class="iconfont icon-dailiguanli"></i>
            <span slot="title">代理管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="3-1" @click="toOtherVue(['3','3-1'],'/agentMan/list')">代理列表</el-menu-item>
            <el-menu-item index="3-2" @click="toOtherVue(['3','3-2'],'/agentMan/rebate')">返佣明细</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="4">
          <template slot="title">
            <i class="iconfont icon-dailiguanli"></i>
            <span slot="title">分仓配资</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="4-1" @click="toOtherVue(['4','4-1'],'/funds/setting')">配资设置</el-menu-item>
            <el-menu-item index="4-2" @click="toOtherVue(['4','4-2'],'/funds/lever')">配置杠杆</el-menu-item>
            <el-menu-item index="4-3" @click="toOtherVue(['4','4-3'],'/funds/dealer')">券商机构管理</el-menu-item>
            <el-menu-item index="4-4" @click="toOtherVue(['4','4-4'],'/funds/securities')">证券信息管理</el-menu-item>
            <el-menu-item index="4-5" @click="toOtherVue(['4','4-5'],'/funds/account')">交易账户管理</el-menu-item>
            <el-menu-item index="4-6" @click="toOtherVue(['4','4-6'],'/funds/apply?type=0')">待审核配资</el-menu-item>
            <el-menu-item index="4-7" @click="toOtherVue(['4','4-7'],'/funds/apply?type=1')">操盘中配资</el-menu-item>
            <el-menu-item index="4-8" @click="toOtherVue(['4','4-8'],'/funds/apply?type=2')">未通过配资</el-menu-item>
            <el-menu-item index="4-9" @click="toOtherVue(['4','4-9'],'/funds/apply?type=3')">到期配资</el-menu-item>
            <el-menu-item index="4-10" @click="toOtherVue(['4','4-10'],'/funds/apply?type=4')">已结束配资</el-menu-item>
            <el-menu-item index="4-11" @click="toOtherVue(['4','4-11'],'/funds/delay?type=0')">续期申请</el-menu-item>
            <el-menu-item index="4-12" @click="toOtherVue(['4','4-12'],'/funds/delay?type=1')">续期记录</el-menu-item>
            <el-menu-item index="4-13" @click="toOtherVue(['4','4-13'],'/funds/expand?type=0')">扩大配资申请
            </el-menu-item>
            <el-menu-item index="4-14" @click="toOtherVue(['4','4-14'],'/funds/expand?type=1')">扩大配资记录
            </el-menu-item>
            <el-menu-item index="4-15" @click="toOtherVue(['4','4-15'],'/funds/margin?type=0')">追加保证金申请
            </el-menu-item>
            <el-menu-item index="4-16" @click="toOtherVue(['4','4-16'],'/funds/margin?type=1')">追加保证金记录
            </el-menu-item>
            <el-menu-item index="4-17" @click="toOtherVue(['4','4-17'],'/funds/end?type=0')">终止操盘申请</el-menu-item>
            <el-menu-item index="4-18" @click="toOtherVue(['4','4-18'],'/funds/end?type=1')">终止操盘记录</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="5">
          <template slot="title">
            <i class="iconfont icon-gupiao"></i>
            <span slot="title">产品管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="5-1" @click="toOtherVue(['5','5-1'],'/product/stock')">股票产品</el-menu-item>
            <el-menu-item index="5-2" @click="toOtherVue(['5','5-2'],'/product/index')">指数产品</el-menu-item>
          </el-menu-item-group>
          <el-submenu index="5-3">
            <span slot="title">外盘期货</span>
            <el-menu-item index="5-3-1" @click="toOtherVue(['5','5-3','5-3-1'],'/product/coin')">基币管理</el-menu-item>
            <el-menu-item index="5-3-2" @click="toOtherVue(['5','5-3','5-3-2'],'/product/futures')">期货产品
            </el-menu-item>
          </el-submenu>
        </el-submenu>
        <el-submenu index="6">
          <template slot="title">
            <i class="iconfont icon-fund"></i>
            <span slot="title">基金管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="6-1" @click="toOtherVue(['6','6-1'],'/money/fund')">基金列表</el-menu-item>
            <el-menu-item index="6-2" @click="toOtherVue(['6','6-2'],'/money/positions')">持仓列表</el-menu-item>
            <el-menu-item index="6-3" @click="toOtherVue(['6','6-3'],'/money/ransoms')">赎回列表</el-menu-item>
            <el-menu-item index="6-4" @click="toOtherVue(['6','6-4'],'/money/financial')">资金明细</el-menu-item>
            <el-menu-item index="6-5" @click="toOtherVue(['6','6-5'],'/money/performance')">代理业绩统计</el-menu-item>
            <el-menu-item index="6-6" @click="toOtherVue(['6','6-6'],'/money/earnings')">代理收益设置</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="7">
          <template slot="title">
            <i class="iconfont icon-zhaijichicang"></i>
            <span slot="title">持仓管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="7-1" @click="toOtherVue(['7','7-1'],'/hold/holdPositions')">融资持仓</el-menu-item>
            <el-menu-item index="7-2" @click="toOtherVue(['7','7-2'],'/hold/indexHoldPositions')">指数持仓
            </el-menu-item>
            <el-menu-item index="7-3" @click="toOtherVue(['7','7-3'],'/hold/futuresHoldPositions')">期货持仓
            </el-menu-item>
            <el-menu-item index="7-4" @click="toOtherVue(['7','7-4'],'/hold/addHoldPositions')">创建融资持仓
            </el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="8">
          <template slot="title">
            <i class="iconfont icon-qudaoguanli1"></i>
            <span slot="title">持仓统计</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="8-1" @click="toOtherVue(['8','8-1'],'/statistics/agentStatistics')">股票持仓统计
            </el-menu-item>
            <el-menu-item index="8-2" @click="toOtherVue(['8','8-2'],'/statistics/inedxStatistics')">指数持仓统计
            </el-menu-item>
            <el-menu-item index="8-3" @click="toOtherVue(['8','8-3'],'/statistics/futuresStatistics')">期货持仓统计
            </el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="9">
          <template slot="title">
            <i class="iconfont icon-zijinguanli"></i>
            <span slot="title">资金管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="9-1" @click="toOtherVue(['9','9-1'],'/cap/capitalDetail')">充值列表</el-menu-item>
            <el-menu-item index="9-2" @click="toOtherVue(['9','9-2'],'/cap/withdraw')">
              <el-badge :value="outMoneyOrder" class="item-mark">提现列表</el-badge>
            </el-menu-item>
            <el-menu-item index="9-3" @click="toOtherVue(['9','9-3'],'/cap/cash')">资金记录</el-menu-item>
            <el-menu-item index="9-4" @click="toOtherVue(['9','9-4'],'/cap/transfer')">转账记录</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="10">
          <template slot="title">
            <i class="iconfont icon-rizhiguanli1"></i>
            <span slot="title">日志管理</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="10-1" @click="toOtherVue(['10','10-1'],'/log/loginlist')">登录日志</el-menu-item>
            <el-menu-item index="10-2" @click="toOtherVue(['10','10-2'],'/log/msglist')">汇率设定日志</el-menu-item>
            <el-menu-item index="10-3" @click="toOtherVue(['10','10-3'],'/log/task')">定时任务</el-menu-item>
            <el-menu-item index="10-4" @click="toOtherVue(['10','10-4'],'/log/exchange')">资金互转记录</el-menu-item>
            <el-menu-item index="10-5" @click="toOtherVue(['10','10-5'],'/log/message')">站内消息</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-menu-item index="11" @click="toOtherVue(['11'],'/manSet/manSetting')">
          <i class="iconfont icon-sysset" :style="menus.index==='11'?'color: #409eff':'color: #ffffff'"></i>
          <span slot="title">管理设置</span>
        </el-menu-item>
        <el-submenu index="12">
          <template slot="title">
            <i class="iconfont icon-fengkongguanli"></i>
            <span slot="title">风控设置</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="12-1" @click="toOtherVue(['12','12-1'],'/risk/product')">产品配置</el-menu-item>
            <el-menu-item index="12-2" @click="toOtherVue(['12','12-2'],'/risk/riskSetting')">股票风控</el-menu-item>
            <el-menu-item index="12-3" @click="toOtherVue(['12','12-3'],'/risk/indexRiskSetting')">指数风控
            </el-menu-item>
            <el-menu-item index="12-4" @click="toOtherVue(['12','12-4'],'/risk/futuresRiskSetting')">期货风控
            </el-menu-item>
            <el-menu-item index="12-5" @click="toOtherVue(['12','12-5'],'/risk/spreadSetting')">点差设置</el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="13">
          <template slot="title">
            <i class="iconfont icon-daohang-guanlishezhi"></i>
            <span slot="title">系统基本设置</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="13-1" @click="toOtherVue(['13','13-1'],'/set/baseSetting')">系统基本设置</el-menu-item>
            <el-menu-item index="13-2" @click="toOtherVue(['13','13-2'],'/set/art')">公告设置</el-menu-item>
            <el-menu-item index="13-3" @click="toOtherVue(['13','13-3'],'/set/banner')">banner设置</el-menu-item>
            <el-menu-item index="13-4" @click="toOtherVue(['13','13-4'],'/set/paychannel')">支付渠道设置</el-menu-item>
            <el-menu-item index="13-5" @click="toOtherVue(['13','13-5'],'/set/exchangeRate')">货币汇率管理
            </el-menu-item>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="14">
          <template slot="title">
            <span slot="title">
              <a title="融资融券 2.0 系统说明书" download="introduction.pdf"
                 :href="adminUrl+'/admins/introduction.pdf'">系统说明</a>
            </span>
          </template>
        </el-submenu>
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
import * as api from '@/axios/api'
import APIUrl from '@/axios/api.url'

export default {
  name: 'MenuNav',
  props: {
    index: {
      type: String,
      default: '1'
    },
    itemMenu: {
      type: String
    },
    isCollapse: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      contentStyleObj: {
        height: ''
      },
      siteInfo: '',
      menus: {
        index: '1',
        open: ['1'],
        path: '/home'
      },
      adminUrl: '',
      outMoneyOrder: 0
    }
  },
  created () {
    window.addEventListener('resize', this.getHeight)
    this.getHeight()
    if (!this.$store.state.userInfo.adminName) {
      this.$store.state.userInfo.adminName = localStorage.getItem('admin-name')
    }
    this.timer = setInterval(this.refreshOutMoneyOrderNum, 1000 * 60)
  },
  destroyed () {
    window.removeEventListener('resize', this.getHeight)
    clearInterval(this.timer)
    localStorage.removeItem('menus')
  },
  mounted () {
    this.getSiteInfo()
    this.adminUrl = APIUrl.baseURL
    console.log(this.$route.path)
    let arrayStr = localStorage.getItem('menus')
    if (arrayStr !== undefined && arrayStr != null) {
      let array = arrayStr.split(',')
      this.menus.index = array[array.length - 1]
      this.menus.open = array
    }
  },
  methods: {
    toOtherVue (array, path) {
      this.$router.push(path)
      this.menus.index = array[array.length - 1]
      this.menus.open = array
      this.menus.path = path
      localStorage.setItem('menus', array)
    },
    getHeight () {
      this.contentStyleObj.height = window.innerHeight - 62 + 'px'
    },
    async getSiteInfo () {
      // 获取站点信息
      let data = await api.getInfo()
      if (data.status === 0) {
        this.siteInfo = data.data
        this.$store.state.siteInfo = data.data
      } else {
        this.$message.error(data.msg)
      }
    },
    async refreshOutMoneyOrderNum () {
      // 刷新出金订单
      let opts = {
        state: 0,
        pageNum: 1,
        pageSize: 1
      }
      let data = await api.withdrawList(opts)
      if (data.status === 0) {
        // 出金待审核金额
        if (data.data.total !== 0 && data.data.total > this.outMoneyOrder) {
          // 有了新的记录
          this.$message({
            showClose: true,
            message: '您有新的订单记录待处理!',
            type: 'warning'
          })
        }
        this.outMoneyOrder = data.data.total
      } else {
        this.$message.error(data.msg)
      }
    }
  }
}
</script>
<style lang="less" scoped>
.logo-img {
  padding: 10px 0;

  img {
    max-width: 80%;
    max-height: 50px;
  }
}

.nav-left {
  overflow: hidden;
  min-height: 500px;
  background-color: #1f2636;
  height: calc(100% - 60px);

  .iconfont {
    vertical-align: middle;
    margin-right: 8px;
    color: #fff;
  }

  /deep/ .el-submenu__title {
    padding: 0 10px;
  }
}

.item-mark {
  /deep/ .el-badge__content.is-fixed {
    top: 19px;
    left: 35px;
    right: auto;
  }
}
</style>
