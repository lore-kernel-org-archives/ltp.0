Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B38FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 06:11:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B49A3E252D
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:11:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7320D3D03F5
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:10:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91C871400C60
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:10:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B6C75BD3F;
 Wed, 29 Apr 2026 06:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777443044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoYkLNZdDDtbXfm4XXwBQQQe3dfYSdtnWbJno9gORSE=;
 b=gxfoVG6JVoT4YWN6B5lFAQDaXGzxRXFbbLWVfancNQPuW2apUOaiGcOrhmenGvZz68bG9l
 00eHdELLTuCIiZRoJJVF0H7MNdUBH8TqIaDqoiDXX9ii4hBcn/m9msSf9O3F62ka2932Sj
 LUaA1yhBts+P2sEhNzxeXsGIkDlQPRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777443044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoYkLNZdDDtbXfm4XXwBQQQe3dfYSdtnWbJno9gORSE=;
 b=aa/Z8Ht/2rUKp6bqo11ZicPqhlDmm3jUkJpyGXCfQCwnbCR5UAq6JsZQNC0ULxMS3O2mvP
 pc+428blH/d7T8Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gxfoVG6J;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="aa/Z8Ht/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777443044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoYkLNZdDDtbXfm4XXwBQQQe3dfYSdtnWbJno9gORSE=;
 b=gxfoVG6JVoT4YWN6B5lFAQDaXGzxRXFbbLWVfancNQPuW2apUOaiGcOrhmenGvZz68bG9l
 00eHdELLTuCIiZRoJJVF0H7MNdUBH8TqIaDqoiDXX9ii4hBcn/m9msSf9O3F62ka2932Sj
 LUaA1yhBts+P2sEhNzxeXsGIkDlQPRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777443044;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZoYkLNZdDDtbXfm4XXwBQQQe3dfYSdtnWbJno9gORSE=;
 b=aa/Z8Ht/2rUKp6bqo11ZicPqhlDmm3jUkJpyGXCfQCwnbCR5UAq6JsZQNC0ULxMS3O2mvP
 pc+428blH/d7T8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75FC1593B0;
 Wed, 29 Apr 2026 06:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r7XSG+Sg8WnDQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 06:10:44 +0000
Date: Wed, 29 Apr 2026 08:10:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260429061043.GA539072@pevik>
References: <20260427115941.31945-1-wegao@suse.com>
 <20260428125804.GA921372@pevik> <20260428163415.GB921372@pevik>
 <afFrf9OtAUkcOjLT@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afFrf9OtAUkcOjLT@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9B6C75BD3F
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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
Cc: Li Wang <liwang@linux.dev>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Apr 28, 2026 at 06:34:15PM +0200, Petr Vorel wrote:
> > Hi all,

> > > Hi all,

> > > > mmapstress06 is designed to stress the mfile_swap kernel primitive, which
> > Uh, I overlooked "mfile_swap kernel primitive". Then the approach would make
> > sense, but is it really true? mfile_swap does not exist any more, not even in a
> > git log. Test was added in January 2003, e.g. even before 2.6.

> > > > manages shared anonymous memory. On architectures with large pages (like
> > > > 64KB on ppc64le), the test's hardcoded request for 32769 pages results
> > > > in a ~2GB mapping. So in suse test system configured with 2GB of RAM and
> > > > no swap space, the test will fails with following information:

> > I'm not really sure. if that's caused by missing swap or would it work on
> > machine with RAM big enough which has swap disabled (I guess you retest with
> > e.g. 8 GB RAM). Otherwise I'd prefer prefer to deal with errno ENOMEM (12)
> > instead (as I pointed out previously).


> Base description/implementation of test case, The original test is "passive," merely creating a 
> mapping and relying on external processes to trigger swapping(case has sleep_time parameter).
> Further more, this case is "ghost test" for current kernel, it do mmap but never 
> writes to it, so kernel never actually allocated memory, 
> Together with current obsolete logic(test targets legcy mfile_swap) i suggest just delete 
> it instead of wasting time patching(refactor) it. What do you think? @Petr @wang li?

I'm ok with deleting, but i hope others will have look on it as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
