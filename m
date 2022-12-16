Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B39C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:13:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F07E3CBC50
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 11:13:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47D9E3CBAF1
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:12:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5FDD11000D10
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:12:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66BBA21D4F;
 Fri, 16 Dec 2022 10:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671185570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCrAdReVKptaSngGucnjk70Zghlda5kMXKJ00KHBydY=;
 b=GPKqJIFTY1CMHprBIBq6ar/Z5y6hnLZybGLTT0eWeTshxi+i4TOKqQPb63d+TevCG1v9RJ
 IxISmWp1CcPnuYpmCsLRqD3MGxvaC7Od9ZNK9T7g6czn0S/OAmt012AybJmWPUb24DWAf0
 kWnGDzdIBPRTaRrKuJwwlj1AIcyKRAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671185570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCrAdReVKptaSngGucnjk70Zghlda5kMXKJ00KHBydY=;
 b=g+kemsPAFT/GziQKwg8hZQVV5/bRp2Dirgp0NRHyFsBt8wV2Vws9HZI/94Q8k56+GgI0Wi
 YsUasknnKm5xtmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3405E138F0;
 Fri, 16 Dec 2022 10:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Yp9HCqJEnGOdZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 10:12:50 +0000
Date: Fri, 16 Dec 2022 11:12:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5xEoHhXDn5EN0gA@pevik>
References: <1671166923-2173-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1671166923-2173-7-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/7] doc/c-test-api.txt
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

Hi Xu,

> Update min_kver usage. Also inotify04 has removed tst_kvercmp2,
> so remove it.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  doc/c-test-api.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index e6d121dce..f4da9ff41 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -559,7 +559,8 @@ static struct tst_test test = {
>  Testcases for newly added kernel functionality require kernel newer than a
>  certain version to run. All you need to skip a test on older kernels is to
>  set the '.min_kver' string in the 'struct tst_test' to a minimal required
> -kernel version, e.g. '.min_kver = "2.6.30"'.
> +kernel version, e.g. '.min_kver = "3.10.0"'. For ltp, the oldest supported
> +kernel version is 3.0, so we don't add this check for old kernel ie 2.6.32.
Again, not sure if this should be added.

>  For more complicated operations such as skipping a test for a certain range
>  of kernel versions, following functions could be used:
> @@ -585,8 +586,7 @@ positive means that it's newer.

>  The second function 'tst_kvercmp2()' allows for specifying per-vendor table of
>  kernel versions as vendors typically backport fixes to their kernels and the
> -test may be relevant even if the kernel version does not suggests so. See
> -'testcases/kernel/syscalls/inotify/inotify04.c' for example usage.
> +test may be relevant even if the kernel version does not suggests so.
+1 for this.

Also, I'd wait with this patchset to what brings the discussion of minimal
level.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
