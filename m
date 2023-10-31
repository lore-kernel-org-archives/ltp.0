Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EBC4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 15:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43D573CF39C
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 16:39:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 729EE3CC971
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 16:39:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D638B2064EF
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 16:38:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95EE61F74D;
 Tue, 31 Oct 2023 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698766738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPS5nSSyrBYpIBhp2Ju2zuRZNn8Yh2H5hPMo8+k5g8U=;
 b=I9A7WRYW3ATDXg0fqhEUh+TFXNlUmvmYJoVkWLkI4CJUixA1GXwjlJtAOlru8GHWb+t2cQ
 JWcyAAOF3OSjjGzAQ8X1IjJK79zFEVDqn3GZg0jlL2fAahjLUAKH6bmnZoqPEOv+Fr7hbW
 plQv31ZNd+CEqcBQLS0+VuMtPCEq//E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698766738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPS5nSSyrBYpIBhp2Ju2zuRZNn8Yh2H5hPMo8+k5g8U=;
 b=BtFLS6OeN46bJafSduzFuLkn+FdpnE5pGOJ00ppqeIdO7bRj4175ZPDOI7kSdiEeh6e3Dh
 aCGP6846Uq30yPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83EE9138EF;
 Tue, 31 Oct 2023 15:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7rmzH5IfQWWcOQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 31 Oct 2023 15:38:58 +0000
Date: Tue, 31 Oct 2023 16:39:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZUEfsSXxSe4nIsyf@yuki>
References: <20230825063932.30875-4-akumar@suse.de>
 <20230905133118.23912-1-akumar@suse.de> <871qe412jm.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871qe412jm.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mmap14: Rewrite test using new LTP API
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
> > -static void setup(void)
> > +static void run(void)
> >  {
> > -	tst_require_root();
> > +	unsigned int sz_before, sz_after, sz_diff;
> >  
> > -	tst_sig(FORK, DEF_HANDLER, cleanup);
> > +	getvmlck(&sz_before);
> >  
> > -	TEST_PAUSE;
> > -}
> > +	if (((sz_before * 1024) + MMAPSIZE) > rlim.rlim_cur)
> > +		tst_brk(TBROK, "Trying to exceed RLIMIT_MEMLOCK limit");
> 
> Should this be TCONF not TBROK?

TCONF also this should be done in the test setup()

And optionally we may atempt to raise the limit as long as rlim_max >=
than the size we need we can easily raise the rlim_cur.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
