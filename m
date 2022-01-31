Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131C5C433F5
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 12:44:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 684C43C97E1
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 13:44:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CC7D3C94C1
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 13:44:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 271C020098C
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 13:44:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4045221128;
 Mon, 31 Jan 2022 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643633063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFbHCSi7DWG9UALrCaTCGISmlSixahPTsZ5T24KSmGg=;
 b=PSFXHIfI2R9wcZnM889U+yZ34igr+FhEEhiF0hNhQrbFpQHeEyyfw3iEoiKqhODsI9/fLp
 0nVTn9MbNiugdMg60X2/U932NVAplycT7rnyAK2uvJWSTv74zWvwv4043rsO5J+iRuZBO2
 KNEpeGQ1VnyjvmLgmqx8p8vtPbKstqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643633063;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFbHCSi7DWG9UALrCaTCGISmlSixahPTsZ5T24KSmGg=;
 b=aR8SC4G8hH5pqVi1/7Uaf3cGKoiFlLrNEmHpOhpyfCFdvLDO0yXSYMexww9xThg6twWpn5
 7v3zS+pQyQZYCwDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 130CF13C4B;
 Mon, 31 Jan 2022 12:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ScoAA6fZ92EteQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Jan 2022 12:44:23 +0000
Date: Mon, 31 Jan 2022 13:44:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YffZpWqHOhBixYbW@pevik>
References: <0e15e1df7251384368ae363cc4f19528d0e77a39.1643627166.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e15e1df7251384368ae363cc4f19528d0e77a39.1643627166.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pread02: extend buffer to avoid glibc
 overflow detection
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

Hi Jan,

> Test started failing with recent glibc (glibc-2.34.9000-38.fc36),
> which detects that buffer in pread is potentially too small:
>   tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>   *** buffer overflow detected ***: terminated
>   tst_test.c:1484: TBROK: Test killed by SIGIOT/SIGABRT!

> (gdb) bt
>   #0  __pthread_kill_implementation at pthread_kill.c:44
>   #1  0x00007ffff7e46f73 in __pthread_kill_internal at pthread_kill.c:78
>   #2  0x00007ffff7df6a36 in __GI_raise at ../sysdeps/posix/raise.c:26
>   #3  0x00007ffff7de082f in __GI_abort () at abort.c:79
>   #4  0x00007ffff7e3b01e in __libc_message at ../sysdeps/posix/libc_fatal.c:155
>   #5  0x00007ffff7ed945a in __GI___fortify_fail at fortify_fail.c:26
>   #6  0x00007ffff7ed7dc6 in __GI___chk_fail () at chk_fail.c:28
>   #7  0x00007ffff7ed8214 in __pread_chk at pread_chk.c:26
>   #8  0x0000000000404d1a in pread at /usr/include/bits/unistd.h:74
>   #9  verify_pread (n=<optimized out>) at pread02.c:44
>   #10 0x000000000040dc19 in run_tests () at tst_test.c:1246
>   #11 testrun () at tst_test.c:1331
>   #12 fork_testrun () at tst_test.c:1462
>   #13 0x000000000040e9a1 in tst_run_tcases
>   #14 0x0000000000404bde in main

> Extend it to number of bytes we are trying to read from fd.

LGTM.

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
