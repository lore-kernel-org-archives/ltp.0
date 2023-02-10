Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C02C61DA4
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 01:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D1B43CD083
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 02:17:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D9053C69D4
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 02:17:38 +0100 (CET)
Received: from s01.bc.feishu.cn (s01.bc.feishu.cn [103.149.242.11])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FB8E601364
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 02:17:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=ruijie-com-cn.20200927.dkim.feishu.cn; t=1675991844;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=IDOu7RNVgzkh7hDQvwziBx4wSRQAZySbbL9LgTFmgWM=;
 b=nDGbxkwOfBt5RNEACafpHzSRZjpPk0Xn7vzKZkB6pxeNZuHbMYlKTZWZdSJux6wLGFiHlt
 G06nAUsk2er5OqTjgXrlMBf/8K1k+i48YMZuktR0ymfshWPocSUxwV5WHpFFh4Me2o3qfG
 kklGCU1RDVr2Uf2LvWfaEwT+S7W3vgDb/0arwStnsPWlbZaT2Do7GVeF7xa3Fxt7FalGmC
 gAdvJMVJ9BsCACt1FKbcA6uhh/rPU/kMyttYKh+ETOhd//2btPeBP5rLpnSwGCXqX8fQQY
 IF5lyqpV+HC30/SxhdQ4QBmHehqw/kApSd+01nlztMpozCD+taPHnLsgtCk4Fg==
X-Lms-Return-Path: <lba+163e59b1a+b1e4cf+lists.linux.it+xiaoshoukui@ruijie.com.cn>
Date: Fri, 10 Feb 2023 09:17:14 +0800
To: "ltp" <ltp@lists.linux.it>
From: =?utf-8?q?=E8=82=96=E5=AE=88=E9=80=B5?= <xiaoshoukui@ruijie.com.cn>
Mime-Version: 1.0
Message-Id: <0328e9f247cfb76b27b68e9592bfb1954ddfe2b2.80b5c6e1.08b5.4363.8caf.668693c771f5@feishu.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH 1/1] Add ioctl_loop08 test for LOOP_GET_STATUS lock
 imbalance
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: xiaoshoukui <xiaoshoukui@ruijie.com.cn> --- testcases/kernel/syscalls/ioctl/Makefile | 1 + .../kernel/syscalls/ioctl/ioctl_loop08.c | 132 ++++++++++++++++++ 2 files changed, 133 inserti

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
