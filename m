Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D3C433EF
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 16:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FF5C3C97D8
	for <ltp@archiver.kernel.org>; Mon, 31 Jan 2022 17:23:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 640943C2417
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 17:23:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 29B9C1400DA1
 for <ltp@lists.linux.it>; Mon, 31 Jan 2022 17:23:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6371A1F383;
 Mon, 31 Jan 2022 16:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643646215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCv6xouH1lcpPWXQ54IH7RhTWE74JvmFpggEhfZp6g0=;
 b=KheqZfaZZtK5HefX9djYUMhOXWE/oDTEjtxjyIoITElB+sy92WgQcW7+3YSu14lomvecC+
 IXPd6W9hI+17/844ENfziwIShbrTww3zWwDXUOxZ2N/4DK83+/J/5XadWMe5LiQ9pMjJic
 yxVhNdAqw97yH+nEQOHDmrVxl/vVAIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643646215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LCv6xouH1lcpPWXQ54IH7RhTWE74JvmFpggEhfZp6g0=;
 b=h+8xGk/fs6fcKUM+T2v/BTkO2feKeC7ZNV0kOcTbWt542vqqsdMWx/bRkia6f4a6MsU/Yc
 eaIRGVGKZvg27UAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49BB413C91;
 Mon, 31 Jan 2022 16:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Qjk0EAcN+GEyeQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Jan 2022 16:23:35 +0000
Date: Mon, 31 Jan 2022 17:25:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YfgNecOiJaTkD6FD@yuki>
References: <0e15e1df7251384368ae363cc4f19528d0e77a39.1643627166.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e15e1df7251384368ae363cc4f19528d0e77a39.1643627166.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Test started failing with recent glibc (glibc-2.34.9000-38.fc36),
> which detects that buffer in pread is potentially too small:
>   tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>   *** buffer overflow detected ***: terminated
>   tst_test.c:1484: TBROK: Test killed by SIGIOT/SIGABRT!
> 
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
> 
> Extend it to number of bytes we are trying to read from fd.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/pread/pread02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/pread/pread02.c b/testcases/kernel/syscalls/pread/pread02.c
> index de2a81fffc37..fda5fd19037c 100644
> --- a/testcases/kernel/syscalls/pread/pread02.c
> +++ b/testcases/kernel/syscalls/pread/pread02.c
> @@ -39,7 +39,7 @@ struct test_case_t {
>  static void verify_pread(unsigned int n)
>  {
>  	struct test_case_t *tc = &tcases[n];
> -	char buf;
> +	char buf[K1];

Either we do this, or change the nb to 1 in the tcases.

Anyways:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
