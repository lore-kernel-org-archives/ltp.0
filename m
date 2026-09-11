Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5FFC88E4C
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 11:11:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D45B3E9200
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:11:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E10E13C18A4
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:10:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 862FB1400DEB
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:10:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E698B21D6A;
 Fri, 11 Sep 2026 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789125044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVcexXyW3SEcw16WnvsdHGgyvBjgCnntEBWABhXh7JU=;
 b=YFLVcAMnCpD1+fUmrnZR6zpj5WVO6M9Gx5DNgrckkuihwP9DbRq37mstuhUqXKrKeps3Sk
 o6T4Kuvgh37L2r5AMRXwni1zmjS0HwF/GwkSwHMC2x7iuOZRzGKRSIoXqqN5mvM2PXMCm6
 sRgsbbgncVh/GrSQySBT12DMkodAeiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789125044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVcexXyW3SEcw16WnvsdHGgyvBjgCnntEBWABhXh7JU=;
 b=CFAg4cslsmbdML33OA2mdlz/Tm7eUWvlEP/OJSCxINVcVXBE6TfASf8vhVWg+ErDa1aqcH
 cYavRODAkVooaXBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789125039;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVcexXyW3SEcw16WnvsdHGgyvBjgCnntEBWABhXh7JU=;
 b=DYka+fMvYCQ/S9xXEzVBbTlra2kaSvrkQM3HMuSg0yG2IcGORMwNy6x3DaYSsO22gR0F57
 Ij3PjRyJiC4bxwbX9OfTSmoVntuy3c/FwYB82L/Nfg1j+GkXToL9TA1w5aoITqTnrLR/LJ
 gGhxZ1c/h1Y/f1qNcM344X5BMsY+I9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789125039;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sVcexXyW3SEcw16WnvsdHGgyvBjgCnntEBWABhXh7JU=;
 b=mBnbGHashH5ifzKyaflygwaM4X1q10Pao0vNVUUfng/ABxaWnGOvxbGp9Tdi89ffzNH01q
 PWBLv12q9R049TCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A43BE13794;
 Fri, 11 Sep 2026 11:10:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id taC0Jq/ho2qQLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 11:10:39 +0000
Date: Fri, 11 Sep 2026 13:10:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911111034.GB1454430@pevik>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
 <20260911-fix_documentation-v2-4-716b2613c477@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-fix_documentation-v2-4-716b2613c477@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/9] include: Document assertion API macros
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

..
> +/**
> + * TST_ASSERT_FILE_STR() - Asserts that string value for field in file equals val.
> + *
> + * @path: Path to the file to check.
> + * @prefix: Field name or prefix preceding the string value.
> + * @val: Expected string value.
> + *
> + * Scans lines in path for prefix followed by ": " and a string value.
nit: there might be more whitespace chars after ":". Also formatting by `` ``
might be better.

* Scans lines in path for prefix followed by ``:`` followed by whitespace and a string value.

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> + * Reports :c:enum:`TPASS <tst_res_flags>` on match, or
> + * :c:enum:`TFAIL <tst_res_flags>` on mismatch.
> + */
>  #define TST_ASSERT_FILE_STR(path, prefix, val) \
>  	tst_assert_file_str(__FILE__, __LINE__, path, prefix, val)

> -/*
> - * Asserts that a string value stored in the prefix field of file pointed by path
> - * equals to the value passed to this function. This is mostly useful for
> - * asserting correct field values in sysfs, procfs, etc.
> - */
>  void tst_assert_file_str(const char *file, const int lineno,
>  			 const char *path, const char *prefix, const char *val);

I guess it's safe to expect the readers will be using macros, not the functions
themselves (that's for use in LTP library itself) => good to move kerneldoc from
functions to macros.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
