Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A9C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 01:14:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D701D60E94
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 01:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D701D60E94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86BDF3C102C
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 03:14:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F2923C0D08
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 03:13:59 +0200 (CEST)
Received: from mail1.bemta26.messagelabs.com (mail1.bemta26.messagelabs.com
 [85.158.142.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D014420076E
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 03:13:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1634087636; i=@fujitsu.com;
 bh=spQTsWsvJPF3czAlmcjKNjuOu+tzpDxd5JITKcKEWFw=;
 h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=PJRdFhIkmwzHQ/I2jtfNl0tVLIfgTQU0mvW+Z+hbYJaNn1zp/wKW4do9sRSfnM79G
 fY4BatfF+22FjYW0lMlQQDCdY4GG/Uf7jdh8OY8dR/zYPvIcSu8TnKWHxy66nFVUYI
 YuOppV8SdYCvRfqpNSeNCY/Il+7NaqeYMPnIpTc4EO+VsD/AUxoIeTa2/VpMO02BSL
 eHbS1WUkhxtSblkASQYFFhTW4nUV89aG7EFi9NGnuzzKpDdC8DxV/8kCZtv1LUOL2s
 r2BMYxajGoE+G7uzNRd1RrOtfuzHhIiCW52aaPrYS2+vz9ChQG/FQHY/OdRQE6+z/b
 tkKc8wkuPosmA==
Received: from [100.113.6.246] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-b.eu-central-1.aws.symcld.net id 56/17-14220-4D236616;
 Wed, 13 Oct 2021 01:13:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsViZ8ORqHvFKC3
 RoP8ph8WK7zsYHRg99v1exxrAGMWamZeUX5HAmrF2306WgptMFVPf3GVrYFzO1MXIxSEkcJZR
 YnnLX3YIZyeTxIvZW1ggnD2MEp0H9zF3MXJysAloSjzrXABmiwhISHQ0vGUHsZkF1CWWT/rFB
 GILC7hJ/Dt1hRHEZhFQlVg75y9YnFfAQ6Jl/kqwegkBBYkpD9+DzeEU8JT49Hg20DIOoGUeEo
 ffGkCUC0qcnPmEBWK8hMTBFy+YIVoVJS51fGOEsCskZs1qY4Kw1SSuntvEPIFRcBaS9llI2hc
 wMq1itEwqykzPKMlNzMzRNTQw0DU0NNY10TU0NtBLrNJN0kst1U1OzSspSgTK6iWWF+sVV+Ym
 56To5aWWbGIEhnBKIUvTDsbfrz7oHWKU5GBSEuW1W5iaKMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ
 0mCl8UwLVFIsCg1PbUiLTMHGE8waQkOHiUR3rkgad7igsTc4sx0iNQpRkUpcV4pkIQASCKjNA
 +uDRbDlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ83JqAU3hycwrgZv+CmgxE9DiwKgUkMU
 liQgpqQYmbyNHQYcPHXH7mi1Zo/dOkrBWT/5X02v4uWzB9333Z+QlH7rV5uPv4/Ho1PaTcxfx
 d0R9sxHMYFdVkU9kOfq+ymxDY3nrlE/rPf2KT3RNnMncs0i5etOB2P2P9ojdOfna6+ZsD5PJn
 kY55293HePd+93ZJXHiwYo1/YvztXuf7CiaNGfBn9veJ968UDpsMLuhZ0V5iIaqwyzxIq4lc0
 IvlW3uaGkPnepyi2kzt1DP3pmzbNYtFnl9zb4i/4ujiYFmhXr2u+KjFeXT1pk8unJbIeJzBdt
 p1jWP/2tNXZ0e8b43buvMZI9eppvnjgS/q2iucGCMZV/zav7yfX51nP3Slt9ldVob309fuuLb
 nNOdSizFGYmGWsxFxYkAhaVvrlwDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-238.messagelabs.com!1634087635!626789!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21593 invoked from network); 13 Oct 2021 01:13:56 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-9.tower-238.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 13 Oct 2021 01:13:56 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 9DBD51009E5
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 02:13:55 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 62D8910025A
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 02:13:55 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 13 Oct 2021 02:13:51 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Wed, 13 Oct 2021 09:14:09 +0800
Message-ID: <1634087649-2137-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1634087649-2137-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] scenario_groups/default: Add irq into default run
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

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 scenario_groups/default | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scenario_groups/default b/scenario_groups/default
index 439783dac..1dc2987d5 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -6,6 +6,7 @@ dio
 io
 mm
 ipc
+irq
 sched
 math
 nptl
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
