Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5520CD1296
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 06:54:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED4E33CE713
	for <ltp@archiver.kernel.org>; Fri,  5 Apr 2024 08:54:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B7E13C19E8
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 08:54:03 +0200 (CEST)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id CBD8260138B
 for <ltp@lists.linux.it>; Fri,  5 Apr 2024 08:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
 Message-ID; bh=r6XZ99k7dYwRq94Uds4nYi4HkhfvIRNyN6/dWBKgzxM=; b=V
 eFrwBhNgB7HLGf7LN0gDKUIX+5F9mEBPMT1bOgO/TnnMxYK3DR/7q3dL7bDdpeID
 mWoUxOV41S2ZFyl56cGxi4tX1uSCIv5cAuWMgqdR9th2AWEmQIqMbcB6wxBqdIlF
 zvisUlMenu8RdQNGaBEt3R4j692kX7LkZ5+auZZiSs=
Received: from yangfeng59949$163.com ( [113.244.168.159] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Fri, 5 Apr 2024 14:53:55 +0800 (CST)
X-Originating-IP: [113.244.168.159]
Date: Fri, 5 Apr 2024 14:53:55 +0800 (CST)
From: yangfeng59949 <yangfeng59949@163.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240404135323.GB526878@pevik>
References: <20240329154715.7130-1-yangfeng59949@163.com>
 <20240404135323.GB526878@pevik>
MIME-Version: 1.0
Message-ID: <386395b4.21c5.18ead090cbb.Coremail.yangfeng59949@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3v68DoA9mbOgAAA--.11945W
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTgK2eGVOCIG0+gABsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sctp: bugfix for
 utils/sctp/func_tests/test_1_to_1_events.c
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
Cc: yangfeng <yangfeng@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksPGJyLz5UaGFua3MgZm9yIGdldHRpbmcgYmFjayB0byBtZS48YnIvPjxici8+Z2NjIChHQ0Mp
IDcuMy4wPGJyLz5MaW51eCBsb2NhbGhvc3QubG9jYWxkb21haW4gNC4xOS45MC04OS42LnYyNDAx
Lmt5MTAuYWFyY2g2NCAjMSBTTVAgVGh1IE1hciAxNCAyMDowNjoxMCBDU1QgMjAyNCBhYXJjaDY0
IGFhcmNoNjQgYWFyY2g2NCBHTlUvTGludXg8YnIvPk1hbnVmYWN0dXJlcnMgSUSjuiAgICAgICAg
ICAgICAgICAgICBIaVNpbGljb248YnIvPkJJT1MgVmVuZG9yIElEOiAgICAgICAgICAgICAgICAg
ICAgICAgIFFFTVU8YnIvPk1vZGVsIG5hbWWjuiAgICAgICAgICAgICAgICAgICAgICAgICAgS3Vu
cGVuZy05MjA8YnIvPkJJT1MgTW9kZWwgbmFtZTogICAgICAgICAgICAgICAgICAgIHZpcnQtNC4x
PGJyLz48YnIvPktpbmQgcmVnYXJkcyw8YnIvPnlhbmdmZW5nCkF0IDIwMjQtMDQtMDQgMjE6NTM6
MjMsICJQZXRyIFZvcmVsIiA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+SGksDQo+DQo+PiBldmVu
dCBub3QgaW5pdGlhbGl6ZWQgdG8gMCBjYXVzZXMgIkdvdCBhIG5vdGlmaWNhdGlvbiwNCj4+IGV4
cGVjdGluZyBhIGRhdGFtc2ciIGlzc3Vlcw0KPg0KPk91dCBvZiBjdXJpb3NpdHkgd2hpY2ggYXJj
aGl0ZWN0dXJlLCBrZXJuZWwgdmVyc2lvbiwgdG9vbGNoYWluIHZlcnNpb24gYW5kDQo+ZGlzdHJv
IGRvIHlvdSBzZWUgdGhlIGlzc3VlPyBJIGNhbm5vdCByZXByb2R1Y2UgaXQgb24gYW55IG9mIHN5
c3RlbXMgd2UgdGVzdC4NCj4NCj4uLi4NCj4+ICsrKyBiL3V0aWxzL3NjdHAvZnVuY190ZXN0cy90
ZXN0XzFfdG9fMV9ldmVudHMuYw0KPj4gQEAgLTk2LDYgKzk2LDcgQEAgbWFpbih2b2lkKQ0KPj4g
IAkvKiBDcmVhdGUgdGhlIGNsaWVudCBzb2NrZXQuICAqLw0KPj4gIAljbHRfc2sgPSB0ZXN0X3Nv
Y2tldChBRl9JTkVULCBTT0NLX1NUUkVBTSwgSVBQUk9UT19TQ1RQKTsNCj4NCj4+ICsJbWVtc2V0
KCZldmVudCwgMCwgc2l6ZW9mKHN0cnVjdCBzY3RwX2V2ZW50X3N1YnNjcmliZSkpOw0KPg0KPk9i
dmlvdXNseSBjb3JyZWN0Lg0KPg0KPlJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4NCj4NCj5Ob3RlLCBub3dhZGF5cyBpdCdkIGJlIGVub3VnaCB0byBpbml0aWFsaXplIGFz
Og0KPg0KPnN0cnVjdCBzY3RwX2V2ZW50X3N1YnNjcmliZSBldmVudCA9IHswfTsNCj4NCj5CdXQg
YmVjYXVzZSB3ZSB1c2UgdGhlIG9sZCBzdHlsZSB3aXRoIHRoZSByZXN0IG9mIHRoZSBmdW5jdGlv
bnMsIG1lbXNldCgpIGlzIE9LLg0KPg0KPktpbmQgcmVnYXJkcywNCj5QZXRyDQoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
