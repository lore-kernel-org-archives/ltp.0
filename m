Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C183FEA837
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:10:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFB963E2248
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:10:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 288373CC6A9
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:10:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F4631A010AE
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:10:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8C165BD98;
 Wed, 25 Mar 2026 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774429809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJIRR++zFUjafvadT1X9dsdWQPkIqeZMR0rvmwFprOA=;
 b=atrSP19/BVrknX528B/xAmxVSsf0kqju5I8aHRIwS2zrCN8UA1Xj8XMTJGFd70dJ0v3N8+
 5hkaWXy5Oy3KzGStoL0bZGXeJzRFAF43fqdX5qGGdU2tbn57Jge2dGPch/Z7Yh0vqX7NKB
 Vo1eFNTH+SrpYi61Gg/42sf8NnAHhlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774429809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJIRR++zFUjafvadT1X9dsdWQPkIqeZMR0rvmwFprOA=;
 b=b+y9VluPiVMgK1WBA+/T20zC5HaBr1HB/ydw87VxbRxTZE2DLWqbEAXOZsg4ROLZjLT4Tl
 E/2+lC7cFdrbYwBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774429809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJIRR++zFUjafvadT1X9dsdWQPkIqeZMR0rvmwFprOA=;
 b=atrSP19/BVrknX528B/xAmxVSsf0kqju5I8aHRIwS2zrCN8UA1Xj8XMTJGFd70dJ0v3N8+
 5hkaWXy5Oy3KzGStoL0bZGXeJzRFAF43fqdX5qGGdU2tbn57Jge2dGPch/Z7Yh0vqX7NKB
 Vo1eFNTH+SrpYi61Gg/42sf8NnAHhlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774429809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJIRR++zFUjafvadT1X9dsdWQPkIqeZMR0rvmwFprOA=;
 b=b+y9VluPiVMgK1WBA+/T20zC5HaBr1HB/ydw87VxbRxTZE2DLWqbEAXOZsg4ROLZjLT4Tl
 E/2+lC7cFdrbYwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E63D44309;
 Wed, 25 Mar 2026 09:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xUPEIXGmw2myewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 25 Mar 2026 09:10:09 +0000
Date: Wed, 25 Mar 2026 10:10:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <20260325091003.GA86256@pevik>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On  Tue  2026-03-24  15:09 , Martin Cermak wrote:
> > On  Tue  2026-03-24  14:18 , Cyril Hrubis wrote:
> > > Hi!
> > > > LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
> > > > help valgrind to use LTP for testing. It discards the actual content of
> > > > the messages printed by the test (removes everything after printing
> > > > TINFO/TPASS/TFAIL/...  flag).

> > > > Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
> > > > TINFO, and TDEBUG messages. Therefore LTP_REPRODUCIBLE_OUTPUT=1 is not
> > > > needed any more.

> > > I do not think so. We still have things like pids and timestamps in
> > > TPASS/TFAIL messages that needs to be removed in order for the output to
> > > be reproducible.

> > From Valgrind persp, seems like we could drop it at the first
> > glance.  But let me confirm that based on a thorough check.

> My quick guess above was wrong.  We do need
> LTP_REPRODUCIBLE_OUTPUT for Valgrind testing.
> Please keep it.

Thanks for info, Martin. Sure, please drop this patch.

I still feel these 2 variables somehow overlap, wouldn't it make sense to merge
the functionality into a single variable?

Kind regards,
Petr

> Thank-you,
> Martin



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
