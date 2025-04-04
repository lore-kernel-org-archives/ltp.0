Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9258C3601A
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 13:18:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50A463CB310
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 15:18:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 157283CB30C
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 15:18:34 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AF0812001B3
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 15:18:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E88F2117D;
 Fri,  4 Apr 2025 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743772711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwwyFVC5Yr8WnGXD8nuJexgstd/PtycG/tG4finZIek=;
 b=QGBN0fWLs+MfG55jcXovyoZPU4Wo7qeIQ85GwnM4/b68PRoGCtb2lAqRHmqNYlrT8qJfct
 2JLCXzneBwlGrcfNXqgC/s9Sey9+fPexZjkb4yzmNihtnnBXfwWeK77OIX3//eTXc2Csac
 Sz1BELs/JsmG6W4YVD7uJ2wPq62KLt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743772711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwwyFVC5Yr8WnGXD8nuJexgstd/PtycG/tG4finZIek=;
 b=mczSrHptqAVAG8BiGs4VLV+vI5L6eWISFNgWKq1f+HtDfIwXOG/gfiy9p2pMa2WQ8h2P9l
 lRotrV122LAqgjDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QGBN0fWL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mczSrHpt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743772711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwwyFVC5Yr8WnGXD8nuJexgstd/PtycG/tG4finZIek=;
 b=QGBN0fWLs+MfG55jcXovyoZPU4Wo7qeIQ85GwnM4/b68PRoGCtb2lAqRHmqNYlrT8qJfct
 2JLCXzneBwlGrcfNXqgC/s9Sey9+fPexZjkb4yzmNihtnnBXfwWeK77OIX3//eTXc2Csac
 Sz1BELs/JsmG6W4YVD7uJ2wPq62KLt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743772711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwwyFVC5Yr8WnGXD8nuJexgstd/PtycG/tG4finZIek=;
 b=mczSrHptqAVAG8BiGs4VLV+vI5L6eWISFNgWKq1f+HtDfIwXOG/gfiy9p2pMa2WQ8h2P9l
 lRotrV122LAqgjDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3385213691;
 Fri,  4 Apr 2025 13:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k1euCyfc72e+WAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Apr 2025 13:18:31 +0000
Date: Fri, 4 Apr 2025 15:18:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250404131829.GB527835@pevik>
References: <20250403113053.20040-1-chrubis@suse.cz>
 <20250403123610.GA465253@pevik> <Z-6XSwc9Rbu2RIzm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-6XSwc9Rbu2RIzm@yuki.lan>
X-Rspamd-Queue-Id: 4E88F2117D
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Fix tst_brk() handling
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

Hi Cyril,

> Hi!
> > One thing I'm worried is the fact that some shell loader tests core dumped in CI:
> > https://github.com/pevik/ltp/actions/runs/14242818586/job/39916477770
> > e.g. these which are supposed to TBROK due broken metadata:
> > shell_loader_invalid_block.sh, shell_loader_no_metadata.sh,
> > shell_loader_wrong_metadata.sh:

> > Segmentation fault (core dumped)

> Ah, that's because if we call tst_brk() before we finished
> initialization results is not defined. We need at least:

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c6395a5eb..6b1100b09 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -407,7 +407,8 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>          * current process.
>          */
>         if (TTYPE_RESULT(ttype) == TBROK) {
> -               tst_atomic_inc(&results->abort_flag);
> +               if (results)
> +                       tst_atomic_inc(&results->abort_flag);

>                 /*
>                  * If TBROK was called from one of the child processes we kill

> > I also wonder if tst_brk() related doc should be updated.

> I did update the documentation comment in the tst_test.h.

I'm sorry to overlook this. The description LGTM.

+ * runs for all filesystems and tst_brk() with TBROK is called, the test exits
+ * and does not attempt to continue a test iteration for the next filesystem.

I guess this part of the doc update is also applicable for the current master,
right? Quite important note, indeed TCONF does not quit testing on
all_filesystems.  Probably not worth to have it as a separate commit (hopefully
this change will not get reverted).

> > Isn't there anything which should be updated in doc/old/C-Test-API.asciidoc ?
> > This docs will stay with us for some time, the conversion to kerneldoc takes
> > time, it'd be good to keep it updated (valuable texts will be migrated to
> > kerneldoc).

> > Maybe parts:
> > 1.8 Doing the test in the child process
> > 1.9 Fork() and Parent-child synchronization
> > (both code examples and the description).

> I will have a look.

Thanks!

> > very nit: please before merge fix typos in both code and commit message:
> > exitting => exiting
> > countes|countes => counters
> > immediatelly => immediately
> > filtesystem => filesyste

> Uff, will do.

Thanks. (I have spell checker on patches, thus I see it red.)

> > NOTE: test_brk_pass could be added to lib/newlib_tests/runtest.sh. I would also
> > prefer, if we changed tests to behave like testcases/lib/run_tests.sh, i.e.
> > allow to run all tests and check exit code (intermediate step before we compare
> > the test output).

> Rewriting the tests is a more complex task that should be done in a
> separate patchset.

Sure, this was more sharing my idea (I planned to write "as a separate effort",
I see I forget).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
