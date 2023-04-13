Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6D5C77B6C
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 08:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D49223CC3D0
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 10:39:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89E273C6C4B
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:38:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B678D60019A
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:38:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F076A218D9;
 Thu, 13 Apr 2023 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681375137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGh5UTG945W/z4XNY0ttXk2+2D7EqjhlBthYYWYaOPI=;
 b=mg2ZdWHIoXYqFHHonS3KBGSUp/bNPLWzh40CbMzakIXjzBhDx9uJlAEvHc4KzeemwPOu+5
 50czqpBd0eHIyDkGVzpYBDgF3vkBqBsQLUVQilE8Erv+1fS9t9rrVDSiAcoNpbuSmkBHev
 BmWlc7VcJOC9z/Bkmb6mnFYQvOFbvUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681375137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGh5UTG945W/z4XNY0ttXk2+2D7EqjhlBthYYWYaOPI=;
 b=6a3sb9yEMnwRCY93s9QJOuGRKRWJZRA5C4PjoLALsFNY9GTTmLFo1xkYZ1EgwP2mlkVETi
 01jK8xWim63d2PAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAD7A1390E;
 Thu, 13 Apr 2023 08:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OZ1iNaG/N2QIGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Apr 2023 08:38:57 +0000
Date: Thu, 13 Apr 2023 10:40:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZDe/43SGucymwRAB@yuki>
References: <20230404054448.23095-1-akumar@suse.de> <ZC1ToUKUUSG7s6S/@yuki>
 <1809432.yOLanILp2W@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1809432.yOLanILp2W@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] getpgid01.c: Rewrite using new LTP API
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
> > > +	pid_1 = SAFE_FORK();
> > > +	if (!pid_1) {
> > > +		child_pid = getpid();
> > > +		ppid = getppid();
> > >  
> > > -		if ((pgid_0 = FORK_OR_VFORK()) == -1)
> > > -			tst_brkm(TBROK, cleanup, "fork failed");
> > > -		if (pgid_0 > 0) {
> > > -			while ((pgid_0 = wait(&ex_stat)) != -1) ;
> > > +		tst_res(TINFO, "getpid() in child = %d", child_pid);
> > > +		tst_res(TINFO, "getppid() in child = %d", ppid);
> > > +		tst_res(TINFO, "Running getpgid() in child");
> > >  
> > > -			if (WEXITSTATUS(ex_stat) == 0)
> > > -				tst_resm(TPASS, "%s PASSED", TCID);
> > > -			else
> > > -				tst_resm(TFAIL, "%s FAILED", TCID);
> > > +		TST_EXP_POSITIVE(getpgid(0));
> > > +		TST_EXP_EQ_LI(TST_RET, ppid);
> > 
> > I do not think that this is correct, the previous code compared the
> > return value from getpgid(0) against the rest, not parent pid.
> I think I wrongly assumed the ppid to be pgid of itself and children processes.
> Thanks for pointing it point.

That only works because the tst_test.c calls SAFE_SETPGID(0, 0) before
it calls the tst_test->run() function, but depending on this is not a
good practice...

> > I guess that the best solution here would be to call getgid() in the
> I guess you meant getpgid() here?
> > parent and save that to a variable and use that for the comparsion in
> > the child.

Indeed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
