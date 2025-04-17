Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4FDC369B2
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 08:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744879006; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Aq3poldKU0UHfVAmgyBq5+KlPyltuhzKfN6GLwKXUcE=;
 b=f3QSIy5WbQK93tsWm32NdkFYmxx+Q3aJSNdTCiTx1Wkc8Q2c4qTrEhxV9Nxv9w1fwRMBm
 scPGrGvCup6NnW15DC4PNxlv5SSD32TFBaSKzKQuZkwlwEvFaKMF7yiaPCEv28YaArIfSNJ
 gGEEWWa+xyTlJJAQ38xuxDZoshTMi4I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC5223CB9E7
	for <ltp@archiver.kernel.org>; Thu, 17 Apr 2025 10:36:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C51043C0B7C
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 10:36:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DADBE600C99
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 10:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744878981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AectQK+U5Q3lcjTAJSU9robbmYAeb6737Q60Rixa1gA=;
 b=d2rDj9IRflExcZ69yXiof5uyqDH1dLC4qEpL2l6PrJE0iwfQeAvBflZA7qH8pOQZdLFjtQ
 esibDeYJGTeY/qPc5saUZNKg+UrGBPWysHA2t4zaWCr9+88t1h719nFrXH6fEFFYslm41I
 zf7FTIsr5r1IX2g7E+drQ9ig7Mdzh5A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-D1KSo5SwPVq4mJ0zGNY66w-1; Thu,
 17 Apr 2025 04:36:17 -0400
X-MC-Unique: D1KSo5SwPVq4mJ0zGNY66w-1
X-Mimecast-MFC-AGG-ID: D1KSo5SwPVq4mJ0zGNY66w_1744878977
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E87511800570
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 08:36:16 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECDD11800362
 for <ltp@lists.linux.it>; Thu, 17 Apr 2025 08:36:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 17 Apr 2025 10:36:21 +0200
Message-ID: <8c3549cbda426969943a2beefa4f50f214b1a8c4.1744878941.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bLcBD9P0C7Tv7pb8qVbJSENK2SCTqrPn7HZbJGmsj6I_1744878977
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] libswap: 6.15 supports one more swapfile with
 CONFIG_DEVICE_PRIVATE
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Since c25465eb7630 ("mm: use single SWP_DEVICE_EXCLUSIVE entry type")
kernel supports onre more swap file.

Link: https://lore.kernel.org/all/73bea938-15a2-4b4a-8d31-0db9f9c476e0@redhat.com/#t
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 libs/swap/libswap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libs/swap/libswap.c b/libs/swap/libswap.c
index 63a995f4e31e..e10355502916 100644
--- a/libs/swap/libswap.c
+++ b/libs/swap/libswap.c
@@ -288,6 +288,8 @@ int tst_max_swapfiles(void)
 			swp_device_num = 2;
 		if (tst_kvercmp(5, 14, 0) >= 0)
 			swp_device_num = 4;
+		if (tst_kvercmp(6, 15, 0) >= 0)
+			swp_device_num = 3;
 	}
 
 	if ((marker.choice == 'y' &&
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
