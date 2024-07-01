Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061DAC30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719927205; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8Yl+3B95KYRK4NO4tS/CDVHAe2BcLriXuskz4GWZLU0=;
 b=rVPMYUQXrTG5kQP9Bdj9Ymn+j5eVAiWqduBv75saTm9HgSJGXWc31FslxH9jAOX6LdxF/
 1mb2kDYud+sTCc1Vc9Z0aBKW1pue8ny2Os0Mtqgbr3oCMbBh8AZgx/UeEuUfuf0BA2VxUFV
 i0icwotjKkXkwuqx7m7+vgwfpfMrIzk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 581073D3ED1
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:33:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 761BF3D3F7E
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 11:50:47 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=mediatek.com (client-ip=60.244.123.138;
 helo=mailgw01.mediatek.com; envelope-from=joe.liu@mediatek.com;
 receiver=lists.linux.it)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7F3F2600CE5
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 11:50:43 +0200 (CEST)
X-UUID: 5c1d330a378f11ef8b8f29950b90a568-20240701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=yaXwV3h8d29shuoGZvXY6hrRP8eWRGoRHtvp5sraY+g=; 
 b=IRrmKIWMMZxyNPXfpAy+aq4GWxhXf18fjnL7ph36lfl6jGXgYhHrdgUnrEm59GZK+Ny0SgukaHPDNXR2i4ZemwkB0HjC+7BwyFx5NZqWw0Teb4vOL4elk8kxXjRf0R0TImoUIsBfEX2UnIKfFhEu7+2PNaoJkqSAWfHd0LagIlk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40, REQID:2cff04be-7532-48ed-a630-750cbdb65429, IP:0,
 U
 RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:1
X-CID-META: VersionHash:ba885a6, CLOUDID:b6fdf2d0-436f-4604-ad9d-558fa44a3bbe,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:4|-5,EDM:-3,I
 P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
 ,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5c1d330a378f11ef8b8f29950b90a568-20240701
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <joe.liu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 864599554; Mon, 01 Jul 2024 17:50:33 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 1 Jul 2024 17:50:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 1 Jul 2024 17:50:32 +0800
To: <chrubis@suse.cz>
Date: Mon, 1 Jul 2024 17:50:32 +0800
Message-ID: <20240701095032.18930-1-joe.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240612112311.10334-1-chrubis@suse.cz>
References: <20240612112311.10334-1-chrubis@suse.cz>
MIME-Version: 1.0
X-MTK: N
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

> Hi!
> > > Instead of hardcoding the values we attempt to measure the CPU speed and
> > > set the timeout accordingly. Given that the difference in the duration
> > > of the test when the kernel is buggy is about 30x we do not have to have
> > > a precise callibration, just very rough estimate if we are running on a
> > > server or small ARM board would suffice.

> > > So we attempt to measure how long does a bussy loop take and base the
> > > default timeout on that. On x86_64 CPUs the resulting timeout is about
> > > double of the value of the actual test runtime and works fine, but we
> > > need to make sure that the coeficient we divide the result from
> > > callibrate works for small boards too. So please run the test on as many
> > > machines as you can and report if we need to make the dividor smaller or
> > > not.
 
> > While applying this new patch, the test result of 32bit kernel is still failed. Please refers following log:
> > 
> > external/ltp/lib/tst_test.c:1690: TINFO: LTP version: 20230929
> > external/ltp/lib/tst_test.c:1576: TINFO: Timeout per run is 0h 00m 30s
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:90: TPASS: sched_setaffinity(0, sizeof(mask), &mask) returned 0
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:58: TINFO: CPU did 100000000 loops in 198306us
> > external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:99: TINFO: cal timeout: 198
> > external/ltp/lib/tst_test.c:1583: TINFO: Updating max runtime to 0h 03m 18s
> > external/ltp/lib/tst_test.c:1576: TINFO: Timeout per run is 0h 03m 48s
> > Test timeouted, sending SIGKILL!
> > 
> > After using "time ./starvation" to check the timecost, we can see the timecost is about 26 mins and 48 seconds

> This is really strange. I tested the code on RPi Zero with 32bit BCM2835
> where the CPU is even slower and runtime limit is set to about 5
> minutes, yet the test finished in a minute. That's with resonably recent
> kernel 6.1 though.

> What kernel version do you use?
We are now using kernel 5.15

> Do you run LTP with background tasks to keep the CPU bussy?
Yes, we are testing LTP with Android VTS. And the test environment is under Android Launcher.

> Do you have any custom patches for kernel scheduller applied?
I think there is no any patch applied for kernel scheduller.

> It really looks like something unexpected is happening at your end.

Actually, the same kernel version using 64bit kernel can pass the ltp test.



1. for 32bit kernel, we have this log

32bit kernel
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:161: TINFO: do_test by pid 4523
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4523
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 4524
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4524
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 0
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:176: TINFO: go loop, current pid is 4523
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:145: TINFO: current ppid is 4523, current pid is 4524, go to child() start

main pid is 4523, child pid is 4524, and we only see child pid is working (checking by top)

4524 root         20   0  14M 472K    0 R 85.7   0.0   0:14.93 starvation_v4 -t 1000000 -l 1000000 <-- cpu_load by top




2. for 64bit kernel, we have this log

64bit kernel
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:161: TINFO: do_test by pid 9753
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 9753
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 9754
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 9754
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 0
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:176: TINFO: go loop, current pid is 9753
external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:145: TINFO: current ppid is 9753, current pid is 9754, go to child() start

main pid is 9753, child pid is 9754, and we see both main and child pid are working (checking by top)

9754 root         20   0  16M 472K    0 R 51.4   0.0   0:05.51 starvation_v4 -t 1000000 -l 1000000 <-- cpu_load by top
9753 root         20   0  16M 464K    0 R 45.7   0.0   0:05.70 starvation_v4 -t 1000000 -l 1000000 <-- cpu_load by top


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
