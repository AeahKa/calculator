<template>
  <div class="calculator">
    <Calculator />
  </div>

</template>

<script lang="ts">
import Calculator from './components/Calculator.vue';
export default {
  components: { Calculator }
}
</script>

<style lang="scss" scoped>
.calculator {
  position: relative;
  max-width: 500px;
  margin: 25vh auto;
}
</style>
