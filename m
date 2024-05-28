Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C67C25B7C
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716892347; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=NYcHMK1GZB6iklFiS7/i/YaQlvI8hLsLtLM4QGaSHg8=;
 b=DnD7Pzgul2RL51hbWWUFTcuUPqvnmAWQgGF1Fv8aY4BwNCb9nR25VQnkGe2fpysY6BaJR
 TzA0laGtvzMCOu+A3plApftyKA/pWgjfJzM6hJBhuORIPycXeZgmblatliDyNEHJBoGf/bC
 t8XVkgB5XkM/5TAE6aza3wPmx2hEOh0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBAAB3D0530
	for <ltp@archiver.kernel.org>; Tue, 28 May 2024 12:32:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D87663C2B89
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:32:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE1A1100112C
 for <ltp@lists.linux.it>; Tue, 28 May 2024 12:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716892326; x=1748428326;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mYwCX6gtBL5NUwIOnad+RmZDZd4uDLKas+dWUz3JNBs=;
 b=QifxEhYIvJ0iNRG3oKpyH0QpD39wwxtgmr2DLwJWVIiGEl3Z8MnJIOlX
 l3orODcuWlFWWjhWUw4F0Xcg6NQes++ilseYaIAXgmolMH4aTOiavfawA
 l02quq4A9Rm6VSz4hJChtBt7PlwrXiwRt3BMVx3V3N1puKs1EiTUIPhlZ
 TD9UqwhdxZB81s76AIP2/J3GUH0BJbODZIvnySEX2xf2uyS0rO7U7NAHv
 X9ZfUF1bd4LSOyx6cUVKNQJJNiAPxRYYrPmDTmeZ6QCEIiHPgE4/bnmeh
 pr08lWgVrjtYhmhNApHxmlgT5cgrtiRhksNNV7rQPJaZZdPxPhX/KsYhA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="139987643"
X-IronPort-AV: E=Sophos;i="6.08,195,1712588400"; d="scan'208";a="139987643"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 19:32:04 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id AAD52D6EF1
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:32:01 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id EEA26D5044
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:32:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5EEA66B4C8
 for <ltp@lists.linux.it>; Tue, 28 May 2024 19:32:00 +0900 (JST)
Received: from G08FNSTD200053.g08.fujitsu.local (unknown [10.167.226.137])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 004F41A000A;
 Tue, 28 May 2024 18:31:59 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 28 May 2024 18:31:15 +0800
Message-Id: <20240528103114.2311-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.26.1.windows.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28414.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28414.007
X-TMASE-Result: 10--4.810200-10.000000
X-TMASE-MatchedRID: 10h2QGXI3YoB1iWUmaOy1wrcxrzwsv5uF4r8H5YrEqyMJxigKCCiSy15
 IFUNL+ETu+U+TVUiqnWAMuqetGVetiVvu9chHp+mavP8b9lJtWr6C0ePs7A07foJlcuVXWZJyux
 tPD8i2MkUR9EBM0KhXggBCZ/MwNK1wi7wthCT9NfjffdEp19sbOlHx5j/hzE1bojYE1mBLLL+z6
 T5KY35aCaVGuaybtUshpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] signalfd: Improve testsuite for signalfd
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently, testsuite for signalfd is written in old API, and only
contains case for normal situation.

So I refactor the existed case with new API, and add case for negative
situations.

Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>

signalfd01: Refactor old case with new API
signalfd: Add negative tests
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/signalfd/.gitignore   |   1 +
 testcases/kernel/syscalls/signalfd/signalfd01.c | 350 +++++++-----------------
 testcases/kernel/syscalls/signalfd/signalfd02.c | 115 ++++++++
 4 files changed, 213 insertions(+), 254 deletions(-)
--- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
