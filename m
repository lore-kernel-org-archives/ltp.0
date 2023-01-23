Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8ECC25B50
	for <ltp@archiver.kernel.org>; Mon, 23 Jan 2023 09:37:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60EB13CB3DB
	for <ltp@archiver.kernel.org>; Mon, 23 Jan 2023 10:37:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26E273CB16B
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 10:37:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71F9F600209
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 10:37:22 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D210A1F385
 for <ltp@lists.linux.it>; Mon, 23 Jan 2023 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674466641;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKffHhO5vStoYlY1ca4AnipwECVMjp9oRGeW92ZSwjE=;
 b=OruwFfU/ZnpXpIST8p6191+HlXITcOvDpv0BtMEqZPKg1OA+9VMwyqUX7sa4luD5l3oQ4M
 pEfNcPFVgfatgG/8vTimRqvpbuDPYDJX56ftjmg+aZtlpkW0MF9zjUXp4zSiJQdTqaTZLy
 mzgMCywLRrvdE43KcTu647l3bAQNkqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674466641;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKffHhO5vStoYlY1ca4AnipwECVMjp9oRGeW92ZSwjE=;
 b=DcfopM5SaGIYgJUUbtQrTiFlnRvn+w6U5dAzvZdlkbuJPW63Rf/fwX3/9glcTmJyv9ryIW
 WwZwhenqZKkHxcBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A65D12C141;
 Mon, 23 Jan 2023 09:37:21 +0000 (UTC)
References: <87sfgawyei.fsf@suse.de> <20230123064845.13564-1-akumar@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 23 Jan 2023 09:30:14 +0000
Organization: Linux Private Site
In-reply-to: <20230123064845.13564-1-akumar@suse.de>
Message-ID: <87leltioby.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] setreuid04.c: Rewrite using new LTP API
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

Avinesh Kumar <akumar@suse.de> writes:

> +		TST_EXP_PASS(SETREUID(nobody_uid, nobody_uid));
>  
> -static void uid_verify(struct passwd *ru, struct passwd *eu, char *when)
> -{
> -	if ((getuid() != ru->pw_uid) || (geteuid() != eu->pw_uid)) {
> -		tst_resm(TFAIL, "ERROR: %s real uid = %d; effective uid = %d",
> -			 when, getuid(), geteuid());
> -		tst_resm(TINFO, "Expected: real uid = %d; effective uid = %d",
> -			 ru->pw_uid, eu->pw_uid);
> +		TST_EXP_EQ_LI(getuid(), nobody_uid);
> +		TST_EXP_EQ_LI(geteuid(), nobody_uid);

Forgot to use the macros for 16bit UIDS again. However we can fix that
before merge.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
