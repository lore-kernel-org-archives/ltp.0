Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA97C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 19:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B691E3C972D
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 20:19:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E9D73C96A3
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 20:19:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 167776019AB
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 20:19:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D97B2114E;
 Fri, 21 Jan 2022 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642792748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gtg5Jgr2ZgDFtBbELnwgrO5EK8B5UMTN5ozehbhNKaE=;
 b=0Fkh+JkuIVed6TrNxyGpnb6/Jl/SkQ7zxjcCbN+4Mvbxf1M2FjnJrQTse347CtLxpGAysJ
 xAR4bEx4mO8QE6VLMwQ487lw8rtSHK+c6ltOYhV0+rKVZAYGLumMvEacOXjbfmwBq/q3Gj
 U3x6YSA2+WeZ1tgWFU3GZv/kdPF42Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642792748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gtg5Jgr2ZgDFtBbELnwgrO5EK8B5UMTN5ozehbhNKaE=;
 b=fm2QI+PzJvxVFOMiw5qG683i4z1Y9E9edQIS1DbbsW7IBfMGtr2KVcEA0LY3MESoRPkk/v
 8pmeedzHlVH6zcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0436A13A98;
 Fri, 21 Jan 2022 19:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QImjACwH62HGZQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 19:19:08 +0000
Date: Fri, 21 Jan 2022 20:20:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YesHlX52Z+6K3Zmj@yuki>
References: <20211127121609.26837-1-saginakash@gmail.com>
 <YerXaAm7cDPRwR4T@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YerXaAm7cDPRwR4T@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] ltp-pan: Report failure if testcases failed
 to run
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
Cc: Sagi Nakash <saginakash@gmail.com>, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> @all: Do we want to include this one in the release?

I do not think that this is complete enough. If we wanted to fix this we
whould have to change the code to write a record to the failcmdfile as
well.

Also increasing the variable on each failure seems wrong as well, it may
as well overflow on large enough runtest file...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
