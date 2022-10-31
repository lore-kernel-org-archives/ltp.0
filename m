Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BFDFA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 10:59:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF453CA9A0
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 11:59:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DE6B3C1BEB
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 11:59:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B5B36100064B
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 11:59:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74DA91F8EA;
 Mon, 31 Oct 2022 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667213971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGYtLhiXDnQ16RvnnsX8tzoK2EV0ZTo5dnphuhlMj+M=;
 b=GxyN/VtmoNZ+2jRi9OEMDE7NNpnb0NmH2eVhouAaGomN1c7oTTHk0BKunMSeAo21dtP1R1
 VmzTjV1RjBTTPqXy/21n5rGkqpiTCdW+kdZFwLgjDwsdp8nQ1hdPutfS+yOJgps6EzCBzJ
 TcG6z3r44C4pDE3X/Qyrmjr0iT15zls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667213971;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sGYtLhiXDnQ16RvnnsX8tzoK2EV0ZTo5dnphuhlMj+M=;
 b=z/Yq6tBToXEBDD5b207EqQ5O5Bm811yd4tQ4+cCRsMNCtjUfymrgZyY5PSHBOey/RyYhvE
 64ScduTDKWXMquAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5931913AAD;
 Mon, 31 Oct 2022 10:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LY02FJOqX2O8DAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 10:59:31 +0000
Date: Mon, 31 Oct 2022 11:59:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: You Zhou <you.zhou@intel.com>
Message-ID: <Y1+qkXXu9uqsJaVG@pevik>
References: <20221028032103.2050696-1-you.zhou@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221028032103.2050696-1-you.zhou@intel.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02
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

> When run setfsuid02 case on x86_64 platform, I got a failure even if
> the filesystem user ID is set successfully.
> "
> ./setfsuid02
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> setfsuid02.c:31: TFAIL: setfsuid(invalid_fsuid) test for expected
> 			failure: retval 11 != 0: SUCCESS (0)

> Summary:
> passed   0
> failed   1
> broken   0
> skipped  0
> warnings 0
> "

> On both success and failure, setfsuid syscall returns the previous
> filesystem user ID of the caller. In this case, if case sets
> filesystem user ID successfully for the first time, this syscall
> can return the ID previously set for the second time.

> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: You Zhou <you.zhou@intel.com>
> ---
>  testcases/kernel/syscalls/setfsuid/setfsuid02.c | 5 +++++
>  1 file changed, 5 insertions(+)

> diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> index 850f17834..441d1e27a 100644
> --- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> +++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> @@ -28,8 +28,13 @@ static void run(void)
>  	UID16_CHECK(invalid_uid, setfsuid);

>  	TST_EXP_VAL_SILENT(SETFSUID(invalid_uid), current_uid);
> +#if __x86_64__
> +	TST_EXP_VAL(SETFSUID(invalid_uid), invalid_uid,
> +		    "setfsuid(invalid_fsuid) test for expected failure:");
Hi You,

this is most certainly invalid way of fixing things.

Would you mind to test if the patch from Avinesh works for you?
https://lore.kernel.org/ltp/20221027140954.4094-1-akumar@suse.de/

Kind regards,
Petr

> +#else
>  	TST_EXP_VAL(SETFSUID(invalid_uid), current_uid,
>  		    "setfsuid(invalid_fsuid) test for expected failure:");
> +#endif
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
