Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E63FC282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 23:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742339901; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=p+iyp1HQQtkWno2N0EppnH/UBn+u1LjhdqA8PdNp47w=;
 b=D/OLaSds0RxnuES7zgpiGP3fUrORuvuB0u997ugeU8aMS+EckcoY1bEF/8zW9X0CaNjPw
 5Ja7agvEZn8lB84McoJb2dVDL5KiNYHSS238IjRAC7EFFEZbx864wdhSTSXjOUxw7Qm8r3H
 PIzGbprYLi+ndw079YF1jJbJY3B1LY8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C98983CAC66
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 00:18:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0D2F3C987E
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 00:17:59 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C0A141400170
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 00:17:58 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B75CB615CF;
 Tue, 18 Mar 2025 23:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C7FC4CEE9;
 Tue, 18 Mar 2025 23:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742339876;
 bh=9hLT1R/qEqEI3JjRlNE/G3S8Oa1/WkEMDdM5aWJsED8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CznHulGJNGzIeCn860+0aPe2lx4UiXd4lzkHS+miREdy1gauPNFqpjzyFdwgcT48E
 S9I2ZgbfaJ80IXWihQbR66sCL54OsWY7mdhFom/rZgfRZnI45cp1RTMmLv7LHCMYGi
 rbpf+h/pLFyiAOuBxhN8j5tePE3mJkeNEZTUieE4MpdQjfUAL/RtSBL2KxL+NPIdRT
 YrqpANfCKMgwZPo7a277rRZ10eIN24g1/lFaVs7mus+Fom6X+Rb+X8RPJKnD1wvk61
 Sodv2DT6B81IdGXeHO6qxJj+0++4GyWMLbDrmRwuAef0f5CZ3d9EjZc7wGDX5klx5Q
 3H9enZDeC9U2Q==
Date: Tue, 18 Mar 2025 16:17:54 -0700
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Oliver Sang <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 18, 2025 at 02:37:29PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 18, 2025 at 01:15:33AM -0700, Luis Chamberlain wrote:
> > I also can't see how the patch ("("block/bdev: enable large folio
> > support for large logical block sizes") would trigger this.
> 
> Easy enough to see by checking the backtrace.
> 
> > [  218.454517][   T51]  folio_mc_copy+0xca/0x1f0
> > [  218.454532][   T51]  __migrate_folio+0x11a/0x2d0
> > [  218.454541][   T51]  __buffer_migrate_folio+0x558/0x660
> 
> folio_mc_copy() calls cond_resched() for large folios only.
> __buffer_migrate_folio() calls spin_lock(&mapping->i_private_lock)
> 
> so for folios without buffer heads attached, we never take the spinlock,
> and for small folios we never call cond_resched().  It's only the
> compaction path for large folios with buffer_heads attached that
> calls cond_resched() while holding a spinlock.
> 
> Jan was the one who extended the spinlock to be held over the copy
> in ebdf4de5642f so adding him for thoughts.

Ah, then that LTP test isn't going to easily reproduce bugs around
compaction bug. To help proactively find compaction bugs more
deterministically we wrote generic/750 and indeed we can easily see
issues creep up with a SOAK_DURATION=9000 on ext4 on linux-next as of
yesterday next-20250317.

Mar 18 07:10:59 extra-ext4-defaults kernel: Linux version 6.14.0-rc7-next-20250317 (mcgrof@beef) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #30 SMP PREEMPT_DYNAMIC Tue Mar 18 07:05:01 UTC 2025
Mar 18 07:10:59 extra-ext4-defaults kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc7-next-20250317 root=PARTUUID=503fa6f2-2d5b-4d7e-8cf8-3a811de326ce ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0
Mar 18 07:10:59 extra-ext4-defaults kernel: BIOS-provided physical RAM map:

<-- etc -->

Mar 18 23:09:29 extra-ext4-defaults kernel: EXT4-fs (loop16): mounted filesystem dc4fc2d3-efb6-4c07-8e2d-e9cf1f9f9773 r/w with ordered data mode. Quota mode: none.
Mar 18 23:09:32 extra-ext4-defaults kernel: EXT4-fs (loop5): mounted filesystem 08064f5c-03f9-4176-a738-ca5df9f258de r/w with ordered data mode. Quota mode: none.
Mar 18 23:09:32 extra-ext4-defaults kernel: EXT4-fs (loop5): unmounting filesystem 08064f5c-03f9-4176-a738-ca5df9f258de.
Mar 18 23:09:32 extra-ext4-defaults kernel: EXT4-fs (loop16): unmounting filesystem dc4fc2d3-efb6-4c07-8e2d-e9cf1f9f9773.
Mar 18 23:09:32 extra-ext4-defaults kernel: EXT4-fs (loop16): mounted filesystem dc4fc2d3-efb6-4c07-8e2d-e9cf1f9f9773 r/w with ordered data mode. Quota mode: none.
Mar 18 23:09:32 extra-ext4-defaults unknown: run fstests generic/750 at 2025-03-18 23:09:32
Mar 18 23:09:33 extra-ext4-defaults kernel: EXT4-fs (loop5): mounted filesystem bf5fcb06-8f03-4384-bd24-3a88418a08c3 r/w with ordered data mode. Quota mode: none.
Mar 18 23:10:21 extra-ext4-defaults kernel: BUG: unable to handle page fault for address: ffff9d5640010c48
Mar 18 23:10:21 extra-ext4-defaults kernel: #PF: supervisor read access in kernel mode
Mar 18 23:10:21 extra-ext4-defaults kernel: #PF: error_code(0x0000) - not-present page
Mar 18 23:10:21 extra-ext4-defaults kernel: PGD 38601067 P4D 38601067 PUD 0 
Mar 18 23:10:21 extra-ext4-defaults kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
Mar 18 23:10:21 extra-ext4-defaults kernel: CPU: 0 UID: 0 PID: 74 Comm: kcompactd0 Not tainted 6.14.0-rc7-next-20250317 #30
Mar 18 23:10:21 extra-ext4-defaults kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Mar 18 23:10:21 extra-ext4-defaults kernel: RIP: 0010:__zone_watermark_ok+0x4e/0x1e0
Mar 18 23:10:21 extra-ext4-defaults kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
Mar 18 23:10:21 extra-ext4-defaults kernel: RSP: 0018:ffffbf47c02b7c78 EFLAGS: 00010202
Mar 18 23:10:21 extra-ext4-defaults kernel: RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
Mar 18 23:10:21 extra-ext4-defaults kernel: RDX: 0000000000000000 RSI: 0000000000002f52 RDI: ffff9d563fff9180
Mar 18 23:10:21 extra-ext4-defaults kernel: RBP: 0000000000000009 R08: 0000000000000080 R09: 00000000000030a1
Mar 18 23:10:21 extra-ext4-defaults kernel: R10: 0000000000000be4 R11: 0000000000000be4 R12: 0000000000000002
Mar 18 23:10:21 extra-ext4-defaults kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000002f52
Mar 18 23:10:21 extra-ext4-defaults kernel: FS:  0000000000000000(0000) GS:ffff9d56b6cce000(0000) knlGS:0000000000000000
Mar 18 23:10:21 extra-ext4-defaults kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 18 23:10:21 extra-ext4-defaults kernel: CR2: ffff9d5640010c48 CR3: 0000000115920006 CR4: 0000000000772ef0
Mar 18 23:10:21 extra-ext4-defaults kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 18 23:10:21 extra-ext4-defaults kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 18 23:10:21 extra-ext4-defaults kernel: PKRU: 55555554
Mar 18 23:10:21 extra-ext4-defaults kernel: Call Trace:
Mar 18 23:10:21 extra-ext4-defaults kernel:  <TASK>
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __die_body.cold+0x19/0x28
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? page_fault_oops+0xa1/0x230
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? search_module_extables+0x40/0x60
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __zone_watermark_ok+0x4e/0x1e0
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? search_bpf_extables+0x5b/0x80
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? exc_page_fault+0x16d/0x190
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? asm_exc_page_fault+0x22/0x30
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __zone_watermark_ok+0x4e/0x1e0
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? hrtimer_try_to_cancel+0x78/0x110
Mar 18 23:10:21 extra-ext4-defaults kernel:  compaction_suitable+0x4b/0xf0
Mar 18 23:10:21 extra-ext4-defaults kernel:  compaction_suit_allocation_order+0x8f/0x110
Mar 18 23:10:21 extra-ext4-defaults kernel:  kcompactd_do_work+0xbc/0x260
Mar 18 23:10:21 extra-ext4-defaults kernel:  kcompactd+0x396/0x3e0
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __pfx_kcompactd+0x10/0x10
Mar 18 23:10:21 extra-ext4-defaults kernel:  kthread+0xf6/0x240
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __pfx_kthread+0x10/0x10
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? _raw_spin_unlock+0x15/0x30
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? finish_task_switch.isra.0+0x94/0x290
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __pfx_kthread+0x10/0x10
Mar 18 23:10:21 extra-ext4-defaults kernel:  ret_from_fork+0x2d/0x50
Mar 18 23:10:21 extra-ext4-defaults kernel:  ? __pfx_kthread+0x10/0x10
Mar 18 23:10:21 extra-ext4-defaults kernel:  ret_from_fork_asm+0x1a/0x30
Mar 18 23:10:21 extra-ext4-defaults kernel:  </TASK>
Mar 18 23:10:21 extra-ext4-defaults kernel: Modules linked in: exfat xfs ext2 loop sunrpc 9p nls_iso8859_1 nls_cp437 crc32c_generic vfat fat kvm_intel kvm ghash_clmulni_intel sha512_ssse3 sha512_generic sha256_ssse3 sha1_ssse3 aesni_intel gf128mul crypto_simd cryptd 9pnet_virtio virtio_console virtio_balloon button joydev evdev serio_raw nvme_fabrics dm_mod nvme_core drm vsock_loopback vmw_vsock_virtio_transport_common vsock nfnetlink autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic efivarfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 md_mod virtio_net net_failover failover virtio_blk psmouse virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
Mar 18 23:10:21 extra-ext4-defaults kernel: CR2: ffff9d5640010c48
Mar 18 23:10:21 extra-ext4-defaults kernel: ---[ end trace 0000000000000000 ]---
Mar 18 23:10:21 extra-ext4-defaults kernel: RIP: 0010:__zone_watermark_ok+0x4e/0x1e0
Mar 18 23:10:21 extra-ext4-defaults kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
Mar 18 23:10:21 extra-ext4-defaults kernel: RSP: 0018:ffffbf47c02b7c78 EFLAGS: 00010202
Mar 18 23:10:21 extra-ext4-defaults kernel: RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
Mar 18 23:10:21 extra-ext4-defaults kernel: RDX: 0000000000000000 RSI: 0000000000002f52 RDI: ffff9d563fff9180
Mar 18 23:10:21 extra-ext4-defaults kernel: RBP: 0000000000000009 R08: 0000000000000080 R09: 00000000000030a1
Mar 18 23:10:21 extra-ext4-defaults kernel: R10: 0000000000000be4 R11: 0000000000000be4 R12: 0000000000000002
Mar 18 23:10:21 extra-ext4-defaults kernel: R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000002f52
Mar 18 23:10:21 extra-ext4-defaults kernel: FS:  0000000000000000(0000) GS:ffff9d56b6cce000(0000) knlGS:0000000000000000
Mar 18 23:10:21 extra-ext4-defaults kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 18 23:10:21 extra-ext4-defaults kernel: CR2: ffff9d5640010c48 CR3: 0000000115920006 CR4: 0000000000772ef0
Mar 18 23:10:21 extra-ext4-defaults kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Mar 18 23:10:21 extra-ext4-defaults kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Mar 18 23:10:21 extra-ext4-defaults kernel: PKRU: 55555554
Mar 18 23:10:21 extra-ext4-defaults kernel: note: kcompactd0[74] exited with irqs disabled

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
