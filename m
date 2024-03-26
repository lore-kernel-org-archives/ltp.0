Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A2BCD11DD
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 11:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5A273CFEB4
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 12:54:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 230A33CFB2D
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 12:54:05 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 847FE603442
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 12:54:04 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78A51205F9;
 Tue, 26 Mar 2024 11:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711454043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+HqiERTGSZGZefDcuNkuKGVrpTJh7eEcCMxnor/LdQ=;
 b=kHqXLLanx7+Y7ooAZnIhkrY9GdLa7sU/Sb16SFkwTaZL1MIoB60kOpPJ9e4JhPZBbBnrHH
 V7NBBRCep1OuxJ89V0vUnXutjcJ/RiQS8TlEbZbqBagdbOZhlr/ikpf+WnGXNwYr4+kvEW
 LHDhdBxXA+MFJoSgxNxSFLFmQgu72R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711454043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+HqiERTGSZGZefDcuNkuKGVrpTJh7eEcCMxnor/LdQ=;
 b=qilPlMIr5iDReIXcIbYfA0KP+kpQEz/JPFAN4JQCr4MpQd3u9x2DceCUD7phjrXDdKVedE
 64NoykkDXrLjCiAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711454043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+HqiERTGSZGZefDcuNkuKGVrpTJh7eEcCMxnor/LdQ=;
 b=kHqXLLanx7+Y7ooAZnIhkrY9GdLa7sU/Sb16SFkwTaZL1MIoB60kOpPJ9e4JhPZBbBnrHH
 V7NBBRCep1OuxJ89V0vUnXutjcJ/RiQS8TlEbZbqBagdbOZhlr/ikpf+WnGXNwYr4+kvEW
 LHDhdBxXA+MFJoSgxNxSFLFmQgu72R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711454043;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+HqiERTGSZGZefDcuNkuKGVrpTJh7eEcCMxnor/LdQ=;
 b=qilPlMIr5iDReIXcIbYfA0KP+kpQEz/JPFAN4JQCr4MpQd3u9x2DceCUD7phjrXDdKVedE
 64NoykkDXrLjCiAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 503BA13587;
 Tue, 26 Mar 2024 11:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id lFyEElu3AmbhIwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 11:54:03 +0000
Date: Tue, 26 Mar 2024 12:53:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240326115356.GD715328@pevik>
References: <20240320102204.475230-1-pvorel@suse.cz>
 <20240320102204.475230-4-pvorel@suse.cz> <ZgKmScOuuiobsEdj@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZgKmScOuuiobsEdj@yuki>
X-Spamd-Result: default: False [-6.96 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.996];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.46)[97.57%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

H
> Hi!
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Co-developed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > changes v1->v2:
> > * Do not include library header in fanotify14 (not needed)

> >  .../kernel/syscalls/fanotify/fanotify14.c      | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)

> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> > index d02d81495..82725f317 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> > @@ -47,6 +47,7 @@ static int pipes[2] = {-1, -1};
> >  static int fanotify_fd;
> >  static int ignore_mark_unsupported;
> >  static int filesystem_mark_unsupported;
> > +static int se_enforcing;
> >  static unsigned int supported_init_flags;

> >  struct test_case_flags_t {
> > @@ -283,9 +284,18 @@ static void do_test(unsigned int number)

> >  	tst_res(TINFO, "Testing %s with %s",
> >  		tc->mark.desc, tc->mask.desc);
> > -	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > -					 tc->mask.flags, dirfd, path),
> > -					 tc->expected_errno);
> > +
> > +	if (tc->pfd && se_enforcing) {
> > +		const int exp_errs[] = {tc->expected_errno, EACCES};
> > +
> > +		TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > +				 tc->mask.flags, dirfd, path),
> > +				 exp_errs);
> > +	} else {
> > +		TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > +						 tc->mask.flags, dirfd, path),
> > +						 tc->expected_errno);
> > +	}

> This looks like the test library is not flexible enough to make this
> simpler. Maybe having the ARRAY_SIZE() in the TST_EXP_FAIL_ARR wasn't a
> good idea after all. Or maybe we just need TST_EXP_FAIL_ARR2() that
> would take the array size explicitly, then we could do:

[ Removing Jan and Amir from the LTP specific discussion ]

@Cyril, @Li: How about add 2 macros with '_SIZE' in the name?
(TST_EXP_FAIL_ARR_SIZE and TST_EXP_FAIL2_ARR_SIZE, see diff at the end).

Other option would be to add '2' (TST_EXP_FAIL_ARR2 and TST_EXP_FAIL2_ARR2),
not sure what is more readable.

Kind regards,
Petr

> 	const int exp_errs[] = {tc->expected_errno, EACESS}

> 	TST_EXP_FAIL_ARR2(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
>                            tc->mask.flags, dirfd, path), exp_errs,
> 			   se_enforcing ? 1 : 2);

+++ include/tst_test_macros.h
@@ -246,6 +246,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL_ARR_(SCALL, #SCALL, EXP_ERRS,                     \
 				  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
+#define TST_EXP_FAIL_ARR_SIZE(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...)                   \
+		TST_EXP_FAIL_ARR_(SCALL, #SCALL, EXP_ERRS,                     \
+				  EXP_ERRS_CNT, ##__VA_ARGS__);
+
 #define TST_EXP_FAIL2_ARR_(SCALL, SSCALL, EXP_ERRS, EXP_ERRS_CNT, ...)         \
 	do {                                                                   \
 		TST_EXP_FAIL_SILENT_(TST_RET >= 0, SCALL, SSCALL,              \
@@ -258,6 +262,10 @@ const char *tst_errno_names(char *buf, const int *exp_errs, int exp_errs_cnt);
 		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
 		                  ARRAY_SIZE(EXP_ERRS), ##__VA_ARGS__);
 
+#define TST_EXP_FAIL2_ARR_SIZE(SCALL, EXP_ERRS, EXP_ERRS_CNT...)                \
+		TST_EXP_FAIL2_ARR_(SCALL, #SCALL, EXP_ERRS,                    \
+		                  EXP_ERRS_CNT, ##__VA_ARGS__);
+
 #define TST_EXP_FAIL2(SCALL, EXP_ERR, ...)                                     \
 	do {                                                                   \
 		int tst_exp_err__ = EXP_ERR;                                   \

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
