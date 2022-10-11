Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7860CC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 10:19:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EF4A3C075E
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:19:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 382043C075E
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 12:19:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A8ECD10008F0
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 12:19:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B7A4121A5D;
 Tue, 11 Oct 2022 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665483564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gD/QrpyPMdMCpyXqc7HColYlF4RiCg42DWB6xAALbZE=;
 b=tbdmw5duzRoubteoU2kPjK10oQ1RibW0/X4F08NuYnErqFyjnpS7KtkyqaRDM0bKHrwVLu
 xRZ7QdW/mrRXDNC5C2Y5tnF43KyrcxNIAHDJFF72IX3F/wMW4KAD1ME8OB1YjfvKKW2DWW
 RBNV9A/TMGb1gYq9H/TqyOuRs8vCMOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665483564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gD/QrpyPMdMCpyXqc7HColYlF4RiCg42DWB6xAALbZE=;
 b=BzHAOiNVixBZcQZoLKZKaPmc558Ce2IZChmbXUBUS/XHWMBxBFn7z1T/Nfl6HU4ymcW47D
 p6fCDxtdfdRqvKBw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0B2FD2C141;
 Tue, 11 Oct 2022 10:19:23 +0000 (UTC)
References: <20220722120501.28670-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 11 Oct 2022 11:15:24 +0100
In-reply-to: <20220722120501.28670-1-andrea.cervesato@suse.com>
Message-ID: <87mta27jdh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/7] Refactor mqns testing suite
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> mqns testing suite has been refactored using new LTP API

It would be easier to just submit one test for review and iterate on
it. This follows the principal of breaking work down into the smallest
chunk practically possible.

Sometimes submitting a large patchset is unavoidable, but this is not
the case here.

I'm setting all of these to "changes requested".

>
> Andrea Cervesato (7):
>   Add more safe macros for mqueue API
>   Refactor mqns_01 using new LTP API
>   Refactor mqns_02 using new LTP API
>   Refactor mqns_03 using new LTP API
>   Refactor mqns_04 using new LTP API
>   Delete deprecated mqns header files
>   Rename common.h into mqns.h for mqns suite
>
>  include/tst_safe_posix_ipc.h                  |  45 +++
>  runtest/containers                            |  12 +-
>  testcases/kernel/containers/mqns/Makefile     |  27 +-
>  testcases/kernel/containers/mqns/mqns.h       | 108 ++++++-
>  testcases/kernel/containers/mqns/mqns_01.c    | 185 ++++--------
>  testcases/kernel/containers/mqns/mqns_02.c    | 217 ++++----------
>  testcases/kernel/containers/mqns/mqns_03.c    | 269 +++++++-----------
>  testcases/kernel/containers/mqns/mqns_04.c    | 263 ++++++++---------
>  .../kernel/containers/mqns/mqns_helper.h      |  56 ----
>  9 files changed, 485 insertions(+), 697 deletions(-)
>  delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h
>
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
