Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7CDC433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 15:21:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7E93CC679
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 16:21:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 154803C32D9
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:21:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B86114002B3
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:21:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6705421B5D;
 Mon, 28 Nov 2022 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669648893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itL/eUt5kewFPO8LlNS3K2UKVzi8uiT4UqGvIDDPo6o=;
 b=F5o37dNMBsBEtij0Nz/CQeh5U/OtI7xM0qzauW190Y9Mrm2DKL555BRdzB7QEI5WS5w9WO
 buvofnfFtYRMXHg5ecllrVWYvffydWEqohcTXZyaRovy9MXF7C6x6OsKHAxR+DUsE+tNwW
 Ben3SKUWy1d0BlTpolMEBEn1eTKvpeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669648893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=itL/eUt5kewFPO8LlNS3K2UKVzi8uiT4UqGvIDDPo6o=;
 b=SZ/nIhudMstTMEWjRcVDCFSyXSxxeNzLHP3aD+uUtON8E+CzpSi4nGyWMab/iT7OUz1HYK
 Vp4IT5wT7xZPr0Bg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 399B32C141;
 Mon, 28 Nov 2022 15:21:33 +0000 (UTC)
References: <20221121135616.19369-1-rpalethorpe@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 28 Nov 2022 15:20:56 +0000
Organization: Linux Private Site
In-reply-to: <20221121135616.19369-1-rpalethorpe@suse.com>
Message-ID: <874jujumtf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty03: Add CONFIG_SERIO_SERPORT as a hint
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


Trivial patch and no remarks, so merged.

Richard Palethorpe via ltp <ltp@lists.linux.it> writes:

> It's not clear what module implements the mouse ldisc. So adding this
> helps configure test kernels.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/pty/pty03.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/testcases/kernel/pty/pty03.c b/testcases/kernel/pty/pty03.c
> index 53df6d62c..6324bc876 100644
> --- a/testcases/kernel/pty/pty03.c
> +++ b/testcases/kernel/pty/pty03.c
> @@ -153,6 +153,10 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.needs_root = 1,
>  	.max_runtime = 30,
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_SERIO_SERPORT",
> +		NULL
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "0ace17d568241"},
>  		{"CVE", "2020-14416"},
> -- 
> 2.38.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
