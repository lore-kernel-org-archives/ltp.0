Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BC2C54E65
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 19:57:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ADF13CC893
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 21:57:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE86F3C68A4
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:57:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7D896002C3
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:57:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55DCA21B3B;
 Thu, 22 May 2025 19:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747943829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaD4icQy47UfvJQ93R/OGiP6dV8pBWmDBFGYNzoj8m4=;
 b=MJD1iotI85XX9PVCaObt0cq75tDirh4fylmKo7kzzvT9oDU69IOr4/yqvOS5xPxaOk/9bG
 Fy7DPWhMH1Vv7BlOdzHxkGY1VqB1VvEUy5RvzSqZMhpkzvfmriDQNEGvMQ9xQuuircauFd
 wDajnTn1CQCAiyKD+PI6exVwNi/s0CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747943829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaD4icQy47UfvJQ93R/OGiP6dV8pBWmDBFGYNzoj8m4=;
 b=DRDOYzW48dBWN+tC4xR6jfKWJXFJ7PH+i5dAIyonpiVKqmwhOkwJki3ul0wCViTFRIVZ46
 iVVMb1knw7X8K+AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747943829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaD4icQy47UfvJQ93R/OGiP6dV8pBWmDBFGYNzoj8m4=;
 b=MJD1iotI85XX9PVCaObt0cq75tDirh4fylmKo7kzzvT9oDU69IOr4/yqvOS5xPxaOk/9bG
 Fy7DPWhMH1Vv7BlOdzHxkGY1VqB1VvEUy5RvzSqZMhpkzvfmriDQNEGvMQ9xQuuircauFd
 wDajnTn1CQCAiyKD+PI6exVwNi/s0CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747943829;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yaD4icQy47UfvJQ93R/OGiP6dV8pBWmDBFGYNzoj8m4=;
 b=DRDOYzW48dBWN+tC4xR6jfKWJXFJ7PH+i5dAIyonpiVKqmwhOkwJki3ul0wCViTFRIVZ46
 iVVMb1knw7X8K+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E350513433;
 Thu, 22 May 2025 19:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7gnZNJSBL2gDcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 May 2025 19:57:08 +0000
Date: Thu, 22 May 2025 21:57:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Jan Polensky <japo@linux.ibm.com>
Message-ID: <20250522195707.GB26060@pevik>
References: <20250521095302.13845-1-chrubis@suse.cz>
 <20250522173111.GA19708@pevik> <aC9jOhqDkRwGp9-T@rei>
 <20250522192612.GA26060@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250522192612.GA26060@pevik>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

...
> > > Could we clearly define what we expect from LTP_SINGLE_FS_TYPE?
> > > FYI I put links to the discussion in the ticket
> > > https://github.com/linux-test-project/ltp/issues/1242

> > > I understand the wish to use LTP_SINGLE_FS_TYPE for a proper testing.  If that
> > > requires to respect .skip_filesystems, but
> > > 1) it should be done for all filesystems
> > > 2) we should have another variable to allow to force the user defined
> > > filesystem, e.g.
> > > LTP_SINGLE_FS_TYPE=ntfs LTP_SINGLE_FS_TYPE_FORCE_FS=1

> > What about LTP_FORCE_SINGLE_FS_TYPE=ntfs that would do the same as
> > LTP_SINGLE_FS_TYPE=ntfs but would disable the skiplist?

Also, what if both are set? Should it be mutually exclusive?

Kind regards,
Petr

> +1, it should go to the release.

> But please update also doc doc/users/setup_tests.rst + -h help in lib/tst_test.c
> and testcases/lib/tst_test.sh (variable will of course affect both).

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
