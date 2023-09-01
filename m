Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D84CA0FE4
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 15:03:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CD843CE581
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 17:03:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CE153CAF8D
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 17:02:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1E7A71000DC5
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 17:02:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C8B5221863;
 Fri,  1 Sep 2023 15:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693580570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eirl8ZuQzk0y/ysRdkn2nTSQqVg+oDOzZFwhN7f3GIw=;
 b=pDGRlRdeQEzvD5ZZPLs/pQ4z5YdXUKU7LDEjtzODdz518EcRv7G8SmGdiMM7HpNzAMPUC/
 jCsYdo25wmGjy2vBwev/EtrAAz018FDkl1/+Axh4DAls86YycNLmsw6LoFQo65v/GZf8Ht
 zo449N1BPhn+5lHwmtDJlEyEuKWrt1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693580570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eirl8ZuQzk0y/ysRdkn2nTSQqVg+oDOzZFwhN7f3GIw=;
 b=LjOrfbhPx7dQU/AlhsSVj9TN1Y1vNI9tRMG0T/z839fuw3NzrwgOdY75Mnt3u06CkKkk+3
 FNI+hS9Bw52QP8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A50F51358B;
 Fri,  1 Sep 2023 15:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 80ZRJxr98WRncgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 01 Sep 2023 15:02:50 +0000
Message-ID: <ac801295-9ea4-9e6b-1576-3203a7dd548e@suse.cz>
Date: Fri, 1 Sep 2023 17:02:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230901144407.364630-1-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230901144407.364630-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] clone302: Fix short size test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 01. 09. 23 16:44, Petr Vorel wrote:
> Test uses sizeof(struct clone_args)-1 as invalid size. Original struct
> size 64 was suitable (because > 64 results in EINVAL), but unrelated

Nit: <64

> change in 45f6916ba increased the size to 88, thus test failed to due
> unexpected clone3() pass.
> 
> Depending on struct clone_args size is not good idea, let's use
> arbitrary value 1.

This will work, but we could also define a "minimal" struct clone_args 
(without any fields other than the required ones) and use the size of 
that (-1 of course). That would give better coverage and leave no 
untested gap between 1 and minimal struct size.

> 
> Fixes: 1b0e8dd71 ("syscalls/clone3: New tests")
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Value is really arbitrary, any hint for better value.
> Or should we delete the test?
> 
> NOTE: tested only on x86_64.
> 
> Kind regards,
> Petr
> 
>   testcases/kernel/syscalls/clone3/clone302.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> index b1b4ccebb..98848e4bc 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -34,7 +34,7 @@ static struct tcase {
>   } tcases[] = {
>   	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>   	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> -	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
> +	{"short size", &valid_args, 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
>   	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
>   	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
>   	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
