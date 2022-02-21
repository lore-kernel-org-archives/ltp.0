Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCB4C433EF
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 18:05:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 441543CA18A
	for <ltp@archiver.kernel.org>; Mon, 21 Feb 2022 19:05:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C673CA167
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 19:05:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7A6E8601B1C
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 19:05:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5897E21138;
 Mon, 21 Feb 2022 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645466700;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpLtogCFOnRJQHt34VFRfoYb80NQgxD5JN1MSIzY8/g=;
 b=1xztKk2qxUMHz+/j2TN6EpbLKSKTDHWJ9ywHaaDYVzOUkgYKYLOh44rBav5cTZ30jEuEP4
 4W0STigXipjNtJGYkA97mO+y7rogMOnBU+wioG+lo+R1YCdyddrLfEeOnjR77con7Zd3iS
 Hx7k984fENiClz+p+BVvS+bp57iQUXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645466700;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpLtogCFOnRJQHt34VFRfoYb80NQgxD5JN1MSIzY8/g=;
 b=kNU7hYU8T4UOMK4d5Mo7fTX1w66BUBOzA/QJsG7nRIvlhZd56KTRe/o6Wxmzz2uUTiJ1/x
 +8s+MJnpRQOYY5CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25C2313B6A;
 Mon, 21 Feb 2022 18:05:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4sbpBkzUE2IDFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 21 Feb 2022 18:05:00 +0000
Date: Mon, 21 Feb 2022 19:04:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <YhPUSnQatwz3BFbg@pevik>
References: <1645459842-1609-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645459842-1609-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/fsmount.h: remove useless sys/mount.h
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Dai, Viresh, all,

[ Cc: Viresh, as he's the author ]

> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  include/lapi/fsmount.h | 1 -
>  1 file changed, 1 deletion(-)

> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> index fa25306..eb98c97 100644
> --- a/include/lapi/fsmount.h
> +++ b/include/lapi/fsmount.h
> @@ -7,7 +7,6 @@
>  #ifndef LAPI_FSMOUNT_H__
>  #define LAPI_FSMOUNT_H__

> -#include <sys/mount.h>

indeed now is sys/mount.h useless, but we're not sure if there is no wrapper 
for new syscalls (e.g. fsopen, fsconfig, fspick, move_mount, ...) in any libc in
the future. Because we have configure checks for these functions.
@Viresh, was this the reason why you added <sys/mount.h> ?

Kind regards,
Petr

>  #include <sys/syscall.h>
>  #include <sys/types.h>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
