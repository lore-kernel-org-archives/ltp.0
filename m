Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE57CD6E68
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 07:27:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 191863E548D
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 09:27:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95FE73C568A
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 09:26:52 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 603431A00799
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 09:26:48 +0200 (CEST)
X-UUID: ba930b545fe611f1aa26b74ffac11d73-20260604
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0329db74-4acf-4aa4-af01-78987d07a884, IP:10,
 URL:25,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:55
X-CID-INFO: VERSION:1.3.12, REQID:0329db74-4acf-4aa4-af01-78987d07a884, IP:10,
 UR
 L:25,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:55
X-CID-META: VersionHash:e7bac3a, CLOUDID:231ca3605760c0a2b3008a122823b13b,
 BulkI
 D:260603173201TXFUS02Z,BulkQuantity:2,Recheck:0,SF:17|19|66|78|81|82|83|10
 1|102|127|841|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:11|99|94|
 82|1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
 PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ba930b545fe611f1aa26b74ffac11d73-20260604
X-User: panzhe@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <panzhe@kylinos.cn>) (Generic MTA)
 with ESMTP id 111360384; Thu, 04 Jun 2026 15:26:40 +0800
From: panzhe <panzhe@kylinos.cn>
To: chrubis@suse.cz
Date: Thu,  4 Jun 2026 15:26:37 +0800
Message-Id: <20260604072637.147497-1-panzhe@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <--compose>
References: <--compose>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] gethostname02: Accept EOVERFLOW on alpha
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Thanks for your review.

The ENAMETOOLONG note in man describes the mainstream glibc implementation based on uname(2), but alpha has its own arch-specific implementation calling raw gethostname syscall and returning EOVERFLOW.
Alpha glibc source:
https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/alpha/gethostname.c.html

POSIX does not specify required errno here, this is existing upstream glibc behavior. I suggest accepting both errnos to resolve alpha test failures.


Regards,
panzhe

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
