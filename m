Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C329C4332F
	for <ltp@archiver.kernel.org>; Thu, 22 Dec 2022 09:31:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D77293CB9C3
	for <ltp@archiver.kernel.org>; Thu, 22 Dec 2022 10:31:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF8E03C327F
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 10:31:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28A53200C04
 for <ltp@lists.linux.it>; Thu, 22 Dec 2022 10:31:23 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E17D576FF7;
 Thu, 22 Dec 2022 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1671701482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/bvX4Gp1bxoxWWMYO+uVXQEKGO5691pNwCk0tNrKc8=;
 b=ybQNg/kBdTUVYWLfCqswoTL4n4frhHOG7mJjD7bKwRihpEbqI0g9ZZnqop6dzu7oaUSgKw
 Y32pTZ/Awj2KlD1KK/wSwbeTDaeozSyorEKb6V5TrVozfa57qIGYNmpsvRoKH2zt4M1jJc
 6yu960tfrQaA48wgN2BDmdZaYyusFMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1671701482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j/bvX4Gp1bxoxWWMYO+uVXQEKGO5691pNwCk0tNrKc8=;
 b=snIrlY2I2G1qGbHWNDSaScCsW7u0nkBEr6IvDIRrfo+8wiwz3MACj81mKSX4jLOfpGnVYZ
 Ql+eS3uI5D9qMTCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B7FCD2C141;
 Thu, 22 Dec 2022 09:31:22 +0000 (UTC)
References: <20221221075821.3786392-1-jencce.kernel@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Murphy Zhou <jencce.kernel@gmail.com>
Date: Thu, 22 Dec 2022 09:31:13 +0000
Organization: Linux Private Site
In-reply-to: <20221221075821.3786392-1-jencce.kernel@gmail.com>
Message-ID: <87edsrss2d.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx07: umount before un-export
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

Murphy Zhou <jencce.kernel@gmail.com> writes:

> We need to umount first, or there will be an umounted mountpoint
> left behind.

Merged, thanks!

>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  testcases/kernel/syscalls/statx/statx07.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index e1ae36a35..8cb3e9b6d 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -149,6 +149,9 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> +	if (mounted)
> +		SAFE_UMOUNT(CLI_PATH);
> +
>  	if (!exported)
>  		return;
>  	snprintf(cmd, sizeof(cmd),
> @@ -156,9 +159,6 @@ static void cleanup(void)
>  
>  	if (tst_system(cmd) == -1)
>  		tst_res(TWARN | TST_ERR, "failed to clear exportfs");
> -
> -	if (mounted)
> -		SAFE_UMOUNT(CLI_PATH);
>  }
>  
>  static struct tst_test test = {
> -- 
> 2.31.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
