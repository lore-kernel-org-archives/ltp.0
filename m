Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC3EC46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 10:35:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F85D3CB584
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 11:35:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B7AA3C85F1
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:35:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7C82200200
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 11:35:44 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 47D594E6CF;
 Tue, 10 Jan 2023 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673346943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zn67LjGl9hEmRs9wQHOkdlST4ymI8HJYpmI1fMUn7r8=;
 b=xVnW/o7C2I552thddQzt/fcfN4uCtQXza7kofDzgjvZ73CyIEf+zRCLXbWyHeuh5AOM/Uk
 /X+GM516i/7QkdjyXYmSv2B9Dgl+2IHRECOutV8R4se2RLcOMsfxSi2vLq8qp0Zk+YNkHf
 WlqNvbGllycE7vVvJlvNjWnjUH4WvTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673346943;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zn67LjGl9hEmRs9wQHOkdlST4ymI8HJYpmI1fMUn7r8=;
 b=jHzNE9pqeD72yvVyDqf2EnebpIph96fDihhpm2+DH59IfQmGxaRWRFVSzFGmF27fNfOVqj
 t+r68x/j4b2kLrAw==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 05E9B2C141;
 Tue, 10 Jan 2023 10:35:42 +0000 (UTC)
References: <20230109032700.7959-1-wegao@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: coolgw <coolgw1126@gmail.com>
Date: Tue, 10 Jan 2023 10:01:25 +0000
Organization: Linux Private Site
In-reply-to: <20230109032700.7959-1-wegao@suse.com>
Message-ID: <87zgaqhe2p.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c fixes: use tst_parse_filesize()
 so that we can pass sizes with units e.g. -s 128M
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

coolgw <coolgw1126@gmail.com> writes:

> Signed-off-by: WEI GAO <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/readahead/readahead02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
> index 3ed88c005..c282b4d68 100644
> --- a/testcases/kernel/syscalls/readahead/readahead02.c
> +++ b/testcases/kernel/syscalls/readahead/readahead02.c
> @@ -367,8 +367,8 @@ static void setup_readahead_length(void)
>  
>  static void setup(void)
>  {
> -	if (opt_fsizestr) {
> -		testfile_size = SAFE_STRTOL(opt_fsizestr, 1, INT_MAX);
> +        if (tst_parse_filesize(opt_fsizestr, &testfile_size, 1, INT_MAX)) {
> +		tst_brk(TBROK, "invalid initial filesize '%s'", opt_fsizestr);

So far correct; if parsing fails we call tst_brk which redirects to cleanup.

>  		tst_set_max_runtime(1 + testfile_size / (DEFAULT_FILESIZE/32));

However this will never be called because it is on the error path.

The time which we give the test to execute is proportional to the file
size (if the size is non-default!). If it were not then large file sizes
would cause timeouts (possibly at random) which would result in
regressions.

Also note that in the existing test we only use tst_set_max_runtime when
the value is non default. This is a mistake, but luckily the
test.max_runtime = 30 and the calculated runtime for the default size
would be 33. So you are not likely to cause a regression by changing
this.

Setting to changes requested in patchwork.

>  	}
>  
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
