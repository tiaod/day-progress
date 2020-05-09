<template lang="pug">
v-menu(
    ref='menu',
    v-model='menu',
    :close-on-content-click='false',
    :nudge-right='40'
    :return-value.sync='time',
    transition='scale-transition',
    offset-y
    max-width='290px',
    min-width='290px'
    )
    template(#activator='{ on }')
        v-text-field(
            v-model='time',
            :label='label',
            :prepend-icon='prependIcon'
            readonly,
            v-on='on'
        )
    v-time-picker(v-if='menu',v-model='time', full-width, @click:minute="$refs.menu.save(time)", format='24hr')
</template>

<script>
export default {
    props: ['value', 'label', 'prependIcon'],
    data(){
        return {
            menu:false,
        }
    },
    computed:{
        time:{
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