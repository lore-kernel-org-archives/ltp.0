Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2545BC4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14D6D3C8C39
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 12:13:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ED6F3C8B02
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 12:13:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 730261A017A9
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 12:13:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9FE511F37C;
 Tue, 14 Dec 2021 11:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639480425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jLLxFECa/Mu2h4/pvJ/DmuXqqqRcZoHhd1VKFwXJ4xI=;
 b=2xD4OrfCah7UvAgCHj/CB5SPX28EsgUXPNheNQVaZKxUFRMMx9pns1oPfDE5yW2LtY+w68
 bPv/4CN8ughFRrWewDdj4bRPUxfpav4sEfPlWqvJzxhH+QgSuwn4oECvTMu9BkaHPPZOec
 hQFjS80/X1P8r2QmTlwQBnvBPYIzklI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639480425;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jLLxFECa/Mu2h4/pvJ/DmuXqqqRcZoHhd1VKFwXJ4xI=;
 b=RJN+BMkNB9bR3f0pUOgm7OO5u7q/56d8di9Ojym2xhtUiSICzntOqxmB63dLbS0QaKZ4HJ
 dOV6NiInrcZXA4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CE0713CF5;
 Tue, 14 Dec 2021 11:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1buoIWl8uGExZAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Dec 2021 11:13:45 +0000
Date: Tue, 14 Dec 2021 12:15:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Ybh8vUPDA8a0oBOC@yuki>
References: <20211214090648.14292-1-rpalethorpe@suse.com>
 <20211214090648.14292-5-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211214090648.14292-5-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] scripts/coccinelle: Helper for converting
 CGroup selftests
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
> +@@
> +expression cg;
> +@@
> +
> +... when != TST_CGROUP_VER(...)
> +
> +- SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");
> ++ if (TST_CGROUP_VER(cg, "memory") != TST_CGROUP_V1)
> ++    SAFE_CGROUP_PRINT(cg, "cgroup.subtree_control", "+memory");

I guess that here we operat on already partially converted code right?


Other than this the rest is really straightforward:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
