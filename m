Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87602C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 09:43:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DA673D131D
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:43:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9603C3D1165
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:42:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D93EC204B4C
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:42:49 +0200 (CEST)
Received: from Phocidae.conference (1.general.phlin.uk.vpn [10.172.194.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F3F253F214; 
 Thu, 27 Jun 2024 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1719481368;
 bh=Q2DpD0gmW8RYkCkZR23Ows+CgyWGuoRR7k6/EgFHryM=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=B7TqnIL6zGHCjOwMK+i95Y7kc36q+OxN06R2zqzLxzoxVio1fqn3v+WOWZ2xAkRGG
 2gayxk8k4po95YItogRkwejHYFUl9xurDwKVatWZr9C2+7wUJOXWxXh/Q026LXczua
 4nUcKg/Zyv7IgBSsX06SuIuYDxcEbBcYyfYjgBVShIxIWAtC/O2ladF4ada7ChH4Yh
 +FPz7mBB8RYlTgcIhMBWHvELU9M1kjE7AzNPzddIxbiBLysApcy7uIeOlCauVD8ItV
 ZIf16OHFcoN8in5nn+2N3oXD0wTE1wSuPfBW4MvwCosNTiKDUcaSrUFgd33tiucmZW
 DfbwuUYKdS0GQ==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: ltp@lists.linux.it
Date: Thu, 27 Jun 2024 17:42:16 +0800
Message-Id: <20240627094216.2204110-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627021947.13718-1-kuan-ying.lee@canonical.com>
References: <20240627021947.13718-1-kuan-ying.lee@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kallsyms: check if CONFIG_KALLSYMS=y
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
Cc: po-hsu.lin@canonical.com, kuan-ying.lee@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tested with Ubuntu Jammy KVM kernel, this test will be skipped as
expected.

<<<test_start>>>
tag=kallsyms stime=1719396276
cmdline="kallsyms"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/5.15.0-1061-kvm/build/.config'
tst_kconfig.c:531: TINFO: Constraint 'CONFIG_KALLSYMS=y' not satisfied!
tst_kconfig.c:477: TINFO: Variables:
tst_kconfig.c:495: TINFO:  CONFIG_KALLSYMS=n
tst_test.c:1192: TCONF: Aborting due to unsuitable kernel config, see above!
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=32 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS

Tested-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Reviewed-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
