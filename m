Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3B0C433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 09:52:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 26AA83C6BE4
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 10:52:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7544E3C0480
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 10:52:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7B7FF1A008A5
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 10:52:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 968B71FD3E;
 Wed,  8 Dec 2021 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638957165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=st6aHrK5UirWhte8Vnb6JW4+qwNXhYTsyHfVaE7DyxU=;
 b=DZvKIpbaIjcdDFH6CxycUTJQXeBipi6ldv/QiC0kS5uRJ6NpIoMj/Fo/dT5XCKhUvnmo8E
 sdeeKGiLk1VRQceJyck8ORroSEwkb7exfl4FWPHr66gnrQFc2575ZxmTg+nfR2pDAy3oId
 X7jD/Eke55ZOKOTrxE7lw/gWOHxcHq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638957165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=st6aHrK5UirWhte8Vnb6JW4+qwNXhYTsyHfVaE7DyxU=;
 b=OGrvCaDJtt826G41lZyj1pmmmlAMGN+QHNigpweCXSrFfxRNhI95IfJZ+BBQGgojEiE9Xo
 pPsWaT57KzIVPHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 752A213C2D;
 Wed,  8 Dec 2021 09:52:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jb9ZG22AsGGCGAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Dec 2021 09:52:45 +0000
Date: Wed, 8 Dec 2021 10:54:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YbCAu+jGas968G8O@yuki>
References: <Ya4DeVrCa1X8IFjk@yuki>
 <1638864483-2446-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ya885sQsH3wftoeb@yuki> <61B02105.7080900@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61B02105.7080900@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] library: add cmd check handler in
 needs_cmds
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Now, I understand. so I can just move tst_check_cmd declaration into 
> tst_private.h and then tst_test.c included it.
> 
> But the source code should move into where, it has two choices:
> 1) like v1, move a new lib source file ie tst_version_parser.c
> 2) since it is related to cmd, we can move it into lib/tst_cmd.c
> 
> 
> I prefer to use 2nd way. What do you think about this?

I would probably put it into a separate file, but tst_cmd.c would work
as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
