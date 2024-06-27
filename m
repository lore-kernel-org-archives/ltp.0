Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC56C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719927182; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rWiiAYf4MgS89aT/tKv9J1C0nlcyiq8g1AhVA3B5+Ss=;
 b=IDvBFvNp8CE9nhvocn3Rt3+GYnwnut1KIqFCSDviRuiVXc8f06NDut16nGX1gWyRCwypx
 zu8US0TMDaEYIaAEOJAjF7jaHlCgoFQBEd8tzilfe4rHLMCk8GeTF9DrRaMPIlX3PdnEJqR
 id+/+V9SbSR3g5yq3Qi+kYLUMtloEaE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 001193D0F6E
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:33:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC8E03D0FAF
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:29:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=mediatek.com (client-ip=210.61.82.184;
 helo=mailgw02.mediatek.com; envelope-from=joe.liu@mediatek.com;
 receiver=lists.linux.it)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A918F101BB81
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 11:29:10 +0200 (CEST)
X-UUID: b16b2a72346711ef99dc3f8fac2c3230-20240627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Gxa2od1bo4v1XSQBSppUzWH9nMviGTGaNw/uaMfAIII=; 
 b=mqV9U364AIAM2/11BYsrL6/EcUJ91gsdiS9pKim/VDZwMEaLUCskIPD9o0tFflG7GA7jZG0LXiF2XhqyG9el7QR4QpzV8Xp1AWy+I8WIFsCkVa0pXL2M6ma7bITMZ4bgIEjR+hvgaVMOd/OP2y4jhvkhUKpvMt4s39EOYmnxOdU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39, REQID:3eae0b92-779b-4bf7-966e-b9be4d5b65e9, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:393d96e, CLOUDID:6ab61989-8d4f-477b-89d2-1e3bdbef96d1,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT
X-CID-BAS: 1,FCT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b16b2a72346711ef99dc3f8fac2c3230-20240627
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <joe.liu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1166797311; Thu, 27 Jun 2024 17:29:03 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jun 2024 17:29:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jun 2024 17:29:00 +0800
To: <chrubis@suse.cz>
Date: Thu, 27 Jun 2024 17:28:59 +0800
Message-ID: <20240627092900.20985-1-joe.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240612112311.10334-1-chrubis@suse.cz>
References: <20240612112311.10334-1-chrubis@suse.cz>
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--2.093100-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQ4HKI/yaqRm+qwWVBfMuvoe7Z0UyQO5TNh7WbOnt2TBzUi
 2rTIOxGG4iklOQCWq9JyxlmD3MM49eU6SuqUlqe6syw+ZJnFumQHdYH++bm0GAPYDdySm+X3ra4
 hwGeKbvKObIAKMbDdIOwtXQyQB91DMdoq6niTi6K4jAucHcCqnTul9KNGwPY6BthzL1hCXp5Iw5
 I+N6KsBKA8+iTsk6pAgDLqnrRlXrZ8nn9tnqel2MprJP8FBOIaimkn+s9We/F9X5QEAPKzPWPnO
 AY0+21Z4lrKw+SpCh5FqU5d6p8JTuCokWcm+5o7At/doGVYVeNRp5EVkVADgL44wH2gofHDndCR
 kxk0cZt0BNB20+SxH7f8mJY57oZddJaBDYald1mHO0tVYDV4T0MMprcbiest
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.093100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 5F87BA15394603AC5F02BF8598FDCE00E13A602E603CC6198653FD5B97D1CBBD2000:8
X-MTK: N
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:32:40 +0200
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
From: "joe.liu via ltp" <ltp@lists.linux.it>
Reply-To: "joe.liu" <joe.liu@mediatek.com>
Cc: alix.wu@mediatek.com, xufeifei1@oppo.com, ltp@lists.linux.it,
 joe.liu@mediatek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Instead of hardcoding the values we attempt to measure the CPU speed and
> set the timeout accordingly. Given that the difference in the duration
> of the test when the kernel is buggy is about 30x we do not have to have
> a precise callibration, just very rough estimate if we are running on a
> server or small ARM board would suffice.

> So we attempt to measure how long does a bussy loop take and base the
> default timeout on that. On x86_64 CPUs the resulting timeout is about
> double of the value of the actual test runtime and works fine, but we
> need to make sure that the coeficient we divide the result from
> callibrate works for small boards too. So please run the test on as many
> machines as you can and report if we need to make the dividor smaller or
> not.

While applying this new patch, the test result of 32bit kernel is still failed. Please refers following log:

external/ltp/lib/tst_test.c:1690: TINFO: LTP version: 20230929
external/ltp/lib/tst_test.c:1576: TINFO: Timeout per run is 0h 00m 30s
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:90: TPASS: sched_setaffinity(0, sizeof(mask), &mask) returned 0
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:58: TINFO: CPU did 100000000 loops in 198306us
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:99: TINFO: cal timeout: 198
external/ltp/lib/tst_test.c:1583: TINFO: Updating max runtime to 0h 03m 18s
external/ltp/lib/tst_test.c:1576: TINFO: Timeout per run is 0h 03m 48s
Test timeouted, sending SIGKILL!

After using "time ./starvation" to check the timecost, we can see the timecost is about 26 mins and 48 seconds


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
