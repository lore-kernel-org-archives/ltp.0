Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD644C433EF
	for <ltp@archiver.kernel.org>; Sun, 13 Feb 2022 16:57:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D246C3C9F6F
	for <ltp@archiver.kernel.org>; Sun, 13 Feb 2022 17:57:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 053C03C94D2
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 17:57:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1AEE714001FC
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 17:57:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F7751F37C;
 Sun, 13 Feb 2022 16:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644771438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TfmBejJB6Pl1IluXP99VAqaQ2nXs2wD0xWwybmfJWA=;
 b=zz487qkN1lWwaETbjE8whCkTEEeqJL3bwz/BHQk5zfI8n7Ra89fBGRxRGjPRNgwMgzh41x
 cffJ8ZIzeLeO8pipvHsEkTY38n0O2Zw1F4kx0jPYWFXXf4VjmFwhi2s6PiwhV8/+zQto2m
 pVYYNQwrD6yv/DUr873BuS/849fpsRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644771438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/TfmBejJB6Pl1IluXP99VAqaQ2nXs2wD0xWwybmfJWA=;
 b=I7amOU7fRIZYJlggav90z84oochp7jXCrl0V40smXYyF3VEhQOKWuRDy1QJCKq+2DxK/Vq
 6cDr7TyP1kedLJDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D388D1331A;
 Sun, 13 Feb 2022 16:57:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XvE6MW04CWKPAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 13 Feb 2022 16:57:17 +0000
Date: Sun, 13 Feb 2022 17:57:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ygk4bFjqdKozU+zL@pevik>
References: <20220213042836.3028266-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220213042836.3028266-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup: allow child zombied for a
 while
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

Hi Li,

> Zombie process is already dead after SIGKILL is processed by the kernel,
> there's usually a kernel reason (similar to being "blocked" waiting on
> a syscall to finish) for the process not terminating.

> Due to this child having been moved under PID 1(init), there is no waitpid()
> guarantee of reaping it anymore. It completely depends on PID 1(init) reclaims
> zombie process at its own pace.

> So here allow the child exist in a zombie state if PID 1(init) does not
> reclaim resource and update the process table instantly.

> Failed CI:
>   https://github.com/linux-test-project/ltp/runs/5171298664?check_suite_focus=true

Good catch!

...
>   runtest TINFO: * test_children_cleanup.sh
>   TFAIL: Child process was left behind
>   cat /proc/69523/status
>   Name:	test_children_c
>   State:	Z (zombie)
>   Tgid:	69523
>   Ngid:	0
>   Pid:	69523
>   PPid:	1

...
> +++ b/lib/newlib_tests/test_children_cleanup.sh
> @@ -13,7 +13,13 @@ if [ "x$CHILD_PID" = "x" ]; then
>  elif ! kill -s 0 $CHILD_PID &>/dev/null; then
>  	echo "TPASS: Child process was cleaned up"
>  	exit 0
> +elif grep -q -E "Z|zombie" /proc/$CHILD_PID/status; then

task_state_array[] in fs/proc/array.c has "Z (zombie)"
Is there a reason to grep just "Z"? Because -E "Z|zombie" matches just "Z" and
when we don't grep for "State:" we can likely search for different result.
"Z (zombie)" is here form kernel git beginning (2.6.12-rc2), we should match it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
