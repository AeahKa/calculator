<template>
  <div class="calculator">
    <div class="display">
      <span class="sign">{{ sign }}</span>{{ output }}
    </div>
    <div class="keyboard clearfix">
      <button @click="input">7</button><button @click="input">8</button><button @click="input">9</button><button
        @click="calculate">÷</button><button @click="backSpace">Del</button> <button @click="input">4</button><button
        @click="input">5</button><button @click="input">6</button><button @click="calculate">×</button><button
        @click="clear">C</button><button @click="input">1</button><button @click="input">2</button><button
        @click="input">3</button><button @click="calculate">-</button><button class="equal"
        @click="equal">=</button><button class='zero' @click="input">0</button><button @click="input">.</button><button
        @click="calculate">+</button>
    </div>
  </div>
</template>

<script lang="ts">
import { ref } from 'vue';
import copy from "../lib/copy";
export default {
  setup() {
    const output = ref("0");
    const sign = ref("");
    const numberCache = ref(0);
    const input = function (event: MouseEvent) {
      const button = event.target as HTMLButtonElement;
      const input = button.textContent!;
      if (output.value.length === 16) {
        return;
      }
      if (output.value === "0") {
        if (input !== ".") {
          output.value = input;
        } else {
          output.value += input;
        }
        return;
      }
      if (output.value.indexOf(".") >= 0 && input === ".") {
        return;
      }
      output.value += input;
    }

    const calculate = function (event: MouseEvent) {
      const button = event.target as HTMLButtonElement;
      const input = button.textContent!;
      const number = parseFloat(copy(output.value));
      if (numberCache.value != 0) {
        numberCache.value = cal(sign.value, numberCache.value, number);
      } else {
        numberCache.value = number;
      }
      output.value = "0";
      sign.value = input;
    }
    const equal = function () {
      if (output.value === "0" && numberCache.value != 0) {
        output.value = numberCache.value.toString();
        sign.value = "";
        return;
      } else if (sign.value === "") {
        sign.value = "";
        return;
      }
      const number = parseFloat(copy(output.value));
      output.value = cal(sign.value, numberCache.value, number).toString();
      numberCache.value = 0;
      sign.value = "";
    }
    const cal = function (key: string, a: number, b: number) {
      if (key === "+") {
        a = a + b;
      } else if (key === "-") {
        a = a - b;
      } else if (key === "×") {
        a = a * b;
      } else if (key === "÷") {
        a = a / b;
      }
      return a;
    }

    const backSpace = function () {
      if (output.value.length === 1) {
        output.value = "0";
      } else {
        output.value = output.value.slice(0, -1);
      }
    }
    const clear = function () {
      output.value = "0";
    }

    return {
      output, sign, numberCache, input, calculate, equal, cal, backSpace, clear
    }
  }



}
</script>

<style lang="scss" scoped>
.calculator {
  width: 100%;
  display: flex;
  flex-flow: column;
  align-items: center;

  .display {
    width: 100%;
    padding: 9px 0;
    font-size: 36px;
    text-align: right;
    font-family: Consolas, monospace;
    box-shadow: inset 0 -3px 3px -3px fade-out($color: #000000, $amount: 0.6),
      inset 0 3px 3px -3px fade-out($color: #000000, $amount: 0.4);

    >.sign {
      color: #d9d9d9;
      margin-right: 10px;
    }
  }

  .keyboard {
    width: 100%;
  }

  button {
    &::after {
      content: '';
      clear: both;
      display: block;
    }

    width: 20%;
    height: 8vh;
    float: left;
    color: #515151;
    background: rgba(51, 51, 51, 0.034);
    border: none;
    font-size: 22px;
    box-shadow: inset 0 0 2px fade-out($color: #000000, $amount: 0.9);

    &.equal {
      height: 16vh;
      float: right;
    }

    &.zero {
      width: 40%;
    }
  }


}
</style>