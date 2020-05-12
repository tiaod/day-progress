<template lang="pug">
v-menu(
    ref='menu',
    v-model='menu',
    :close-on-content-click='false',
    :nudge-right='40'
    transition='scale-transition',
    offset-y
    max-width='290px',
    min-width='290px'
    )
    template(#activator='{ on }')
        v-text-field(
            v-model='color',
            :label='label',
            :prepend-icon='prependIcon'
            readonly,
            v-on='on',
            :style='"color:" + color'
        )
            template(#prepend)
                v-icon(:color='color') {{ mdiCircle }}
    v-color-picker(v-if='menu',v-model='color')
</template>

<script>
import { mdiCircle } from '@mdi/js'
export default {
    props: ['value', 'label', 'prependIcon'],
    data(){
        return {
            menu:false,
            mdiCircle
        }
    },
    computed:{
        color:{
            set(val){
                this.$emit('input', val)
            },
            get(){
                return this.value
            }
        }
    }
}
</script>