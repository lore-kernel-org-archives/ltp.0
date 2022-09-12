Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCD0ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 10:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD3273CAADF
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 12:02:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 018E23C941D
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:02:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 89AE21000234
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 12:02:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A56741FF29;
 Mon, 12 Sep 2022 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662976923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvO1dukhlJrHdJIsQbsLk+w0DyCy+es8zfWjHeOG6Fw=;
 b=hsY9sCxxsrCuVA9RopJ/Ua1FdfZ5J7C9TIz6ca1NDjbdBw/bp9BgU0e2GdczJl3cX6jjBR
 hc4FD7S2Vy9fE7/a034Mytr+rbA3R1Pfj+g4EgoQs1gMQn1bW6XgyVkhmzsO8yXuf5fFjm
 g3LlZJzvGrnWwMDuFZaB9N0BcMXATlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662976923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvO1dukhlJrHdJIsQbsLk+w0DyCy+es8zfWjHeOG6Fw=;
 b=u47wxKraqxddq5vWNjBOANZJ8V2Y2GhWDiHg+xlSj0kZE6NseeJUgSXG7s9yDcU708NMWj
 iB7hAA1+4+38N7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E34B139C8;
 Mon, 12 Sep 2022 10:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Tm2LIZsDH2PjVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Sep 2022 10:02:03 +0000
Date: Mon, 12 Sep 2022 12:03:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yx8EDrF0P9fhbC3O@yuki>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220909141840.18327-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 02/10] shell API/tests: Require root for
 format/mount tests
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Although the warning is quite obvious:
> tst_device.c:101: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
> tst_device.c:140: TINFO: No free devices found
> TBROK: Failed to acquire device
> 
> It's safer to expect root to get valid result.

Another option would actually be to make the TST_NEED_DEVICE flag imply
TST_NEEDS_ROOT flag, but I do not think that we have that for the C
library either.

Either way this is fine as well:

Reviwed-by: Cyril Hrubis <chrubis@suse.cz>

> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> The same as in v4
> 
>  lib/newlib_tests/shell/tst_format_device.sh      | 1 +
>  lib/newlib_tests/shell/tst_mount_device.sh       | 1 +
>  lib/newlib_tests/shell/tst_mount_device_tmpfs.sh | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
> index 73a919086..dbe4ea9e7 100755
> --- a/lib/newlib_tests/shell/tst_format_device.sh
> +++ b/lib/newlib_tests/shell/tst_format_device.sh
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
>  
>  TST_FORMAT_DEVICE=1
> +TST_NEEDS_ROOT=1
>  TST_TESTFUNC=test
>  TST_CNT=2
>  TST_DEV_FS_OPTS="-b 1024"
> diff --git a/lib/newlib_tests/shell/tst_mount_device.sh b/lib/newlib_tests/shell/tst_mount_device.sh
> index 561f878d2..70f80f84a 100755
> --- a/lib/newlib_tests/shell/tst_mount_device.sh
> +++ b/lib/newlib_tests/shell/tst_mount_device.sh
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
>  
>  TST_MOUNT_DEVICE=1
> +TST_NEEDS_ROOT=1
>  TST_FS_TYPE=ext4
>  TST_TESTFUNC=test
>  TST_CNT=3
> diff --git a/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
> index 36a78bc85..ed2ba8c50 100755
> --- a/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
> +++ b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
>  
>  TST_MOUNT_DEVICE=1
> +TST_NEEDS_ROOT=1
>  TST_FS_TYPE=tmpfs
>  TST_TESTFUNC=test
>  
> -- 
> 2.37.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
