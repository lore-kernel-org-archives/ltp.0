Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9DAC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 21:02:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC653CAE0A
	for <ltp@archiver.kernel.org>; Thu,  6 Oct 2022 23:02:35 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDE213CAA2E
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 23:02:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DD0814016FB
 for <ltp@lists.linux.it>; Thu,  6 Oct 2022 23:02:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4BBB1F8AB;
 Thu,  6 Oct 2022 21:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665090141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqJaKJxRsur4AiQXbdrnBdMsy84tCF7PKfz8qyfkzQA=;
 b=TalVfN0hcl2jRQomKAGm2H0VMJj0vO2yjMNui1W6AQgOYh3LjxwD8hGrxlLlMau8RW8i9S
 IZYUnDyG1cMkpxP+OOz8V1X0PBfGclG/00RkWdw1IC1m2lDmvem4lN17V7JvMlrC913GCS
 16z/k83FlM+g8C4P1OBjNJKx4Khd37E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665090141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tqJaKJxRsur4AiQXbdrnBdMsy84tCF7PKfz8qyfkzQA=;
 b=s2A7zASfYnTQNuXD9o7/b4r7XhxtKtg77VvuqjX3v/P/MySWB3CBNkPlmzTrh4L13/iPbS
 wAunkiCmxXHZCrAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72A861376E;
 Thu,  6 Oct 2022 21:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FjFcGV1CP2OcDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Oct 2022 21:02:21 +0000
Date: Thu, 6 Oct 2022 23:02:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <Yz9CW5vXCuztOTOl@pevik>
References: <20221006164342.68763-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221006164342.68763-1-zohar@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] security/ima: limit the scope of the LTP policy
 rules based on the UUID
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

Hi Mimi,

> The LTP policy rules either replace or extend the global IMA policy. As a
> result, the ordering of the LTP IMA tests is important and affects the
> ability of re-running the tests.  For example, ima_conditionals.sh
> defines a rule to measure user files, while ima_measuremnets.sh verifies
> not measuring user files.  Not limiting the LTP IMA policy scope could
> also affect the running system.

> To allow the LTP tests to be re-run without rebooting the system, limit the
> scope of the LTP policy rules to the loopback mounted filesystem based on
> the UUID.
Thanks a lot for this, that'll be a great simplification for IMA testing.
I'll have a deeper look tomorrow, but what we need is to ima_setup.sh is to
always have loopback device. ATM it's just only if TMPDIR is tmpfs.
See patch below (untested, I'll test it tomorrow).

Also is the kernel code path very different to use UUID from the current code?
If yes, we might want also to keep the old behavior enabled with some environment
variable (the default would be to use UUID). Or not worth of keeping it?

I'd also wish to have simple C implementation instead requesting blkid
(although util-linux is very common, it's an extra dependency).
I might write simple C code which finds which UUID in /dev/disk/by-uuid/ is for
loop device should be pretty simple code. But for now it's ok to use blkid,
although it should be added into TST_NEEDS_CMDS.

...
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> index 0d50db906..d5c5f3ebe 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> @@ -28,7 +28,7 @@ verify_measurement()
>  	ROD rm -f $test_file

>  	tst_res TINFO "verify measuring user files when requested via $request"
> -	ROD echo "measure $request=$value" \> $IMA_POLICY
> +	ROD echo "measure $FSUUID $request=$value" \> $IMA_POLICY
>  	ROD echo "$(cat /proc/uptime) $request test" \> $test_file

>  	case "$request" in
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> index af1fb0028..95e7331a4 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> @@ -27,7 +27,12 @@ load_policy()
>  	exec 2>/dev/null 4>$IMA_POLICY
>  	[ $? -eq 0 ] || exit 1

> -	cat $1 >&4 2> /dev/null
> +	if [ -n "$FSUUID" ]; then
Interesting, would it be correct if there is no UUID with my changes below (i.e.
always use the loop device)? Actually, do we also want to have way to disable
loop device (obviously only on TMPDIR not being tmpfs).
> +		sed "s/measure /measure $FSUUID /" $1 >&4 2> /dev/null
> +	else
> +		cat $1 >&4 2> /dev/null
> +	fi
> +
>  	ret=$?
>  	exec 4>&-

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index df3fc5603..016a68cb2 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -178,6 +178,10 @@ ima_setup()
>  	if [ "$TST_MOUNT_DEVICE" = 1 ]; then
>  		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
>  		cd "$TST_MNTPOINT"
> +
> +		loopdev=$(mount | grep $TST_MNTPOINT | cut -f1 -d' ')
We have $TST_DEVICE for this.

> +		FSUUID="fsuuid=$(blkid | grep $loopdev | cut -f2 -d'"')"
> +		tst_res TINFO "LTP IMA policy rules based on $FSUUID"
>  	fi

>  	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER

Proposed (not yet tested) changes.

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/tests/ima_setup.sh testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 016a68cb2..dd88fbc71 100644
--- testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -11,9 +11,7 @@ TST_CLEANUP_CALLER="$TST_CLEANUP"
 TST_CLEANUP="ima_cleanup"
 TST_NEEDS_ROOT=1
 TST_MOUNT_DEVICE=1
-
-# TST_MOUNT_DEVICE can be unset, therefore specify explicitly
-TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="$TST_NEEDS_CMDS blkid"
 
 SYSFS="/sys"
 UMOUNT=
@@ -179,8 +177,7 @@ ima_setup()
 		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
 		cd "$TST_MNTPOINT"
 
-		loopdev=$(mount | grep $TST_MNTPOINT | cut -f1 -d' ')
-		FSUUID="fsuuid=$(blkid | grep $loopdev | cut -f2 -d'"')"
+		FSUUID="fsuuid=$(blkid | grep $TST_DEVICE | cut -f2 -d'"')"
 		tst_res TINFO "LTP IMA policy rules based on $FSUUID"
 	fi
 
@@ -339,10 +336,4 @@ require_evmctl()
 	fi
 }
 
-# loop device is needed to use only for tmpfs
-TMPDIR="${TMPDIR:-/tmp}"
-if tst_supported_fs -d $TMPDIR -s "tmpfs"; then
-	unset TST_MOUNT_DEVICE
-fi
-
 . tst_test.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
