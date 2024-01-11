Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98CFC47077
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 05:15:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4ACA3CE4E8
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 06:15:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76C5A3C024D
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 06:15:15 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=192.198.163.11; helo=mgamail.intel.com;
 envelope-from=pengfei.xu@intel.com; receiver=lists.linux.it)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F6BB1400E79
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 06:15:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704950114; x=1736486114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gaFflbUwmaaUBsr94fS8XMbuc3gcltPn6JmfDFpOG4w=;
 b=L84TuieKLdVY1qJvfC5BtVjP6ClLT61PJgGaVWavz62tSZYzwgGh9jJS
 zoO769WrOkoDHSoee7m9K9Ab/4jZmaa4wx4dIsV5BKXbfn7EyzFV+hbag
 TAJR5UsM48IIPIVLp2u+OwndFcYr1/f9oyt2KHL+P2tBZMGVUwMJD2kf8
 3JpguRS9mxXO8nHs9JhHb7wLMpkEjmbLgYfCAUn89yH22RRtnaGKD6Bid
 7ir/eRh3kcw/RtwQoX1wGnP/JQCfedrHNpc2jBbKNz5G6PZqhl6Blbcls
 nPmhrQR+aWI6o4a+koz+LVQmmLf9GKuptEKKco0cLYtxwfWupmWFgOZ85 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5484548"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="5484548"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 21:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="1029413752"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; d="scan'208";a="1029413752"
Received: from xpf.sh.intel.com ([10.239.182.130])
 by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2024 21:15:08 -0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: ltp@lists.linux.it
Date: Thu, 11 Jan 2024 13:09:45 +0800
Message-Id: <48efcb1293a682182fc5db23f01be7af2889e26c.1704949719.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1704949719.git.pengfei.xu@intel.com>
References: <cover.1704949719.git.pengfei.xu@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/1] keyctl05: improve the dns_res_payload for
 boundary testing
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
Cc: Heng Su <heng.su@intel.com>, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Because the following patch will fix the add_key syscall incoming data boundary
size issue, 6 bytes incoming data should pass:
https://lore.kernel.org/all/1784441.1704907412@warthog.procyon.org.uk/
 -> https://lore.kernel.org/all/1850031.1704921100@warthog.procyon.org.uk/
In order to test above boundary incoming data size, change the dns_res_payload
size.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/syscalls/keyctl/keyctl05.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
index 90cf1ef06..50e78853c 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl05.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
@@ -199,11 +199,11 @@ static void do_test(unsigned int i)
 	 * We need to pass check in dns_resolver_preparse(),
 	 * give it dummy server list request.
 	 * From v6.7-rc8 commit 1997b3cb4217b09e49659b634c94da47f0340409:
-	 * the incoming data for add_key syscall should be larger than 6 bytes,
-	 * because struct dns_server_list_v1_header without body is 6 bytes.
+	 * the incoming data for add_key syscall should be not less than 6
+	 * bytes, because struct dns_server_list_v1_header is 6 bytes.
+	 * The minimum payload will be tested here for boundary testing.
 	 */
-	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, \
-					  0x00, 0x00 };
+	static char dns_res_payload[] = { 0x00, 0x00, 0x01, 0xff, 0x00, 0x00 };
 
 	switch (i) {
 	case 0:
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
