Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72361C00140
	for <ltp@archiver.kernel.org>; Sun, 31 Jul 2022 16:24:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C00E83C9176
	for <ltp@archiver.kernel.org>; Sun, 31 Jul 2022 18:24:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82DFC3C0FA3
 for <ltp@lists.linux.it>; Sun, 31 Jul 2022 18:24:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4FA70600284
 for <ltp@lists.linux.it>; Sun, 31 Jul 2022 18:24:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF4CE5D0F7;
 Sun, 31 Jul 2022 16:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659284642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCBiaUWyLy55IeCJsQbJq+CMnFpst+/gQoQH5iZJajQ=;
 b=Umn3mHut1aog5bu7mGvWZMKPN5gjep5L6QhgeRGIT841V9Hfpl54WPyp5L5RA6mFtV/0cE
 ieZagHe8hqWrEL1TjWjDh5o1XFz9ptgMuvc0kpatp7dMFp+UjBDXGYHWVjAKgiRcbtVDET
 9bcYBKnojvjLpYdqGG/uM9EY8VHJirw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659284642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCBiaUWyLy55IeCJsQbJq+CMnFpst+/gQoQH5iZJajQ=;
 b=+GupCS7GofUtHXqUattzw1ZhICfRFh2sPCdfwVSpN8NZfixPfiR97IFhITYCii8BU7yMG4
 6BOSsS52znMAh/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0ABF13416;
 Sun, 31 Jul 2022 16:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VLP1LKKs5mLgGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 31 Jul 2022 16:24:02 +0000
Date: Sun, 31 Jul 2022 18:24:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YuasocCLj5v7Oas/@pevik>
References: <20220731160307.16063-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220731160307.16063-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] MAINTAINERS: Add Namjae's exfat git tree
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
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Oops, wrong list.

Asked by Namjae to send this, but obviously working in the weekend brings
mistakes.

Kind regards,
Petr

> From: Petr Vorel <petr.vorel@gmail.com>

> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..0cfde0f3544b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7573,6 +7573,7 @@ M:	Namjae Jeon <linkinjeon@kernel.org>
>  M:	Sungjong Seo <sj1557.seo@samsung.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
>  F:	fs/exfat/

>  EXT2 FILE SYSTEM

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
