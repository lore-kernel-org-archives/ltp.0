Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEC3C77B78
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 13:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 800B13CD8B1
	for <ltp@archiver.kernel.org>; Thu,  4 May 2023 15:43:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7BD83CB749
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:43:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E5BE4200AD9
 for <ltp@lists.linux.it>; Thu,  4 May 2023 15:43:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F026A1F86B;
 Thu,  4 May 2023 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683207807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyFVbQ3479XZKv2SAiElZpsio4ux9vT76y5EYw8yCIQ=;
 b=CzOWQT1Wn7XknFQY0q4pknYz1TnQG2IZuHo4YL8zbnkj3QBOSsqhvt7Tp53e+gTUKk7Qad
 HsdyrhTg6lp+2NheRXjkLCw3kZgDq668IL5op4gVxvBWfIz2rrYu4OLMSzlIso1OO0Jzf+
 VPl9rioSj2i+aL4w+O8quLRY8T2rcME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683207807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NyFVbQ3479XZKv2SAiElZpsio4ux9vT76y5EYw8yCIQ=;
 b=olU3wS7dXiKmFd2NwnAok4rwAuBO13OkEETU961X5skjm6AIHd76zXgFbFzpBz9WZOLhYA
 Z/CFNd1Gu7iemNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBB0A13444;
 Thu,  4 May 2023 13:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1VOBNH+2U2SnZwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 04 May 2023 13:43:27 +0000
Date: Thu, 4 May 2023 15:44:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZFO2vmWk-tvrZoQQ@yuki>
References: <ZEjsKC6ESB1+mM0H@rei> <20230502143711.GA3665733@pevik>
 <ZFIp4Sulcy20GWkc@rei> <20230504131706.GA3826382@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504131706.GA3826382@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
> > > * nfslock01.sh: Don't test on NFS v3 on TCP
> > > https://patchwork.ozlabs.org/project/ltp/patch/20230502075921.3614794-1-pvorel@suse.cz/
> > > => IMHO should go in to increase NFS tests stability
> 
> > The discussion around it sounds like this is a kernel problem after all.
> 
> I didn't get if we want to keep this *not* merged.

That goes against "do not work around real bugs in tests", if possible I
wouldn't apply any workarounds even if there is no upstream fix yet,
maybe just a message that this is a known bug.

> > > * NFS: test on all filesystems
> > > https://patchwork.ozlabs.org/project/ltp/list/?series=352840&state=*
> 
> > This is rather big change, is this important enough to get it in just
> > before the git freeze?
> 
> There is v5 which tests only btrfs, ext4 and xfs. That should be safe to merge.
> https://patchwork.ozlabs.org/project/ltp/list/?series=353495

I will have a look.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
