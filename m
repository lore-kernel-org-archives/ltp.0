Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CABFEE4ED
	for <ltp@archiver.kernel.org>; Sat, 28 Feb 2026 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772299070; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0mRkM0Vi6hbhLKl4iObE+m78bUaZSRIv/dqUWpYMI84=;
 b=W35mwGEHOf4hjVUJxsNPBGn9ljS1p46V/2eoFNkCwyBb+VUZ3P93am0exyYi0idkQRpRK
 qIPgKiibhbiBZPXQfc5m6Mv49wUHC8vWsyJXzATHap8E92WpjFv7aJRyNEBP2FhTARcflHy
 VLxOw2Ut87KEve7NdLPy9c8JGo8NLG0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE3603CE49D
	for <ltp@archiver.kernel.org>; Sat, 28 Feb 2026 18:17:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E002A3C01A4
 for <ltp@lists.linux.it>; Sat, 28 Feb 2026 18:17:27 +0100 (CET)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6436F1400325
 for <ltp@lists.linux.it>; Sat, 28 Feb 2026 18:17:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=hvu6FVzuC+3FkiDMdSsoTz6HLMNY7itvYnBrM00tMQA=; b=DOYQL35On1gG
 OV2I1JjqvhSatL7LqJlzNl2IZS6fvAYYv6Lprf2AbAsyCdBrQVN9cTRFvBM5Wke6ePqccVfXXpcta
 s6gKMh743tVrBXPHEL/EkESYvuwOMmtGQBNZ6HqOmsEKxjaums7zDJ9TybjEQQhz5ElHi9LEFnbIc
 h+XDiTSrngIGmu23k6CfSbNEJ48V7fZMx4Tu0kJ4wjLA+upy1bi4FD7ICnD3FptlhuaRjS6QsHmAo
 NzgIS+F+xd2MZjeU26PMmDA+vTlLWPnInHvKn3qoaR7iIlphuGBx+t55QpUUO6/xkC3M/GhGbS2NU
 866ZsIWufBlpe9KLTYS8Hw==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1vwNv4-00DNfk-0b; Sat, 28 Feb 2026 18:17:19 +0100
To: ltp@lists.linux.it
Date: Sat, 28 Feb 2026 17:15:38 +0000
Message-ID: <20260228171722.753403-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] pty04: use the correct protocol per line
 discipline to avoid extra packets
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use specific protocol filter (ETH_P_IP for N_SLIP, ETH_P_CAN for N_SLCAN)
instead of ETH_P_ALL to avoid catching unrelated packets like IPv6
multicast (MLD) which cause false test failures.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
v2:
- Removes switch statement
- Adds protocol to the ldisc_info structure

 testcases/kernel/pty/pty04.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/pty/pty04.c b/testcases/kernel/pty/pty04.c
index 00b714c82..6359ff998 100644
--- a/testcases/kernel/pty/pty04.c
+++ b/testcases/kernel/pty/pty04.c
@@ -85,11 +85,12 @@ struct ldisc_info {
 	int n;
 	char *name;
 	int mtu;
+	int protocol;
 };
 
 static struct ldisc_info ldiscs[] = {
-	{N_SLIP, "N_SLIP", 8192},
-	{N_SLCAN, "N_SLCAN", CAN_MTU},
+	{N_SLIP, "N_SLIP", 8192, ETH_P_IP},
+	{N_SLCAN, "N_SLCAN", CAN_MTU, ETH_P_CAN},
 };
 
 static int ptmx, pts, sk, mtu, no_check;
@@ -270,7 +271,7 @@ static void open_netdev(const struct ldisc_info *ldisc)
 	SAFE_IOCTL(sk, SIOCGIFINDEX, &ifreq);
 
 	lla.sll_family = PF_PACKET;
-	lla.sll_protocol = htons(ETH_P_ALL);
+	lla.sll_protocol = htons(ldisc->protocol);
 	lla.sll_ifindex = ifreq.ifr_ifindex;
 	SAFE_BIND(sk, (struct sockaddr *)&lla, sizeof(struct sockaddr_ll));
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
