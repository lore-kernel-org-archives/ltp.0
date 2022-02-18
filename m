Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E78C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 16:12:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0B4C3CA12D
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 17:12:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B86CE3C9678
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:12:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3CB512011B1
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:12:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7EDAC1F37E;
 Fri, 18 Feb 2022 16:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645200730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0TmRKo+D4oYpxLqP/9fHKakR2PAoqc6ytqL5NNjNhzs=;
 b=CJ/Kij8UNQIUxoAbR805JJKz4zHv3f2I9g0jzoK/Mi221bMLpGNS7MWTjx4HanD3NkqcBg
 GP9ZcLtiqoyRPmi+f4ALC77Xy4fn42CUDMxx2pwgP7B4/BfrF7DM7ErQ13ijzoM9qdYkmV
 aTxTIbUlZbO0+LPGILY02DWCgAcy9Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645200730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0TmRKo+D4oYpxLqP/9fHKakR2PAoqc6ytqL5NNjNhzs=;
 b=ucIfUMMuLRVMYHe/0SZKNj1QoNkshdxW97TAfi4IATsohZiAB9a4lUmbiSdh4U7l/guLVn
 HwnRTs1S/LZ8GYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6003213CA1;
 Fri, 18 Feb 2022 16:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xeJDFlrFD2LwOAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Feb 2022 16:12:10 +0000
Date: Fri, 18 Feb 2022 17:14:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yg/F2xuMiy1hJYLB@yuki>
References: <20220218160035.4121-1-pvorel@suse.cz>
 <Yg/E3aAwnUWYgchY@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg/E3aAwnUWYgchY@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] netstress: Workaround race between SETSID()
 and exit(0)
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Hm, on one of the machines it blocked after 12 runs:

Ah, there is another race there. The new thread may send the signal
before the parent is sleeping in pause()...

Just use the checkpoint WAKE() WAIT() pair instead, these are
RaceFree(tm).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
