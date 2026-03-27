Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C08D10ED664
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 12:34:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73E233CFB7B
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 13:34:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 123533CFAA2
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 13:33:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CDBA91001580
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 13:33:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 256444D354;
 Fri, 27 Mar 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774614837;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWUGiGCWOBJUK64AoIPwP9AXcE41fXU9h9jukDFthTY=;
 b=0aIxlxNDW3vfdjSJ0cgFqk/RPMKxthoXSXHOCeEFg6/n5NXd00ChIm7CI0D05x4O4tbHTe
 TCc8i99idtDw9faFmaPiVIVWkU51IEtoPe9RgYfvka75QlcM2LXm25PRwecn1nBS6JxaeV
 6+9V0LqJ8Yl0eW7TyRCziMELg2/eHLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774614837;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWUGiGCWOBJUK64AoIPwP9AXcE41fXU9h9jukDFthTY=;
 b=DecapD3Ek1Efvhu78avs/1BVdFNCUSe9jK1vHSsOKSm3sWNFLdfWItHtTneAKWRPcYDU02
 xVzGeDn4B0xU5sCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774614837;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWUGiGCWOBJUK64AoIPwP9AXcE41fXU9h9jukDFthTY=;
 b=0aIxlxNDW3vfdjSJ0cgFqk/RPMKxthoXSXHOCeEFg6/n5NXd00ChIm7CI0D05x4O4tbHTe
 TCc8i99idtDw9faFmaPiVIVWkU51IEtoPe9RgYfvka75QlcM2LXm25PRwecn1nBS6JxaeV
 6+9V0LqJ8Yl0eW7TyRCziMELg2/eHLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774614837;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWUGiGCWOBJUK64AoIPwP9AXcE41fXU9h9jukDFthTY=;
 b=DecapD3Ek1Efvhu78avs/1BVdFNCUSe9jK1vHSsOKSm3sWNFLdfWItHtTneAKWRPcYDU02
 xVzGeDn4B0xU5sCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0440D4A0A2;
 Fri, 27 Mar 2026 12:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vbGeOjR5xmlDWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 12:33:56 +0000
Date: Fri, 27 Mar 2026 13:33:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260327123351.GA1083266@pevik>
References: <20260316130320.138328-1-japo@linux.ibm.com>
 <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c66196.5d0a0220.2a94f1.b1f7@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Jan,

> > # C/Assembly source files, headers, and shell files use tabs
> > [{*.{c,h,S,sh},ver_linux}]
> > indent_style = tab
> > indent_size = 4

> LTP follows Linux kernel coding style, which uses 8-character-wide tabs.
> This should be indent_size = 8.

FYI I asked for 4 in v1 [1], Jan had originally 8 and I'm ok with following
kernel. It's just my personal preference to display tab as 4 spaces and not 8
(IMHO editorconfig plugins don't allow certain setup to be overwritten).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260310132227.GC39882@pevik/

> > # Python and Perl: default to tabs (most test files use tabs, checkpatch.pl which we modify)
> > [*.{py,pl}]
> > indent_style = tab
> > indent_size = 8

> Not 100% sure about this.

> The Python test files in the tree (e.g. pm_sched_domain.py, pm_ilb_test.py)
> all use 4-space indentation, not tabs. The default for *.py should be
> indent_style = space / indent_size = 4. Perl (checkpatch.pl) does use tabs,
> so it should get its own section.

> Also kirk uses 4 tabs indentation. So I guess we need to invert the two rules
> at this point.

> Regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
