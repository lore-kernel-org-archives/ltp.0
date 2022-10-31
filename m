Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF67FA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3C0A3CAA8B
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:59:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33063CA2E6
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:58:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 134081400517
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 14:58:54 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8FF30B816D4;
 Mon, 31 Oct 2022 13:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2B1C433D6;
 Mon, 31 Oct 2022 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1667224732;
 bh=3NsdpCSUWBSdV5NCvj7+OeqbVsWQVL3imQP5IYAbRdo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=eWu/QSdcLJm9+qqY9aMBJqIovw0tK5ytk9uRJaIdgWCd+nnVovlV2+T0XOut7fFVI
 lhG+RbFVEajVY3sK36wCxijBVje8qlyuiQgDsEiOhiJuUVOZpxVq+A9et7AC2o2k+n
 IMkbPyIx+KJjiyt5hDMFzATeQZroVFVCsKL2gTAVZJdd2ZXjtig4LoLSrR41XJM5+C
 Infg08zlZdUlgzSdp1AvAxs2WUiE2pOYqojpCPm/d6hejXyY+Ji5vciSw0JxMWwREf
 nRIM57Be63KCMrnqezYF7/sRb0z3U38NoUc7GLy62sJOHdHzfe6tzilNHy1Rh0t6Vm
 eKiQVu2EUWTYA==
Message-ID: <b735dfe6911387b7ba3a2fbfc599c9c55a455288.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 Oct 2022 09:58:50 -0400
In-Reply-To: <5AE322AD-FF73-4495-A3DF-60A98DBE49A7@oracle.com>
References: <Y1/P8gDAcWC/+VR3@pevik>
 <5AE322AD-FF73-4495-A3DF-60A98DBE49A7@oracle.com>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP test regression on exportfs in kernel 6.0
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 NeilBrown <neilb@suse.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Steve Dickson <steved@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 2022-10-31 at 13:47 +0000, Chuck Lever III wrote:
> [ dropping Bruce, he's no longer an NFSD maintainer ]
> 
> 
> > On Oct 31, 2022, at 9:38 AM, Petr Vorel <pvorel@suse.cz> wrote:
> > 
> > Hi all,
> > 
> > LTP tests got broken on kernel 6.0. During test cleanup it hangs on exportfs
> > (high load). I tested it both on nfs-utils 2.6.2, the same userspace, the
> > version of the tests (obviously), it looks really like kernel related regression.
> 
> Not oopsen, but rather RCU splats.
> 
> [  326.587135] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  326.587168] rcu: 	0-....: (5249 ticks this GP) idle=cf74/1/0x4000000000000000 softirq=7256/7256 fqs=2484
> [  326.587187] 	(t=5250 jiffies g=4009 q=388 ncpus=2)
> 
> and
> 
> watchdog: BUG: soft lockup - CPU#0 stuck for 44s! [exportfs:1180]
> 
> RIP: __nfsd_file_cache_purge+0x54
> 
> seems like the common element. Jeff, can you have a look at this?
> 

Sure, I'll take a look since I'm in here anyway.

I'll see if I can set up a reproducer.

> 
> > # Simple reproducer
> > git clone https://github.com/linux-test-project/ltp.git
> > # install dependencies with your distro in ci/*.sh
> > make autotools && ./configure && make -j$(getconf _NPROCESSORS_ONLN) && make install
> > export LTPROOT=/opt/ltp; PATH="/opt/ltp/testcases/bin:$PATH" nfs02.sh -v 4 -t tcp
> > TMPDIR="/var/tmp" nfs02.sh -v 4 -t tcp
> > 
> > # Example on kernel oops on openSUSE
> > [  304.772002] Initializing XFRM netlink socket
> > [  304.833577] IPv6: ADDRCONF(NETDEV_CHANGE): ltp_ns_veth1: link becomes ready
> > [  304.833604] IPv6: ADDRCONF(NETDEV_CHANGE): ltp_ns_veth2: link becomes ready
> > [  304.957269] FS-Cache: Loaded
> > [  305.002821] Key type dns_resolver registered
> > [  305.153926] NFS: Registering the id_resolver key type
> > [  305.153942] Key type id_resolver registered
> > [  305.153943] Key type id_legacy registered
> > [  326.587135] rcu: INFO: rcu_preempt self-detected stall on CPU
> > [  326.587168] rcu: 	0-....: (5249 ticks this GP) idle=cf74/1/0x4000000000000000 softirq=7256/7256 fqs=2484
> > [  326.587187] 	(t=5250 jiffies g=4009 q=388 ncpus=2)
> > [  326.587191] NMI backtrace for cpu 0
> > [  326.587192] CPU: 0 PID: 1008 Comm: exportfs Not tainted 5.19.0 #4
> > [  326.587195] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
> > [  326.587199] Call Trace:
> > [  326.587212]  <IRQ>
> > [  326.587216]  dump_stack_lvl+0x45/0x5e
> > [  326.587231]  nmi_cpu_backtrace.cold+0x30/0x76
> > [  326.587234]  ? lapic_can_unplug_cpu+0x80/0x80
> > [  326.587241]  nmi_trigger_cpumask_backtrace+0x10c/0x140
> > [  326.587252]  rcu_dump_cpu_stacks+0xf8/0x130
> > [  326.587260]  rcu_sched_clock_irq.cold+0x67/0x2f8
> > [  326.587270]  ? raw_notifier_call_chain+0x41/0x60
> > [  326.587275]  ? timekeeping_update+0xde/0x130
> > [  326.587280]  ? __cgroup_account_cputime_field+0x5d/0x90
> > [  326.587286]  update_process_times+0x62/0x90
> > [  326.587291]  tick_sched_handle+0x22/0x60
> > [  326.587300]  tick_sched_timer+0x71/0x90
> > [  326.587303]  ? tick_sched_do_timer+0xa0/0xa0
> > [  326.587306]  __hrtimer_run_queues+0x127/0x2c0
> > [  326.587310]  hrtimer_interrupt+0x106/0x220
> > [  326.587313]  __sysvec_apic_timer_interrupt+0x7c/0x170
> > [  326.587319]  sysvec_apic_timer_interrupt+0x9d/0xd0
> > [  326.587328]  </IRQ>
> > [  326.587328]  <TASK>
> > [  326.587329]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [  326.587339] RIP: 0010:__nfsd_file_cache_purge+0x54/0xd0 [nfsd]
> > [  326.587374] Code: 48 89 24 24 48 89 64 24 08 e8 88 3e e8 e5 48 8d 7c 24 10 e8 ae 53 e8 e5 48 8d 7c 24 10 e8 04 4d e8 e5 48 89 c5 48 85 c0 74 27 <48> 81 fd 00 f0 ff ff 77 55 48 85 db 74 06 48 39 5d 38 75 ec 48 89
> > [  326.587376] RSP: 0018:ffffbfe84100bd88 EFLAGS: 00000202
> > [  326.587378] RAX: ffff9dcd01f9a3a8 RBX: ffff9dcd0af86600 RCX: ffffffffc0ceabc0
> > [  326.587380] RDX: 0000000000000000 RSI: 000000000000008c RDI: ffffbfe84100bd98
> > [  326.587381] RBP: ffff9dcd01f9a3a8 R08: 0000000000000000 R09: ffffffffa6fd2b75
> > [  326.587382] R10: 0000000000000000 R11: ffffbfe84100bd98 R12: ffffbfe84100bf08
> > [  326.587383] R13: 00007fff97dc3a20 R14: ffffbfe84100bf08 R15: 0000000000000000
> > [  326.587385]  ? _raw_spin_unlock+0x15/0x30
> > [  326.587393]  ? __nfsd_file_cache_purge+0x4c/0xd0 [nfsd]
> > [  326.587410]  ? _raw_spin_unlock+0x15/0x30
> > [  326.587412]  expkey_flush+0x2a/0x40 [nfsd]
> > [  326.587427]  write_flush.constprop.0+0xf4/0x140 [sunrpc]
> > [  326.587460]  proc_reg_write+0x4e/0x90
> > [  326.587470]  vfs_write+0xc3/0x3d0
> > [  326.587478]  ? preempt_count_add+0x4d/0xa0
> > [  326.587482]  ? fd_install+0x5c/0xe0
> > [  326.587489]  ksys_write+0x5f/0xe0
> > [  326.587492]  do_syscall_64+0x38/0xc0
> > [  326.587496]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  326.587501] RIP: 0033:0x7f6f908063f3
> > [  326.587505] Code: 8b 15 21 9a 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> > [  326.587506] RSP: 002b:00007fff97dc3a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [  326.587508] RAX: ffffffffffffffda RBX: 000056110e2f8dd0 RCX: 00007f6f908063f3
> > [  326.587509] RDX: 000000000000000b RSI: 00007fff97dc3a20 RDI: 0000000000000006
> > [  326.587510] RBP: 000056110e2f500e R08: 00007f6f908b83e0 R09: 0000000000000000
> > [  326.587512] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff97dc3ad0
> > [  326.587514] R13: 00007fff97dc3a20 R14: 0000000000000006 R15: 000056110e2f4fef
> > [  326.587517]  </TASK>
> > 
> > # Bug on Debian config with openSUSE setup looks fairly similar:
> > [ 7972.371206] watchdog: BUG: soft lockup - CPU#0 stuck for 44s! [exportfs:1180]
> > [ 7972.371250] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache netfs xfrm_user xfrm_algo veth intel_rapl_msr intel_rapl_common intel_pmc_core_pltdrv intel_pmc_core kvm_intel kvm irqbypass ghash_clmulni_intel snd_hda_codec_generic ledtrig_audio aesni_intel crypto_simd cryptd rapl qxl evdev snd_hda_intel drm_ttm_helper snd_intel_dspcfg serio_raw pcspkr snd_intel_sdw_acpi ttm joydev virtio_console virtio_balloon snd_hda_codec sg drm_kms_helper snd_hda_core snd_hwdep snd_pcm qemu_fw_cfg snd_timer snd soundcore button nfsd auth_rpcgss nfs_acl lockd grace sunrpc drm fuse configfs virtio_rng rng_core ip_tables x_tables autofs4 btrfs blake2b_generic xor raid6_pq zstd_compress libcrc32c crc32c_generic hid_generic usbhid hid dm_mod virtio_net net_failover virtio_blk failover sr_mod cdrom crct10dif_pclmul crct10dif_common crc32_pclmul crc32c_intel psmouse ata_generic uhci_hcd ehci_pci ehci_hcd ata_piix usbcore libata usb_common virtio_pci virtio_pci_legacy_dev virtio_pci_m
 odern_dev
> > [ 7972.371310]  virtio virtio_ring scsi_mod i2c_piix4 scsi_common floppy
> > [ 7972.371315] CPU: 0 PID: 1180 Comm: exportfs Not tainted 6.0.1 #2
> > [ 7972.371317] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
> > [ 7972.371318] RIP: 0010:__nfsd_file_cache_purge+0x54/0xd0 [nfsd]
> > [ 7972.371344] Code: 48 89 24 24 48 89 64 24 08 e8 38 23 46 d4 48 8d 7c 24 10 e8 5e 38 46 d4 48 8d 7c 24 10 e8 b4 31 46 d4 48 89 c5 48 85 c0 74 27 <48> 81 fd 00 f0 ff ff 77 55 48 85 db 74 06 48 39 5d 38 75 ec 48 89
> > [ 7972.371348] RSP: 0018:ffffc05241067d88 EFLAGS: 00000202
> > [ 7972.371350] RAX: ffff9bd3c5380618 RBX: ffff9bd3f260d500 RCX: ffffffffc0b0cbc0
> > [ 7972.371351] RDX: 0000000000000000 RSI: 00000000000000b2 RDI: ffffc05241067d98
> > [ 7972.371352] RBP: ffff9bd3c5380618 R08: 0000000000000000 R09: ffffffff953d3aa5
> > [ 7972.371353] R10: 0000000000000000 R11: ffffc05241067d98 R12: ffffc05241067f08
> > [ 7972.371354] R13: 00007ffd820fd9f0 R14: ffffc05241067f08 R15: 0000000000000000
> > [ 7972.371356] FS:  00007fd3e4d1c740(0000) GS:ffff9bd3fec00000(0000) knlGS:0000000000000000
> > [ 7972.371357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 7972.371358] CR2: 00007fd3e4d8a040 CR3: 00000000089a6005 CR4: 0000000000370ef0
> > [ 7972.371362] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [ 7972.371363] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [ 7972.371364] Call Trace:
> > [ 7972.371367]  <TASK>
> > [ 7972.371376]  ? _raw_spin_unlock+0x15/0x30
> > [ 7972.371383]  expkey_flush+0x2a/0x40 [nfsd]
> > [ 7972.371402]  write_flush.constprop.0+0xf4/0x140 [sunrpc]
> > [ 7972.371440]  proc_reg_write+0x4e/0x90
> > [ 7972.371443]  vfs_write+0xc3/0x3d0
> > [ 7972.371446]  ? preempt_count_add+0x4d/0xa0
> > [ 7972.371450]  ? fd_install+0x5c/0xe0
> > [ 7972.371452]  ksys_write+0x5f/0xe0
> > [ 7972.371454]  do_syscall_64+0x38/0xc0
> > [ 7972.371458]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [ 7972.371460] RIP: 0033:0x7fd3e4e193f3
> > [ 7972.371462] Code: 8b 15 21 9a 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> > [ 7972.371464] RSP: 002b:00007ffd820fd9d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [ 7972.371466] RAX: ffffffffffffffda RBX: 00005559a20e4dd0 RCX: 00007fd3e4e193f3
> > [ 7972.371467] RDX: 000000000000000b RSI: 00007ffd820fd9f0 RDI: 0000000000000006
> > [ 7972.371468] RBP: 00005559a20e100e R08: 00007fd3e4ecb3e0 R09: 0000000000000000
> > [ 7972.371469] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd820fdaa0
> > [ 7972.371470] R13: 00007ffd820fd9f0 R14: 0000000000000006 R15: 00005559a20e0fef
> > [ 7972.371473]  </TASK>
> > 
> > I guess I don't need to turn any debugging with rpcdebug at this point (enough
> > info from this), right?
> > 
> > It looks like to be config related, because it's broken with openSUSE config,
> > but not with Debian config. Building with Debian config, but changing just these
> > NFS specific options it also fails:
> > 
> > # config difference Debian (-) vs openSUSE (+)
> > -CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> > +# CONFIG_NFS_DISABLE_UDP_SUPPORT is not set
> > -# CONFIG_NFSD_SCSILAYOUT is not set
> > -# CONFIG_NFSD_FLEXFILELAYOUT is not set
> > -# CONFIG_NFSD_V4_2_INTER_SSC is not set
> > +CONFIG_NFSD_SCSILAYOUT=y
> > +CONFIG_NFSD_FLEXFILELAYOUT=y
> > +CONFIG_NFSD_V4_2_INTER_SSC=y
> > 
> > I suspect it was caused by e394ff83bbca ("Merge tag 'nfsd-6.0' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux") [1], but I need to
> > finish bisecting to be sure (it was merged earlier than aeb6e6ac18c7 ("Merge tag
> > 'nfs-for-5.20-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs") [2],
> > both are broken).
> > 
> > Kind regards,
> > Petr
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e394ff83bbca1c72427b1feb5c6b9d4dad832f01
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aeb6e6ac18c73ec287b3b1e2c913520699358c13
> 
> --
> Chuck Lever
> 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
