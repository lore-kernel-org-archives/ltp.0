Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA6AC433F5
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 20:14:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 475E63C96C8
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 21:14:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40E683C268E
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 21:14:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 71C0C1400F49
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 21:14:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40BCF1F3AB;
 Thu, 20 Jan 2022 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642709682;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIO6zWI0z9Tu+ABa/EFpSjsfGURgRJhwTJHjmK5wlks=;
 b=ORSCgEBvga4VLeLM1gi+Y0SOIbvK+1XmMqS67ax+4gxFq7LT/Ua1aQDsMFrLCIZaZxzcOz
 mhr2gg2NzD++F8Gnj41J3G8ZBtxn2tHxI65VyqaXmk+2j8DB7aTFwvu/7jCGtq38KmG5xo
 ln6Bw+yHtq2569esMsZR36+QpGFTekk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642709682;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eIO6zWI0z9Tu+ABa/EFpSjsfGURgRJhwTJHjmK5wlks=;
 b=LhhpuBrPYyHPtN9jbibpmGVg9clrV5399FHU2InSzlj3HbGMGNhQMGpO0rptX55CrUHmpG
 ooH0LL2EdOL7ccDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 011DB13BE0;
 Thu, 20 Jan 2022 20:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pZ5cObHC6WGaMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jan 2022 20:14:41 +0000
Date: Thu, 20 Jan 2022 21:14:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>
Message-ID: <YenCsGyklP6fAxz2@pevik>
References: <20220120163407.30744-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220120163407.30744-1-kushalkataria5@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] tst_taint: print readable error message
 instead of numerical codes
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Kusal,

there are one problematic thing: use tst_brk() and code style.
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2-coding-style


> This patch stores the possible kernel tainted messages in taint_strings
> and corresponding error is printed.

> Fixes: #776
> ---
>  lib/tst_taint.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> index 49146aacb..e224984f5 100644
> --- a/lib/tst_taint.c
> +++ b/lib/tst_taint.c
> @@ -8,6 +8,27 @@

>  static unsigned int taint_mask = -1;

> +static const char * const taint_strings[] = {
nit: please remove space after star
static const char *const taint_strings[] = {
> +				       "G (Propriety module loaded)",
> +				       "F (Module force loaded)",
> +				       "S (Running on out of spec system)",
> +				       "R (Module force unloaded)",
> +				       "M (Machine check exception)",
> +				       "B (Bad page reference)",
> +				       "U (User request)",
> +				       "D (OOPS/BUG)",
> +				       "A (ACPI table overridden)",
> +				       "W (Warning)",
> +				       "C (Staging driver loaded)",
> +				       "I (Workaround BIOS/FW bug)",
> +				       "O (Out of tree module loaded)",
> +				       "E (Unsigned module loaded)",
> +				       "L (Soft lock up occured)",
> +				       "K (Live patched)",
> +				       "X (Auxilary)",
> +				       "T (Built with struct randomization)",
nit: Why so many levels to indent? You also mix tabs and spaces.
Could you use just 1 tab?

> +};

> +
>  static unsigned int tst_taint_read(void)
>  {
>  	unsigned int val;
> @@ -74,6 +95,7 @@ static int tst_taint_check_kver(unsigned int mask)
>  void tst_taint_init(unsigned int mask)
>  {
>  	unsigned int taint = -1;
> +	long unsigned int i;
Please use unsigned long

NOTE: warn done by 'cd lib && make check-tst_taint'
tst_taint.c:98: WARNING: type 'long unsigned int' should be specified in [[un]signed] [short|int|long|long long] order
tst_taint.c:98: WARNING: Prefer 'unsigned long' over 'long unsigned int' as the int is unnecessary

there are more warning which you can ignore for now.

>  	if (mask == 0)
>  		tst_brk(TBROK, "mask is not allowed to be 0");
> @@ -90,7 +112,10 @@ void tst_taint_init(unsigned int mask)
>  	}

>  	if ((taint & taint_mask) != 0)
> -		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> +		for (i = 0; i < ARRAY_SIZE(taint_strings); i++)
> +			if (taint & (1 << i))
> +				tst_brk(TBROK, "Kernel is already tainted: %s",
> +					taint_strings[i]);
The main reason why I just didn't fix the whitespace myself and applied is using
tst_brk(). It quits test on first matching flag. You can accumulate letters into
char array and print after loop.

nit: Please wrap the code around for { }
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

FYI we have make check target to help prevent. But some info can be confusing
(not related to your changes or even false positive):

E.g. for this:

$ cd lib && make check-tst_taint
tst_taint.c:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
=> you can ignore this

tst_taint.c:98: WARNING: type 'long unsigned int' should be specified in [[un]signed] [short|int|long|long long] order
tst_taint.c:98: WARNING: Prefer 'unsigned long' over 'long unsigned int' as the int is unnecessary
=> please fix this one 

make: [../include/mk/rules.mk:48: check-tst_taint] Error 1 (ignored)
tst_taint.c:32:21: warning: LTP-003: Symbol 'tst_taint_read' has the LTP public library prefix, but is static (private).
tst_taint.c:41:12: warning: LTP-003: Symbol 'tst_taint_check_kver' has the LTP public library prefix, but is static (private).
=> you can ignore these two.

Both code style and make check are documented at:
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2-coding-style

>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
