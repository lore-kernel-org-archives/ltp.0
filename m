Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABE0D46C15
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 23:26:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D37A83CB493
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 00:26:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4073CAEC3
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 00:26:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BC9110009B0
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 00:26:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D2325BCEF;
 Wed, 28 Jan 2026 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769642778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAe3vH586Z+bnPRGLPvUh1hIcGF//x5eigTRErwgWh4=;
 b=expVVPqoFLUpiVF5t4HWq/JvR8ZZvC7L8SOKg7qQoS5VnI+F2CjmM8pN3nKS0KpKMMTRUJ
 VQojP5OVpBLReluAbMJxQ4JMZCoMRn6GkGyIjrItabj3tUCbv4b0eXzkZ2aG9nWaWR6rkh
 24WiCZFGp/T1UqgvGCYd3ug/Q6kMgyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769642778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAe3vH586Z+bnPRGLPvUh1hIcGF//x5eigTRErwgWh4=;
 b=qsahGQWCepjG2MoOgoHUBk62dReG7D/LyKRPwqmLWmza4+UCHt/Z04buQXlDGo8Dmcdu+O
 WAbJhb7ARP6ahnCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769642778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAe3vH586Z+bnPRGLPvUh1hIcGF//x5eigTRErwgWh4=;
 b=expVVPqoFLUpiVF5t4HWq/JvR8ZZvC7L8SOKg7qQoS5VnI+F2CjmM8pN3nKS0KpKMMTRUJ
 VQojP5OVpBLReluAbMJxQ4JMZCoMRn6GkGyIjrItabj3tUCbv4b0eXzkZ2aG9nWaWR6rkh
 24WiCZFGp/T1UqgvGCYd3ug/Q6kMgyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769642778;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAe3vH586Z+bnPRGLPvUh1hIcGF//x5eigTRErwgWh4=;
 b=qsahGQWCepjG2MoOgoHUBk62dReG7D/LyKRPwqmLWmza4+UCHt/Z04buQXlDGo8Dmcdu+O
 WAbJhb7ARP6ahnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAC4A3EA61;
 Wed, 28 Jan 2026 23:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2S/zMxmbemkYeAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 23:26:17 +0000
Date: Thu, 29 Jan 2026 00:26:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260128232616.GA69843@pevik>
References: <20260116022507.204549-1-liwang@redhat.com>
 <20260116022507.204549-2-liwang@redhat.com>
 <20260128212207.GA60105@pevik>
 <CAEemH2fkn3C4ov0YL9sx5SiBMuWEOoNfrwAzEsOwCZZDTtuEwA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fkn3C4ov0YL9sx5SiBMuWEOoNfrwAzEsOwCZZDTtuEwA@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] include/old: rename legacy headers to
 tso_* namespace
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

Hi Li, all,

> > As I wrote, I don't like the whole rename but I will not block it.
> > I guess it will be merged after the release, just not to break anything.

> > But is it worth to rename whole old API sources and headers? Isn't it
> > enough
> > just to know that 'tst_' or 'tse_' are new API, the rest is the old API or
> > no
> > API? Each rename means that 'git log' requires '--' because the rename.


> Well, yes, that's my hesitation too.

> However, I believe the old APIs may persist for a long time. Therefore,
> using consistent naming conventions for all APIs will make it easier for
> LTP beginners to understand the code logic.

OK. Ack for both commits.
Acked-by: Petr Vorel <pvorel@suse.cz>

> > Anyway, IMHO it would help (as a separate effort after the release) to
> > describe
> > the prefixes in doc.


> Yes, it's not a rush, we could give enough time for refinement work.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
