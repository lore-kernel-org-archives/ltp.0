Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C0EC433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:23:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2DC23C9200
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:23:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C87C3C012A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:23:32 +0100 (CET)
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com
 [195.245.231.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0010B600F4F
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1648200211; i=@fujitsu.com;
 bh=jAhPLg8ty6OHqv0vYFQ1HRrfU7UvCraNUNbfeVmcv0s=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=k2Hww2wm3DBgjf8VSyRU2TaSndgXwGK6CzTP54n/50f92XvnetHCeTcVo92hwv6Mg
 orQD+h4l+PeZtkAoX6vf6PjUe2KQ/Qy4vNMaHYXulIEqE61XQioXPKLxNo7R8R10h8
 CGum3WDbfNEyPs9zBy1liewe5uzLo/TxkvOkZxnblU6zkMaOGqIH8+GNwEIn78DxEV
 mR5ZEp5r/g/uwoTiP3X1O/4XqNlD/Cp4QQbXTE3DW0LHRVql5hIf5/+VXxc3c0q4JH
 cE4sjCcCcTvHdqcLc/h8JyLJcxRnGg9PFfD4va8QnrCXtxN+VZWCeN9bvgA8IHLm76
 3p2Qx/tRcSqPA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRWlGSWpSXmKPExsViZ8MxSVeoyzb
 J4MF1FYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePns2ssBZdYKi42HWVrYOxi6WLk4hASOMso
 seZ0K3sXIyeQs5NJ4uhFeYjEfkaJtyvusIAk2AQ0JK49bmcGsUUEJCQ6Gt6CNTALqEnsvnqMD
 cQWFnCX2DHjB1g9i4CqxKpeCJtXwFXiw9VbYPUSAgoSUx6+Z4aIC0qcnPmEBWKOhMTBFy+YIW
 oUJfbv3cgIYVdIzJixjQ3CVpO4em4T8wRG/llI2mchaV/AyLSK0TqpKDM9oyQ3MTNH19DAQNf
 Q0FTX2AjINNFLrNJN1Est1S1PLS7RNdJLLC/WSy0u1iuuzE3OSdHLSy3ZxAgMy5RihYwdjN9X
 /tQ7xCjJwaQkyqvuY5skxJeUn1KZkVicEV9UmpNafIhRhoNDSYK3owIoJ1iUmp5akZaZA4wRm
 LQEB4+SCG9TFVCat7ggMbc4Mx0idYpRUUqcV7ATKCEAksgozYNrg8XlJUZZKWFeRgYGBiGegt
 Si3MwSVPlXjOIcjErCvIs7gKbwZOaVwE1/BbSYCWjx85+WIItLEhFSUg1Mymc1Jt5JWL/99Iy
 ANqlFqk+ehX96rOsnp1EovjztQ++nDau/mtbdnmyoyCW6SVNNLPO9qQD/ukDHOCvNpN+7jbtc
 qvx/fZcJZsh3ZrHdcdXFp4vTxiHFfJugRGpUn1Gpa/pdK7Z/lSrPrCdOFP4xM2PzTvcJounlb
 8O2MB2YxCHWtnbhmm2H1Ys8NHM/T919ImZZaN3jDNW2+uzQPdeao7lmXY8S1n36McQmYTezqv
 +2y0sZtb1sG3d9s1nct1jpz4YlviVZB2/7H+xsCKk0fr/m8pwNq9LNikOfSMqt+aLp0fv0v62
 NrCRjnJnMChn9+Ztz81k6F626ML/cX3L9jrMHKhaXvjj0N/jpt5VKLMUZiYZazEXFiQAIRMEF
 RgMAAA==
X-Env-Sender: daisl.fnst@fujitsu.com
X-Msg-Ref: server-2.tower-571.messagelabs.com!1648200210!269177!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.10; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18403 invoked from network); 25 Mar 2022 09:23:30 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
 by server-2.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 25 Mar 2022 09:23:30 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 3CB9F100456
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 09:23:30 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 2FC8A10032A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 09:23:30 +0000 (GMT)
Received: from rhel79.g08.fujitsu.local (10.167.225.51) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 25 Mar 2022 09:23:23 +0000
From: Dai Shili <daisl.fnst@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 25 Mar 2022 17:22:56 -0400
Message-ID: <1648243376-5306-1-git-send-email-daisl.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.225.51]
X-ClientProxiedBy: G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/umount2_02: remove useless TST_ERR assignment
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

Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/umount2/umount2_02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/umount2/umount2_02.c b/testcases/kernel/syscalls/umount2/umount2_02.c
index 4c3b30e..d1aed11 100644
--- a/testcases/kernel/syscalls/umount2/umount2_02.c
+++ b/testcases/kernel/syscalls/umount2/umount2_02.c
@@ -69,7 +69,6 @@ static int umount2_retry(const char *target, int flags)
 	tst_res(TWARN, "Failed to umount('%s', %i) after 50 retries",
 		target, flags);
 
-	TST_ERR = EBUSY;
 	return -1;
 }
 
-- 
1.8.3.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
