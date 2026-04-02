Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79112D6AB10
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 21:34:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29A573E5494
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 23:34:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA2C93E14A5
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 23:34:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4C8202002AF
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 23:34:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E0CC5BD74;
 Thu,  2 Apr 2026 21:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775165649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLuP+mPuOk9F3U+CgCH1xex2Sx9hSJ7VZoPjwcWAGF4=;
 b=koiWxzo4Feqa/K+IunA20Z0dc94OP0Xy2zIQQPCTm8BFHE2xKaiKsTHeRnXPgAzp+6c4x9
 1m5aSDMd2Q9k3cOXIvVjLL+cb+f3ckIWmVDSmOkopDQaZC+neaKfoSNv3ioKviarw3HOs9
 70+vK+mtiQxjrr5VM2VPqeyrRhjqLnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775165649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLuP+mPuOk9F3U+CgCH1xex2Sx9hSJ7VZoPjwcWAGF4=;
 b=cEHU2srgvBbx3Y+t/9pOxtzmw8ucXdq6qT8Nz9OBnM0Bz6SXSdoKNzrXv7zBUzkHwkntXP
 m936bfKgzrBJKYCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775165649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLuP+mPuOk9F3U+CgCH1xex2Sx9hSJ7VZoPjwcWAGF4=;
 b=koiWxzo4Feqa/K+IunA20Z0dc94OP0Xy2zIQQPCTm8BFHE2xKaiKsTHeRnXPgAzp+6c4x9
 1m5aSDMd2Q9k3cOXIvVjLL+cb+f3ckIWmVDSmOkopDQaZC+neaKfoSNv3ioKviarw3HOs9
 70+vK+mtiQxjrr5VM2VPqeyrRhjqLnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775165649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLuP+mPuOk9F3U+CgCH1xex2Sx9hSJ7VZoPjwcWAGF4=;
 b=cEHU2srgvBbx3Y+t/9pOxtzmw8ucXdq6qT8Nz9OBnM0Bz6SXSdoKNzrXv7zBUzkHwkntXP
 m936bfKgzrBJKYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 701514A0B0;
 Thu,  2 Apr 2026 21:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fKoNGNHgzmnoQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Apr 2026 21:34:09 +0000
Date: Thu, 2 Apr 2026 23:34:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260402213403.GC225068@pevik>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-18-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260402121356.31266-18-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 17/17] doc: metadata: Remove needs_drivers from
 docs
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

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/developers/writing_tests.rst |  3 ---
>  doc/old/C-Test-API.asciidoc      | 13 ++++++-------
>  metadata/README.md               | 15 ++++++---------
>  3 files changed, 12 insertions(+), 19 deletions(-)

> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index 992374f8b..5b1516ba5 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -435,9 +435,6 @@ LTP C And Shell Test API Comparison
>      * - .needs_device
>        - TST_NEEDS_DEVICE

> -    * - .needs_drivers
> -      - TST_NEEDS_DRIVERS
> -
NOTE: this is the old comparison for tst_test.sh, it should be change:

 -    * - not applicable
 -      - TST_NEEDS_DRIVERS

>      * - .needs_kconfigs
>        - TST_NEEDS_KCONFIGS

> diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
> index 72fd2731d..7493fc578 100644
> --- a/doc/old/C-Test-API.asciidoc
> +++ b/doc/old/C-Test-API.asciidoc
> @@ -1621,13 +1621,12 @@ test should include 'tst_checksum.h' header, then can call 'tst_crc32c()'.
>  1.26 Checking kernel for the driver support
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> -Some tests may need specific kernel drivers, either compiled in, or built
> -as a module. If '.needs_drivers' points to a 'NULL' terminated array of kernel
> -module names these are all checked and the test exits with 'TCONF' on the
> -first missing driver.
> -
> -The detection is based on reading 'modules.dep' and 'modules.builtin' files
> -generated by kmod. The check is skipped on Android.
> +Some tests may need specific kernel drivers, either compiled in, or built as a
> +module. For this cases a mappping of kernel config options to modules is
> +maintained in the kconfig checker. When a kernel config option is requested by
Please amend before merge to use formatting:
``modules.dep``

> +a test that has associated mapping in the kconfig source the 'modules.dep' file
> +is checked for module presence when the option is set to 'm'. The check is
... set to ``m``.
> +skipped on Android.

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
