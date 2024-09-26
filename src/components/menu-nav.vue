<template>
  <div class="nav-left" :unique-opened='true' :style="contentStyleObj">
    <el-scrollbar style="height: 100%">
      <el-menu :default-openeds="index" :default-active="itemMenu" :collapse="isCollapse" background-color="#1f2636"
               text-color="rgb(191, 203, 217)" active-text-color="#409eff">
        <el-menu-item index="0">
          <div class="menu-wra" @click="$router.push('/home')">
            <i class="iconfont icon-yemian"></i>
            <span slot="title">首页</span>
          </div>
        </el-menu-item>
        <el-submenu index="2" v-if="P1002&&P1001">
          <template slot="title">
            <i class="iconfont icon-yonghuguanli"></i>
            <span slot="title">用户管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P1001" to="/userMan/list?type=0">
              <el-menu-item index="2-1">用户列表</el-menu-item>
            </router-link>
            <router-link v-if="P1002" to="/userMan/list?type=1">
              <el-menu-item index="2-2">模拟用户</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="3" v-if="P2001">
          <template slot="title">
            <i class="iconfont icon-dailiguanli"></i>
            <span slot="title">代理管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P2001" to="/agentMan/list">
              <el-menu-item index="3-1">代理列表</el-menu-item>
            </router-link>
          </el-menu-item-group>

          <!-- <router-link to="/agentStatistics" tag="li">
              <el-menu-item index="3-2">股票持仓统计</el-menu-item>
          </router-link>
          <router-link to="/inedxStatistics" tag="li">
              <el-menu-item index="3-3">指数持仓统计</el-menu-item>
          </router-link>
          <router-link to="/futuresStatistics" tag="li">
              <el-menu-item index="3-4">期货持仓统计</el-menu-item>
          </router-link> -->
        </el-submenu>
        <el-submenu index="12">
          <template slot="title">
            <i class="iconfont icon-dailiguanli"></i>
            <span slot="title">分仓配资</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P3001" to="/funds/setting" tag="li">
              <el-menu-item index="12-1">配资设置</el-menu-item>
            </router-link>
            <router-link v-if="P3002" to="/funds/lever" tag="li">
              <el-menu-item index="12-2">配置杠杆</el-menu-item>
            </router-link>
            <router-link v-if="P3003" to="/funds/dealer" tag="li">
              <el-menu-item index="12-3">券商机构管理</el-menu-item>
            </router-link>
            <router-link v-if="P3004" to="/funds/securities" tag="li">
              <el-menu-item index="12-4">证券信息管理</el-menu-item>
            </router-link>
            <router-link v-if="P3005" to="/funds/account" tag="li">
              <el-menu-item index="12-5">交易账户管理</el-menu-item>
            </router-link>
            <router-link v-if="P3006" to="/funds/apply?type=0" tag="li">
              <el-menu-item index="12-6">待审核配资</el-menu-item>
            </router-link>
            <router-link v-if="P3007" to="/funds/apply?type=1" tag="li">
              <el-menu-item index="12-7">操盘中配资</el-menu-item>
            </router-link>
            <router-link v-if="P3008" to="/funds/apply?type=2" tag="li">
              <el-menu-item index="12-8">未通过配资</el-menu-item>
            </router-link>
            <router-link v-if="P3009" to="/funds/apply?type=3" tag="li">
              <el-menu-item index="12-9">到期配资</el-menu-item>
            </router-link>
            <router-link v-if="P3010" to="/funds/apply?type=4" tag="li">
              <el-menu-item index="12-10">已结束配资</el-menu-item>
            </router-link>
            <router-link v-if="P3011" to="/funds/delay?type=0" tag="li">
              <el-menu-item index="12-11">续期申请</el-menu-item>
            </router-link>
            <router-link v-if="P3012" to="/funds/delay?type=1" tag="li">
              <el-menu-item index="12-12">续期记录</el-menu-item>
            </router-link>
            <router-link v-if="P3013" to="/funds/expand?type=0" tag="li">
              <el-menu-item index="12-13">扩大配资申请</el-menu-item>
            </router-link>
            <router-link v-if="P3014" to="/funds/expand?type=1" tag="li">
              <el-menu-item index="12-14">扩大配资记录</el-menu-item>
            </router-link>
            <router-link v-if="P3015" to="/funds/margin?type=0" tag="li">
              <el-menu-item index="12-15">追加保证金申请</el-menu-item>
            </router-link>
            <router-link v-if="P3016" to="/funds/margin?type=1" tag="li">
              <el-menu-item index="12-16">追加保证金记录</el-menu-item>
            </router-link>
            <router-link v-if="P3017" to="/funds/end?type=0" tag="li">
              <el-menu-item index="12-17">终止操盘申请</el-menu-item>
            </router-link>
            <router-link v-if="P3018" to="/funds/end?type=1" tag="li">
              <el-menu-item index="12-18">终止操盘记录</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="4">
          <template slot="title">
            <i class="iconfont icon-gupiao"></i>
            <span slot="title">产品管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P4001" to="/product/stock" tag="li">
              <el-menu-item index="4-1">股票产品</el-menu-item>
            </router-link>
            <router-link v-if="P4002" to="/product/index" tag="li">
              <el-menu-item index="4-2">指数产品</el-menu-item>
            </router-link>
          </el-menu-item-group>
          <el-submenu index="4-3">
            <span slot="title">外盘期货</span>
            <router-link v-if="P5001" to="/product/coin" tag="li">
              <el-menu-item index="4-4">基币管理</el-menu-item>
            </router-link>
            <router-link v-if="P5002" to="/product/futures" tag="li">
              <el-menu-item index="4-5">期货产品</el-menu-item>
            </router-link>
          </el-submenu>
        </el-submenu>

        <el-submenu index="5-6">
          <template slot="title">
            <i class="iconfont icon-fund"></i>
            <span slot="title">基金管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P13001" to="/money/fund" tag="li">
              <el-menu-item index="fund">基金列表</el-menu-item>
            </router-link>
            <router-link v-if="P13002" to="/money/positions" tag="li">
              <el-menu-item index="positions">持仓列表</el-menu-item>
            </router-link>
            <router-link v-if="P13003" to="/money/ransoms" tag="li">
              <el-menu-item index="ransoms">赎回列表</el-menu-item>
            </router-link>
            <router-link v-if="P13004" to="/money/financial" tag="li">
              <el-menu-item index="financial">资金明细</el-menu-item>
            </router-link>
            <router-link v-if="P13005" to="/money/performance" tag="li">
              <el-menu-item index="performance">代理业绩统计</el-menu-item>
            </router-link>
            <router-link v-if="P13006" to="/money/earnings" tag="li">
              <el-menu-item index="earnings">代理收益设置</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="5">
          <template slot="title">
            <i class="iconfont icon-zhaijichicang"></i>
            <span slot="title">持仓管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P6001" to="/hold/holdPositions" tag="li">
              <el-menu-item index="5-1">融资持仓</el-menu-item>
            </router-link>
            <router-link v-if="P6002" to="/hold/indexHoldPositions" tag="li">
              <el-menu-item index="5-2">指数持仓</el-menu-item>
            </router-link>
            <router-link v-if="P6003" to="/hold/futuresHoldPositions" tag="li">
              <el-menu-item index="5-3">期货持仓</el-menu-item>
            </router-link>
            <router-link v-if="P6004" to="/hold/addHoldPositions" tag="li">
              <el-menu-item index="5-4">创建融资持仓</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="5-4">
          <template slot="title">
            <i class="iconfont icon-qudaoguanli1"></i>
            <span slot="title">持仓统计</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P7001" to="/statistics/agentStatistics" tag="li">
              <el-menu-item index="agentStatistics">股票持仓统计</el-menu-item>
            </router-link>
            <router-link v-if="P7002" to="/statistics/inedxStatistics" tag="li">
              <el-menu-item index="inedxStatistics">指数持仓统计</el-menu-item>
            </router-link>
            <router-link v-if="P7003" to="/statistics/futuresStatistics" tag="li">
              <el-menu-item index="futuresStatistics">期货持仓统计</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="1">
          <template slot="title">
            <i class="iconfont icon-zijinguanli"></i>
            <span slot="title">资金管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P8001" to="/cap/capitalDetail" tag="li">
              <el-menu-item index="1-1">充值列表</el-menu-item>
            </router-link>
            <router-link v-if="P8002" to="/cap/withdraw" tag="li">
              <el-menu-item index="1-2">
                <el-badge :value="outMoneyOrder" class="item-mark">
                  提现列表
                </el-badge>
              </el-menu-item>
            </router-link>
            <router-link v-if="P8003" to="/cap/cash" tag="li">
              <el-menu-item index="1-3">资金记录</el-menu-item>
            </router-link>
            <router-link v-if="P8004" to="/cap/transfer" tag="li">
              <el-menu-item index="1-4">转账记录</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="6">
          <template slot="title">
            <i class="iconfont icon-rizhiguanli1"></i>
            <span slot="title">日志管理</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P9001" to="/log/loginlist" tag="li">
              <el-menu-item index="6-1">登录日志</el-menu-item>
            </router-link>
            <router-link v-if="P9002" to="/log/msglist" tag="li">
              <el-menu-item index="6-2">汇率设定日志</el-menu-item>
            </router-link>
            <router-link v-if="P9003" to="/log/task" tag="li">
              <el-menu-item index="6-3">定时任务</el-menu-item>
            </router-link>
            <router-link v-if="P9004" to="/log/exchange" tag="li">
              <el-menu-item index="6-4">资金互转记录</el-menu-item>
            </router-link>
            <router-link v-if="P9005" to="/log/message" tag="li">
              <el-menu-item index="6-5">站内消息</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="7" v-if="P10001">
          <template slot="title">
            <i class="iconfont icon-sysset"></i>
            <span slot="title">管理设置</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P10001" to="/manSet/manSetting" tag="li">
              <el-menu-item index="7-1">管理列表</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="9">
          <template slot="title">
            <i class="iconfont icon-fengkongguanli"></i>
            <span slot="title">风控设置</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P11001" to="/risk/product" tag="li">
              <el-menu-item index="9-0">产品配置</el-menu-item>
            </router-link>
            <router-link v-if="P11002" to="/risk/riskSetting" tag="li">
              <el-menu-item index="9-1">股票风控</el-menu-item>
            </router-link>
            <router-link v-if="P11003" to="/risk/indexRiskSetting" tag="li">
              <el-menu-item index="9-2">指数风控</el-menu-item>
            </router-link>
            <router-link v-if="P11004" to="/risk/futuresRiskSetting" tag="li">
              <el-menu-item index="9-3">期货风控</el-menu-item>
            </router-link>
            <router-link v-if="P11005" to="/risk/spreadSetting" tag="li">
              <el-menu-item index="9-4">点差设置</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="11">
          <template slot="title">
            <i class="iconfont icon-daohang-guanlishezhi"></i>
            <span slot="title">系统基本设置</span>
          </template>
          <el-menu-item-group>
            <router-link v-if="P12001" to="/set/baseSetting" tag="li">
              <el-menu-item index="11-1">系统基本设置</el-menu-item>
            </router-link>
            <router-link v-if="P12002" to="/set/art" tag="li">
              <el-menu-item index="11-2">公告设置</el-menu-item>
            </router-link>
            <router-link v-if="P12003" to="/set/banner" tag="li">
              <el-menu-item index="11-3">banner设置</el-menu-item>
            </router-link>
            <router-link v-if="P12004" to="/set/paychannel" tag="li">
              <el-menu-item index="11-4">支付渠道设置</el-menu-item>
            </router-link>
            <router-link v-if="P12005" to="/set/exchangeRate" tag="li">
              <el-menu-item index="11-5">货币汇率管理</el-menu-item>
            </router-link>
          </el-menu-item-group>
        </el-submenu>
        <el-submenu index="14">
          <template slot="title">
            <span slot="title">
              <a title="融资融券 2.0 系统说明书" download="introduction.pdf"
                 :href="adminUrl+'/admins/introduction.pdf'">系统说明</a>
            </span>
          </template>
          <!-- <template slot="title"> -->
          <!-- 融资融券 2.0 系统说明书 -->
          <!-- <a title="融资融券 2.0 系统说明书" download="introduction.pdf" :href="adminUrl+'/admins/introduction.pdf'">系统说明</a> -->
          <!-- <a title="系统说明" download="1.pdf" href="../assets/1.pdf">系统说明</a> -->
          <!-- </template> -->
        </el-submenu>
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
import * as api from '@/axios/api'

export default {
  name: 'MenuNav',
  components: {},
  props: {
    index: {
      type: Array
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
      menus: {},
      adminUrl: '',
      P1001: true,
      P1002: true,
      P1003: true,
      P2001: true,
      P3001: true,
      P3002: true,
      P3003: true,
      P3004: true,
      P3005: true,
      P3006: true,
      P3007: true,
      P3008: true,
      P3009: true,
      P3010: true,
      P3011: true,
      P3012: true,
      P3013: true,
      P3014: true,
      P3015: true,
      P3016: true,
      P3017: true,
      P3018: true,
      P4001: true,
      P4002: true,
      P5001: true,
      P5002: true,
      P6001: true,
      P6002: true,
      P6003: true,
      P6004: true,
      P7001: true,
      P7002: true,
      P7003: true,
      P8001: true,
      P8002: true,
      P8003: true,
      P8004: true,
      P9001: true,
      P9002: true,
      P9003: true,
      P9004: true,
      P9005: true,
      P10001: true,
      P11001: true,
      P11002: true,
      P11003: true,
      P11004: true,
      P11005: true,
      P12001: true,
      P12002: true,
      P12003: true,
      P12004: true,
      P12005: true,
      P13001: true,
      P13002: true,
      P13003: true,
      P13004: true,
      P13005: true,
      P13006: true,
      outMoneyOrder: 0
    }
  },
  watch: {},
  computed: {},
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
  },
  mounted () {
    this.getSiteInfo()
    this.getMenu()
    // this.$store.state.userInfo.id
    this.adminUrl = process.env.API_HOST
    if (this.adminUrl === undefined) {
      this.adminUrl = ''
    }
  },
  methods: {
    getHeight () {
      this.contentStyleObj.height = window.innerHeight - 62 + 'px'
    },
    async getSiteInfo() {
      // 获取站点信息
      let data = await api.getInfo()
      if (data.status === 0) {
        this.siteInfo = data.data
        this.$store.state.siteInfo = data.data
      } else {
        this.$message.error(data.msg)
      }
    },
    async getMenu() {
      // 获取站点信息
      // 刷新出金订单A
      let opts = {
        uid: localStorage.getItem('id')
      }
      // let data = await api.getMenu(opts)
      // if (data.status === 0) {
      //   this.menus = data.data
      //   console.log(this.menus)
      //   for(var i=0;i<this.menus.length;i++){
      //     var menu = this.menus[i];
      //     if(menu.aid === 1001){
      //       this.P1001 = menu.selected;
      //     }
      //     if(menu.aid === 1002){
      //       this.P1002 = menu.selected;
      //     }
      //     if(menu.aid === 1003){
      //       this.P1003 = menu.selected;
      //     }
      //     if(menu.aid === 2001){
      //       this.P2001 = menu.selected;
      //     }
      //     if(menu.aid === 3001){
      //       this.P3001 = menu.selected;
      //     }
      //     if(menu.aid === 3002){
      //       this.P3002 = menu.selected;
      //     }
      //     if(menu.aid === 3003){
      //       this.P3003 = menu.selected;
      //     }
      //     if(menu.aid === 3004){
      //       this.P3004 = menu.selected;
      //     }
      //     if(menu.aid === 3005){
      //       this.P3005 = menu.selected;
      //     }
      //     if(menu.aid === 3006){
      //       this.P3006 = menu.selected;
      //     }
      //     if(menu.aid === 3007){
      //       this.P3007 = menu.selected;
      //     }
      //     if(menu.aid === 3008){
      //       this.P3008 = menu.selected;
      //     }
      //     if(menu.aid === 3009){
      //       this.P3009 = menu.selected;
      //     }
      //     if(menu.aid === 3010){
      //       this.P3010 = menu.selected;
      //     }
      //     if(menu.aid === 3011){
      //       this.P3011 = menu.selected;
      //     }
      //     if(menu.aid === 3012){
      //       this.P3012 = menu.selected;
      //     }
      //     if(menu.aid === 3013){
      //       this.P3013 = menu.selected;
      //     }
      //     if(menu.aid === 3014){
      //       this.P3014 = menu.selected;
      //     }
      //     if(menu.aid === 3015){
      //       this.P3015 = menu.selected;
      //     }
      //     if(menu.aid === 3016){
      //       this.P3016 = menu.selected;
      //     }
      //     if(menu.aid === 3017){
      //       this.P3017 = menu.selected;
      //     }
      //     if(menu.aid === 3018){
      //       this.P3018 = menu.selected;
      //     }
      //     if(menu.aid === 4001){
      //       this.P4001 = menu.selected;
      //     }
      //     if(menu.aid === 4002){
      //       this.P4002 = menu.selected;
      //     }
      //     if(menu.aid === 5001){
      //       this.P5001 = menu.selected;
      //     }
      //     if(menu.aid === 5002){
      //       this.P5002 = menu.selected;
      //     }
      //     if(menu.aid === 6001){
      //       this.P6001 = menu.selected;
      //     }
      //     if(menu.aid === 6002){
      //       this.P6002 = menu.selected;
      //     }
      //     if(menu.aid === 6003){
      //       this.P6003 = menu.selected;
      //     }
      //     if(menu.aid === 6004){
      //       this.P6004 = menu.selected;
      //     }
      //     if(menu.aid === 7001){
      //       this.P7001 = menu.selected;
      //     }
      //     if(menu.aid === 7002){
      //       this.P7002 = menu.selected;
      //     }
      //     if(menu.aid === 7003){
      //       this.P7003 = menu.selected;
      //     }
      //     if(menu.aid === 8001){
      //       this.P8001 = menu.selected;
      //     }
      //     if(menu.aid === 8002){
      //       this.P8002 = menu.selected;
      //     }
      //     if(menu.aid === 8003){
      //       this.P8003 = menu.selected;
      //     }
      //     if(menu.aid === 9001){
      //       this.P9001 = menu.selected;
      //     }
      //     if(menu.aid === 9002){
      //       this.P9002 = menu.selected;
      //     }
      //     if(menu.aid === 9003){
      //       this.P9003 = menu.selected;
      //     }
      //     if(menu.aid === 9004){
      //       this.P9004 = menu.selected;
      //     }
      //     if(menu.aid === 9005){
      //       this.P9005 = menu.selected;
      //     }
      //     if(menu.aid === 10001){
      //       this.P10001 = menu.selected;
      //     }
      //     if(menu.aid === 11001){
      //       this.P11001 = menu.selected;
      //     }
      //     if(menu.aid === 11002){
      //       this.P11002 = menu.selected;
      //     }
      //     if(menu.aid === 11003){
      //       this.P11003 = menu.selected;
      //     }
      //     if(menu.aid === 11004){
      //       this.P11004 = menu.selected;
      //     }
      //     if(menu.aid === 11005){
      //       this.P11005 = menu.selected;
      //     }
      //     if(menu.aid === 12001){
      //       this.P12001 = menu.selected;
      //     }
      //     if(menu.aid === 12002){
      //       this.P12002 = menu.selected;
      //     }
      //     if(menu.aid === 12003){
      //       this.P12003 = menu.selected;
      //     }
      //     if(menu.aid === 12004){
      //       this.P12004 = menu.selected;
      //     }
      //   }

      //   if(this.$store.state.userInfo.id===5){
      //       this.P10001 = true;
      //   }
      //   this.$store.state.siteInfo = data.data
      // } else {
      //   this.$message.error(data.msg)
      // }
    },
    async refreshOutMoneyOrderNum() {
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
