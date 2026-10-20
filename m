Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FC606A31C
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lvBAZ3bY;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tA113ImI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lvBAZ3bY;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tA113ImI
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7EB3EA609
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 12:06:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3926F3E1271
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:06:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B88B4100093C
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 12:06:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2D01F79E;
 Tue, 20 Oct 2026 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792490803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bokGfXkZe7bnmgXcIfUjQkULOmehIqZqmcnesW6i8Vs=;
 b=lvBAZ3bYJPUPzRiZxO6FXxJKzqmnscEBOPeVmsFZ6+cg9Wo05aQUrKEo9gMTX/ECzbAjYV
 MD+nxU4FZMG4LEZjc1cKJk9D5XiJ4+9DHUozDMoT+EbxofqpUJoJi1nCRgiv15MmOnlU4J
 628xtZbDEOLFZpdwKluWWD+195HjTIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792490803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bokGfXkZe7bnmgXcIfUjQkULOmehIqZqmcnesW6i8Vs=;
 b=tA113ImIgRZ/o3B6b63V5iFhI+acDaQ1rd/hTBBzN+qQY/DcubFI2RmGNGLFP+gWGo2xqr
 85nHHVmAgi2iDnBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792490803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bokGfXkZe7bnmgXcIfUjQkULOmehIqZqmcnesW6i8Vs=;
 b=lvBAZ3bYJPUPzRiZxO6FXxJKzqmnscEBOPeVmsFZ6+cg9Wo05aQUrKEo9gMTX/ECzbAjYV
 MD+nxU4FZMG4LEZjc1cKJk9D5XiJ4+9DHUozDMoT+EbxofqpUJoJi1nCRgiv15MmOnlU4J
 628xtZbDEOLFZpdwKluWWD+195HjTIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792490803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bokGfXkZe7bnmgXcIfUjQkULOmehIqZqmcnesW6i8Vs=;
 b=tA113ImIgRZ/o3B6b63V5iFhI+acDaQ1rd/hTBBzN+qQY/DcubFI2RmGNGLFP+gWGo2xqr
 85nHHVmAgi2iDnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD594136C6;
 Tue, 20 Oct 2026 10:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id msrEJTI912qfKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 20 Oct 2026 10:06:42 +0000
Date: Tue, 20 Oct 2026 12:06:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20261020100641.GB142152@pevik>
References: <20261019131327.GA63027@pevik>
 <N2K8VeQov9Sg4LgN54hYWPRvgHd1PvbTfIFF@localhost.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <N2K8VeQov9Sg4LgN54hYWPRvgHd1PvbTfIFF@localhost.localdomain>
X-Spam-Score: -7.50
X-Spam-Level: 
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nextafter01: Check exact results and convert to
 new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> > ...
> > > +	if (ret == tc->exp) {
> > Hm, we still does not have TST_EXP_EQ_* variant for double.
> > Likely not worth of having it (not many tests comparing double).

> > Kind regards,
> > Petr

> actually I think it's a good idea, even if we don't have many examples
> like this one. Maybe we can skip it for this time, keeping an eye on
> patches to check for similar patterns.

+1, once we have it, people can start using it.

I suggest: Jan, feel free to merge as is and either send a separate patch to add
it or I send a patch to add it later (let's don't block a test rewrite unless
you have time to add TST_EXP_EQ_*).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
