Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3178AC05027
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 08:53:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33EAB3CC5A7
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 09:53:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0012B3C01AA
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 11:28:28 +0100 (CET)
Received: from v03.bc.feishu.cn (v03.bc.feishu.cn [101.36.218.33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C12E60012D
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 11:28:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=ruijie-com-cn.20200927.dkim.feishu.cn; t=1675938495;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=K2ACNIheEEOWxeYNWiQ4MpIK+bZgMfrIhPpLLp/2ahc=;
 b=fPXeAvtrmCTDdLeEEx/E//E6iSUq6pAgPorXasu1VzwL2WAkUyGbm+uD8kqC8oK2MNRaFI
 S2zAlaH3ydolwStWZ1EtUpsT53ORlH9MCSbw28/1zKFCn7/JjsQIClYHYaGu3kytAbx19w
 APRp19inDlpXNzdwe8AZ6yvOa/D3d+4lZ+QQ7EevjmMB30kK2mHpsFIHHW8QxsedEERR+T
 LLuO41f1/eGEiFICMcw1TNjUZfw/W00ibUh10NkMt8GO0/C4mpctrWGieCVjKLCM3+jF5p
 eS/bACyGwfR2HIClfYmuYyM72CZlTAK9vF3sQCHBMPq3WjnERYiteU4GPBSe/Q==
Message-Id: <0328e9f247cfb76b27b68e9592bfb1954ddfe2b2.14943319.2fea.4ca2.8fe1.01735a19e47e@feishu.cn>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+163e4cab4+c49968+lists.linux.it+xiaoshoukui@ruijie.com.cn>
Date: Thu, 09 Feb 2023 18:28:04 +0800
From: =?utf-8?q?=E8=82=96=E5=AE=88=E9=80=B5?= <xiaoshoukui@ruijie.com.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 14 Feb 2023 09:53:33 +0100
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
