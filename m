Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D8CC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 06:13:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AE0F3CDA33
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:13:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 758663CB7FF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:13:23 +0100 (CET)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com
 [68.232.139.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0F7E1000237
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:13:21 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="142767939"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; d="scan'208";a="142767939"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 15:13:20 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 21C81D9D94
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:13:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 51D43D9478
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:13:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D925520074726
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:13:16 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 893E71A0070;
 Tue, 28 Nov 2023 14:13:16 +0800 (CST)
Message-ID: <22adad8a-0462-32a6-4777-9ae7eaf60253@fujitsu.com>
Date: Tue, 28 Nov 2023 14:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20231027071236.51779-1-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20231027071236.51779-1-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.005
X-TMASE-Result: 10--2.571600-10.000000
X-TMASE-MatchedRID: wjdoQEOKyraPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizxULhp+W/a9mfNY
 yBBaMLojhiLcY10zORqfpwWoBJ/J6eVHGbcDbAq6OX/V8P8ail2cIZLVZAQa0A2uPhjP6+n7F/+
 bTgkwLgkLbigRnpKlKWxlRJiH4397y++ZInAH1kx8pAty59SyK0Ur1toDllSSSgvsEzt9HcCV03
 HSXk8FMpMs6D/nsANaAywsND2dwEhHSJZxT1jVS4+Pb9RxTVah
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Refactor and merge symlink04/05 using new LTP
 API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2023/10/27 15:12, Yang Xu wrote:
> -	cleanup();
> -	tst_exit();
> -
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);

Hi Yang

Is it better to call SAFE_TOUCH(TESTFILE, 0644, NULL) here?
In this case, we can drop cleanup() as well.
Other than that, it looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
