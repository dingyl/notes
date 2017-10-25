<div id="app">
    <input type="text" v-model.trim="newlist" v-on:keyup.enter="addnewlist">
    <ul>
        <mylist v-for="(list, index) in lists" v-bind:list="list" v-bind:key="index"  v-on:remove="removelist(index)"></mylist>
    </ul>
</div>