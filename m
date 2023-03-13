Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF59C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 14:37:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48E193CD54E
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 15:37:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C658F3CA013
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 15:37:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8A881000761
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 15:37:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 724B31FE0A;
 Mon, 13 Mar 2023 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678718243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2tYV5Qaw5ZTDG/9uhjGJuxgIPgzYZtwJSesS1Tcdh4=;
 b=ADcxL337J/9xA/rYWqZVzhVzrbPXEs0Abn7PtAO30AbTWuP/iylFrtd4dKdQl2iEPwP2ev
 LR0VbFf9/1NT54MJcg4dvM1fGfey3etnNu9PriTISIDf4osuOlicx4lLfIXpQMnh9WUtvN
 a547CvcxXwjDNi5zG+6E+gehCjSx9W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678718243;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2tYV5Qaw5ZTDG/9uhjGJuxgIPgzYZtwJSesS1Tcdh4=;
 b=E2l8XIhdQrz23K0dn+PmR7QjIerneW4jC5A7h7o8ExRnn2ukr0fvcUDU+QG8f7IHt/Icka
 K38JSlPc919yqMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C74613582;
 Mon, 13 Mar 2023 14:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kg8zFSM1D2R4UAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Mar 2023 14:37:23 +0000
Date: Mon, 13 Mar 2023 15:38:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZA81c11hvBu4xlsd@yuki>
References: <20230307145517.1359-1-pvorel@suse.cz>
 <20230307145517.1359-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307145517.1359-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] df01.sh: Use tst_fsfreeze for XFS on kernel
 >= 5.19
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
 ltp@lists.linux.it, Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> XFS since kernel 5.19 postpone certain operation.  Use LTP fsfreeze
> implementation to force all the background garbage collection to run
> to completion.
> 
> Link: https://lore.kernel.org/linux-block/974cc110-d47e-5fae-af5f-e2e610720e2d@redhat.com/
> Suggested-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/commands/df/df01.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index ae0449c3c..699d1538f 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  # Copyright (c) 2015 Fujitsu Ltd.
> -# Copyright (c) 2018-2022 Petr Vorel <pvorel@suse.cz>
> +# Copyright (c) 2018-2023 Petr Vorel <pvorel@suse.cz>
>  # Author: Zhang Jin <jy_zhangjin@cn.fujitsu.com>
>  #
>  # Test df command with some basic options.
> @@ -46,6 +46,11 @@ df_test()
>  
>  	ROD_SILENT rm -rf $TST_MNTPOINT/testimg
>  
> +	# force all the background garbage collection to run to completion
> +	if [ "$TST_FS_TYPE" = "xfs" ] && tst_kvcmp -ge "5.19"; then
> +		tst_fsfreeze $TST_MNTPOINT
> +	fi

This looks overly specific, can't we just freeze and unfreeze the FS
without looking at kernel version? Or will we get errors on older XFS?

I suppose that this may still start to fail on distribution kernels if
some of the newer functionality gets backported...

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
