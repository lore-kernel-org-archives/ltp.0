Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B612CE7A8E
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 08:59:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D05793CF814
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 09:59:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ABF43CEB11
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:58:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 73C86600704
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 09:58:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D11632122A;
 Fri, 14 Nov 2025 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763110737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gA5OiCyKp75wUbTE8yrluJMtPul9g48ypurzJQcug0=;
 b=N1jdnBr6BpDpl/bqk9tWAMpoaNL4xRp7Fy0JjSC/IMh7FXEwe0aPGGjEzI4rE+99zBj0el
 DH6OqVRfasU7lyrVNC0F80c1JrrBGGyjViHootDDfc26c42NQUd8HqM/GBlvdMGBny08n2
 qSWtN1B7oyXp+nWKLDyWXbEh+6oB4yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763110737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gA5OiCyKp75wUbTE8yrluJMtPul9g48ypurzJQcug0=;
 b=9S+sfed4h4rwignY5x0zIFzIeP+SDwRVNWgr9SA0p5+xR6LT7kqx8H9QK8ypZTmSE/wtNd
 avi9gktqeJPJHBCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763110737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gA5OiCyKp75wUbTE8yrluJMtPul9g48ypurzJQcug0=;
 b=N1jdnBr6BpDpl/bqk9tWAMpoaNL4xRp7Fy0JjSC/IMh7FXEwe0aPGGjEzI4rE+99zBj0el
 DH6OqVRfasU7lyrVNC0F80c1JrrBGGyjViHootDDfc26c42NQUd8HqM/GBlvdMGBny08n2
 qSWtN1B7oyXp+nWKLDyWXbEh+6oB4yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763110737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gA5OiCyKp75wUbTE8yrluJMtPul9g48ypurzJQcug0=;
 b=9S+sfed4h4rwignY5x0zIFzIeP+SDwRVNWgr9SA0p5+xR6LT7kqx8H9QK8ypZTmSE/wtNd
 avi9gktqeJPJHBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF9ED3EA61;
 Fri, 14 Nov 2025 08:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GSHsKFHvFmmuNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Nov 2025 08:58:57 +0000
Date: Fri, 14 Nov 2025 09:58:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251114085856.GA43654@pevik>
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250523210950.1019560-1-wegao@suse.com>
 <aRXtUIlkNP3aDReN@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRXtUIlkNP3aDReN@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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

Hi all,

...
> > @@ -192,63 +253,36 @@ static int purge_dir(const char *path, char **errptr)
> >  	return ret_val;
> >  }

> Again, there shouldn't be two function for the same job. There should be
> only purge_dirat() and the tst_purge_dir() should call purge_dirat()
> with AT_FDCWD as the dirfd.

+1. That is what I meant by "it'd be nice if we could use only rmobjat()" in v1.

> >  	} else {
> > -		if (unlink(obj) < 0) {
> > +		if (unlinkat(dir_fd, obj, 0) < 0) {
> >  			if (errmsg != NULL) {
> > -				sprintf(err_msg,
> > -					"unlink(%s) failed; errno=%d: %s", obj,
> > +				snprintf(err_msg, sizeof(err_msg),
> > +					"unlinkat(%s) failed; errno=%d: %s", obj,
> >  					errno, tst_strerrno(errno));
> >  				*errmsg = err_msg;
> >  			}
> > @@ -305,7 +339,7 @@ void tst_tmpdir(void)
> >  		tst_resm(TERRNO, "%s: chdir(%s) failed", __func__, TESTDIR);

> >  		/* Try to remove the directory */
> > -		if (rmobj(TESTDIR, &errmsg) == -1) {
> > +		if (rmobjat(0, TESTDIR, &errmsg) == -1) {
> >  			tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> >  				 __func__, TESTDIR, errmsg);
> >  		}
> > @@ -343,7 +377,7 @@ void tst_rmdir(void)
> >  	/*
> >  	 * Attempt to remove the "TESTDIR" directory, using rmobj().
> >  	 */
> > -	if (rmobj(TESTDIR, &errmsg) == -1) {
> > +	if (rmobjat(0, TESTDIR, &errmsg) == -1) {
> >  		tst_resm(TWARN, "%s: rmobj(%s) failed: %s",
> >  			 __func__, TESTDIR, errmsg);
> >  	}

> We should pass AT_FDCWD to the two rmobjat() here since it's possible to
> pass relative path in the TMPDIR environment variable. Otherwise the
> code will not work with e.g. TMPDIR="." ./test_foo

Very good catch. BTW we expect TMPDIR to be correct - without double quotes and
trailing '/' which are example for shell tests which lead to failures in LTP
NFS tests. That was fixed in:

273c497935 ("tst_test.sh: Remove possible double/trailing slashes from TMPDIR")

Wouldn't be better just to normalize relative TMPDIR to absolute path? Simple
realpath() would do the job, right?

e.g. this patch "swapon03: Remove grep dependency" [1] + fix attempt to swapoff
leftover from previous run (when one does ctrl+C in previous run) expect that
TMPDIR is absolute. I'll note it below the patch that either we change
lib/tst_tmpdir.c to convert relative to absolute, or swapon03.c test needs to do
it itself. I would prefer lib/tst_tmpdir.c do the job including normalizing the
path (more tests will benefit/need it).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20251106163500.1063704-6-pvorel@suse.cz/


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
