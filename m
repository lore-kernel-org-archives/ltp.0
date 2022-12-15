Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF22C4332F
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 11:09:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 426AC3CBCB4
	for <ltp@archiver.kernel.org>; Thu, 15 Dec 2022 12:09:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 923303CBC83
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 12:09:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24BF8200B6B
 for <ltp@lists.linux.it>; Thu, 15 Dec 2022 12:09:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6E17221BB4;
 Thu, 15 Dec 2022 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671102545;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrIRWlprqqCJyPRxMjp3T94pov+Y5Yn/MME2UL4ydyY=;
 b=KXQu2cA6DTWFbaSJ0J1oc9HOlZg+tNtVsYYCd7B0g3gW0lsTuI0w/5KtFf5N/IIJwRCNkg
 mklwAXVB+SdqYcUVw/Eyio0tjAb4oJhxHMU7Zkq9g/TJj5RyN9lyiFOi0rJ5pJxkq4BFQF
 58Wd4ZJPAjs9oJSJ9c7YxgnCEmW5I70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671102545;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mrIRWlprqqCJyPRxMjp3T94pov+Y5Yn/MME2UL4ydyY=;
 b=QJoWOZxnPxzeQqnkfLC2Wr73l5WlOKEIKNrZrWqIA6ZsWPL2hOMp+o8Qbj7F/84wG4vgY9
 5NyJ9SCkfaSq33BQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 42A962C141;
 Thu, 15 Dec 2022 11:09:05 +0000 (UTC)
References: <1671079666-15971-1-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 15 Dec 2022 11:08:15 +0000
Organization: Linux Private Site
In-reply-to: <1671079666-15971-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87len8q5yn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setresuid04: Use SETRESUID instead of
 SAFE_SETRESUID to check 16bit syscall
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

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/syscalls/setresuid/setresuid04.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
> index 833aee91d..57b290f37 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid04.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
> @@ -40,7 +40,7 @@ static void run(void)
>  	pid_t pid;
>  	int status;
>  
> -	SAFE_SETRESUID(-1, ltpuser->pw_uid, -1);
> +	TST_EXP_PASS_SILENT(SETRESUID(-1, ltpuser->pw_uid, -1));
>  	TST_EXP_FAIL2(open(TEMP_FILE, O_RDWR), EACCES);
>  
>  	pid = SAFE_FORK();
> @@ -52,7 +52,7 @@ static void run(void)
>  	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
>  		tst_res(TFAIL, "child process exited with status: %d", status);
>  
> -	SAFE_SETRESUID(-1, 0, -1);
> +	TST_EXP_PASS_SILENT(SETRESUID(-1, 0, -1));
>  	TST_EXP_FD(open(TEMP_FILE, O_RDWR));
>  	SAFE_CLOSE(TST_RET);
>  }
> -- 
> 2.27.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
