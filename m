Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30110C46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 09:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172123CE50C
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 10:03:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4FF3CD18C
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 10:03:12 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AE3A42009E0
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 10:03:10 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="133948282"
X-IronPort-AV: E=Sophos;i="6.04,182,1695654000"; d="scan'208";a="133948282"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 18:03:08 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id CAFACCF1C0
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:03:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 06B256CC19
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:03:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 821F76895A
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:03:05 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 383251A0070
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 17:03:05 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: ltp@lists.linux.it
Date: Tue,  9 Jan 2024 17:03:04 +0800
Message-Id: <20240109090304.766663-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28108.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28108.006
X-TMASE-Result: 10-3.414200-10.000000
X-TMASE-MatchedRID: I938M4WVR+Kbe2Qk1v1tPwXGi/7cli9jg8vk+C7vzx5YC5LPd7BvbVYM
 JR3dIrh2W/1hh+Rku8O1QhEk8s7S2KNu8YiLlIJQxvp0tuDMx3kytf6nW43O0NNCpFsK/tYLg9x
 e4gtUJtq1h3Ci3ttLrSglc2KPMh6DL/tBTZzO5Q2eAiCmPx4NwHJnzNw42kCxxEHRux+uk8hxKp
 vEGAbTDn1FM46sTtJeXIzU5TEs9+FUOw5Bh6kF41xHXckpLXTmBjYicfEhAE3531f0E5pif9OCU
 Vu53Z/uUfppuo89q+Gw2kwi4BJbuyxYQ3DdDFicmj6erosOco3TT39S4oU+hn1PSr31RCxk
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test_macros.h: fix "too many arguments"
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2hpbGUgY2FsbGluZyBUU1RfRVhQX0ZEX1NJTEVOVCgpIGFuZCBUU1RfRVhQX1BJRF9TSUxFTlQo
KSwgdGhlaXIKZGVmaW5lZCBmdW5jdGlvbiBUU1RfRVhQX1BPU0lUSVZFXygpIHNob3VsZCBwYXNz
IGl0cyBTU0NBTEwgdG8KVFNUX0VYUF9QT1NJVElWRV9fKCksIGluc3RlYWQgb2YgY3JlYXRpbmcg
YSBuZXcgb25lLiAgVGhpcyBmaXggbWFrZXMKZXJyb3IgbWVzc2FnZSBsb29rIGNvcnJlY3QsIGFu
ZCBhbHNvIGNhbiBlbGltaW5hdGUgYnVpbGQgd2FybmluZ3MsIHN1Y2gKYXM6CgpkdXAzXzAxLmM6
NDM6ODM6IHdhcm5pbmc6IHRvbyBtYW55IGFyZ3VtZW50cyBmb3IgZm9ybWF0IFstV2Zvcm1hdC1l
eHRyYS1hcmdzXQogICA0MyB8ICAgICAgICAgVFNUX0VYUF9GRF9TSUxFTlQoZHVwMygxLCA0LCB0
Yy0+Y29lX2ZsYWcpLCAiZHVwMygxLCA0LCAlZCkiLCB0Yy0+Y29lX2ZsYWcpOwogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCi4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3RfbWFj
cm9zLmg6NDA6MzI6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8g4oCYVFNUX0ZNVF/igJkK
ICAgNDAgfCAjZGVmaW5lIFRTVF9GTVRfKEZNVCwgXzEsIC4uLikgRk1ULCAjI19fVkFfQVJHU19f
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fgouLi8uLi8uLi8uLi9p
bmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oOjQ0OjI2OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFj
cm8g4oCYVFNUXzJf4oCZCiAgIDQ0IHwgICAgICAgICAgICAgICAgIFRTVF9GTVRfKFRTVF8yXyhk
dW1teSwgIyNfX1ZBX0FSR1NfXywgU0NBTEwpIEZNVCwgX19WQV9BUkdTX18pKQogICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4KLi4vLi4vLi4vLi4vaW5jbHVkZS90c3RfdGVz
dF9tYWNyb3MuaDo2MToyNTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRTVF9NU0df
4oCZCiAgIDYxIHwgICAgICAgICAgICAgICAgICAgICAgICAgVFNUX01TR18oVEZBSUwgfCBUVEVS
Uk5PLCAiIGZhaWxlZCIsICAgICAgICAgICAgICAgICAgIFwKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fgouLi8uLi8uLi8uLi9pbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5o
Ojc4OjE3OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYVFNUX0VYUF9QT1NJVElWRV9f
4oCZCiAgIDc4IHwgICAgICAgICAgICAgICAgIFRTVF9FWFBfUE9TSVRJVkVfXyhTQ0FMTCwgI1ND
QUxMLCAjI19fVkFfQVJHU19fKTsgICAgICAgICAgICAgIFwKICAgICAgfCAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+Ci4uLy4uLy4uLy4uL2luY2x1ZGUvdHN0X3Rlc3RfbWFjcm9z
Lmg6OTQ6NDE6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhUU1RfRVhQX1BPU0lUSVZF
X+KAmQogICA5NCB8ICNkZWZpbmUgVFNUX0VYUF9GRF9TSUxFTlQoU0NBTEwsIC4uLikgICBUU1Rf
RVhQX1BPU0lUSVZFXyhTQ0FMTCwgI1NDQUxMLCAjI19fVkFfQVJHU19fKQogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgpkdXAz
XzAxLmM6NDM6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmFRTVF9FWFBfRkRfU0lM
RU5U4oCZCiAgIDQzIHwgICAgICAgICBUU1RfRVhQX0ZEX1NJTEVOVChkdXAzKDEsIDQsIHRjLT5j
b2VfZmxhZyksICJkdXAzKDEsIDQsICVkKSIsIHRjLT5jb2VfZmxhZyk7CiAgICAgIHwgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fgoKU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3ku
Zm5zdEBmdWppdHN1LmNvbT4KLS0tCiBpbmNsdWRlL3RzdF90ZXN0X21hY3Jvcy5oIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdHN0X3Rlc3RfbWFjcm9zLmggYi9pbmNsdWRlL3RzdF90ZXN0X21hY3Jv
cy5oCmluZGV4IGJkMGM0OTFjMS4uM2Y0ZjlmMTFkIDEwMDY0NAotLS0gYS9pbmNsdWRlL3RzdF90
ZXN0X21hY3Jvcy5oCisrKyBiL2luY2x1ZGUvdHN0X3Rlc3RfbWFjcm9zLmgKQEAgLTczLDkgKzcz
LDkgQEAgZXh0ZXJuIHZvaWQgKlRTVF9SRVRfUFRSOwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwK
IAl9IHdoaWxlICgwKQogCi0jZGVmaW5lIFRTVF9FWFBfUE9TSVRJVkVfKFNDQUxMLCAuLi4pICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAorI2RlZmluZSBUU1RfRVhQ
X1BPU0lUSVZFXyhTQ0FMTCwgU1NDQUxMLCAuLi4pICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwKIAkoeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwKLQkJVFNUX0VYUF9QT1NJVElWRV9fKFNDQUxMLCAj
U0NBTEwsICMjX19WQV9BUkdTX18pOyAgICAgICAgICAgICAgXAorCQlUU1RfRVhQX1BPU0lUSVZF
X18oU0NBTEwsIFNTQ0FMTCwgIyNfX1ZBX0FSR1NfXyk7ICAgICAgICAgICAgICBcCiAJCVRTVF9S
RVQ7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKIAl9KQogCi0tIAoyLjM0LjEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
