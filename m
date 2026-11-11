Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F62606A324
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=BeEjxMlU;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=g/EnqHKT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=S1sSxccD;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=J3rqIjZ5
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C83D3EAC5E
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 15:36:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 176B13EA132
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 15:36:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A29E660093B
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 15:35:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF4B9223E5;
 Wed, 11 Nov 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794407759;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6o71/tP11khj/QflLp/m60MT3PH3hd7UH2B7a073YhM=;
 b=BeEjxMlUD1INzTXEseZJ3/y0dzkhwccYuwIjFHrwYYUx+07afP4IqjLPd3hBLPYE9Ug+v+
 wxMEmgu2UKiI9xAyxRpqLiNnXhDUKAWoB0RHO9ZXpWLLnoAgtHidfRBlUcSNTqEEpyt+6D
 SruZan79zcQ2Gbjkdo6ip4FRFWQZjic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794407759;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6o71/tP11khj/QflLp/m60MT3PH3hd7UH2B7a073YhM=;
 b=g/EnqHKTVOisR/mXOrOghSIRHHi6hsJCsp1Qyq1HT9K0a73dMAehd4x+GsnKzpXRwDN1aS
 LygPZakLq5DD9bDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794407757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6o71/tP11khj/QflLp/m60MT3PH3hd7UH2B7a073YhM=;
 b=S1sSxccD9Fl2E4puX1so+DIuALCijya3jKoy5uzJstyDX08aS5uKdFZah+NDgsmyNTXr88
 wJpDsP8OV6ktEqMheNam0Qv9+4ISqgPqinvxDLNCcNCr7MEzxsZqyZ/fnZjQiLUPE+IcxN
 ByWMBWIOP6tzq/dwz70ZmhI7Rj2Hsgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794407757;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6o71/tP11khj/QflLp/m60MT3PH3hd7UH2B7a073YhM=;
 b=J3rqIjZ5+NuUvy5iXjqF2H+a9bFMXJZH8KxJtZCGP0bGOLRovL762nvRN8bdyCeJieqRu0
 0Hfn96GazJUPSKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98976134E5;
 Wed, 11 Nov 2026 14:35:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EWsPGU199GprFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Nov 2026 14:35:57 +0000
Date: Wed, 11 Nov 2026 15:35:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Hristos Nenkov <nenkov2004@gmail.com>
Message-ID: <20261111143555.GA763965@pevik>
References: <CAO7_G+wYCDjBpia5UbAJc52v1Rn9uRKoLn=UHhg_U4bs=UYeDA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO7_G+wYCDjBpia5UbAJc52v1Rn9uRKoLn=UHhg_U4bs=UYeDA@mail.gmail.com>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Proposed scope for replacing FTP/HTTP stress tests
 (#1207)
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

Hi Hristos,

> Hello,

> I would like to contribute a replacement for the FTP/HTTP stress tests
> described in issue #1207:
> https://github.com/linux-test-project/ltp/issues/1207

> Before implementing the full replacement, could you confirm whether
> someone is already working on it, and whether the following direction
> is appropriate?

IMHO nobody is working on it ATM.

> I propose a separate TCP bulk-transfer tool integrated with the
> current LTP API and tst_net.sh, covering upload and download, a large
> single transfer, and bounded concurrent transfers for a configurable
> duration. Data would be generated and checked in fixed-size buffers
> using position-dependent patterns, without creating multi-gigabyte
> files. Both IPv4 and IPv6, partial I/O, deadlines and owned-process
> cleanup would be covered. Legacy test removal would follow only after
> the replacement coverage is demonstrated.

> Would you prefer this standalone approach, as suggested in the earlier
> discussion, or extending netstress instead? Are the existing
> transfer-size and duration settings important compatibility
> requirements?

If the diff would be reasonably small it'd be better extend netstress.c.
But I'm not sure if there is much code to be reused.

> Separately, I have an AI-assisted local prototype adding opt-in TCP
> reply validation to netstress. It has built on Ubuntu/WSL and passed
> 11 isolated receive checks and 8 loopback client checks across
> IPv4/IPv6. Those results apply only to that prototype, not the
> proposed bulk-transfer replacement. No patch is attached; I have read
> the project's guidance on AI-generated changes and understand that
> independent review and validation are required before any submission.

Yes, human review before sending to LTP would be nice.

Kind regards,
Petr

> Thank you,
> Hristos Nenkov

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
