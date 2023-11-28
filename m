Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C520DC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 06:32:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AED453CD988
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:32:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE2EF3CB7FF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:32:07 +0100 (CET)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D66B1400E51
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:32:06 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="119998572"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; d="scan'208";a="119998572"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 15:32:04 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C82B3D4F62
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:32:02 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D69DF992
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:32:02 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9F8B24119F
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:32:01 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 34EC61A0070;
 Tue, 28 Nov 2023 14:32:01 +0800 (CST)
Message-ID: <17196c76-e767-1353-6725-21d92c3633b8@fujitsu.com>
Date: Tue, 28 Nov 2023 14:32:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Xiao Yang <yangx.jy@fujitsu.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
In-Reply-To: <9bcca18a-42a8-2200-c6c1-0f97b42e11e6@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.005
X-TMASE-Result: 10--1.639600-10.000000
X-TMASE-MatchedRID: wjdoQEOKyraPvrMjLFD6eK5i3jK3KDOoC/ExpXrHizzB5dpOqrSWikur
 PCb2dldyL8pdHj/gu/qbGV2woY7yrUPbYPqd/GaJngIgpj8eDcCcIZLVZAQa0PHGabLdyIkFF/+
 bTgkwLgkLbigRnpKlKZx+7GyJjhAUf3128dnF1goAyk0ze1dqEnuq3SCoXLe/z9mAs4nc5+hPwR
 1mSoEsfCum1K6CfV+larGwI36oPqR931gCHvTe6RI394sFIBqxrYpOC6Au14ZHr0IsTgdOWjJcV
 zTDm9VqcsBjhhUpYerFhXMjdQIJpg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] pathconf01: Convert to new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyMy8xMS8yOCAxMzoyMSwgWGlhbyBZYW5nIHdyb3RlOgo+IC0vKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCj4gLSAqIGNs
ZWFudXAoKSAtIHBlcmZvcm1zIGFsbCBPTkUgVElNRSBjbGVhbnVwIGZvciB0aGlzIHRlc3QgYXQK
PiAtICrCoMKgwqDCoMKgwqDCoCBjb21wbGV0aW9uIG9yIHByZW1hdHVyZSBleGl0Lgo+IC0gKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqLwo+ICDCoCB2b2lkIGNsZWFudXAodm9pZCkKSGkgWWFuZwoKT25lIG1vcmUgaGludDoKc3Rh
dGljIHZvaWQgY2xlYW51cCh2b2lkKSBpcyBiZXR0ZXIgaGVyZS4KCkJlc3QgUmVnYXJkcywKWGlh
byBZYW5nCj4gIMKgIHsKPiAtwqDCoMKgIGlmICghbGZsYWcpIHsKPiAtwqDCoMKgwqDCoMKgwqAg
dHN0X3JtZGlyKCk7Cj4gLcKgwqDCoMKgwqDCoMKgIGZyZWUocGF0aCk7Cj4gLcKgwqDCoCB9Cj4g
K8KgwqDCoCBmcmVlKHBhdGgpOwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
