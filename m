Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB49EE7B61B
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D07E73CE137
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 16:02:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16C623CC38E
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 16:01:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 657371A00E25
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 16:01:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 503101F38A;
 Wed,  4 Oct 2023 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696428117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l72w6G7RhhHN96aZ2a/YNyId0KMPP3AKwXEAMF2wClM=;
 b=ye0zt61i37gt+lbrihMZhHBFKBrYdvmNJL+6v+zP2Bv8T7UuR8JeBSFTV1xT7WcwbUQ1vw
 a5d0uZBDMWgqp69OVXqNkcpT/m+pch81oJQOYoD4xxKK+7QVwjGslSdKad8UcFjbUutmjc
 E8yamku+IhU2CzG6JG1UygPnlf2EkKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696428117;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l72w6G7RhhHN96aZ2a/YNyId0KMPP3AKwXEAMF2wClM=;
 b=SRtG94rAvYAYBtH05vTljeAnI5/dwquytD4L/wswS2PZVtB7Gj4xGcdqxZlc+TRukCuLl4
 MjEQkXyppxQz+WAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D01C139F9;
 Wed,  4 Oct 2023 14:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D4VoCVVwHWXjagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 04 Oct 2023 14:01:57 +0000
Date: Wed, 4 Oct 2023 16:01:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20231004140155.GA72459@pevik>
References: <20231003065238.31896-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231003065238.31896-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Correct the reference to kernel documentation
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

Hi Avinesh,

> +++ b/doc/build-system-guide.txt
This file is now doc/Build-System.rest.
IMHO it should be renamed to doc/Build-System.asciidoc and convert to this
format.

Also the wiki content is empty, I need to have look on it.
https://github.com/linux-test-project/ltp/wiki/Build-System

> @@ -112,7 +112,7 @@ the module because the file does not exists, the test is skipped.

>  Note the 'ifneq($(KERNELRELEASE),)', the reason it's there is that the
>  Makefile is executed twice, once by LTP build system and once by kernel
> -kbuild, see 'Documentation/kbuild/modules.txt' in the Linux kernel tree for
> +kbuild, see 'Documentation/kbuild/modules.rst' in the Linux kernel tree for
Reviewed-by: Petr Vorel <pvorel@suse.cz>

We probably should migrate this page to asciidoc format.
Then it could be a link:

see https://docs.kernel.org/kbuild/modules.html[Documentation/kbuild/modules.rst]

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
