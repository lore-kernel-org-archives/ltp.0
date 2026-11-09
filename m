Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F963606A326
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qcDqUJ86;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wSzwBx7h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p3coS5DQ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Mv1S8hc0
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 923A43EAD77
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 14:01:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8BD3E18C8
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 14:00:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC12920006A
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 14:00:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32A021F7DC;
 Mon,  9 Nov 2026 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794229253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SfmMepgWSCkTeMAyRSvmxDDNNaguh20izs7eni23RcQ=;
 b=qcDqUJ86Nh1INL6o3w1+CASmJHeeth8X0oo2iil5HbH4EFnL3sxOt1GLUUvITCc6gtxgbO
 uRGp44lEGRappIXxVAlR7mRcOANjCpslFay0BhJRHY8ZnQY1Rr2N48LAx9KlKSJPi7i/wm
 OxYk//MS1b9wxO46VP8s19mKUYcDtnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794229253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SfmMepgWSCkTeMAyRSvmxDDNNaguh20izs7eni23RcQ=;
 b=wSzwBx7hiX441qg3BYCrUn+Pac0UjdGuCXuL50ZPd320gla1IIWDwZ09CAZJKoOYliPGnh
 0eWzdSNJogiw3VDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794229252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SfmMepgWSCkTeMAyRSvmxDDNNaguh20izs7eni23RcQ=;
 b=p3coS5DQbhPV+V9+0u3gd5UrZFCQXlP+6JqXuatxZkA685r2M6CI5UQy7cbWP5P9H4npRw
 zSCvmv7eXzYdLIRSeCT1sAzP/mJ15+tT2fQCz75MDftgG6rFJ8DWZW1j5H9GHBGoMxIzfD
 SV2oqWqiQGigGMzA5NFKIrcFVDBWo7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794229252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SfmMepgWSCkTeMAyRSvmxDDNNaguh20izs7eni23RcQ=;
 b=Mv1S8hc03Bod+OJGZF14Mg0seu6k9R4l85uwNy5IHFV2EX9AuXf27k2OX3IirA9JUE02VP
 NEX62lPvRTub9UCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5A4C13319;
 Mon,  9 Nov 2026 13:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nVSGKQPE8WpaDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Nov 2026 13:00:51 +0000
Date: Mon, 9 Nov 2026 14:00:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20261109130049.GA631538@pevik>
References: <20261104225051.402911-1-anders.roxell@linaro.org>
 <20261104225051.402911-2-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261104225051.402911-2-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,run-tests.sh:url,suse.cz:replyto,run.sh:url,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] openposix: Install the .args files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Anders,

> run-tests.sh reads the arguments for a test from a .args file next to
> it, but make install does not copy the .args files. So on an installed
> system the two mqueues_multi_send_rev tests run without the number of
> threads and fail with a usage message.

> Install the .args files together with the tests.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  testcases/open_posix_testsuite/scripts/generate-makefiles.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> index 1c12a456cc41..19c781ba8054 100755
> --- a/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> +++ b/testcases/open_posix_testsuite/scripts/generate-makefiles.sh
> @@ -182,6 +182,7 @@ install: \$(INSTALL_DIR) run.sh
>  				\$(INSTALL_DIR)/\$\$file;	\\
>  		fi;						\\
>  	done
> +	\$(if \$(wildcard \$(srcdir)/*.args),install -m 00644 \$(wildcard \$(srcdir)/*.args) \$(INSTALL_DIR)/)

We talk about these 2 files:

$ git ls-files |grep args$
testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_1.args
testcases/open_posix_testsuite/stress/mqueues/mqueues_multi_send_rev_2.args

Looking at the use:

sh -c "$SCRIPT_DIR/t0 $TIMEOUT_VAL ./$1 $(cat ./$(echo "$1" | sed 's,\.[^\.]*,,').args 2>/dev/null)" > $complog 2>&1

Uh, that ugly run-tests.sh should be rewritten.

Ideally, we would get rid of these 2 files, i.e. the in multi_send_rev_[12].c I
would #define some constant for the default value and replace

	if ((2 != argc) || ((num = atoi(argv[1])) <= 0)) {
		fprintf(stderr, "Usage: %s number_of_threads\n", argv[0]);
		return PTS_FAIL;
	}

with using it if argc < 2.
(+ remove <getopt.h>)

And update run-tests.sh to remove that section.

Would you mind to send v2 doing it?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
