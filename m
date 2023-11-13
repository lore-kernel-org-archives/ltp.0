Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B694BC4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 16:06:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 258953CE5E9
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 17:06:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5130D3CE54E
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 17:05:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 186C910011A5
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 17:05:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 501A61F854;
 Mon, 13 Nov 2023 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699891554;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llIr6vjKXmC030FHvNW3oXp0bFpn1osllx7tHVMKRQ8=;
 b=yqPQwL8isoNcdbQf5FbVS6TpZcJYH5rw0oSJ06lIgLLjPZK9YzXXYdOKguRIFyJ1AUBSkV
 RERMbywEydupfVJjlQBBrQMRcqQsPilj/KyWM3t9CBm63gdr/8c28zaGvF/Eq9Dr/GafJA
 feeBglq8be9KaAC1G2qzNblRm3olf+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699891554;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=llIr6vjKXmC030FHvNW3oXp0bFpn1osllx7tHVMKRQ8=;
 b=usxs7HEpMMU0hAldovG6J0wPaDv7wHOdb7FmIqgKlfYlIiUgXPt6eYQMxrZQy6F9d4SFtw
 38MsCoNrxw4dlaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D78913398;
 Mon, 13 Nov 2023 16:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JTIICWJJUmVVXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Nov 2023 16:05:54 +0000
Date: Mon, 13 Nov 2023 17:05:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20231113160552.GA2235190@pevik>
References: <20231030110107.4528-1-andrea.cervesato@suse.de>
 <20231030110107.4528-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231030110107.4528-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rewrite fsx-linux test
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
> +++ b/testcases/kernel/fs/fsx-linux/Makefile
> @@ -22,13 +22,11 @@

>  top_srcdir			?= ../../../..

> -include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/testcases.mk

>  CPPFLAGS			+= -DNO_XFS -I$(abs_srcdir) \
>  				   -D_LARGEFILE64_SOURCE -D_GNU_SOURCE

>  WCFLAGS				+= -w

> -INSTALL_TARGETS			:= fsxtest*
> -
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

This could be a separate change, right? The point of separating changes is to
make each patchset smaller, which I agree does not help much here.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
