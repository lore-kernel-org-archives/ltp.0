Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59653C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 15:03:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 139D53C95F0
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 16:03:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67AB73C14B2
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 16:03:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC1FC6011AE
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 16:03:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1447F21136;
 Tue, 25 Jan 2022 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643122996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wy7UKuyV9l3z8bqCD55uO31z+BW5IZV7L21a2SAcMsQ=;
 b=3P5rndtRTay0gbOzszB09vAJiRlycyU1WevLyiYfVo1oCtco+EQ/bhWuw7cCH2ruO58+29
 L6ith/TJU1XOmh7G/b/nbpkZP74QjyTOMDNqcH4Rd6OJbkTs7g/p/YzIG5k1XetSwongdi
 h4npyREeDW4Hp0JQrjpknnkhlSjjb4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643122996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wy7UKuyV9l3z8bqCD55uO31z+BW5IZV7L21a2SAcMsQ=;
 b=eZ0yxVTysRhZ6qBu2ltP/TCj70zr9cyUy5bztB2IE6SIz2RndYZd+AuQoM58a6w63r5N9h
 WKl854MFCnhSIECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0015413E05;
 Tue, 25 Jan 2022 15:03:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pyvrNzMR8GH+AQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 25 Jan 2022 15:03:15 +0000
Date: Tue, 25 Jan 2022 16:05:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YfARoEoyhkTsWg9d@yuki>
References: <20220125144043.31798-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125144043.31798-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/4] sched_{g,s}etattr01: Add missing policies
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
> sched_getattr and sched_setattr are 99% identical (2 values are
> different). I was thinking to use the same approach from e197796f22
> ("sethostname: Convert to new API"), but not sure if it's a good
> approach.

Actually I do not think that the approach in sethostname is good. There
should be a C file for each test. If they share code that should be put
into headers or libraries.

We used to have more tests like that that build binaries in different
directories from a single source with different macros and I find it
utterly confusing.

> Do we want to reduce files needed to be updated after new policy is
> added? If yes, shouldn't there be just a single directory?
> (what name should be using to show 2 syscalls are in sources in this
> directory?)

I would vote against this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
