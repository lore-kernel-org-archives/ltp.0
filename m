Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD523C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 22:08:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDED3C963F
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 23:08:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96B3C3C71B8
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 23:08:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E8449600196
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 23:08:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E063B212B9;
 Mon, 17 Jan 2022 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642457294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0v83BczOUYb4CGlPe8rd0oMQkPnx0oL6BDeq7lrRNik=;
 b=ti6UiXvHqlCIRD2JgMhB1arHjcqW/EkBgsyS+utbh7OdKX9XwtZ4niMaARJuxBTMXAn0y8
 u7dZVg1Qz0xHYysjBJr8RlADN0Zg0mbLkUAkvzB8xRaCBQxLLFGqWX0INRLIlnhIgYPKLm
 6/zju8gn/1Qs6G09uaeMAnSZJkDZcZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642457294;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0v83BczOUYb4CGlPe8rd0oMQkPnx0oL6BDeq7lrRNik=;
 b=gTtPvaEs/qugC365X35RvXf4zMtgulxADc3IjBZfNLKuw44czgPmXjmHo2nG5GLiFO/iKa
 vufQFtHn35zuyxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C11FA13E95;
 Mon, 17 Jan 2022 22:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /SS1Lc7o5WFgeQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jan 2022 22:08:14 +0000
Date: Mon, 17 Jan 2022 23:08:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>
Message-ID: <YeXozP1LGPscTfje@pevik>
References: <20220114161612.206475-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220114161612.206475-1-kushalkataria5@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fixes: #776,
 tst_taint prints human readable error messages instead of numerical
 codes
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

Hi Kushal,

> This patch prints human readable messages when kernel is tainted instead
> of numerical codes.

> Git Hub Issue link  - https://github.com/linux-test-project/ltp/issues/776

> Signed-off-by: Kushal Chand <kushalkataria5@gmail.com>

commit message could be improved, but that's a detail.
I'd put commit message as:

tst_taint: print readable error instead of numerical codes

Fixes: #776

Signed-off-by: Kushal Chand <kushalkataria5@gmail.com>

> ---
>  lib/tst_taint.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)

> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> index 49146aacb..049769873 100644
> --- a/lib/tst_taint.c
> +++ b/lib/tst_taint.c
> @@ -8,6 +8,48 @@

>  static unsigned int taint_mask = -1;

> +struct pair {
> +	const char *name;
> +	int val;
> +};
> +
> +#define PAIR(def)[def] = {.name = #def, .val = def},
> +
> +#define STRPAIR(key, value)[key] = {.name = value, .val = key},
> +
> +#define PAIR_LOOKUP(pair_arr, idx) do {			      \
> +	if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
> +	    pair_arr[idx].name == NULL)			      \
> +		return "???";				      \
> +	return pair_arr[idx].name;			      \
> +} while (0)

You copy pasted definitions from lib/tst_res.c. It's quite a lot of code to be
duplicated. Could you please move these definitions from include/tst_common.h
into lib/tst_res.c in separate commit?

Also when you generate new version with git format-patch, please use -v2
(as a second version). Also feel free to Cc me with
--cc 'Petr Vorel <pvorel@suse.cz>'

> +
> +const char *tst_strtaint(int err)
> +{
> +	static const struct pair taint_pairs[] = {
> +		STRPAIR(TST_TAINT_A, "TAINT_A(ACPI table overridden)")
I'd really rather remove TAINT_ (that's our LTP string, IMHO not needed)
as I suggested previously. And put space after the letter. i.e.:
		STRPAIR(TST_TAINT_A, "A (ACPI table overridden)")

Kind regards,
Petr

> +		STRPAIR(TST_TAINT_B, "TAINT_B(Bad page reference)")
> +		STRPAIR(TST_TAINT_C, "TAINT_C(Staging driver loaded)")
> +		STRPAIR(TST_TAINT_D, "TAINT_D(OOPS/BUG)")
> +		STRPAIR(TST_TAINT_E, "TAINT_E(Unsigned module loaded)")
> +		STRPAIR(TST_TAINT_F, "TAINT_F(Module force loaded)")
> +		STRPAIR(TST_TAINT_G, "TAINT_G(Propriety module loaded)")
> +		STRPAIR(TST_TAINT_I, "TAINT_I(Workaround BIOS/FW bug)")
> +		STRPAIR(TST_TAINT_K, "TAINT_K(Live patched)")
> +		STRPAIR(TST_TAINT_L, "TAINT_L(Soft lock up occured)")
> +		STRPAIR(TST_TAINT_M, "TAINT_M(Machine check exception)")
> +		STRPAIR(TST_TAINT_O, "TAINT_O(Out of tree module loaded)")
> +		STRPAIR(TST_TAINT_R, "TAINT_R(Module force unloaded)")
> +		STRPAIR(TST_TAINT_S, "TAINT_S(Running on out of spec system)")
> +		STRPAIR(TST_TAINT_T, "TAINT_T(Built with struct randomization)")
> +		STRPAIR(TST_TAINT_U, "TAINT_U(User request)")
> +		STRPAIR(TST_TAINT_W, "TAINT_W(Warning)")
> +		STRPAIR(TST_TAINT_X, "TAINT_X(Auxilary)")
> +	};
> +
> +	PAIR_LOOKUP(taint_pairs, err);
> +}
> +
>  static unsigned int tst_taint_read(void)
>  {
>  	unsigned int val;
> @@ -90,7 +132,8 @@ void tst_taint_init(unsigned int mask)
>  	}

>  	if ((taint & taint_mask) != 0)
> -		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
> +		tst_brk(TBROK, "Kernel is already tainted: %s",
> +			tst_strtaint(taint));
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
