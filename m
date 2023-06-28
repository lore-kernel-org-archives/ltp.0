Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8C6EB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:30:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10EBF3CC78D
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 10:30:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58E063CC30F
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:29:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA4D21A00936
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 10:29:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 229CE2187F;
 Wed, 28 Jun 2023 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687940992;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WXuKn8kahuBwYrBSAfkzca5OurVM7vSdY9WSapmJPE=;
 b=ef53iqs/M47MRraaFWi8uIfkwmUypNEZPxihULTauUUKlcvAGGm9+cjXKv9T9D7ETryBlI
 ctGvb2j8yQekw4PvV2ppQTA82BV0qYFb342NDDdcm1N4h6NC23XP2EB3ks60Vie2eYv/WV
 MhRCbMdBY76XwqaAFn9090CGXKYcwCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687940992;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WXuKn8kahuBwYrBSAfkzca5OurVM7vSdY9WSapmJPE=;
 b=xdfSyOUkeG0kUpBS3sDS4ACtfPuglqk09p5a9Q8j3I3jGbj5vBB/mFqyIM5dBz4vscNgYu
 wsQSFC/q6e7q4aAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBCA0138E8;
 Wed, 28 Jun 2023 08:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id grj4N3/vm2QZWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jun 2023 08:29:51 +0000
Date: Wed, 28 Jun 2023 10:29:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20230628082950.GB115947@pevik>
References: <20230628081831.123189-1-pvorel@suse.cz>
 <20230628081831.123189-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230628081831.123189-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lapi/fcntl.h: Fix O_DIRECT definition for
 various archs
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
Cc: NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

>  #ifndef LAPI_FCNTL_H__
> @@ -11,7 +12,15 @@
>  #include <sys/socket.h>

Maybe we should put note here:
/* Consider #define _GNU_SOURCE if you need O_DIRECT in tests */
>  #ifndef O_DIRECT
> -# define O_DIRECT 040000
> +# if defined(__mips__)
> +#  define O_DIRECT 0100000
> +# elif defined(__arm__) || defined(__aarch64__) || defined(__m68k__)
> +#  define O_DIRECT 0200000
> +# elif defined(__powerpc__) || defined(__powerpc64__)
> +#  define O_DIRECT 0400000
> +# else
> +#  define O_DIRECT 040000
> +# endif
>  #endif

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
