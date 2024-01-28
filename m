Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B161AC47258
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 16:32:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A83893CE184
	for <ltp@archiver.kernel.org>; Sun, 28 Jan 2024 17:32:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C7D83CC968
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 17:32:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=yangx.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6A9241400978
 for <ltp@lists.linux.it>; Sun, 28 Jan 2024 17:31:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1706459520; x=1737995520;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ElzWZ3/OQyOBr4TbweHC4WreovR0D8GboYUJCQUBmak=;
 b=qG6eR/lbb8xHkk77WcNHnRKMkb7crBQtwgoY5ej4FLMomUJNWF0TuCkX
 WFIC5WdXJ/KG5Gz5Xgq92rDtCCX4aNfwazr4GHcY6+7OVtK1tK5jQSvtr
 ddP7SxLPpjTkJX1QKh4smtiETIH72aCrXNIOf+0k6P2TzDitfX+9CDNCt
 Ga021WzH5j92OK+GEu+T5AgHCfb9yz1t1py5+008DKvvBCs0mZAgoopQ5
 MXn3ha9w/CAumW0cbbEYYP9S/Fvj32jORDeJXhsmMOc9Zpo7d6Tr9ZEbJ
 RyNrst4V624i58lrm5848fSqgXrQ1Mwsu49eks4KjhtEKQjHG37yiWdUc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="147522062"
X-IronPort-AV: E=Sophos;i="6.05,220,1701097200"; d="scan'208";a="147522062"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2024 01:31:56 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 21F77EDC18
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 01:31:54 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4DC6F21AA16
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 01:31:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id BE7C8200501A0
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 01:31:52 +0900 (JST)
Received: from [10.167.214.93] (unknown [10.167.214.93])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3B58B1A006C;
 Mon, 29 Jan 2024 00:31:52 +0800 (CST)
Message-ID: <0ab9793c-e9a8-cfd5-4582-728ca420860e@fujitsu.com>
Date: Mon, 29 Jan 2024 00:31:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Petr Vorel <pvorel@suse.cz>
References: <20240121122959.1386-1-yangx.jy@fujitsu.com>
 <20240121122959.1386-4-yangx.jy@fujitsu.com> <20240121194949.GF51882@pevik>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20240121194949.GF51882@pevik>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28148.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28148.000
X-TMASE-Result: 10--0.205300-10.000000
X-TMASE-MatchedRID: 2UwwcHKl5CGPvrMjLFD6eL084HjrfFAS82SgwNf6SK5mimiikJEPRKPF
 jJEFr+olA9Mriq0CDAiIxtV/pB/tzNvteQQ2MnYQvM83WO0obmVP1GghjjIA0gtuKBGekqUpbGV
 EmIfjf3u6x6MAwYU0Qu8xeCBpQaq4m06OEXhQPKd7njm3UNEQDGkOl6o4hZ5f9Kpk6L5uXxvmjp
 qHWd5d8YvXMDl2Z/5HFUZFMicqbsM=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] syscalls/pwritev: Make make check happy
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Merged with your reviewed-by and relicense.
Thanks a lot.

Best Regards,
Xiao Yang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
