Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A85EDEC6B
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 14:43:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39CFC3CE7A4
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 16:43:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61DBB3CB2FB
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 16:43:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0AC8F201DDC
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 16:43:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E12FC21862;
 Wed, 13 Sep 2023 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694616207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPTp9pviYNTxAB5T8NoS7trQmlizzBEjjUb3GPlPToQ=;
 b=WosiW4uTnAVkNhOo9c17jwRK4wWb4l3b3si7s6oH5nmNOuFhqIt/H3LnbDeb3lM+12cpI1
 5jyXppxRQgtb+SaLLxF3jLVvvdfWVWVwSP5e3p+XjwghZQzn/gg2AaJL1aZbWTjRV04Qr1
 7kMhyCh0cEgTv+pD5nN4YEIcyJlYqPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694616207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPTp9pviYNTxAB5T8NoS7trQmlizzBEjjUb3GPlPToQ=;
 b=piQD8MTU3GZRA0aUCpUP1EAYpM+CVKT8+jKFPjHTJuEnKTq4ldYRmdx1fjfTSqCrwugbLi
 z8NHu3WkbpZ+tGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF37913440;
 Wed, 13 Sep 2023 14:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3NCHMY/KAWXQagAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Sep 2023 14:43:27 +0000
Date: Wed, 13 Sep 2023 16:44:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZQHKvmuQXhtm4Uws@yuki>
References: <20230705141223.31468-1-andrea.cervesato@suse.de>
 <20230705141223.31468-2-andrea.cervesato@suse.de>
 <ZQGoXAAPcWjLjear@yuki>
 <f36ca896-a7b5-4131-b48d-09f19b9d534d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f36ca896-a7b5-4131-b48d-09f19b9d534d@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/4] Refactor mqns_03 using new LTP API
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
> I tried absolute and relative path for devdir and they both work well 
> with SAFE_UMOUNT() function, but any other combination of SAFE_MOUNT() 
> parameters doesn't really work.
> 
> I think we can left it absolute, unless we really want to get rid of it.

I tend to keep the tests as simple as possible, so I would go for
relative paths and get rid of the allocation.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
