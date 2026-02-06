Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF9FEE209E
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770382724; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=NAgVc+B2akDeqcCTZk3iAgn823d63avqGS9021Ax9/8=;
 b=VTFqEjFqPbchEwMFAZJiDMhyGG8/jF+IOEU09t7Dp8bO+MOgxj7SjeKlFTlbegedmEU1o
 zFedPxPPD21jaKt6VSDnPzbNl5iy+0q9Pe0TcZsb6SbiUc195bK+OYmLSVxOKS36az8d84/
 EuWZJytHrZMOKAKAsjIHFrUcknwGvSY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A7963CC86D
	for <ltp@archiver.kernel.org>; Fri,  6 Feb 2026 13:58:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 179603C19BA
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 13:58:21 +0100 (CET)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7E293200DAB
 for <ltp@lists.linux.it>; Fri,  6 Feb 2026 13:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=Rzhg6bY7iDeO2ZbrAHEDaVNfftCmvTihJHYDdHnyfx4=; b=Vx5Asz2/825q
 hvy6WJ6h6SKrM7Jk4BL2qDo5Hpbnd52N98a0LihJ/WxFhLJ4K6nXdyguISzqZyX/W4TP6wysm4clV
 XhfJjoEzPyEWnEn3SQq/QyP/ZxX1ORce5k5EkTOj/TrpfVaxZI5XllJBdYdw/Kx3DkeCb8r3BiYTY
 mdwrew4dL0P+irZOX5Ga07loCFhL0ctuOqdToEeanmwCw/OqUEJIrbs9L8BQXRuxvxhpFSH+n9qZK
 5GTg0Qbf93w176fnsm0d4hwm5QYa7LtmJa8oCsCNWEy4tthf4A0ojYmr6wcOiAQPgfKmXdBYDEa12
 GNzPUZ9eq38KQJd6dQ95Pw==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1voLOo-000BYY-1q for ltp@lists.linux.it;
 Fri, 06 Feb 2026 13:58:17 +0100
To: ltp@lists.linux.it
Date: Fri,  6 Feb 2026 12:51:11 +0000
Message-ID: <20260206125818.319190-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] pty: use correct protocol in pty04 based on line
 discipline
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

Hi,

during testing of the LTP pty test pty04, we observed intermittent
failures caused by unexpected IPv6 packets being received.

The test currently filters packets using ETH_P_ALL. As a result,
packets with protocols other than the expected one (e.g. IPv6) may be
received, leading to data corruption reports such as:

TFAIL: Corrupt data (max 64 of 8191 bytes shown): data[0..64] =
TFAIL: 60 00 00 00 00 24 00 01 00 00 00 00 00 00 00 00
TFAIL: 00 00 00 00 00 00 00 00 ff 02 00 00 00 00 00 00
TFAIL: 00 00 00 00 00 00 00 16 3a 00 05 02 00 00 01 00
TFAIL: 8f 00 6e 8a 00 00 00 01 04 00 00 00 ff 02 00 00

This patch series addresses the issue by selecting the protocol based
on the configured line discipline.

Patch 1 adds a compatibility definition for ETH_P_CAN to the LAPI
headers. Patch 2 updates pty04 to choose the appropriate protocol,
avoiding reception of unrelated packets.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>

Vasileios Almpanis (2):
  add ETH_P_CAN compat macro to LAPI headers
  pty04: use the correct protocol per line discipline to avoid extra
    packets

 include/lapi/if_ether.h      |  4 ++++
 testcases/kernel/pty/pty04.c | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
