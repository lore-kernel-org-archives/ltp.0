Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C271FB3D17
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:43:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F6CE3E4F24
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:43:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9DA83CD9AA
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:42:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA3BD600859
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:42:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 65B5A5BD2D;
 Mon, 30 Mar 2026 10:42:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DF864A0A2;
 Mon, 30 Mar 2026 10:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +WkbBqNTymldbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 10:42:43 +0000
Date: Mon, 30 Mar 2026 12:42:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260330104237.GA82381@pevik>
References: <20260327160157.76906-1-rbranco@suse.de>
 <20260330072412.GA62327@pevik> <acpNKiCdqpKyhRo-@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acpNKiCdqpKyhRo-@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 65B5A5BD2D
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Minor fixes
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > As a separate effort: Cyril raised a question if (as a separate effort) should
> > all test have some kconfig check (e.g. CONFIG_USERFAULTFD=y)

> > IMHO it's a question if we are ok with wide spread of needs_kconfig even if it's
> > not necessary (i.e. here SAFE_USERFAULTFD() check. In that case the benefit
> > would be 1) documentation of dependencies for testers in the test catalog 2)
> > check earlier that before running test code. And of course disadvantage to
> > really drag kconfig dependency, but we have accepted that already.

> > Ideally we'd decide on some policy (which may also includes .needs_drivers).
> > @all I planned to reword my original policy patch [1] to Li's suggestion +
> > Cyril's kconfig changes [2], but that still does not have "use kconfig to
> > document dependencies".

> I think that we can get rid of needs_drivers if we add more runtime
> checks.

> We have needs_drivers in:

> - kvm tests -> CONFIG_KVM + runtime check for kvm module
Maybe some of KVM might be more specific.

> - zram tests -> CONFIG_ZRAM + runtime check for zram module
> - squasfs tests -> CONFIG_SQUASHFS + runtime check for squashfs module
> - setxattr02 -> CONFIG_BLK_DEV_RAM + runtime check for brd module
> - ioctl08 -> has both filesystems and needs_drivers set to btrfs
>              likely we do not need the needs_drivers there
> - ioctl_loop tests -> CONFIG_BLK_DEV_LOOP + runtime check for loop module
> - madvise11 -> CONFIG_HWPOISON_INJECT + runtime check for hwpoison_inject module
> - quotactl tests -> CONFIG_QUOTA_V2 + runtime check for quota_v2 module
And quota_remount_test01.sh shell test.

> - uinput tests -> CONFIG_BLK_DEV_LOOP + CONFIG_TUN + CONFIG_INPUT_UINPUT
> - can tests -> CONFIG_CAN_VCAN + CONFIG_CAN_RAW + CONFIG_CAN_BCM

FYI a bit more, just few of them, but fortunately all for have config.
I'd be surprised if there was a kernel module without it.

testcases/cve/tcindex01.c dummy -> CONFIG_DUMMY

shell has more tests (fortunately already supports $TST_NEEDS_KCONFIGS):
tst_net.sh (if using nets) netns_lib.sh: veth -> CONFIG_VETH
binfmt_misc_lib.sh: binfmt_misc -> CONFIG_BINFMT_MISC + runtime check for binfmt_misc module
+ many more

> If we agree that we want to switch from needs_drivers to needs_kconfig +
> runtime checks I will add mappings from congfigs to module names into
> tst_kconfig and convert the tests..

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
