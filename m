Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85609C54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 07:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 807CD3CE783
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 08:26:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB7EC3CE77C
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 08:26:27 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 487CD20020F
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 08:26:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5472221AFF;
 Wed, 13 Mar 2024 07:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710314785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhqG97T1DnJGuDzOXwIwQE5Q+yKIc2t9VaqTPG8dyA=;
 b=KiHa9RQwFffmrRTsF5aA7M6SCq3LrciNxepxt6Qgtj5OgQuDtpac5KaFfuMXbYuR8iUrrJ
 o0JchAmUGncHsfO1RT7dJUVuZazvJav59P5HFws/77NW+4RHBufCh5timpS8XVhTy4Wzv7
 Hl9U2FGkEgdb9Z6W+G/TRJcM/SOCXzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710314785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhqG97T1DnJGuDzOXwIwQE5Q+yKIc2t9VaqTPG8dyA=;
 b=he+dbSDa7SOsaGb8JEMIGbFoBLcR92w5BRVVnLsj+ZIsYo6PCGt2yiQmaVdAtnmjsDk2w6
 u0845RAr3ghDCPCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710314785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhqG97T1DnJGuDzOXwIwQE5Q+yKIc2t9VaqTPG8dyA=;
 b=KiHa9RQwFffmrRTsF5aA7M6SCq3LrciNxepxt6Qgtj5OgQuDtpac5KaFfuMXbYuR8iUrrJ
 o0JchAmUGncHsfO1RT7dJUVuZazvJav59P5HFws/77NW+4RHBufCh5timpS8XVhTy4Wzv7
 Hl9U2FGkEgdb9Z6W+G/TRJcM/SOCXzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710314785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLhqG97T1DnJGuDzOXwIwQE5Q+yKIc2t9VaqTPG8dyA=;
 b=he+dbSDa7SOsaGb8JEMIGbFoBLcR92w5BRVVnLsj+ZIsYo6PCGt2yiQmaVdAtnmjsDk2w6
 u0845RAr3ghDCPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BA61397F;
 Wed, 13 Mar 2024 07:26:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 30wsCiFV8WVQTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Mar 2024 07:26:25 +0000
Date: Wed, 13 Mar 2024 08:26:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20240313072623.GA519991@pevik>
References: <20240312120829.178305-1-meted@linux.ibm.com>
 <20240312120829.178305-2-meted@linux.ibm.com>
 <CAOQ4uxgPK=t25OvBcevkQseFEr9S6p7PtU35p8T+snzqzN+ndg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgPK=t25OvBcevkQseFEr9S6p7PtU35p8T+snzqzN+ndg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] fanotify14: fix anonymous pipe testcases
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
Cc: Mete Durlu <meted@linux.ibm.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,
...

> >  static void do_test(unsigned int number)
> >  {
> >         struct test_case_t *tc = &test_cases[number];
> > @@ -275,17 +290,28 @@ static void do_test(unsigned int number)
> >         /* Set mark on non-dir only when expecting error ENOTDIR */
> >         const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
> >         int dirfd = AT_FDCWD;
> > +       int se_enforcing = 0;

> >         if (tc->pfd) {
> >                 dirfd = tc->pfd[0];
> >                 path = NULL;
> > +               se_enforcing = is_selinux_enforcing();
nit: this check should be in the setup function to be done only once.
(by default it's done twice, because we have 2 testcases with pfd, we support
-iN parameter, thus it's actually 2*N.). I'll fix it before merge.
> >         }

> >         tst_res(TINFO, "Testing %s with %s",
> >                 tc->mark.desc, tc->mask.desc);
> > -       TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > -                                        tc->mask.flags, dirfd, path),
> > -                                        tc->expected_errno);
> > +
> > +       if (tc->pfd && se_enforcing) {
> > +               const int exp_errs[] = {tc->expected_errno, EACCES};
> > +
> > +               TST_EXP_FAIL_ARR(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > +                                tc->mask.flags, dirfd, path),
> > +                                exp_errs);
> > +       } else {
> > +               TST_EXP_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
> > +                                                tc->mask.flags, dirfd, path),
> > +                                                tc->expected_errno);
> > +       }


> This looks fine to me, but on second thought I am not sure how important
> it is to special case se_enforcing.
> We could probably always check for either error value.

I don't mind explicitly testing EACCES with SELinux. @Jan WDYT?

With a diff below (I can change it before merge + I would do the following work
to integrate this into the LTP C API):
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fanotify/fanotify14.c testcases/kernel/syscalls/fanotify/fanotify14.c
index 52c327dff..89d59c8b2 100644
--- testcases/kernel/syscalls/fanotify/fanotify14.c
+++ testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -49,6 +49,7 @@ static int pipes[2] = {-1, -1};
 static int fanotify_fd;
 static int ignore_mark_unsupported;
 static int filesystem_mark_unsupported;
+static int se_enforcing;
 static unsigned int supported_init_flags;
 
 struct test_case_flags_t {
@@ -290,12 +291,10 @@ static void do_test(unsigned int number)
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
 	int dirfd = AT_FDCWD;
-	int se_enforcing = 0;
 
 	if (tc->pfd) {
 		dirfd = tc->pfd[0];
 		path = NULL;
-		se_enforcing = is_selinux_enforcing();
 	}
 
 	tst_res(TINFO, "Testing %s with %s",
@@ -360,6 +359,8 @@ static void do_setup(void)
 	SAFE_FILE_PRINTF(FILE1, "0");
 	/* Create anonymous pipes to place marks on */
 	SAFE_PIPE2(pipes, O_CLOEXEC);
+
+	se_enforcing = is_selinux_enforcing();
 }
 
 static void do_cleanup(void)
> Let's see what Jan and Petr think.

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
