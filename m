Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587E3C6FD18
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:12:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06D7D3CCAF5
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 15:12:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 258FF3CA2F9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:11:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B674E1000A33
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:11:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89C35219F8;
 Tue, 28 Mar 2023 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680009109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oV11SKAdrCCwHet2gceDc+VO2KltioYQN4i7uOGvivU=;
 b=P9dcOODskf/e1N0tDBOQPUZeJJpqv6K/uYt9EOLo12YfZBdjCb2GpjhVkFFualsmauFmOf
 42rum8L8t4npHS2zzRpGBTINrHg3f8OkmW7LUDtgqWKQe5eShu+GD9+D056TcpqT65+TzY
 +toDq3+ECF5l2rbjwqXpBLF3aMdz1LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680009109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oV11SKAdrCCwHet2gceDc+VO2KltioYQN4i7uOGvivU=;
 b=R8jFiwI3tvmoS4vmBgecMeQB++mEJ53C6wSoLTmStddw+M4pi7LPqtwfkB15msZl6vTeB9
 0RkS4tfP/dtfuiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B6AC1390D;
 Tue, 28 Mar 2023 13:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Vq8QGZXnImSjTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 28 Mar 2023 13:11:49 +0000
Date: Tue, 28 Mar 2023 15:13:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZCLn3Fk26bPjm4qB@yuki>
References: <20230324062446.GA519460@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230324062446.GA519460@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Sparse checks does not include other headers in include
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> cd lib && make check-tst_device
> 
> ...
> tst_device.c:78:5: warning: Symbol 'tst_find_free_loopdev' has no prototype or library ('tst_') prefix. Should it be static?
> tst_find_free_loopdev() is in include/tst_device.h. Could sparse-ltp.c take into
> consideration all files in include/ (if is trivial to do that)?

This is actually a geniune error, the tst_device.c does not include
tst_device.h. I will send a patchset to fix the issues.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
