Return-Path: <SRS0=V1t1=NZ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F43C433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Sep 2021 22:42:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D0B6101A
	for <ltp@archiver.kernel.org>; Fri,  3 Sep 2021 22:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6D0B6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F132F3C956C
	for <ltp@archiver.kernel.org>; Sat,  4 Sep 2021 00:42:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEFDB3C28B8
 for <ltp@lists.linux.it>; Sat,  4 Sep 2021 00:41:52 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B80BE200332
 for <ltp@lists.linux.it>; Sat,  4 Sep 2021 00:41:51 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id i3so250464wmq.3
 for <ltp@lists.linux.it>; Fri, 03 Sep 2021 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:reply-to:mime-version
 :content-disposition;
 bh=95NafztKWH9deikkfh442WRs0pVjWrDFz1h2mBxZ7fE=;
 b=ok9C0Osyt5fnq71keej2ONcLRa8uJGhRKvlXY9Vb3E1byjjUoYpaq9atRFRPgUXeCm
 hlRVsWTfNlXL3wK4otGRItCPJofiuyp/2taYlL0dkVlzX7A+o3vWs9T2bKLtdo2plnNN
 WQJEu2HIBYs7jthwdWwZjBgJP93FqHzeA/Lkw2DihZhppYUs+ePS2zpHpdCRbUCXhkl2
 +FppTeW36/Rzesz0+Nf18spb7fN5/erkJSjxlWhnCFfnNzNtOkXBvC++jkcrrG4gOe0M
 MUJPAuTIvhBCy2zLtFfeOP7c07go7qqH+BdSr4dIIHhv9lEkh4s2qyJL4DqRPoj08PSN
 p1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mime-version:content-disposition;
 bh=95NafztKWH9deikkfh442WRs0pVjWrDFz1h2mBxZ7fE=;
 b=HP81xmj3fuYcx/zkBQOu77Q6yBDOj0a2YvgpYv7t5B6B77b0fy1Uu/U+JtznQQ/SQU
 ximmRv3lbnGFrEXV09LCfrbIY98D5ufOMKVs7F/u703yDpwv0b+MeGYtl+uFZXBLDWJQ
 AH+ZXkpaM9baT/N6GzAG4A2Nej3p4IvUR8uJ0UVOvTnQfGP97fnnpQ/xssKeqks6bdXu
 fi5/LBVxMP7V7wm1ggZWfNqlXxEb2iYsctE+cBZ+GZr4Mz71iMMYAQ3TRV8RAZjLc+9o
 cdGI0VGFery9DGA1m0IEsOBeo8v6FMfGOWFzlNVYNyIbtmzsWuSHNPw2H/MnzBBwSNxS
 +G7g==
X-Gm-Message-State: AOAM531c7KlMwoLOiLb7sHl9/0BrrMBttpUnIA+zo2pecHyCcpnXKMel
 cldJuU56j3j1IaXoUMT1v3FT20NSzvJSwg==
X-Google-Smtp-Source: ABdhPJz2bdmaSg7ADsMKgZfWGzBTLH1BU/B5S4GyGOmeJXD+BJUtLWHPHligPjWqEjtdwYNXsBVlqg==
X-Received: by 2002:a05:600c:2e4a:: with SMTP id
 q10mr730540wmf.189.1630708911339; 
 Fri, 03 Sep 2021 15:41:51 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id l10sm496073wrg.50.2021.09.03.15.41.50
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 15:41:50 -0700 (PDT)
Date: Sat, 4 Sep 2021 00:41:48 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <YTKkrHbMHeKCJiTr@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Rewrite fmtmsg01.c
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210903224148.CD51KQc7SSU88CweHPU_dJsZRnvE2fWosiuWyWPYFoI@z>

Hi,

I'm going to rewrite testcases/kernel/syscalls/fmtmsg/fmtmsg01.c which tests
addseverity() and fmtmsg(). The reason is that addseverity() is not POSIX,
thus not in musl. Taking an usual approach (*) is not enough, because the test
logic depends on all tests being run. Thus just hope the test is valid (thus
worth of cleanup).

(*) check with autotools whether addseverity() available and comment out parts
which test it; + TCONF test if fmtmsg() is not available - uclibc.

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
