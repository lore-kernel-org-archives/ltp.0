Return-Path: <SRS0=Ux39=O7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E1AC433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B64260EE5
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 15:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B64260EE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26C473C0BBA
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 17:02:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0C503C0302
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 17:02:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 611B3140124C
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 17:02:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2E09220C3;
 Mon, 11 Oct 2021 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633964523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=katfHzxRA/R4Xyj2QDbdsnIULc9yU9r9yMPGXIti0xc=;
 b=KUPvbHxCOAE46YwdQtM/MocU1n2xe226Tgi/thl3u1yRqnmsQTpLxIcfIEzszSTh+22YKV
 vaL7tBy/YXtfSf7RtJyx+/XuV6sV1ejRPSfE4QVY7r987maZ1ot00iVRdlOHboBRQ1Zk2u
 pwPe2Vhv5wD0oBZMgJJDTkKxxPRIvss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633964523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=katfHzxRA/R4Xyj2QDbdsnIULc9yU9r9yMPGXIti0xc=;
 b=5dnF62w/1kxQ/dUQl2TVpDUXHxPV60PGV7BONygyQCkZAQ/A7v1Q8ZrCY5+I7WQjJu35kn
 ountY1vX+SiSHaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9635A13C72;
 Mon, 11 Oct 2021 15:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id njlAJOtRZGEWRQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Oct 2021 15:02:03 +0000
Date: Mon, 11 Oct 2021 17:02:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YWRSEt30zrkDlSWO@yuki>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
 <20210923085224.868-2-zhanglianjie@uniontech.com>
 <87bl4il49f.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bl4il49f.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] syscalls/clone03: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static void verify_clone(void)
> > +{
> > +	int child_pid;
> >
> > -		/* Close read end from parent */
> > -		if ((close(pfd[0])) == -1)
> > -			tst_resm(TWARN | TERRNO, "close(pfd[0]) failed");
> > +	TST_EXP_PID_SILENT(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
> > +				child_stack));
> 
> tst_clone is the new API.

Actually we can't use it as it is becuase:

- these tests are tests fof clone() not for clone3() so we really have
  to use the old syscall

- even if we added flag to tst_clone to force the older syscall we would
  have to add size parameter to the structure since we need to test the
  case where we pass the stack explicitly as well

I guess that it would be better to do this eventually but I do not want
to block the cleanup because of this. We can fix this later on.

> >
> > -		/* Get child's pid from pid string */
> > -		child_pid = atoi(buff);
> > +	if (!TST_PASS)
> > +		return;
> >
> > -		if (TEST_RETURN == child_pid)
> > -			tst_resm(TPASS, "Test passed");
> > -		else
> > -			tst_resm(TFAIL, "Test failed");
> > +	tst_reap_children();
> >
> > -		if ((wait(&status)) == -1)
> > -			tst_brkm(TBROK | TERRNO, cleanup,
> > -				 "wait failed, status: %d", status);
> > -	}
> > +	child_pid = atoi(channel);
> 
> atoi is deprecated (see the man page).
> 
> >
> > -	free(child_stack);
> > -
> > -	cleanup();
> > -	tst_exit();
> > +	TST_EXP_PASS(!(TST_RET == child_pid), "pid(%d)", child_pid);
> >  }
> >
> >  static void setup(void)
> >  {
> > -	tst_sig(FORK, DEF_HANDLER, cleanup);
> > -	TEST_PAUSE;
> > +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> > +	channel = SAFE_MMAP(NULL, 10, PROT_READ | PROT_WRITE,
> > +				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 
> You could mmap a region needed for pid_t and just read and write it like
> a normal variable.

That was my point when I suggested mmap()

it should really be:

static int *child_pid;


...
	child_pid = SAFE_MMAP(NULL, sizeof(*child_pid), ....);
...

Then we can just do *child_pid = foo and if (*child_pid == bar) in the
code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
