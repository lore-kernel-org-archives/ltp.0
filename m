Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F85C52D7F
	for <ltp@archiver.kernel.org>; Sat, 17 Aug 2024 04:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ABA43D221C
	for <ltp@archiver.kernel.org>; Sat, 17 Aug 2024 06:44:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 664403C71B0
 for <ltp@lists.linux.it>; Sat, 17 Aug 2024 06:43:57 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 10D661400247
 for <ltp@lists.linux.it>; Sat, 17 Aug 2024 06:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=MNzaqDtIM5nv4ckvrNAFIrvvxuV4AUOhMNbT0oLxvbc=; b=X
 Jjs4jaxWpa+zWXW3E90btnwF8425wfgbgFfKTb0roh54a34L0MXGcsKmHLxwwX5n
 kcjVAKWljPudp8LKGcvlrLJGReTmA/+kUQGC53yvhWCi61vrZ6ZnHuNSOUzHL5N+
 OJhlowDJvYAy767H4As7uY71D+PaJRfK9BTbd4XlXY=
Received: from ice_yangxiao$163.com ( [160.86.227.245] ) by
 ajax-webmail-wmsvr-40-131 (Coremail) ; Sat, 17 Aug 2024 12:43:50 +0800
 (CST)
X-Originating-IP: [160.86.227.245]
Date: Sat, 17 Aug 2024 12:43:50 +0800 (CST)
From: =?UTF-8?B?5p2o5pmT?= <ice_yangxiao@163.com>
To: "Li Wang" <liwang@redhat.com>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAEemH2dZk3b2nxO7F87ag8XJiHqxvqr1u0eWv5nxwr59FkRpdQ@mail.gmail.com>
References: <20240816045342.185737-1-ice_yangxiao@163.com>
 <20240816045342.185737-2-ice_yangxiao@163.com>
 <CAEemH2dZk3b2nxO7F87ag8XJiHqxvqr1u0eWv5nxwr59FkRpdQ@mail.gmail.com>
X-NTES-SC: AL_Qu2ZAfSdtkAo5iGeYekfmkwaj+w9XcqwuPsm24BUOpp+jA/o/RodT3lnOVb69PuyMw+KuTyzbiZK9elLWblIQYQLax96iRBqc31N2Ww6TwMJ4w==
MIME-Version: 1.0
Message-ID: <3c1b35f2.140a.1915ea61c1c.Coremail.ice_yangxiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3H9KGKsBmhmUYAA--.2419W
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMx0+XmXAnPB3cQABsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] syscalls/mseal01.c: Use the correct "'" for
 JSON
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgoKCgpQdXNoZWQuIFRoYW5rcyBmb3IgeW91ciByZXZpZXcuCgoKCgoKQmVzdCBSZWdh
cmRzLAoKWGlhbyBZYW5nCgoKCgoKT24gMjAyNC0wOC0xNiAxNTowMTo1M++8jCJMaSBXYW5nIiA8
bGl3YW5nQHJlZGhhdC5jb20+IHdyb3Rl77yaCgoKCgoKT24gRnJpLCBBdWcgMTYsIDIwMjQgYXQg
MTI6NTTigK9QTSBYaWFvIFlhbmcgPGljZV95YW5neGlhb0AxNjMuY29tPiB3cm90ZToKCkZpeCB0
aGUgZm9sbG93aW5nIHdhcm5pbmdzIGZyb20gbWV0YWRhdGEvbWV0YXBhcnNlOgpkYXRhX3N0b3Jh
Z2UuaDozMjU6IFdBUk5JTkc6IGludmFsaWQgY2hhcmFjdGVyIGZvciBKU09OOiBmZmZmZmZlMgpk
YXRhX3N0b3JhZ2UuaDozMjU6IFdBUk5JTkc6IGludmFsaWQgY2hhcmFjdGVyIGZvciBKU09OOiBm
ZmZmZmY4MApkYXRhX3N0b3JhZ2UuaDozMjU6IFdBUk5JTkc6IGludmFsaWQgY2hhcmFjdGVyIGZv
ciBKU09OOiBmZmZmZmY5OQoKU2lnbmVkLW9mZi1ieTogWGlhbyBZYW5nIDxpY2VfeWFuZ3hpYW9A
MTYzLmNvbT4KCgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0t
LQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2VhbDAxLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jCmluZGV4IDYyY2ZkZDZhNi4uMDA0NTRhNzY2IDEw
MDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEuYworKysg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21zZWFsL21zZWFsMDEuYwpAQCAtMTYsNyArMTYs
NyBAQAogICogLSBtb2RpZnlpbmcgYSBWTUEgdmlhIG1tYXAoTUFQX0ZJWEVEKQogICogLSBtcHJv
dGVjdCgpIGFuZCBwa2V5X21wcm90ZWN0KCkKICAqIC0gZGVzdHJ1Y3RpdmUgbWFkdmljZSgpIGJl
aGF2aW9ycyAoZS5nLiBNQURWX0RPTlRORUVEKSBmb3IgYW5vbnltb3VzIG1lbW9yeSwKLSAqICAg
d2hlbiB1c2VycyBkb27igJl0IGhhdmUgd3JpdGUgcGVybWlzc2lvbiB0byB0aGUgbWVtb3J5Cisg
KiAgIHdoZW4gdXNlcnMgZG9uJ3QgaGF2ZSB3cml0ZSBwZXJtaXNzaW9uIHRvIHRoZSBtZW1vcnkK
ICAqCiAgKiBBbnkgb2YgdGhlIGRlc2NyaWJlZCBhY3Rpb25zIGlzIHJlY29nbml6ZWQgdmlhIEVQ
RVJNIGVycm5vLgogICoKLS0KMi40NS4yCgoKLS0KTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCgoKCgoKLS0KClJlZ2FyZHMsCgpMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
