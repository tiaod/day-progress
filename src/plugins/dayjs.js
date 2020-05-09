import dayjs from 'dayjs'
import relativeTime from 'dayjs/plugin/relativeTime'
import calendar from 'dayjs/plugin/calendar'
import 'dayjs/locale/zh-cn'
dayjs.extend(calendar)
dayjs.locale('zh-cn')
dayjs.extend(relativeTime)