<h1>Preferences</h1>

<table border="1">
	<tr>
		<th>Key Name</th>
		<th>Value</th>
	</tr>
	
	{#each lAllowedKeys as name}
		<tr>
			<td>{name}</td>
			<td>
				<input {name} bind:value={$hPrefs[name]} />
			</td>
		</tr>
	{/each}
</table>

<script lang="coffee">
	import {
		hPrefs, lAllowedKeys,
		} from '$lib/stores.js'
</script>

