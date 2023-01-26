Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20529C05027
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 10:49:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DA983CB38F
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 11:49:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBFEB3C0925
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:49:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 498141400FB0
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:49:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8992F21BFD;
 Thu, 26 Jan 2023 10:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674730149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVCYlKCws56unLqsJTr+bP2IzphOPCwimkGjz6lVOZg=;
 b=G9BCdQVb92etVx3hLuaWykKt+wtu5n63mjo3hi/bLfo4Qgq6DqpinKAwMKFoME4uZijGjR
 A4M1oM7icWGl6W6WxVF6x+kmojMt2X92stafMrML2iVIaSu0DEsunj0OZrxg4YtiAYf2f5
 TMqYKjLg4ObAWnHIvCAR6hgcqKGpeMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674730149;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bVCYlKCws56unLqsJTr+bP2IzphOPCwimkGjz6lVOZg=;
 b=FGpoqHes4boeLPpFveHHvH/xp5yPMmijU9qSJIJSeaCjdbokKVP9On9R1AbgcUjjLqnfcW
 aaKyMAP5dOGeCPBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 307DC139B3;
 Thu, 26 Jan 2023 10:49:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XxirCaVa0mMkCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 10:49:09 +0000
Date: Thu, 26 Jan 2023 11:49:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Petr Vorel <petr.vorel@gmail.com>
Message-ID: <Y9Jao+blkCShXtjD@pevik>
References: <20230125232751.31809-1-pvorel@suse.cz> <Y9JVZdbm/1yLwAKs@yuki>
 <Y9JYfuWB2cdYgMQ+@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9JYfuWB2cdYgMQ+@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify.h: Include <linux/types.h>
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

Hi all,

merged with change that header was added to fanotify.h in lapi
(pointed out by Cyril).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
