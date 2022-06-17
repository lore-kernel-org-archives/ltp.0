Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E6FC433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 05:56:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53E3E3C8CCF
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 07:56:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A88243C217C
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 07:56:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9C0231401144
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 07:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655445371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cO3uOCSDqNeoI/wYDEc2rN0YGHNue9gug9et/LOnzCE=;
 b=caTttpllqF9+5rhvwKwMegoKCcvDKwpBpxko+yFIaF4KCw1W/08MtqKh3Toiwb8ju9M4LL
 EW0PP34dGMMh5qOE4zpVcOa6JLekwlZm91twQurajmjrIV6o1UdT6SJvxluAa3O+jlssxj
 xd3AQHKapk/zo7spszYEfm90JIeaMVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-89TqY1k2Oi6DCmRJXAmiIA-1; Fri, 17 Jun 2022 01:56:03 -0400
X-MC-Unique: 89TqY1k2Oi6DCmRJXAmiIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC715800882
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 05:56:02 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAD592026985
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 05:56:01 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jun 2022 13:56:00 +0800
Message-Id: <20220617055600.455225-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapping01: set .max_runtime to 90 seconds
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

This fix can significantly improve timeouts on slower systems:

  # free -h
                total        used        free      shared  buff/cache   available
  Mem:          2.9Gi       1.1Gi       1.1Gi        20Mi       732Mi       1.5Gi
  Swap:         2.0Gi          0B       2.0Gi

  # time ./swapping01
  tst_kconfig.c:82: TINFO: Parsing kernel config '/boot/config-4.18.0-309.el8.x86_64+debug'
  tst_test.c:1528: TINFO: Timeout per run is 0h 02m 00s
  swapping01.c:110: TINFO: available physical memory: 1545 MB
  swapping01.c:113: TINFO: try to allocate: 2008 MB
  swapping01.c:152: TPASS: no heavy swapping detected, 218 MB swapped.
  ...

  real    0m34.241s
  user    0m0.386s
  sys     0m16.040s

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index f6133cc0d..73bad5d6a 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -159,6 +159,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
+	.max_runtime = 90,
 	.test_all = test_swapping,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SWAP=y",
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
