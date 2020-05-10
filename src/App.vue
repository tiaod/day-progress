<template>
  <router-view />
</template>

<script>
import HelloWorld from './components/HelloWorld';

export default {
  name: 'App',

  components: {
    HelloWorld,
  },

  data: () => ({
    //
  }),
};
</script>

<style lang="stylus">
html
  overflow-y hidden !important
  user-select none
</style>