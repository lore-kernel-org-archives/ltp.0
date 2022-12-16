Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929FCC4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 10:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 906263CBC34
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 11:18:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E61E3C913E
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:18:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE6151A00E25
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 11:18:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 131F922B8D;
 Fri, 16 Dec 2022 10:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671185898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=og+Yu7WnWoiW92o/aHMe/0YIZDNn4kJwPXj0ryOAV0k=;
 b=piGnlQ8Q2itaY/skv043KyJWfPBS6Z1A9q4XCwVwBPx3tmnVZC8J2tNMvUDd6n6XLiEtZT
 871qRmHNojAHSzxvOPBFKqFUJsZZEmppGPBzUQS/qqYkKiO3D2pieMOAT6e5K7pze81+7b
 6Y3fGdZBcVNKslVvxg+dqz7cdeP/2Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671185898;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=og+Yu7WnWoiW92o/aHMe/0YIZDNn4kJwPXj0ryOAV0k=;
 b=9VdHpX7TPzYhK6C5tT/P66Ipin1ZbbTi0njMphYJWYv4xMlyIzKFLT+2qTjmWYICxKfAnh
 V8g850vrK2WuxJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6F69138FD;
 Fri, 16 Dec 2022 10:18:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KwzzMulFnGNcZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 10:18:17 +0000
Date: Fri, 16 Dec 2022 11:18:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Y5xF6PU5Yvh+oku5@pevik>
References: <20221201084351.31644-1-akumar@suse.de>
 <20221201111112.8183-1-akumar@suse.de> <87zgc2t9ga.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zgc2t9ga.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] statvfs01: Convert to new LTP API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> > +	fs_type = tst_fs_type(TEST_PATH);
> > +	if (fs_type != TST_VFAT_MAGIC && fs_type != TST_EXFAT_MAGIC)
> > +		TST_EXP_FD(creat(valid_fname, 0444));

> I suppose, thanks to Petr, we now know using a unicode character will
> allow you to construct a valid name of the maximum length.

Yes, Avinesh would you mind to add valid testing also for vfat and exfat?

Something like this?

#define NLS_MAX_CHARSET_SIZE 6 /* from include/linux/nls.h */

if (fs_type == TST_VFAT_MAGIC && fs_type == TST_EXFAT_MAGIC)
	memset(valid_fname, 'a', buf.f_namemax / NLS_MAX_CHARSET_SIZE); // should be (f_namelen / 6) + 1
else
	memset(valid_fname, 'a', buf.f_namemax - 1);

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Y4nDWW2ur6KA1kIw@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
