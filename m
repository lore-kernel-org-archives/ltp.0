Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DB8C7619A
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 08:53:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A03E33CC656
	for <ltp@archiver.kernel.org>; Wed, 12 Apr 2023 10:52:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD6BD3C00DC
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 10:52:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F34591400500
 for <ltp@lists.linux.it>; Wed, 12 Apr 2023 10:52:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 62BE1218FC;
 Wed, 12 Apr 2023 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1681289567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QovY0jVO50UY8r9HjQNNSfVHIvno4s8bnQiZtLummVM=;
 b=X8qIKOsDU2s+sVJpRxvItxCLpHLRHJGlLoNqP98CBhm9Nl3s1vpy9V6wVUFWNMn5fHRyT3
 VGKV2xmhHUu3dyMfN3BIeOBxePDpqAm5YKCJLMf7zU4/Gh0xuVoulcqTuEJoXqEbb58C6E
 c7JKMb2eFBti+xUWmPx4c1wRJQVWMA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1681289567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QovY0jVO50UY8r9HjQNNSfVHIvno4s8bnQiZtLummVM=;
 b=T1+lpZnlABSoTUXGSO/lqJD9BvJvuXWwxDfDNXHzybQcdhjs+PGjbQcFfjaoCV3iNC5ZEl
 oupBJoEnBA2gWDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D961813498;
 Wed, 12 Apr 2023 08:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AcxHK15xNmRtaAAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 12 Apr 2023 08:52:46 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Apr 2023 14:22:44 +0530
Message-ID: <1809432.yOLanILp2W@localhost>
Organization: SUSE
In-Reply-To: <ZC1ToUKUUSG7s6S/@yuki>
References: <20230404054448.23095-1-akumar@suse.de> <ZC1ToUKUUSG7s6S/@yuki>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

Hi Cyril,
Thank you for the review.

On Wednesday, April 5, 2023 4:25:29 PM IST you wrote:
> Hi!
> > +	pid_1 = SAFE_FORK();
> > +	if (!pid_1) {
> > +		child_pid = getpid();
> > +		ppid = getppid();
> >  
> > -		if ((pgid_0 = FORK_OR_VFORK()) == -1)
> > -			tst_brkm(TBROK, cleanup, "fork failed");
> > -		if (pgid_0 > 0) {
> > -			while ((pgid_0 = wait(&ex_stat)) != -1) ;
> > +		tst_res(TINFO, "getpid() in child = %d", child_pid);
> > +		tst_res(TINFO, "getppid() in child = %d", ppid);
> > +		tst_res(TINFO, "Running getpgid() in child");
> >  
> > -			if (WEXITSTATUS(ex_stat) == 0)
> > -				tst_resm(TPASS, "%s PASSED", TCID);
> > -			else
> > -				tst_resm(TFAIL, "%s FAILED", TCID);
> > +		TST_EXP_POSITIVE(getpgid(0));
> > +		TST_EXP_EQ_LI(TST_RET, ppid);
> 
> I do not think that this is correct, the previous code compared the
> return value from getpgid(0) against the rest, not parent pid.
I think I wrongly assumed the ppid to be pgid of itself and children processes.
Thanks for pointing it point.
> 
> I guess that the best solution here would be to call getgid() in the
I guess you meant getpgid() here?
> parent and save that to a variable and use that for the comparsion in
> the child.
> 
> 

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
