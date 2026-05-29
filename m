Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B011ECD6E49
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 16:08:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 031013E76A6
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 18:08:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58A8C3C6FCD
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:07:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A91551A00CCE
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:07:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3DF670A1;
 Fri, 29 May 2026 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780070861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzNNtPSseuPuEZTDOgHBWuOpXwdY1y5gA9vyY+yvqXs=;
 b=SkkeoMGuH3YfIB1IK0NOAA5QA6hNUPXnattcwKqdekjjOFOhurc9cnXFd+Spqq1KL0CYvm
 SthSHJmtJKQOHvZ9XPtSIOAK1tBtp7cL9ZiVDVUqHt19K+h3roK+uQbsVIxnV5IilT1K9A
 5zZY5Ei0YO/BUxffLnprfYpqhlXcoig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780070861;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzNNtPSseuPuEZTDOgHBWuOpXwdY1y5gA9vyY+yvqXs=;
 b=lpEXTWCkbqVr00ciOGW5RESwuTe1ZXoZrS5IptoccYNs4kPYotqze5ZwBfT9kA/M13XsJD
 C05j84gtY97lIsAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="BgK4hF/t";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2sJCmsK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780070860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzNNtPSseuPuEZTDOgHBWuOpXwdY1y5gA9vyY+yvqXs=;
 b=BgK4hF/tPqRCMBCiuxdg6m8CpGbS781A6X/N/WXoPV2Jla17md/Lhy6teGv3TzgleUw6NO
 8PVHajJ1i4YLeSWjoproqSjqSlrqPtfKJiPUXlQMl56q6B/8KZjiKwUQf/Uyk70/vJ1x9A
 uGSO4Yu1V9ZlGQl2g8xz3ByG40AFZDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780070860;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PzNNtPSseuPuEZTDOgHBWuOpXwdY1y5gA9vyY+yvqXs=;
 b=2sJCmsK1jhVPv6tOI+LCG7jJBDRmW2A10lWjFCqWAtxSGOEKLpKY+y5lXRWQCHERIqoFxZ
 9TUja/gH2HDo7BAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 470EA779A7;
 Fri, 29 May 2026 16:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yuTlDsy5GWo+YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 29 May 2026 16:07:40 +0000
Date: Fri, 29 May 2026 18:07:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260529160708.GA287653@pevik>
References: <20260527050843.14963-1-wegao@suse.com> <ahcQd-5ffiCDU8IE@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahcQd-5ffiCDU8IE@yuki.lan>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A3DF670A1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mem/min_free_kbytes: Add grace period for
 memory reclaim
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

> > @@ -140,14 +140,13 @@ static void test_tune(unsigned long overcommit_policy)
> >  		} else {
> >  			if (WIFEXITED(status)) {
> >  				if (WEXITSTATUS(status) != 0) {
> > -					tst_res(TFAIL, "child unexpectedly "
> > -						 "failed: %d", status);
> > +					tst_res(TFAIL, "child unexpectedly failed: %d",
> > +						status);

> We do have tst_strstatus().

+1, I fixed this as a separate change:
https://github.com/linux-test-project/ltp/commit/d81526f7da5645a04d6e03e557d3c829b67b3c57

> >  				}
> >  			} else if (!WIFSIGNALED(status) ||
> >  				   WTERMSIG(status) != SIGKILL) {
> > -				tst_res(TFAIL,
> > -					 "child unexpectedly failed: %d",
> > -					 status);
> > +				tst_res(TFAIL, "child unexpectedly failed: %d",
> > +					status);
> >  			}
> >  		}
> >  	}
> > @@ -183,18 +182,32 @@ static void check_monitor(void)
> >  {
> >  	unsigned long tune;
> >  	unsigned long memfree;
> > +	int i;

> >  	while (!end) {
> >  		memfree = SAFE_READ_MEMINFO("MemFree:");
> >  		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);

> >  		if (memfree < tune) {
> > -			tst_res(TINFO, "MemFree is %lu kB, "
> > -				 "min_free_kbytes is %lu kB", memfree, tune);
> > -			tst_res(TFAIL, "MemFree < min_free_kbytes");
> > +			/*
> > +			 * Give it some time to reclaim. The kernel should keep
> > +			 * MemFree above min_free_kbytes, but transient drops
> > +			 * are possible under high pressure.
> > +			 */
> > +			for (i = 1; i < 1024; i *= 2) {
> > +				usleep(i * 1000);
> > +				memfree = SAFE_READ_MEMINFO("MemFree:");
> > +				if (memfree >= tune)
> > +					break;
> > +			}
> > +
> > +			if (memfree < tune) {
> > +				tst_res(TFAIL, "MemFree %lu kB < min_free_kbytes %lu kB",
> > +					memfree, tune);
> > +			}
> >  		}

> Looks good.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> I think that we also want to change the test so that the monitor is
> started and stopped for each testcase with a specific value we set the
> min_free_kbytes to. Running it asynchronously like this may mean that we
> will be looking for a wrong value for the second if we are unlucky. But
> that can be done later on.

@Wei Unfortunately this does not help on the current stable kernels (at least
not on 7.0.10 on Tumbleweed. We discussed it with Vlastimil Babka and Cyril
Hrubis and the conclusion  is to start with running the monitor synchronously
with each subtestcase and making sure MemFree is big enough before we start the
monitor and the process that creates memory stress.
Also, please rebase when doing changes.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
