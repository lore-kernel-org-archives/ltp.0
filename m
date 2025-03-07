Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D68C282DE
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 10:24:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD8C43CA128
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 11:24:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9C6B3CA00D
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 11:24:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7AA5E600677
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 11:24:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 60BA91F38E;
 Fri,  7 Mar 2025 10:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741343076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
 b=206iIpJGngdxUtvntAfhGRGxs3+MOsXh2WIPsBDaihYSQ793WnV47LuqiYONxLB58nC6b/
 sfikihV2XKHby1UqDbbn/61bWNxNuIkEsHB3Ofx2Ew2QsIxU2Srm9BcVUbqJOeDt+a92Bt
 1oK9nhhuTwXm/PbbyW3fJL6EPEIyBA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741343076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
 b=tcYZkfrIFot+qp5/FVk1z9/TzWiE09MTaXHX6nTt/ZxWCfXAUWQLqFA2X99rzmo+Rk5cNn
 CrSNbkkjD/EOtDAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=206iIpJG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tcYZkfrI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741343076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
 b=206iIpJGngdxUtvntAfhGRGxs3+MOsXh2WIPsBDaihYSQ793WnV47LuqiYONxLB58nC6b/
 sfikihV2XKHby1UqDbbn/61bWNxNuIkEsHB3Ofx2Ew2QsIxU2Srm9BcVUbqJOeDt+a92Bt
 1oK9nhhuTwXm/PbbyW3fJL6EPEIyBA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741343076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGBPuazfuU8d/m3KNTLHqkIQ7W1iEh+aUAC591BnAzA=;
 b=tcYZkfrIFot+qp5/FVk1z9/TzWiE09MTaXHX6nTt/ZxWCfXAUWQLqFA2X99rzmo+Rk5cNn
 CrSNbkkjD/EOtDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C269113939;
 Fri,  7 Mar 2025 10:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VQnzJmPJymdNWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Mar 2025 10:24:35 +0000
Date: Fri, 7 Mar 2025 11:24:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20250307102429.GA272497@pevik>
References: <20250114113239.611278-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250114113239.611278-1-pvorel@suse.cz>
X-Rspamd-Queue-Id: 60BA91F38E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] IMA: Remove evm_overlay.sh
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
Cc: Ignaz Forster <iforster@suse.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi, Ignaz,

> Proof of concept, it was never fixed in the kernel.
> Instead we should have some basic EVM tests.

gently ping. Is evm_overlay.sh test useful for you?
Otherwise I'll delete it.

Kind regards,
Petr

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  runtest/ima                                   |  1 -
>  .../kernel/security/integrity/ima/README.md   | 64 -------------
>  .../integrity/ima/tests/evm_overlay.sh        | 93 -------------------
>  3 files changed, 158 deletions(-)
>  delete mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

> diff --git a/runtest/ima b/runtest/ima
> index 01942eefa3..75e5a99e7c 100644
> --- a/runtest/ima
> +++ b/runtest/ima
> @@ -7,4 +7,3 @@ ima_keys ima_keys.sh
>  ima_kexec ima_kexec.sh
>  ima_selinux ima_selinux.sh
>  ima_conditionals ima_conditionals.sh
> -evm_overlay evm_overlay.sh
> diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
> index 5b261a1914..d3c3206bf2 100644
> --- a/testcases/kernel/security/integrity/ima/README.md
> +++ b/testcases/kernel/security/integrity/ima/README.md
> @@ -64,67 +64,3 @@ and reading the IMA policy allowed in the kernel configuration:
>  CONFIG_SECURITY_SELINUX=y
>  CONFIG_IMA_READ_POLICY=y
>  ```
> -
> -## EVM tests
> -
> -`evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
> -kernel parameter) which appraises the integrity of all files owned by root and EVM setup.
> -Again, for simplicity ignore possibility to load requires rules via custom policy.
> -
> -Mandatory kernel configuration for EVM tests:
> -```
> -CONFIG_INTEGRITY=y
> -CONFIG_INTEGRITY_SIGNATURE=y
> -CONFIG_IMA=y
> -CONFIG_IMA_APPRAISE=y
> -CONFIG_EVM=y
> -CONFIG_KEYS=y
> -CONFIG_TRUSTED_KEYS=y
> -CONFIG_ENCRYPTED_KEYS=y
> -```
> -
> -Example of preparing environment on for EVM on openSUSE:
> -
> -* Boot install system with `ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix` kernel parameters
> -  (for IMA measurement, IMA appraisal and EVM protection)
> -* Proceed with installation until summary screen, but do not start the installation yet
> -* Select package `dracut-ima` (required for early boot EVM support) for installation
> -  (Debian based distros already contain IMA + EVM support in `dracut` package)
> -* Change to a console window and run commands to generate keys required by EVM:
> -```
> -# mkdir /etc/keys
> -# user_key=$(keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u)
> -# keyctl pipe "$user_key" > /etc/keys/kmk-user.blob
> -# evm_key=$(keyctl add encrypted evm-key "new user:kmk-user 64" @u)
> -# keyctl pipe "$evm_key" >/etc/keys/evm.blob
> -# cat <<END >/etc/sysconfig/masterkey
> -MASTERKEYTYPE="user"
> -MASTERKEY="/etc/keys/kmk-user.blob"
> -END
> -# cat <<END >/etc/sysconfig/evm
> -EVMKEY="/etc/keys/evm.blob"
> -END
> -# mount -t securityfs security /sys/kernel/security
> -# echo 1 >/sys/kernel/security/evm
> -```
> -
> -* Go back to the installation summary screen and start the installation
> -* During the installation execute the following commands from the console:
> -```
> -# cp -r /etc/keys /mnt/etc/ # Debian based distributions: use /target instead of /mnt
> -# cp /etc/sysconfig/{evm,masterkey} /mnt/etc/sysconfig/
> -```
> -
> -This should work on any distribution using dracut.
> -Loading EVM keys is also possible with initramfs-tools (Debian based distributions).
> -
> -Of course it's possible to install OS usual way, add keys later and fix missing xattrs with:
> -```
> -evmctl -r ima_fix /
> -```
> -
> -or with `find` if evmctl is not available:
> -```
> -find / \( -fstype rootfs -o -fstype ext4 -o -fstype btrfs -o -fstype xfs \) -exec sh -c "< '{}'" \;
> -```
> -Again, fixing requires `ima_policy=tcb|appraise_tcb ima_appraise=fix evm=fix` kernel parameters.
> diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
> deleted file mode 100755
> index 12b2a28c25..0000000000
> --- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-or-later
> -# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
> -# Based on reproducer and further discussion with Ignaz Forster <iforster@suse.de>
> -# Reproducer for not upstreamed patchset [1] and previous report [2].
> -# [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> -# [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> -
> -TST_SETUP="setup"
> -TST_CLEANUP="cleanup"
> -TST_CNT=4
> -
> -setup()
> -{
> -	EVM_FILE="/sys/kernel/security/evm"
> -
> -	[ -f "$EVM_FILE" ] || tst_brk TCONF "EVM not enabled in kernel"
> -	[ $(cat $EVM_FILE) -eq 1 ] || tst_brk TCONF "EVM not enabled for this boot"
> -
> -	require_ima_policy_cmdline "appraise_tcb"
> -
> -	lower="$TST_MNTPOINT/lower"
> -	upper="$TST_MNTPOINT/upper"
> -	work="$TST_MNTPOINT/work"
> -	merged="$TST_MNTPOINT/merged"
> -	mkdir -p $lower $upper $work $merged
> -
> -	device_backup="$TST_DEVICE"
> -	TST_DEVICE="overlay"
> -
> -	fs_type_backup="$TST_FS_TYPE"
> -	TST_FS_TYPE="overlay"
> -
> -	mntpoint_backup="$TST_MNTPOINT"
> -	TST_MNTPOINT="$PWD/$merged"
> -
> -	params_backup="$TST_MNT_PARAMS"
> -	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
> -
> -	tst_mount
> -	mounted=1
> -}
> -
> -test1()
> -{
> -	local file="foo1.txt"
> -
> -	tst_res TINFO "overwrite file in overlay"
> -	EXPECT_PASS echo lower \> $lower/$file
> -	EXPECT_PASS echo overlay \> $merged/$file
> -}
> -
> -test2()
> -{
> -	local file="foo2.txt"
> -
> -	tst_res TINFO "append file in overlay"
> -	EXPECT_PASS echo lower \> $lower/$file
> -	EXPECT_PASS echo overlay \>\> $merged/$file
> -}
> -
> -test3()
> -{
> -	local file="foo3.txt"
> -
> -	tst_res TINFO "create a new file in overlay"
> -	EXPECT_PASS echo overlay \> $merged/$file
> -}
> -
> -test4()
> -{
> -	local f
> -
> -	tst_res TINFO "read all created files"
> -	for f in $(find $TST_MNTPOINT -type f); do
> -		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
> -	done
> -}
> -
> -cleanup()
> -{
> -	[ -n "$mounted" ] || return 0
> -
> -	tst_umount $TST_MNTPOINT
> -
> -	TST_DEVICE="$device_backup"
> -	TST_FS_TYPE="$fs_type_backup"
> -	TST_MNTPOINT="$mntpoint_backup"
> -	TST_MNT_PARAMS="$params_backup"
> -}
> -
> -. ima_setup.sh
> -tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
