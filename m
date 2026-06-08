Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA710CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:34:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A8CB3E6F93
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 15:34:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FB703E2FBD
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:01:53 +0200 (CEST)
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B3536010E4
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 15:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=tOujf75ag3QZ2QrXgxIr0sStPibXPGJUB/K0E1F9Ric=; b=e
 Z80mcEf18C0BjD6LH6lf47yY++f3NQdTNvK7wZzyXOU1+38pw4xDwLV1V98jHPow
 qlp7PqO9ne+Izv3fX+L4+9SCb8vf6C2rQXERbCIjrI1IdT2MH+ryXDLCBnogOfxq
 guozm9+mtqq0c8w5We3p2WnbgXOa2mqMCT41WwcF8c=
Received: from lihao4869$yeah.net ( [240e:476:ff8f:1bb6:b015:cbf3:9389:7568]
 ) by ajax-webmail-wzpm-k8s-gz (Coremail) ; Mon, 8 Jun 2026 21:01:46 +0800
 (GMT+08:00)
X-Originating-IP: [240e:476:ff8f:1bb6:b015:cbf3:9389:7568]
Date: Mon, 8 Jun 2026 21:01:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: lihao4869 <lihao4869@yeah.net>
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) MailMasterIOS/7.25.13.2260_(26.5) Copyright (c)
 2002-2026 www.mailtech.cn yeah
X-CM-CTRLMSGS: 46rZz3RyYWNlQXR0Q250PTA=
X-NTES-SC: AL_Qu2TAvWZvE8r4CGbbekXm04Whec/UMW3vfkj2YNfNp80uirz1w8lVkJiEVXf2u2XGwectz+acR9z5/pHYoNiYr8OX/7+9vlcDrCU+NJQoLe+
MIME-Version: 1.0
Message-ID: <5fdb5657.6e2b.19ea7532b4b.Coremail.lihao4869@yeah.net>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wDnL946vSZqbxgGAA--.57416W
X-CM-SenderInfo: 5olkt0iuywmqh1hdxhhqhw/1tbiNBqh1momvTrBMAAA3j
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:52 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] Some question related LTP ftrace-stress-test
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

CgpIZWxsbywKICBJIG5vdGljZWQgdGhhdCBpbiB0aGUgTFRQIHRlc3QgY2FzZSBmdHJhY2Utc3Ry
ZXNzLXRlc3QsIHRoZSBzY3JpcHQgZnRyYWNlX3RyYWNlX3BpcGUuc2hpcyBleGVjdXRlZC4KICBJ
biB0aGUgc2Vjb25kIHdoaWxlIGxvb3AsIHRoZSB2YXJpYWJsZSB0aGlzX3BpZGlzIGFzc2lnbmVk
IHRoZSB2YWx1ZSAwLiBJcyB0aGlzIHJlYXNvbmFibGU/CiAgQmVjYXVzZSB3aGVuIHRoaXNfcGlk
IGlzIDAgYW5kIGZ0cmFjZV90cmFjZV9waXBlLnNoIHJlY2VpdmVzIGEgU0lHVVNSMSBzaWduYWws
IHRoZSB0cmFwcGVkIGhhbmRsZXIgd2lsbCBleGVjdXRlIGtpbGwgLUtJTEwgMCwgd2hpY2ggc2Vu
ZHMgU0lHS0lMTCB0byB0aGUgZW50aXJlIHByb2Nlc3MgZ3JvdXAuIEFzIGEgcmVzdWx0LCB0aGUg
cGFyZW50IHByb2Nlc3MgZnRyYWNlX3N0cmVzc190ZXN0LnNoIGlzIGtpbGxlZCwgdWx0aW1hdGVs
eSBjYXVzaW5nIHRoZSB0ZXN0IHRvIGZhaWwuCgoKc2NyaXB0IGlzIGFzIGZvbGxvd++8mgpraWxs
X3RoaXNfcGlkKCkKewogICAgICAgIGtpbGwgLUtJTEwgJHRoaXNfcGlkCiAgICAgICAgd2FpdCAk
dGhpc19waWQKICAgICAgICBleGl0IDAKfQoKCnRyYXAga2lsbF90aGlzX3BpZCBTSUdVU1IxCgoK
TE9PUD0yMAoKCndoaWxlIHRydWU7IGRvCiAgICAgICAgaT0wCiAgICAgICAgd2hpbGUgWyAkaSAt
bHQgJExPT1AgXTsgZG8KICAgICAgICAgICAgICAgIGNhdCAiJFRSQUNJTkdfUEFUSCIvdHJhY2Vf
cGlwZSA+IC9kZXYvbnVsbCAmCiAgICAgICAgICAgICAgICB0aGlzX3BpZD0kIQoKCiAgICAgICAg
ICAgICAgICB0c3Rfc2xlZXAgMjAwMDAwdXMKCgogICAgICAgICAgICAgICAga2lsbCAtSU5UICR0
aGlzX3BpZAogICAgICAgICAgICAgICAgd2FpdCAkdGhpc19waWQKCgogICAgICAgICAgICAgICAg
dGhpc19waWQ9MAoKCiAgICAgICAgICAgICAgICB0c3Rfc2xlZXAgMjAwMDAwdXMKCgogICAgICAg
ICAgICAgICAgaT0kKChpICsgMSkpCiAgICAgICAgZG9uZQogICAgICAgIHNsZWVwIDIKZG9uZQoK
Ckxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5LgoKCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
