Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8A3C6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 13:46:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FB8F3CAEAF
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 14:46:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C2BA3C01AA
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 14:46:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D10A6001FD
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 14:46:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F214D1FE07;
 Mon, 13 Mar 2023 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678715188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4cD9P6DNbFUNffTdJtFClemEn78m7WOcKsuD2fWuiBU=;
 b=osEuFmWqpmGLzIY/8f25U24/WyLzsipMY1RteOLULKGXnYdC5VKNoBwOurKPHbHlAtlo3E
 E0BXqcksJFpo7zTWP7j7Z6lvv/kMPFjo5KJQoap8fOIq++0JAouxslnW/RyHfW5VnKAGdo
 UEq41B8xK67xWAvjgh/uq8z9bSntq+w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D922613517;
 Mon, 13 Mar 2023 13:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b9DBJDMpD2RZMwAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 13 Mar 2023 13:46:27 +0000
Date: Mon, 13 Mar 2023 09:46:24 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230313134624.GA9783@localhost>
References: <20230311023343.25177-1-wegao@suse.com>
 <20230312004420.16457-1-wegao@suse.com> <ZA7qq15aeKS+ZeJR@yuki>
 <20230313122100.GA12608@localhost> <ZA8Y+O7QFfVB0/62@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZA8Y+O7QFfVB0/62@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] madvise11.c:Check loadable module before rmmod
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Mar 13, 2023 at 01:37:12PM +0100, Cyril Hrubis wrote:
> Hi!
> > > That does not solve the problem completely though, if we have a kernel
> > > where the hwpoinson_inject is set to N in config the test will attempt
> > > to rmmod it and get different error.
> > 
> > 
> > I have tested on the kernel which set to N in config and the test will report:
> > tst_test.c:1180: TCONF: hwpoison_inject driver not available
> > 
> > I think it should caused by following configuration of test case:
> >         .needs_drivers = (const char *const []) {
> >                 HW_MODULE,
> >                 NULL
> >         },
> > 
> > So the scenario of "N in kernel config" already handled by LTP framework, i have
> > to say LTP frame work already do a lot of things which i have no idea... xD
> 
> Ah, missed that part as well.
> 
> Looking at lib/tst_kernel.c we can also easily add tst_buildin_driver()
> function into the LTP library with just:
> 
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index ecf4b917e..6000522b7 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -153,6 +153,11 @@ static int tst_check_driver_(const char *driver)
>         return -1;
>  }
> 
> +int tst_buildin_driver(const char *driver)
> +{
> +       return !tst_search_driver(driver, "modules.buildin");
> +}
> +
>  int tst_check_driver(const char *driver)
>  {
>  #ifdef __ANDROID__
> 

Try use above implementation but i found another TWARN : (

localhost:/home/ltp/testcases/kernel/syscalls/madvise # ./madvise11
tst_test.c:1560: TINFO: Timeout per run is 0h 01m 00s
madvise11.c:396: TINFO: Spawning 5 threads, with a total of 800 memory pages
madvise11.c:165: TINFO: Thread [3] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [1] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [2] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [4] returned 0, succeeded.
madvise11.c:165: TINFO: Thread [0] returned 0, succeeded.
madvise11.c:199: TPASS: soft-offline / mmap race still clean
madvise11.c:327: TWARN: open(/sys/kernel/debug/hwpoison/unpoison-pfn,1,0000) failed: ENOENT (2) !!!!


> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
