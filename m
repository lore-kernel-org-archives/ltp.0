Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E1CEB64DA
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 12:07:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D8473C99D2
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 14:07:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FF8A3C1B84
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 14:07:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CDAA0200770
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 14:07:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F60C20550;
 Tue,  4 Jul 2023 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688472451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K36L4WpTmixtImbFHQIAL5HB6f92lnvs5oGhI6YPjtE=;
 b=wyQo2W/cLWQ/Sbw4sSOHwHbsZ4x4c6AT1C6AtgosF8bdAkOzo3eFjSp8KQRk80fsS2BmRO
 pEQTwG0cDXJB/Q5AhYToUDIahk60UNt8O32K3uF8bFZIudYYoaDLDT6kuqf2eb6GBPz3r0
 MObB2gp6iY6rUIy4OseiBMboAW6WSvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688472451;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K36L4WpTmixtImbFHQIAL5HB6f92lnvs5oGhI6YPjtE=;
 b=NxvIiJWY8uUYNsP4RXwOg44cV+DLIQhfOfn939i+rOYf7Tqi2lvxw1O3ZP2eTghdxD46Jm
 OI7sfAEDNfPQYEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15BD51346D;
 Tue,  4 Jul 2023 12:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BtUkBIMLpGQOKAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 12:07:31 +0000
Date: Tue, 4 Jul 2023 14:07:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230704120729.GE507064@pevik>
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-3-pvorel@suse.cz> <ZKP1afDMgcKSIESE@yuki>
 <20230704115013.GD507064@pevik> <ZKQKwpA87GUaoSpX@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKQKwpA87GUaoSpX@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/3] lib/C-API: Add option -V to print LTP
 version
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

> Hi!
> > > Why don't we print that as a part of help? Do we really need to allocate
> > > a flag for this?

> > Well, people expect -V or --verbose. But because I add printing also on running
> > test, we could just move it to -h.

> You mean --version right?

Yes, I'm sorry for a confusion.

> > BTW I was also thinking about using getopt_long(), at least to allow --help,
> > I guess you don't think any value in it.

> I do not think that it's importan enough to spend time on, but feel free
> to send a patch.

Agree. A real reason would be if netstress.c would need to have some more
options (there are still some room left, but not many).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
