Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967BAC36010
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:50:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CB6D3CA2DB
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:50:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD1B43C9B47
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:50:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0177E6001AE
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:50:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45415211AB;
 Fri, 28 Mar 2025 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743151826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVod6Ryb/aoTmN2QkCVUzh9dLpb5ln3zBol8qtgF2F4=;
 b=hLF23gykHiIey7dl/4Zx2ott1Hf7Bp9gSIiSk3dw1fyrRuM3LYNvfJCOLCHSn+IWy3j32P
 vYIGxoDeTcBMI1ePLa3zDt6ZMedM13CmUhrHbYYYM2B/powW26O8IzEvsWXLBNqJfPLfjb
 wbSy9SOmIGx62t4+6I3LlqKUlJ4lS20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743151826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVod6Ryb/aoTmN2QkCVUzh9dLpb5ln3zBol8qtgF2F4=;
 b=u4TUC5XRp0PrSVXJwBuBsG1QIPhKyN9+EWSGCJfUMcDOjxugIo8YZ0PmhSsKznKCycR0bT
 G/lmtLeg2CXcBxAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hLF23gyk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u4TUC5XR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743151826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVod6Ryb/aoTmN2QkCVUzh9dLpb5ln3zBol8qtgF2F4=;
 b=hLF23gykHiIey7dl/4Zx2ott1Hf7Bp9gSIiSk3dw1fyrRuM3LYNvfJCOLCHSn+IWy3j32P
 vYIGxoDeTcBMI1ePLa3zDt6ZMedM13CmUhrHbYYYM2B/powW26O8IzEvsWXLBNqJfPLfjb
 wbSy9SOmIGx62t4+6I3LlqKUlJ4lS20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743151826;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EVod6Ryb/aoTmN2QkCVUzh9dLpb5ln3zBol8qtgF2F4=;
 b=u4TUC5XRp0PrSVXJwBuBsG1QIPhKyN9+EWSGCJfUMcDOjxugIo8YZ0PmhSsKznKCycR0bT
 G/lmtLeg2CXcBxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25FD513927;
 Fri, 28 Mar 2025 08:50:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id duhiCNJi5mcNCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Mar 2025 08:50:26 +0000
Date: Fri, 28 Mar 2025 09:50:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Lu Fei <lufei@uniontech.com>
Message-ID: <20250328085020.GA130961@pevik>
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <20250327103336.GA70364@pevik>
 <0A99FFBB46DDB0B4+Z+YKSlAwn1vx3Dz4@rocky>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0A99FFBB46DDB0B4+Z+YKSlAwn1vx3Dz4@rocky>
X-Rspamd-Queue-Id: 45415211AB
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare03: using soft limit of NOFILE
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
Cc: Al Viro <viro@zeniv.linux.org.uk>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi lufei, Al,

> Hi Petr,

> Yes, kselftest tools/testing/selftests/core/unshare_test.c failed as
> well, dup2 failed:

> ```
> unshare_test.c:60:unshare_EMFILE:Expected dup2(2, nr_open + 64) (-1) >= 0 (0)
> ```

Thanks for info.  Maybe also sending a patch to kselftest?

Kind regards,
Petr

PS: lufei, please keep Cc to keep other informed.

> Thanks for reply.
> Best regards.

> On Thu, Mar 27, 2025 at 11:33:36AM +0100, Petr Vorel wrote:
> > Hi lufei, Al,

> > @Al, you're the author of the original test unshare_test.c [1] in kselftest.
> > This is a patch to LTP test unshare03.c, which is based on your test.

> > > I think it's safer to set NOFILE increasing from soft limit than from
> > > hard limit.

> > > Hard limit may lead to dup2 ENOMEM error which bring the result to
> > > TBROK on little memory machine. (e.g. 2GB memory in my situation, hard
> > > limit in /proc/sys/fs/nr_open come out to be 1073741816)

> > IMHO lowering number to ~ half (in my case) by using rlimit.rlim_max instead of
> > /proc/sys/fs/nr_open should not affect the functionality of the test, right?
> > Or am I missing something obvious?

> > @lufei I guess kselftest tools/testing/selftests/core/unshare_test.c would fail
> > for you as well, right?

> > Kind regards,
> > Petr

> > [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=611fbeb44a777e5ab54ab3127ec85f72147911d8

> > > Signed-off-by: lufei <lufei@uniontech.com>
> > > ---
> > >  testcases/kernel/syscalls/unshare/unshare03.c | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)

> > > diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> > > index 7c5e71c4e..bb568264c 100644
> > > --- a/testcases/kernel/syscalls/unshare/unshare03.c
> > > +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> > > @@ -24,7 +24,7 @@

> > >  static void run(void)
> > >  {
> > > -	int nr_open;
> > > +	int rlim_max;
> > >  	int nr_limit;
> > >  	struct rlimit rlimit;
> > >  	struct tst_clone_args args = {
> > > @@ -32,14 +32,12 @@ static void run(void)
> > >  		.exit_signal = SIGCHLD,
> > >  	};

> > > -	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> > > -	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
> > > +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> > > +	rlim_max = rlimit.rlim_max;

> > > -	nr_limit = nr_open + NR_OPEN_LIMIT;
> > > +	nr_limit = rlim_max + NR_OPEN_LIMIT;
> > >  	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);

> > > -	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> > > -
> > >  	rlimit.rlim_cur = nr_limit;
> > >  	rlimit.rlim_max = nr_limit;

> > > @@ -47,10 +45,10 @@ static void run(void)
> > >  	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
> > >  		nr_limit);

> > > -	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
> > > +	SAFE_DUP2(2, rlim_max + NR_OPEN_DUP);

> > >  	if (!SAFE_CLONE(&args)) {
> > > -		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> > > +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", rlim_max);
> > >  		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> > >  		exit(0);
> > >  	}


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
