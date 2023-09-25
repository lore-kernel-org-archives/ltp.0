Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B22ACE7A94
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:12:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A18083CDD2E
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:12:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D2BF3CACBD
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:12:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9651D1A01215
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:12:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB54721838;
 Mon, 25 Sep 2023 13:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695647556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oZxGz6ZZW1eOAdlpPtT7uM9H37t8dckKwBYhKxKNbbc=;
 b=3bh7474Zssi3ay5yfsL9bKoDRMLyV/w+3YN8/ew8eBxTyIdETwlG0K5llljN4r1v8mUGGa
 ut7IAuz9nQaq3o2JteRW66mt2aBpJqJXbxcS//goVLO+H60xL10O+WhUXkd5Y65oGJ0Ls/
 bgL3txQI+h4jzeF3cthu9/bwkfQgKWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695647556;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oZxGz6ZZW1eOAdlpPtT7uM9H37t8dckKwBYhKxKNbbc=;
 b=CElPQXtnq7G5Z2/8wjNqYz5PNYvruin1dQkAMbTgLkhwgMYnuys+kKwE9eI7bjL/y2x+wZ
 LMbe1s1mXMn5JgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CABA613580;
 Mon, 25 Sep 2023 13:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MKCsL0SHEWUuBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 13:12:36 +0000
Date: Mon, 25 Sep 2023 15:12:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230925131235.GB60471@pevik>
References: <20230920153145.30891-1-mdoucha@suse.cz>
 <ZQ2E_pKz2QSG61LY@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQ2E_pKz2QSG61LY@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pidns05: Use tst_getpid()
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

> Hi!
> > --- a/testcases/kernel/containers/pidns/pidns05.c
> > +++ b/testcases/kernel/containers/pidns/pidns05.c
> > @@ -28,7 +28,7 @@ static void child_func(int *level)
> >  {
> >  	pid_t cpid, ppid;

> > -	cpid = getpid();
> > +	cpid = tst_getpid();
> >  	ppid = getppid();

> >  	TST_EXP_EQ_LI(cpid, 1);
> > @@ -55,7 +55,7 @@ static int find_cinit_pids(pid_t *pids)
> >  	int next = 0;
> >  	pid_t parentpid, pgid, pgid2;

> > -	parentpid = getpid();
> > +	parentpid = tst_getpid();

> I suppose that this one is not strictly required, but it does not harm
> to consistently use tst_getpid()

Well, Martin found that some of SLES versions (e.g. some SLES versions based on
kernel 4.12 or older) started to fail after rewrite:

8c201e55f ("Remove libclone dependency from pidns05 test")

tst_test.c:1684: TINFO: LTP version: 20230516
tst_test.c:1570: TINFO: Timeout per run is 0h 00m 30s
pidns05.c:34: TFAIL: cpid (2075) != 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TFAIL: cpid (2075) != 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TFAIL: cpid (2075) != 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TFAIL: cpid (2075) != 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TFAIL: cpid (2075) != 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:34: TFAIL: cpid (2075) != 1 (1)
pidns05.c:35: TPASS: ppid == 0 (0)
pidns05.c:97: TPASS: find_cinit_pids(pids) returned 6
pidns05.c:115: TPASS: No children left after sending SIGKILL to the first child

Therefore it was needed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
