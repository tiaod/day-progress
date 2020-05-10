<template lang="pug">
  v-app
    v-content
      v-container(fill-height)
        v-row
          v-col
            v-alert(v-if='color=="error"', dense, outlined, type='error')
              | 警告：你正在透支明天！
            template(v-if='circular')
              .text-center
                v-progress-circular(
                  :size='280'
                  :width='40'
                  :value='progress'
                  color='primary'
                )
                  strong.headline {{ progress }}%
                p.mt-3 {{ timeLeft }}
                  v-btn(text, icon, color='grey', @click='dialog=true')
                    v-icon {{ mdiCog }}
            template(v-else)
              v-progress-linear(
                :reverse='true'
                :value="progress"
                :color='color'
                height="65")
              v-row
                v-col
                  strong {{ progress }}%
                  p {{ timeLeft }}
                  //- p now: {{ now.calendar() }}
                  //- p 开始时间{{ startDay.calendar() }}
                  //- p 结束时间{{ endDay.calendar() }}
                v-col
                  v-btn(text, icon, color='grey', @click='dialog=true').float-right
                    v-icon {{ mdiCog }}
        v-dialog(v-model='dialog', max-width='800', persistent)
          v-card
            v-card-title 设置
              v-spacer
              v-btn(text ,icon, @click='save')
                v-icon {{ mdiClose }}
            v-card-text
              v-form
                v-row
                  v-col
                    v-switch(label='暗黑模式', v-model='$vuetify.theme.dark')
                    v-switch(label='环形进度条', v-model='circular')
                    //- v-text-field(label='起床时间')
                    TimePicker(v-model='start', label='起床时间')
                    TimePicker(v-model='end', label='睡觉时间')
                    v-divider.my-2
                    .subheader 高级选项
                    TimePicker(v-model='newDayBegins', label='新一天开始时间')
            v-card-actions
              v-spacer
              v-btn(color='primary', @click='save') 保存
                      
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'
import TimePicker from '@/components/TimePicker.vue'
import dayjs from 'dayjs'
import { mdiCog, mdiClock, mdiClose } from '@mdi/js'
export default {
  name: 'Home',
  data(){
    return {
      dialog: false, //设置弹窗
      start: localStorage.getItem('settings.start') || '9:00', //早上9点
      end: localStorage.getItem('settings.end') || '22:00', //晚上10点
      color: 'primary', // 进度条颜色
      circular: localStorage.getItem('settings.circular') == 'true', //圆环进度条
      now: dayjs(), //dayjs().set('hour', 1).set('minute',0).set('second', 45), 
      newDayBegins: localStorage.getItem('settings.newDayBegins') || '6:00', //两天的分界线
      mdiCog,
      mdiClock,
      mdiClose
    }
  },
  created(){
    setInterval(()=>this.now = dayjs(),1000)
  },
  computed:{
    newDayBeginsDay(){
      let newDayBegins = this.newDayBegins.split(':')
      newDayBegins = this.now.set('hour', newDayBegins[0]).set('minute', newDayBegins[1]).set('second', 0)
      return newDayBegins
    },
    endDay(){
      let end = this.end.split(':').map(i=>parseInt(i))
      end = this.now.set('hour', end[0]).set('minute', end[1]).set('second', 0)
      if(end.isBefore(this.startDay)){
        end = end.add(1, 'day')
      }else if(this.now.isBefore(this.newDayBeginsDay)){
        end = end.subtract(1, 'day')
      }
      return end
    },
    startDay(){
      let start = this.start.split(':').map(i=>parseInt(i))
      start = this.now.set('hour', start[0]).set('minute', start[1]).set('second', 0)
      if(this.now.isBefore(this.newDayBeginsDay)){ //在新一天分界线之前，算前一天。
        start = start.subtract(1, 'day')
      }
      return start
    },

    timeLeft(){
      let res = this.now.to(this.endDay)
      return res.substr(0, res.length - 1)
    },
    progress(){
      
      let progress = (this.now.unix() - this.endDay.unix())/(this.startDay.unix() - this.endDay.unix())
      progress = progress*100
      progress = progress.toFixed(3)
      if(progress < 0){
        this.color = 'error'
        return -progress
      }else{
        this.color = 'primary'
        return progress
      }
    }
  },
  methods:{
    save(){
      localStorage.setItem('settings.start', this.start)
      localStorage.setItem('settings.end', this.end)
      localStorage.setItem('settings.dark', this.$vuetify.theme.dark)
      localStorage.setItem('settings.newDayBegins', this.newDayBegins)
      localStorage.setItem('settings.circular', this.circular)
      this.dialog=false
    }
  },
  components: {
    HelloWorld,
    TimePicker
  }
}
</script>
