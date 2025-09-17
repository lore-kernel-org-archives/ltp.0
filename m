Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED01CAC599
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 11:30:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3D53CDBFB
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 13:30:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43BD53CDB75
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:30:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 868852009C6
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:30:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7A921F7B9;
 Wed, 17 Sep 2025 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758108615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDu60v7WMyzUG1AITKrla5l4PAfeqj5o23K1J0JPrfo=;
 b=RMliJDCGb+I3Fnflg9x0BNV9S7EiSlKUIt7VA+P2/YOEJJE16+ThDnBitgXO/xc+j2ILV0
 wlLgGvlJdrndCPpxdA98DIZC7bL1TM6dO2phdJ3l7OvfwODe4dlGBtg/X6OFj59WZ41WB+
 ZUJKqabH90fxM9SPyyYvvER+FS2FWo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758108615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDu60v7WMyzUG1AITKrla5l4PAfeqj5o23K1J0JPrfo=;
 b=RufxKD6zU2gahTkaysoU7BeqH8TWNS31VU9l/GRQDG30GS9m00k73X6MljU9IiBhGAIvXL
 QudxcmgV1we957BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758108615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDu60v7WMyzUG1AITKrla5l4PAfeqj5o23K1J0JPrfo=;
 b=RMliJDCGb+I3Fnflg9x0BNV9S7EiSlKUIt7VA+P2/YOEJJE16+ThDnBitgXO/xc+j2ILV0
 wlLgGvlJdrndCPpxdA98DIZC7bL1TM6dO2phdJ3l7OvfwODe4dlGBtg/X6OFj59WZ41WB+
 ZUJKqabH90fxM9SPyyYvvER+FS2FWo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758108615;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDu60v7WMyzUG1AITKrla5l4PAfeqj5o23K1J0JPrfo=;
 b=RufxKD6zU2gahTkaysoU7BeqH8TWNS31VU9l/GRQDG30GS9m00k73X6MljU9IiBhGAIvXL
 QudxcmgV1we957BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4913E137C3;
 Wed, 17 Sep 2025 11:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h2CJDsebymjESwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Sep 2025 11:30:15 +0000
Date: Wed, 17 Sep 2025 13:30:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <20250917113013.GA340479@pevik>
References: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
 <20250917103717.GB336745@pevik>
 <20250917111319.wgfpjmkicmv2rjti@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250917111319.wgfpjmkicmv2rjti@lida.tpb.lab.eng.brq.redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Proposal for new LTP config knob: LTP_QUIET
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On  Wed  2025-09-17  12:37 , Petr Vorel wrote:
> > Hi Martin,

> > > Hi folks,

> > > some time back, LTP_REPRODUCIBLE_OUTPUT was introduced in LTP.
> > > I'd like to propose a new, related LTP knob for our Valgrind
> > > test automation purposes: LTP_QUIET.  See attached patch.

> > > LTP_QUIET is supposed to suppress certain types of test output
> > > messages, such as: TCONF, TWARN, TINFO, and TDEBUG.  This would
> > > help us keep our test logs briefer, while still keeping the
> > > information we need in the logs.

> > > Please, consider merging upstream.

> > Thanks for contributing this. So the point is to have only the final summary
> > printed, right? (summary of TCONF/TWARN/TBROK/...).

> > I'm ok for merging this + to introduce the same for shell API (tst_test.sh),
> > although you in valgrind don't use it.  And we could even introduce '-q' getopt
> > (easier for manual debugging).

> > Do we then want to keep the "reproducible output" part? Or should it quiet
> > replace it?

> Hi Petr,  you are right that these two knobs (LTP_QUIET and
> LTP_REPRODUCIBLE_OUTPUT) partly overlap.  In my proposal, LTP_QUIET
> doesn't silence everything.  It does silence TCONF, TWARN, TINFO,
> and TDEBUG messages.  But it keeps TPASS, TFAIL, and TBROK.

Ah, correct (I was wrong). If there were users who need to separate these (i.e.
using just single of these) I would keep it separate. But IMHO you valgrind
folks are the only ones who use it, therefore feel free to modify it to fix your
needs. OTOH, if you're ok to using 2 variables, I guess we are ok to have both.
Let's see what others think (Andrea already acked).

> Suppressing everything except the final summary seemed too
> aggressive to me initially.  But as we speak, it would work for
> Valgrind testing purposes just fine.

If you compare whole output mismatch in Summary would catch a difference.

OTOH you're right that it's safer to keep at least TFAIL and TBROK.
I'd personally add also TWARN (not that many messages).

Kind regards,
Petr

> > @Cyril, if you agree, do we dare to have it before the release?



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
