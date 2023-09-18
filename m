Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94123C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 09:01:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE34E3CADE0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:01:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E9DC3CA9AE
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:01:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EAFB9200DD4
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:01:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A052219BD;
 Mon, 18 Sep 2023 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695027698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBH8snM5uzoEqe/bXfa0ag/bDrUSaPKV2d7zBv3WqQ0=;
 b=QAIMOEaZtlnXDcISl+QrUevvFWQxvBjNGFPixaBswfAFKbIUP0nlD9PgL4A2NUhkPI8o2s
 LsbAVK12a9rXXTUc92km/YNpJ7yFEIQ8/WQwMlsKZv877LLmjI0TQkQ/6WxWv6h2kZpbiN
 7LZv0SSLbVoMKTK9+/D8yrybLavpTMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695027698;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBH8snM5uzoEqe/bXfa0ag/bDrUSaPKV2d7zBv3WqQ0=;
 b=GeN4OoOzNIVzPN7MsmXWRglGkB7KiNVKrTQDjooQtPbV8XhvDjo+NIDc5iU+tXd73Kq413
 vxQIQVip4E+d2EBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BB7A13480;
 Mon, 18 Sep 2023 09:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PdiNBfIRCGXLCQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 09:01:38 +0000
Date: Mon, 18 Sep 2023 11:01:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230918090136.GA30304@pevik>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
 <20230918082506.17464-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918082506.17464-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] Replace runltp-ng with kirk framework
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

Hi Andrea,

...
> +++ b/.gitmodules
> @@ -7,3 +7,6 @@
>  [submodule "tools/runltp-ng"]
>  	path = tools/runltp-ng
>  	url = https://github.com/linux-test-project/runltp-ng.git
> +[submodule "tools/kirk"]
> +	path = tools/kirk
> +	url = https://github.com/linux-test-project/kirk.git

I'm not sure if anybody asked you to keep runltp-ng, but I'd prefer to remove
runltp-ng as you did in v2. I don't think runltp-ng was really adopted a lot

We should have runltp-ng symlink to kirk at least in LTP:

cd tools/kirk && make install
install -m 00644 ../../tools/kirk/libkirk/*.py /opt/ltp/libkirk
install -m 00775 ../../tools/kirk/kirk /opt/ltp/kirk
...
Here I would add
ln -s /opt/ltp/kirk /opt/ltp/runltp-ng

...
> +++ b/tools/kirk
> @@ -0,0 +1 @@
> +Subproject commit c7419dd6f73d90f3f02aa17d30270e895e30c88e
+1 for fixing this.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
