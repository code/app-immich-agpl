<script lang="ts">
  import UserPageLayout from '$lib/components/layouts/user-page-layout.svelte';
  import UserSettingsList from '$lib/components/user-settings-page/user-settings-list.svelte';
  import ShortcutsModal from '$lib/modals/ShortcutsModal.svelte';
  import { Container, IconButton, modalManager } from '@immich/ui';
  import { mdiKeyboard } from '@mdi/js';
  import { t } from 'svelte-i18n';
  import type { PageData } from './$types';

  interface Props {
    data: PageData;
  }

  let { data }: Props = $props();
</script>

<UserPageLayout title={data.meta.title}>
  {#snippet buttons()}
    <IconButton
      shape="round"
      color="secondary"
      variant="ghost"
      icon={mdiKeyboard}
      aria-label={$t('show_keyboard_shortcuts')}
      onclick={() => modalManager.show(ShortcutsModal, {})}
    />
  {/snippet}
  <Container size="medium" center>
    <UserSettingsList keys={data.keys} sessions={data.sessions} />
  </Container>
</UserPageLayout>
