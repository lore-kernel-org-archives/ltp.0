Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B2C4332F
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 15:20:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 038113CB00C
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 17:20:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F8DE3CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 17:20:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E1146002B4
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 17:20:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 719B25C238;
 Mon, 17 Oct 2022 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666020013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXq62A60+pMKZKKuVjTP18v1g4OQVI7mpEoEFf8zoDk=;
 b=oYKN/6JVziWp6WNMXPL7NIj9agtkqJ/BttNBHm1toojXa/mmuEFvg/J65gyXkTP9GZuGBv
 HU3R/hoas1yWYaGccdgaef8EituLlYGilvTgcnds4YGeOGBM92fTleR+ULfzkU0o8RR/k9
 gVI/r8o+nYGtVT4FYtyPKugTI7xdPqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666020013;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXq62A60+pMKZKKuVjTP18v1g4OQVI7mpEoEFf8zoDk=;
 b=WgEXHwFvKDV9mFJDQcd+IOPaYoPvjvcy1eKFrT+ZlcGiHSjnFrcXPKD9swcaBV0LcrJBa8
 ToQTAe4FgCN43uBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CB3113ABE;
 Mon, 17 Oct 2022 15:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KvB+AK1yTWMHHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Oct 2022 15:20:13 +0000
Date: Mon, 17 Oct 2022 17:20:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Palmer Dabbelt <palmer@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <Y01yqrDR/oEX8/o0@pevik>
References: <20221013214638.30953-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221013214638.30953-1-palmer@rivosinc.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] MAINTAINERS: git://github -> https://github.com
 for linux-test-project
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
Cc: alexey.kodanev@oracle.com, vapier@gentoo.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>, ltp@lists.linux.it,
 stanislav.kholmanskikh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrew,

> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.

> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Could you please merge this? iit got ack from Cyril (the main maintainer
and me):
https://lore.kernel.org/ltp/20221013214638.30953-1-palmer@rivosinc.com/

Kind regards,
Petr

> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index d103b44fb40c..d118acdce8b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11972,7 +11972,7 @@ M:	Alexey Kodanev <alexey.kodanev@oracle.com>
>  L:	ltp@lists.linux.it (subscribers-only)
>  S:	Maintained
>  W:	http://linux-test-project.github.io/
> -T:	git git://github.com/linux-test-project/ltp.git
> +T:	git https://github.com/linux-test-project/ltp.git

>  LYNX 28G SERDES PHY DRIVER
>  M:	Ioana Ciornei <ioana.ciornei@nxp.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
