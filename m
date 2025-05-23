Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F222C54ED0
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 06:30:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 461093CC2EF
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 08:30:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 180763C0E44
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:29:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A36E1A00142
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:29:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18DDC1F385;
 Fri, 23 May 2025 06:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747981792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agL27eFaAka+Q1aIbEaygNTG8j8nDiJhiu+9IdYCrv0=;
 b=VHG5EJ7QVgagO8d1Cml1YdVEfm3sDSww6roPcq+fT79UuuwQypY+1UhCtYLml9//vny14X
 qrSxxaW5ZZSxpXlC59Po+h743HHxKh79ez9sGFHmlvDFK4l+P4cbwGWXKsxHiodFKbv3+F
 Kb5zaibJoQy1LKHjBK9CSb/ZFdogMF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747981792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agL27eFaAka+Q1aIbEaygNTG8j8nDiJhiu+9IdYCrv0=;
 b=AsYDoVE/NMYTsMjzF07fq3T7TGc8CWTbJxUJ+SpmIg405HaOccNaZQT48B/rEu2SRdRVHk
 T+qAouONdTorwFBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747981792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agL27eFaAka+Q1aIbEaygNTG8j8nDiJhiu+9IdYCrv0=;
 b=VHG5EJ7QVgagO8d1Cml1YdVEfm3sDSww6roPcq+fT79UuuwQypY+1UhCtYLml9//vny14X
 qrSxxaW5ZZSxpXlC59Po+h743HHxKh79ez9sGFHmlvDFK4l+P4cbwGWXKsxHiodFKbv3+F
 Kb5zaibJoQy1LKHjBK9CSb/ZFdogMF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747981792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=agL27eFaAka+Q1aIbEaygNTG8j8nDiJhiu+9IdYCrv0=;
 b=AsYDoVE/NMYTsMjzF07fq3T7TGc8CWTbJxUJ+SpmIg405HaOccNaZQT48B/rEu2SRdRVHk
 T+qAouONdTorwFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A6B5137B8;
 Fri, 23 May 2025 06:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X5YdAuAVMGj8CQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 23 May 2025 06:29:52 +0000
Date: Fri, 23 May 2025 08:29:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <aDAV1hbkNcuOjYDs@rei>
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250522193910.GA28496@pevik>
 <CAASaF6z7r=NTD0ymx=pZhsKfDQ43aSpufb7EkpsCCC3mA2cNSA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6z7r=NTD0ymx=pZhsKfDQ43aSpufb7EkpsCCC3mA2cNSA@mail.gmail.com>
X-Spamd-Result: default: False [-0.80 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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

Hi!
> > @all: is this a candidate for a release? It'd be nice to get it fixed.
> 
> I'd wait after release, it's not a trivial change and other than static analysis
> there are no reports of it actually happening.  And it also allows more time
> for review.

Agree here.

I guess that it could be triggered if we pass long enough TMPDIR= to the
tests, but for changes like this we need a proper testing phase and we
are too close to the release for that to happen.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
