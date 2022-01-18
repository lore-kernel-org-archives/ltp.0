Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6A4C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 11:28:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A01CB3C965D
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 12:28:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCD633C875F
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 12:28:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C9EE2009A6
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 12:28:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E30D1F3A1;
 Tue, 18 Jan 2022 11:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642505320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upkRVXDQGY44i+PizPDZD8Ow7VTL1X37D5OSdOcU1TI=;
 b=hKYlmvC5EqrTYcgQOQD/vv9kYI7fdH2bwi25CTuFcu/JmBCTOZpM/O+Y7yHFEL5+4wYFQi
 hhwHGCrCJ/ATqVl29XgLzFeAODa0oEey/OgK09IwYWdJXxC4DK+N2uKG+p0vwkgb0aszoE
 +UrA4w2liDNvCyikyRH5PWWIogkIdDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642505320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upkRVXDQGY44i+PizPDZD8Ow7VTL1X37D5OSdOcU1TI=;
 b=PI/f76IG2gHgY/mhWghyS++BCx6U7uGv4v4ayYMfmABpMlqgIeZ98mpGCNUCiU9sdqKgc6
 6blSwXG2juP3qLAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07EA713DC7;
 Tue, 18 Jan 2022 11:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S77EAGik5mGZTwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 18 Jan 2022 11:28:40 +0000
Message-ID: <26152227-acdf-50a4-e1bc-1a1850880040@suse.cz>
Date: Tue, 18 Jan 2022 12:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Kushal Chand <kushalkataria5@gmail.com>, ltp@lists.linux.it
References: <20220114161612.206475-1-kushalkataria5@gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220114161612.206475-1-kushalkataria5@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 14. 01. 22 17:16, Kushal Chand wrote:
> This patch prints human readable messages when kernel is tainted instead
> of numerical codes.
> 
> Git Hub Issue link  - https://github.com/linux-test-project/ltp/issues/776
> 
> Signed-off-by: Kushal Chand <kushalkataria5@gmail.com>
> 
> ---
>  lib/tst_taint.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_taint.c b/lib/tst_taint.c
> index 49146aacb..049769873 100644
> --- a/lib/tst_taint.c
> +++ b/lib/tst_taint.c
> @@ -8,6 +8,48 @@
>  
>  static unsigned int taint_mask = -1;
>  
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
> +
> +const char *tst_strtaint(int err)
> +{
> +	static const struct pair taint_pairs[] = {
> +		STRPAIR(TST_TAINT_A, "TAINT_A(ACPI table overridden)")
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

This is not the correct approach. You've constructed an array with
131,073 items to store a total of 18 strings. And the value passed in
the "err" parameter is a bitmask which can hold multiple taint flags.

What you should do is this:

const char *taint_strings[] = {
	"G (Propriety module loaded)",
	"F (Module force loaded)",
	"S (Running on out of spec system)",
	"R (Module force unloaded)",
	...
	"X (Auxilary)",
	"T (Built with struct randomization)"
};

Then loop from 0 to ARRAY_SIZE(taint_strings) and print taint_strings[i]
if (err & (1 << i)) != 0

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
