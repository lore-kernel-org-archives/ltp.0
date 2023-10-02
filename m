Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69431E784AC
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 11:08:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA5263CDE04
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 13:08:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C47773CB9E8
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 13:08:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CF93200B69
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 13:08:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A38E1F747;
 Mon,  2 Oct 2023 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696244921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2RZDcBkVhrxwDnJD0LiVFNJbgomzrWV/dK4FLbTiXc=;
 b=kCQFQ0wxX0diZ449T96nC/Xm5bXZ+ELrTw5TDYfri/FSLnWG0b0Ja7wUIKp7RyICytAT+7
 +rXGdSBESJ77YJBdN3fCDtdZpbvvvDxw4RGqex52cz3yZdUt1DjA/tCB2W+Aaymstu1Fj9
 5gtGw+1U5/hCZ571NYq2EWfcUIlggg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696244921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2RZDcBkVhrxwDnJD0LiVFNJbgomzrWV/dK4FLbTiXc=;
 b=kjWW5897TGLoqhh+IL84xYyXKRjCv3ki8KUHwiWM7Ptxr2UHi0mPJgd12QjQfw5vw+A4Kr
 M+fPCoAqEC5vAPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6859413456;
 Mon,  2 Oct 2023 11:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CwNgGLmkGmWGeQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 02 Oct 2023 11:08:41 +0000
Date: Mon, 2 Oct 2023 13:09:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZRqk47qqtquBw3XQ@yuki>
References: <20230901144433.2526-1-chrubis@suse.cz>
 <87cyxx2tna.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87cyxx2tna.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched: add sched sysctl sanity test
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
> > +static void rt_runtime_us_einval(void)
> > +{
> > +	TST_EXP_FAIL(write(runtime_fd, "-2", 2), EINVAL,
> > +	             "echo -2 > "RT_RUNTIME_US);
> > +}
> 
> I would happily add my tags to the test except that as a general
> principal, I don't want to deal with tests that fail if an unexpected
> error number is returned.
> 
> Unless something can be done (e.g. with meta-data), so that TST_EXP_FAIL
> and similar can be reduced to a TCONF when the wrong errno is returned.
> 
> For instance, this would allow running the tests with a seccomp BPF
> profile, LSM, CGroup or /proc bind mount that blocks the write.
> 
> Or you could just seperate the tests I guess. Then the reset can be
> checked while skipping the errno checks.

Hmm, so I guess that with LSM we are able to open these files R/W but we
can stil get EPERM from the write() right? I'm reluctant to add wildcard
TCONF on any errno, but I guess that we can add a TST_EXP_FAIL macro
version that would have one errno for PASS and one errno for TCONF.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
