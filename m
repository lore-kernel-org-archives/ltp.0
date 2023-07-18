Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A1FEB64DC
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 09:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAF663C9A2E
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 11:31:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47A423C9901
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 11:31:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2396C600C5A
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 11:30:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 641C21FDC5;
 Tue, 18 Jul 2023 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689672658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPUXrrog+lWkwjebGbL5W7IB5MP0CFdkpaPNV0LgPkA=;
 b=2FqQ9QMHjybWqTuqew5ygUf9HSdmpW+UtjKAHQ8vCjRNcvhMvsyoavc76pmfh3B/+edSqs
 xd+rVSBAsqbPpQyz8vMWS0/Rrt5vXrZQvaYdcr6sot4leee94+nUdSmm6WxaACyiZFf1xD
 j8cHXJxts+aoVy3EUqVeTjsxMbUnNmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689672658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SPUXrrog+lWkwjebGbL5W7IB5MP0CFdkpaPNV0LgPkA=;
 b=KJUeTaza4kpCBauJhRR0c/vme8Geend/6+NPZh79FGkgUFnHR+xOYZLKxUr59u0iex4ulb
 NL99shyzEtKMR2Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3DBD134B0;
 Tue, 18 Jul 2023 09:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UBOsLtFbtmQxZQAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 18 Jul 2023 09:30:57 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Jul 2023 14:57:29 +0530
Message-ID: <2691616.mvXUDI8C0e@localhost>
Organization: SUSE
In-Reply-To: <20230718082313.GA1140910@pevik>
References: <20230717153339.11904-1-akumar@suse.de>
 <20230718082313.GA1140910@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe06: Rewrite the test using new LTP
 API
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

Hi Petr,

On Tuesday, July 18, 2023 1:53:13 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> >  testcases/kernel/syscalls/pipe/pipe06.c | 133 ++++++------------------
> 
> ...
> 
> > +static void setup(void)
> > 
> >  {
> > 
> > +	int max_fds;
> > 
> > -		/* reset tst_count in case we are looping */
> > -		tst_count = 0;
> > +	max_fds = getdtablesize();
> > +	tst_res(TINFO, "getdtablesize() = %d", max_fds);
> > +	opened_fds = SAFE_MALLOC(max_fds * sizeof(int));
> 
> You don't free opened_fds in cleanup, that would be a memory leak.
Thank you for reviewing and catching this issue. I've sent a v2 with
your suggested fix.


Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
