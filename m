Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A78DD3CCB7
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 07:23:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86A2D3C9B86
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 08:23:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2C143C0EB3
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 08:22:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8E7111400DD3
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 08:22:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D20F333694;
 Thu, 15 Jan 2026 07:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768461762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlpvlU9RUc1F4iCVSO3rQkbgCwaKD8hJUxYfFKTEWPM=;
 b=XudOJ7mXjnIlMu3K7TB0kagbLb1j6nnRvRPD/IEC0DEoJZdAWPKWq6viZgqjpf2X5VNEap
 Cx6R4BrUaFXl+LF7szzxyk8SdYFXL4M/pMa7opi98bXMR//mtYJUpUBuLrzuwYVLVLhNNB
 FuEkbP/vrzh1iC9/wFPY/VixADrHNso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768461762;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlpvlU9RUc1F4iCVSO3rQkbgCwaKD8hJUxYfFKTEWPM=;
 b=laRMAzTMuY0e1xM1KJ0OlxKvtxtI3igNm1eI91cdWd7eQ9S5M3wV8LhKp8vZQkVLlPMwVa
 8WJzcpBCjMt/ZbDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768461760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlpvlU9RUc1F4iCVSO3rQkbgCwaKD8hJUxYfFKTEWPM=;
 b=EHOK3G7LUt5NFSkL63tRI1gVs6DgtgfLeW9tSWAhPSyJqR8Dpu9TteYq98YSkVWxb2dPfl
 Cv5glKbITvpaCnUMw5WPyBYgW/f3xosTrbA43TNKzE8Jz4Rb1Wl24fBQGSVvLc9CCHS1k/
 CrBgnU+hNvH4jTulh75LGJnARVM4ciU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768461760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlpvlU9RUc1F4iCVSO3rQkbgCwaKD8hJUxYfFKTEWPM=;
 b=hnIFZBUbDdTh8Jjf23yzSwZRQKE4wan9Aarv1CEz22nKP5qYRqNhnXLw+iH2vLihSYeB0T
 Da0DgR1RIODq1JCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B03F3EA63;
 Thu, 15 Jan 2026 07:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oXj3IMCVaGmrRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 Jan 2026 07:22:40 +0000
Date: Thu, 15 Jan 2026 08:22:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: cryolitia@uniontech.com
Message-ID: <20260115072231.GA438294@pevik>
References: <20260113-checkpatch-v2-1-5dfe8b9f4d90@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260113-checkpatch-v2-1-5dfe8b9f4d90@uniontech.com>
X-Spamd-Result: default: False [-6.00 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[canonical.com,perches.com,gmail.com,kernel.org,vger.kernel.org,kvack.org,uniontech.com,lists.linux.it];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[cryolitia.uniontech.com];
 REPLYTO_EQ_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH RESEND v2] checkpatch: Suppress warnings when
 Reported-by: is followed by Link:
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
Cc: Cryolitia PukNgae via B4 Relay
 <devnull+cryolitia.uniontech.com@kernel.org>, linux-doc@vger.kernel.org,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Joe Perches <joe@perches.com>, workflows@vger.kernel.org,
 Andy Whitcroft <apw@canonical.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 niecheng1@uniontech.com, ltp@lists.linux.it, zhanjun@uniontech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cryolitia,

> From: Cryolitia PukNgae <cryolitia@uniontech.com>

> > The tag should be followed by a Closes: tag pointing to the report,
> > unless the report is not available on the web. The Link: tag can be
> > used instead of Closes: if the patch fixes a part of the issue(s)
> > being reported.

Indeed, this is true, although there is a prerequisite:

	The Link: tag can be used instead of Closes: if the patch fixes a part of
	the issue(s) being reported.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I also see you Cc LTP ML. FYI we vendored scripts/checkpatch.pl (with occasional
updates).

Kind regards,
Petr

> Accroding to Documentation/process/submitting-patches.rst , Link: is
> also acceptable to followed a Reported-by:

> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
> Link to previous: https://lore.kernel.org/r/20251023-checkpatch-v1-1-ff73ed1027d6@uniontech.com
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c0250244cf7a..dac9d98133c6 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3209,10 +3209,10 @@ sub process {
>  			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
>  				if (!defined $lines[$linenr]) {
>  					WARN("BAD_REPORTED_BY_LINK",
> -					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
> -				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
> +					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . "\n");
> +				} elsif ($rawlines[$linenr] !~ /^(closes|link):\s*/i) {
>  					WARN("BAD_REPORTED_BY_LINK",
> -					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
> +					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
>  				}
>  			}
>  		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
