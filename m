Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE6BC5478C
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709026280; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=XlrZN69CtzLbq9WzQ/MzW3xnAwLPGm6Q0KGvMjDLjAE=;
 b=mPqkyUbl0zJdcG54odaK6XhgSynLGQ9XxBemZsLO8Yucwxki1a0H3/xGi9QJcBgTgM1i8
 bSOfOu8DRQYScymFLHTNJ+lonJatXSXEimXRHfOg+gtWzkk1UCOnxvNycVFur6NXUGf70sp
 7a28/90reCIi1l48WvpC8WKv5yv/M+w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161683CEFBD
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 10:31:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F0673CC68D
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 10:30:58 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F8361002032
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 10:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1709026257; x=1740562257;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=iOLUvd77ipDS0wo83BCbwdvB+ooZXoGd162Zlxfc6FA=;
 b=tX8UZQVfODQ7VLHBS6Y4HJ1yMeCx/88iKveBzZdFY3nexrPbfcRck/yR
 rpsgYS0KL/bhzM6/qz0mMcL7dRG8JLnmncdI/9Rx3SFwJLAmVVAO8uI5S
 eRRbBvA2TY8n7yLFnte81H8EfrwjLNiQsM59/Flr/wRKUolSKmXVB0Zdq
 9s7LcVzMYTTipOxArHvOHKXXk4qw+v4vZb5xD1a0tgbI15v5L5v0Gwev3
 6qje5SIP5ljhuWa//c1y3abGnpkhrxLVgJsfsdC3sowUm22SgOXrlmWG/
 xYuyvnDKnpZhHp0G2scPONTj05HsLUqJ/MTS7d7r1lbzRoeiCEXiLm2Xv w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="138176486"
X-IronPort-AV: E=Sophos;i="6.06,187,1705330800"; d="scan'208";a="138176486"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 18:30:53 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 481F2E8CC1
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 18:30:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EBDB141D9
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 18:30:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 247466BE50
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 18:30:50 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id B17181A006A
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 17:30:49 +0800 (CST)
Message-ID: <d6d0557e-6c11-4678-8f4a-ab8ec65a7fa4@fujitsu.com>
Date: Tue, 27 Feb 2024 17:30:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240126062540.2596279-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20240126062540.2596279-1-ruansy.fnst@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28216.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28216.006
X-TMASE-Result: 10--9.774200-10.000000
X-TMASE-MatchedRID: XCX1jWV9QFOPvrMjLFD6eHchRkqzj/bEt3aeg7g/usDfUZT83lbkED13
 GoPFA1HFIvrftAIhWmLP85tlrdTfE4+kj9iRsuif7TovvZPhLcB1zSnwpu89bft9kl8N0Ihcj3d
 ZSyALReJZZO2km095FRza9vQBPvMp2FMcgddyBa+RgPzABkqxIJ+Z30eyNnRTTPm/MsQarwO+Yp
 N3FsaosnsxI/tIum4Yz72Gwe3KfEeVJ1qZ2q4yfL0dPFETpBAHsnK72MaPSqdP3Eb4+bLT+qOsi
 KS3awH4gcDogF3e9CxXNicS/yg1bT+7nvNv6fe6dXu122+iJtr+8VJw3WmYLGtEzrC9eANpfScD
 ttuEn50Zzt4lZ/HlzYXOTE0Q3bSbbBgnprrOG6aeAiCmPx4NwFkMvWAuahr8AsMBg/gBdVHudjn
 WXAurTyAHAopEd76vq/eCYvQluERoiuA1DT1woMwKlWxq+BwHCqwltTVKecVehCX/iwYY3A==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Subject: Re: [LTP] [PATCH 1/2] fchownat01: Convert to new API
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

cGluZwoK5ZyoIDIwMjQvMS8yNiAxNDoyNSwgU2hpeWFuZyBSdWFuIOWGmemBkzoKPiBTaWduZWQt
b2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPgo+IC0tLQo+ICAg
Li4uL2tlcm5lbC9zeXNjYWxscy9mY2hvd25hdC9mY2hvd25hdDAxLmMgICAgIHwgMTU0ICsrKysr
Ky0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyksIDEwNSBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
Y2hvd25hdC9mY2hvd25hdDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjaG93bmF0
L2ZjaG93bmF0MDEuYwo+IGluZGV4IDc3NzFjMTExYS4uMWE1YjY2ZDk5IDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmNob3duYXQvZmNob3duYXQwMS5jCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY2hvd25hdC9mY2hvd25hdDAxLmMKPiBAQCAtMSwx
MzMgKzEsNzcgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKPiAgIC8qCj4gLSAqICAgQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1h
Y2hpbmVzICBDb3JwLiwgMjAwNgo+IC0gKiAgIEFVVEhPUjogWWkgWWFuZyA8eXlhbmdjZGxAY24u
aWJtLmNvbT4KPiAtICoKPiAtICogICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKPiAtICogICBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQo+
IC0gKiAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2Yg
dGhlIExpY2Vuc2UsIG9yCj4gLSAqICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lv
bi4KPiAtICoKPiAtICogICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKPiAtICogICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7
ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKPiAtICogICBNRVJDSEFOVEFC
SUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKPiAtICogICB0
aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KPiAtICoKPiAt
ICogICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZQo+IC0gKiAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3
cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLAo+IC0gKiAgIEluYy4sIDUxIEZy
YW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EKPiAr
ICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwg
MjAwNgo+ICsgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAwNy0yMDI0Cj4g
ICAgKi8KPiAtLyoKPiAtICogREVTQ1JJUFRJT04KPiAtICoJVGhpcyB0ZXN0IGNhc2Ugd2lsbCB2
ZXJpZnkgYmFzaWMgZnVuY3Rpb24gb2YgZmNob3duYXQKPiAtICoJYWRkZWQgYnkga2VybmVsIDIu
Ni4xNiBvciB1cC4KPiArCj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4gKyAqCj4gKyAqIFZl
cmlmeSBiYXNpYyBmdW5jdGlvbiBvZiBmY2hvd25hdCgpIGFkZGVkIGJ5IGtlcm5lbCAyLjYuMTYg
b3IgdXAuCj4gICAgKi8KPiAgIAo+ICAgI2RlZmluZSBfR05VX1NPVVJDRQo+IC0KPiAtI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgo+IC0jaW5jbHVkZSA8c3lzL3N0YXQuaD4KPiAtI2luY2x1ZGUgPHVu
aXN0ZC5oPgo+IC0jaW5jbHVkZSA8c3RkbGliLmg+Cj4gLSNpbmNsdWRlIDxlcnJuby5oPgo+IC0j
aW5jbHVkZSA8c3RyaW5nLmg+Cj4gLSNpbmNsdWRlIDxzaWduYWwuaD4KPiAtCj4gLSNpbmNsdWRl
ICJ0ZXN0LmgiCj4gLSNpbmNsdWRlICJzYWZlX21hY3Jvcy5oIgo+IC0jaW5jbHVkZSAibGFwaS9m
Y250bC5oIgo+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiAgIAo+ICAgI2RlZmluZSBURVNURklM
RQkidGVzdGZpbGUiCj4gLQo+IC1zdGF0aWMgdm9pZCBzZXR1cCh2b2lkKTsKPiAtc3RhdGljIHZv
aWQgY2xlYW51cCh2b2lkKTsKPiArI2RlZmluZSBURVNURklMRTIJInRlc3RmaWxlMiIKPiAgIAo+
ICAgc3RhdGljIGludCBkaXJfZmQ7Cj4gICBzdGF0aWMgaW50IGZkOwo+ICAgc3RhdGljIGludCBu
b19mZCA9IC0xOwo+ICAgc3RhdGljIGludCBjdV9mZCA9IEFUX0ZEQ1dEOwo+ICAgCj4gLXN0YXRp
YyBzdHJ1Y3QgdGVzdF9jYXNlX3Qgewo+ICtzdGF0aWMgc3RydWN0IHRjYXNlIHsKPiAgIAlpbnQg
ZXhwX3JldDsKPiAgIAlpbnQgZXhwX2Vycm5vOwo+ICAgCWludCBmbGFnOwo+IC0JaW50ICpmZHM7
Cj4gLQljaGFyICpmaWxlbmFtZXM7Cj4gLX0gdGVzdF9jYXNlc1tdID0gewo+IC0JezAsIDAsIDAs
ICZkaXJfZmQsIFRFU1RGSUxFfSwKPiAtCXstMSwgRU5PVERJUiwgMCwgJmZkLCBURVNURklMRX0s
Cj4gLQl7LTEsIEVCQURGLCAwLCAmbm9fZmQsIFRFU1RGSUxFfSwKPiAtCXstMSwgRUlOVkFMLCA5
OTk5LCAmZGlyX2ZkLCBURVNURklMRX0sCj4gLQl7MCwgMCwgMCwgJmN1X2ZkLCBURVNURklMRX0s
Cj4gKwlpbnQgKmZkOwo+ICsJY2hhciAqZmlsZW5hbWU7Cj4gK30gdGNhc2VzW10gPSB7Cj4gKwl7
IDAsIDAsIDAsICZkaXJfZmQsIFRFU1RGSUxFIH0sCj4gKwl7IDAsIDAsIDAsICZjdV9mZCwgVEVT
VEZJTEUgfSwKPiArCXsgLTEsIEVOT1RESVIsIDAsICZmZCwgVEVTVEZJTEUgfSwKPiArCXsgLTEs
IEVCQURGLCAwLCAmbm9fZmQsIFRFU1RGSUxFIH0sCj4gKwl7IC0xLCBFSU5WQUwsIDk5OTksICZk
aXJfZmQsIFRFU1RGSUxFIH0sCj4gICB9Owo+ICAgCj4gLWNoYXIgKlRDSUQgPSAiZmNob3duYXQw
MSI7Cj4gLWludCBUU1RfVE9UQUwgPSBBUlJBWV9TSVpFKHRlc3RfY2FzZXMpOwo+IC1zdGF0aWMg
dm9pZCBmY2hvd25hdF92ZXJpZnkoY29uc3Qgc3RydWN0IHRlc3RfY2FzZV90ICopOwo+IC0KPiAt
aW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpCj4gK3N0YXRpYyB2b2lkIGZjaG93bmF0X3Zlcmlm
eSh1bnNpZ25lZCBpbnQgbikKPiAgIHsKPiAtCWludCBsYzsKPiAtCWludCBpOwo+IC0KPiAtCXRz
dF9wYXJzZV9vcHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Cj4gLQo+IC0Jc2V0dXAoKTsKPiAtCj4g
LQlmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgbGMrKykgewo+IC0JCXRzdF9jb3VudCA9
IDA7Cj4gLQkJZm9yIChpID0gMDsgaSA8IFRTVF9UT1RBTDsgaSsrKQo+IC0JCQlmY2hvd25hdF92
ZXJpZnkoJnRlc3RfY2FzZXNbaV0pOwo+IC0JfQo+IC0KPiAtCWNsZWFudXAoKTsKPiAtCXRzdF9l
eGl0KCk7Cj4gKwlzdHJ1Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1tuXTsKPiArCXVpZF90IGV1aWQg
PSBnZXRldWlkKCk7Cj4gKwlnaWRfdCBlZ2lkID0gZ2V0ZWdpZCgpOwo+ICsJaW50IGZkID0gKnRj
LT5mZDsKPiArCWludCBmbGFnID0gdGMtPmZsYWc7Cj4gKwljb25zdCBjaGFyICpmaWxlbmFtZSA9
IHRjLT5maWxlbmFtZTsKPiArCj4gKwlpZiAodGMtPmV4cF9yZXQgPT0gMCkKPiArCQlUU1RfRVhQ
X1BBU1MoZmNob3duYXQoZmQsIGZpbGVuYW1lLCBldWlkLCBlZ2lkLCBmbGFnKSwKPiArCQkJICAg
ICAiZmNob3duYXQoJWQsICVzLCAlZCwgJWQsICVkKSIsCj4gKwkJCSAgICAgZmQsIGZpbGVuYW1l
LCBldWlkLCBlZ2lkLCBmbGFnKTsKPiArCWVsc2UKPiArCQlUU1RfRVhQX0ZBSUwoZmNob3duYXQo
ZmQsIGZpbGVuYW1lLCBldWlkLCBlZ2lkLCBmbGFnKSwKPiArCQkJICAgICB0Yy0+ZXhwX2Vycm5v
LAo+ICsJCQkgICAgICJmY2hvd25hdCglZCwgJXMsICVkLCAlZCwgJWQpIiwKPiArCQkJICAgICBm
ZCwgZmlsZW5hbWUsIGV1aWQsIGVnaWQsIGZsYWcpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9p
ZCBzZXR1cCh2b2lkKQo+ICAgewo+IC0JdHN0X3NpZyhOT0ZPUkssIERFRl9IQU5ETEVSLCBjbGVh
bnVwKTsKPiAtCj4gLQlURVNUX1BBVVNFOwo+IC0KPiAtCXRzdF90bXBkaXIoKTsKPiAtCj4gLQlk
aXJfZmQgPSBTQUZFX09QRU4oY2xlYW51cCwgIi4vIiwgT19ESVJFQ1RPUlkpOwo+IC0KPiAtCVNB
RkVfVE9VQ0goY2xlYW51cCwgVEVTVEZJTEUsIDA2MDAsIE5VTEwpOwo+IC0KPiAtCWZkID0gU0FG
RV9PUEVOKGNsZWFudXAsICJ0ZXN0ZmlsZTIiLCBPX0NSRUFUIHwgT19SRFdSLCAwNjAwKTsKPiAt
fQo+IC0KPiAtc3RhdGljIHZvaWQgZmNob3duYXRfdmVyaWZ5KGNvbnN0IHN0cnVjdCB0ZXN0X2Nh
c2VfdCAqdGVzdCkKPiAtewo+IC0JVEVTVChmY2hvd25hdCgqKHRlc3QtPmZkcyksIHRlc3QtPmZp
bGVuYW1lcywgZ2V0ZXVpZCgpLAo+IC0JCSAgICAgIGdldGVnaWQoKSwgdGVzdC0+ZmxhZykpOwo+
IC0KPiAtCWlmIChURVNUX1JFVFVSTiAhPSB0ZXN0LT5leHBfcmV0KSB7Cj4gLQkJdHN0X3Jlc20o
VEZBSUwgfCBUVEVSUk5PLAo+IC0JCQkgImZjaG93bmF0KCkgcmV0dXJuZWQgJWxkLCBleHBlY3Rl
ZCAlZCwgZXJybm89JWQiLAo+IC0JCQkgVEVTVF9SRVRVUk4sIHRlc3QtPmV4cF9yZXQsIHRlc3Qt
PmV4cF9lcnJubyk7Cj4gLQkJcmV0dXJuOwo+IC0JfQo+IC0KPiAtCWlmIChURVNUX0VSUk5PID09
IHRlc3QtPmV4cF9lcnJubykgewo+IC0JCXRzdF9yZXNtKFRQQVNTIHwgVFRFUlJOTywKPiAtCQkJ
ICJmY2hvd25hdCgpIHJldHVybmVkIHRoZSBleHBlY3RlZCBlcnJubyAlZDogJXMiLAo+IC0JCQkg
dGVzdC0+ZXhwX3JldCwgc3RyZXJyb3IodGVzdC0+ZXhwX2Vycm5vKSk7Cj4gLQl9IGVsc2Ugewo+
IC0JCXRzdF9yZXNtKFRGQUlMIHwgVFRFUlJOTywKPiAtCQkJICJmY2hvd25hdCgpIGZhaWxlZCB1
bmV4cGVjdGVkbHk7IGV4cGVjdGVkOiAlZCAtICVzIiwKPiAtCQkJIHRlc3QtPmV4cF9lcnJubywg
c3RyZXJyb3IodGVzdC0+ZXhwX2Vycm5vKSk7Cj4gLQl9Cj4gKwlkaXJfZmQgPSBTQUZFX09QRU4o
Ii4vIiwgT19ESVJFQ1RPUlkpOwo+ICsJU0FGRV9UT1VDSChURVNURklMRSwgMDYwMCwgTlVMTCk7
Cj4gKwlmZCA9IFNBRkVfT1BFTihURVNURklMRTIsIE9fQ1JFQVQgfCBPX1JEV1IsIDA2MDApOwo+
ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4gICB7Cj4gLQlpZiAoZmQg
PiAwKQo+IC0JCWNsb3NlKGZkKTsKPiAtCj4gLQlpZiAoZGlyX2ZkID4gMCkKPiAtCQljbG9zZShk
aXJfZmQpOwo+IC0KPiAtCXRzdF9ybWRpcigpOwo+ICsJU0FGRV9DTE9TRShmZCk7Cj4gKwlTQUZF
X0NMT1NFKGRpcl9mZCk7Cj4gICB9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3Qg
PSB7Cj4gKwkubmVlZHNfdG1wZGlyID0gMSwKPiArCS50ZXN0ID0gZmNob3duYXRfdmVyaWZ5LAo+
ICsJLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksCj4gKwkuc2V0dXAgPSBzZXR1cCwKPiArCS5j
bGVhbnVwID0gY2xlYW51cCwKPiArfTsKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
