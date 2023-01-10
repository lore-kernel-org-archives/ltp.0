Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DB2C46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 14:41:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84DEF3CCB3D
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 15:41:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9153E3CA6C2
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 15:41:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B1A461A003EC
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 15:41:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B65C877175
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673361691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWZzeVJuOReBO8vE5P1gHUZXUAHRF5OaDoi83J8Q+xE=;
 b=19+5KvY9GBo4zVmnJS0r0Z9GLKqDHKtEjPcga3n+2VHpsgg1xx3Xmk+GqmjRsYB/uA4Z66
 00LJDaWTkdk/UM5YcheV481f0k4F8WWRhlytg0S8mDs3L97/uxTqTnQyId6dJ84FT7YgmL
 oJxn2c4r1EZlmZT+nVIqhwZXaxGkKIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673361691;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eWZzeVJuOReBO8vE5P1gHUZXUAHRF5OaDoi83J8Q+xE=;
 b=ougOkFOHbyj3fFk1G7iqXw2iu41555+OGEf1uMEHrx8LOvaZa1g8ZPwLP9s8UbbhmZmMZp
 boriAOAB5yJxSfCg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6FFB22C141;
 Tue, 10 Jan 2023 14:41:31 +0000 (UTC)
References: <20230110130135.27979-1-akumar@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Tue, 10 Jan 2023 14:41:22 +0000
Organization: Linux Private Site
In-reply-to: <20230110130135.27979-1-akumar@suse.de>
Message-ID: <87ilheh2p3.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setregid01.c: Turn comment into docparse format
 and use TST_EXP_PASS macro
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

Merged, thanks!

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../kernel/syscalls/setregid/setregid01.c     | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
> index 8c9e11918..741028a4a 100644
> --- a/testcases/kernel/syscalls/setregid/setregid01.c
> +++ b/testcases/kernel/syscalls/setregid/setregid01.c
> @@ -15,14 +15,16 @@
>   * Co-pilot: Dave Fenner
>   */
>  
> -/*
> - * Testcase to test the basic functionality of setregid(2) systemm call.
> +/*\
> + * [Description]
> + *
> + * Verify the basic functionality of setregid(2) system call.
>   */
>  
>  #include "tst_test.h"
>  #include "compat_tst_16.h"
>  
> -static gid_t gid, egid;	    /* current real and effective group id */
> +static gid_t gid, egid;
>  static gid_t neg_one = -1;
>  
>  static struct tcase {
> @@ -30,23 +32,18 @@ static struct tcase {
>  	gid_t *arg2;
>  	const char *msg;
>  } tcases[] = {
> -	{&neg_one, &neg_one, "Dont change either real or effective gid" },
> +	{&neg_one, &neg_one, "Leave real and effective both gids unchanged" },
>  	{&neg_one, &egid,    "Change effective to effective gid" },
>  	{&gid,     &neg_one, "Change real to real gid" },
>  	{&neg_one, &gid,     "Change effective to real gid" },
> -	{&gid,     &gid,     "Try to change real to current real" }
> +	{&gid,     &gid,     "Change real and effective both gids to current real gid" }
>  };
>  
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  
> -	TEST(SETREGID(*tc->arg1, *tc->arg2));
> -
> -	if (TST_RET == -1)
> -		tst_res(TFAIL | TTERRNO, "%s", tc->msg);
> -	else
> -		tst_res(TPASS, "%s", tc->msg);
> +	TST_EXP_PASS(SETREGID(*tc->arg1, *tc->arg2), "%s:", tc->msg);
>  }
>  
>  static void setup(void)
> -- 
> 2.39.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
