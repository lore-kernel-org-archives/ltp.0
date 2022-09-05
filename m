Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6889CECAAD5
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 14:08:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95C803CA959
	for <ltp@archiver.kernel.org>; Mon,  5 Sep 2022 16:08:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30E23C6A74
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 16:08:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 21B131000485
 for <ltp@lists.linux.it>; Mon,  5 Sep 2022 16:08:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 29FA8339E2;
 Mon,  5 Sep 2022 14:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662386897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOiJIORZebez34zpM6Hf8xC53vAAOczkzH2kNURhOqM=;
 b=lLmzJWdtfLri1PNSNKvI3sonyV3+RJUKl3jRBHmzeszieDL3v9xvG+GojsixZHP2jC6lxC
 njsx2Yp1ZYzcwrCnC6/tAZ4+MPPY3CMDfXL0ASca8qP+O51G1Cy1GPgbH60GVFg5+GZY9g
 Dk/Es2OdXshe7xS3wQ5dz/lM7/cY6AI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662386897;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YOiJIORZebez34zpM6Hf8xC53vAAOczkzH2kNURhOqM=;
 b=lXcKa9Uec/l0daGU6wIch3Y96Lnt5xO78zplwPcZP5lA9m9XXG1wcFa3VO32ARMXPwbwPD
 gcO6Rt+wbI9ysmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0897139C7;
 Mon,  5 Sep 2022 14:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7b0gOdACFmOGMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 05 Sep 2022 14:08:16 +0000
Date: Mon, 5 Sep 2022 16:08:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <YxYCz1RX7xcLgWin@pevik>
References: <20220902204539.1035669-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902204539.1035669-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Revert "m4: Remove check for io_set_eventfd"
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> This reverts commit 5ca0d16d66c42fbfa483c180de4c881de7f182cc.

> Android has libaio headers but is missing some functions including
> io_set_eventfd.  Without these checks it will fail to compile.

Ack to revert as I guess we cannot avoid this. But we should fix newly
introduced warnings on 2.71:

configure.ac:391: warning: The macro `AC_TRY_LINK' is obsolete.
configure.ac:391: You should run autoupdate.
./lib/autoconf/general.m4:2920: AC_TRY_LINK is expanded from...
m4/ltp-eventfd.m4:6: LTP_CHECK_SYSCALL_EVENTFD is expanded from...
configure.ac:391: the top level

-AC_TRY_LINK([
+AC_LINK_IFELSE([AC_LANG_PROGRAM([[

...

-],
+]],

NOTE: if you don't have 2.71 available I can fix this myself.

...
> +++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
> @@ -1,6 +1,5 @@
>  /*
>   *   Copyright (c) 2008 Vijay Kumar B. <vijaykumar@bravegnu.org>
> - *   Copyright (c) Linux Test Project, 2008-2022
NOTE for person who merges this: this copyright should be kept (amend the commit
before merge).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
