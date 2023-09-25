Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CFECE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:29:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E7883CE26B
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:29:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FDDB3C997B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:29:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A588201DB5
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:29:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C176C2184E
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695655770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv1zXZ2efO9MVO2SQ+3YJ/L9jqjqqMxHh1d6+LFMbCI=;
 b=crZpktZSzqjEvtwIz6d43obvzN9wN+Icvf+KmYSkWr5dWTbD8xso2jOr4hAYcjAHGbOzrD
 lnU0PxNSEtkHmAgcs2JioxR2mEBCoyCUmxKICWl35rnrs97VHGXbNGFYjLIteZ7BIpy0ew
 C8FaGf4xSWutmji/BhIAb5yyA/0aQKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695655770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv1zXZ2efO9MVO2SQ+3YJ/L9jqjqqMxHh1d6+LFMbCI=;
 b=y29XvvEuwA38SDjA4LdoTh8Jul3TA7K7a3lGMYGh1gRezRDsmbVuyvV69spzHznftAMO0v
 uhqOu1jdBi2rp2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3B5213580
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nBTUKlqnEWVoVwAAMHmgww
 (envelope-from <mkittler@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 15:29:30 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 25 Sep 2023 17:29:30 +0200
Message-ID: <4834400.GXAFRqVoOG@linux-9lzf>
In-Reply-To: <20230925151319.87688-1-pvorel@suse.cz>
References: <20230925151319.87688-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Report clone04 failure on musl
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Am Montag, 25. September 2023, 17:13:16 CEST schrieb Petr Vorel:
> This required to add musl-git support into lib.
> 
> Petr Vorel (3):
>   lib/tst_test.c: docparse/testinfo.pl: Add support for musl git fixes
>   clone04: Add musl-git tag
>   lib/tst_test.c: Print failure hints also for TBROK
> 
>  docparse/testinfo.pl                      | 3 ++-
>  lib/tst_test.c                            | 8 +++++++-
>  testcases/kernel/syscalls/clone/clone04.c | 5 +++++
>  3 files changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Marius Kittler <mkittler@suse.de>

Looks good to me.




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
