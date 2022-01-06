Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFDEC433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 09:49:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88D4D3C2BD3
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 10:49:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E43993C0596
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:49:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C9671A0098D
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 10:49:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E59FC1F37C;
 Thu,  6 Jan 2022 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641462551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKCdOnwDgXg50s8D1uwIKV6sB24ARkhcjv4uv7VMGvo=;
 b=dW5hRawqVzRH/swwD2Bwf2FOn/VnxduN/uS+dFSYmB0dvHH3TcjAdvWUDZK5Bp+JyJY9uS
 IL9BZsrrbmkcdwGdwWf0vTj9VVkYGd4x4wi6wyteZecZ6wiFWqYmR7sHNYXDogQQ1sW0Dr
 5n5bkKO9fomriwkIcoKWiuG1sHA+HXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641462551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rKCdOnwDgXg50s8D1uwIKV6sB24ARkhcjv4uv7VMGvo=;
 b=eYapmAKjTIoYsRabMDF/k4c9YbwZOaAbBpxU4316GUezLvDTlnx7fzdwbxYIrJdlamWP0R
 AuGQPeTx4b3J2tDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B704713A07;
 Thu,  6 Jan 2022 09:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aMEaKxe71mGlcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Jan 2022 09:49:11 +0000
Date: Thu, 6 Jan 2022 10:49:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Yda7FTnMi5surU0J@pevik>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE
 environment variables
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

Hi Xu,

> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
...
> +| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
> +                          'y' or '1': disable kconfig check,
> +                          'n' or '0': enable kconfig check.
Not sure if you got inspired by LTP_COLORIZE_OUTPUT, which also uses y/1 or n/0
input, but I'd really stick just to LTP_KCONFIG_DISABLE=1 to disable kconfig check.
By default kconfig check would be kept.

LTP_COLORIZE_OUTPUT has more complicated the default value, because it's on by
default when print to stderr, but off when redirected (we should document it in
doc/user-guide.txt). But there is no reason have way to configure the default
value.

But maybe others see it differently.

And writing it today I'd have probably chosen for LTP_KCONFIG_DISABLE only one:
y/n or 1/0.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
