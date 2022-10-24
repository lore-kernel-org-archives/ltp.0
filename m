Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C60C3A59D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 07:45:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 085FE3C3099
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 09:45:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BE043C0763
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:44:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5EF6D600625
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 09:44:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7290C1F85D;
 Mon, 24 Oct 2022 07:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666597494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSzkxOE5Oga1jAl/d8S7hh8KM9SzVZ76cYSLNUGOEzw=;
 b=QoL2Enh1B0p4vSHQD7v+jKevDODKba4W8s4kiaE3d5ftpM+TmwEHYrs3CvzymClubc7MBF
 I0FnvU/EDcgY2UmMCvR19KRuw4TVDPwCuRDils9rR/g/kcwfuwlsD1frMD6LVbOnjSDdxk
 4MF7T5eTuY+3LkOdoaAFFZRrA55lXu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666597494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSzkxOE5Oga1jAl/d8S7hh8KM9SzVZ76cYSLNUGOEzw=;
 b=liYn3hM1XU6vTaX5EmtegFjAjRxOvyIoMbQKhdY2dtuabUI0BPU8yrhaCjrc4B0cQY5FnX
 VgaR0YOOYdrkzGAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 366322C141;
 Mon, 24 Oct 2022 07:44:54 +0000 (UTC)
References: <20221013082146.14581-1-andrea.cervesato@suse.com>
 <20221013082146.14581-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Mon, 24 Oct 2022 08:27:00 +0100
In-reply-to: <20221013082146.14581-2-andrea.cervesato@suse.com>
Message-ID: <874jvt1x8q.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] Refactor aiocp using new LTP API
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

I can crash the test with the following:

./aiocp -b 256 -s 1024 -n 8 -i 10
tst_test.c:1526: TINFO: Timeout per run is 0h 30m 30s
aiocp.c:248: TINFO: Maximum AIO blocks: 65536
aiocp.c:273: TINFO: Fill srcfile.bin with random data
aiocp.c:302: TINFO: Copy srcfile.bin -> dstfile.bin
aiocp.c:314: TINFO: Comparing srcfile.bin with dstfile.bin
aiocp.c:337: TPASS: Files are identical
aiocp.c:302: TINFO: Copy srcfile.bin -> dstfile.bin
aiocp.c:314: TINFO: Comparing srcfile.bin with dstfile.bin
aiocp.c:337: TPASS: Files are identical
aiocp.c:302: TINFO: Copy srcfile.bin -> dstfile.bin
aiocp.c:314: TINFO: Comparing srcfile.bin with dstfile.bin
aiocp.c:337: TPASS: Files are identical
aiocp.c:302: TINFO: Copy srcfile.bin -> dstfile.bin
aiocp.c:314: TINFO: Comparing srcfile.bin with dstfile.bin
aiocp.c:337: TPASS: Files are identical
aiocp.c:302: TINFO: Copy srcfile.bin -> dstfile.bin
malloc(): corrupted top size
tst_test.c:1583: TBROK: Test killed by SIGIOT/SIGABRT!

Summary:
passed   4
failed   0
broken   1
skipped  0
warnings 0

I haven't looked into what might be causing that, but you could try
compiling and running it with the address sanitizer.

Also if I pass -f DIRECT it fails with EINVAL.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
