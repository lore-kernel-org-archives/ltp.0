Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D752FC02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737525132; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=TwjwqGLWzBW8AEIkBiU9/LqEumc342mr9jKlMV5yVBQ=;
 b=cXNTrHO7Ps9nfksW8rc61fEGcZpHGzzXwKbaZqMLsIDwsmt0sa0RxnLud/biTbFSYKeYS
 gel0nJsW7IhHAaK6rwSgSPTfNxMxl13fyBMAJ+inoIyqnBwxg77dFCva+QlSlEjkzi3zb3f
 fT6dsRhx/71dd6swT8gO/tV9M0BSbWE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40EFA3C2CF0
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 06:52:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446243C2C40
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 06:51:51 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 608EE642088
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 06:51:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737525111; x=1769061111;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=T1JiXHleznc2sYXjQn9ENb1glSLM4ZBnOhJM+sWNqeU=;
 b=gxNZ8M1jG5TkDDcahBNYOUiMLwN4+FdMsBlyXCFAYKe8Z4+59pMNv4iQ
 +qoiT/zl8+eaYJvci1rFeanrjZSJ9dmSk7U5tYNLI5UDAzy58CP0EJ8Oc
 GxWtoki3zayJrLJr3eyuzk4x0wint25LMjJnuaUIXJLqm6H97e3lahWLv
 1sT8qExJOfI6J4Gh3OPOaAQCY0Nam9+d7wuKVBzk/fcesG9gQiai+2vkX
 zb8nauS/TzyvoWtqKh7UBhpW5BnvhgmPX6gljOSldt/7XeQXJCgFs8O9E
 Z8vXXwxriAU0K/g2jY1l9reWL4KGsRtoJQ8lDzlC9Mq/rP+UR8eKCsYAk g==;
X-CSE-ConnectionGUID: UvMBHHOdQlSnK4pigKTLNQ==
X-CSE-MsgGUID: 8MRBnDlkS9CCYElplAFgww==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="186539834"
X-IronPort-AV: E=Sophos;i="6.13,224,1732546800"; d="scan'208";a="186539834"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 14:51:47 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com
 [192.168.83.66])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 00E45D4F43
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:51:45 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B86CF144F6
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:51:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3345A7BFAE
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 14:51:44 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 82F2E1A000B;
 Wed, 22 Jan 2025 13:51:43 +0800 (CST)
Message-ID: <42ef31cf-df74-44fb-83ee-bdbdd32cf7c4@fujitsu.com>
Date: Wed, 22 Jan 2025 13:51:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, andrea.cervesato@suse.com, pvorel@suse.cz
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28938.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28938.005
X-TMASE-Result: 10--16.795600-10.000000
X-TMASE-MatchedRID: apohXHlrmwePvrMjLFD6eHchRkqzj/bEC/ExpXrHizxYC5LPd7BvbZWI
 He6lXpDN0qyKcKgAqX4dFyZVU7BLG8aZnhgjGx37HWRJEfGP5nmlY4F8r0vXPwMFD5cGHhglkYd
 nzk6dz7bBo6qhB6MT9ntDSez43O/RcXyA8CxIt6GqFx2c/3V5cUyQ5fRSh265wLkNMQzGl5DfZL
 rUlw8Hxx0Dxc9hDIBQwuG7EB5IaS+TReo2rNvq+HzmmMD/HXF+82SgwNf6SK4wAYdq1VTXowYBt
 xnUC0owrbrumMUoE/98AX8i9OoygK9+M8Cl8ZiBbTdhrAcm88LA10GlIGdlLNWM2x6EZ/S9BCKn
 2rDvKLdZ7eVi3CkHD+vbgxb5qGOHrVSkkKFNk8GlJdWkFL6KVo5UafLmrvaGPM1GpA31IisRRLf
 e6UPgvJIDpnANBdZHE9PhZaJeNjOOrUPm9PNUUoanR/CvYO8Xw77CRCdy4LxJYgLrWYroW33Yvt
 P37IU49kqj5hJ6BqWdqC2fLtk9xL9ZdlL8eonaRjjVhf+j/woNlf30fAUOwiq2rl3dzGQ1DBbGv
 tcMofyPmrZM87i3iuFenuRTp/UwkC67LftSD2J7WrW53ECCzm79Fyv62GRf
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] fchownat01: Convert to new API
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

cGluZ34KCuWcqCAyMDI1LzEvMTYgMTY6NDAsIFNoaXlhbmcgUnVhbiDlhpnpgZM6Cj4gMS4gY29u
dmVydCB0byBuZXcgQVBJCj4gMi4gbW92ZSBlcnJvciB0ZXN0cyB0byBmY2hvd25hdDAzCj4gMy4g
Y2hlY2sgaWYgdWlkL2dpZCBpcyBjb3JyZWN0bHkgc2V0Cj4gCj4gU2lnbmVkLW9mZi1ieTogU2hp
eWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4KPiAKPiAtLS0KPiBWMjogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwMTE1MDkxMjE4LjI2MzA4OTEtMS1ydWFuc3kuZm5z
dEBmdWppdHN1LmNvbS8KPiAKPiBDaGFuZ2VzOgo+ICAgKiBJbml0aWFsaXplIGZkIHRvIC0xLCBh
bmQgY2hlY2sgZmQgIT0gLTEgd2hlbiBjbGVhbnVwCj4gICAqIERvIG5vdCB1c2UgVFNUXypfU0lM
RU5UKCkKPiAgICogZmNob3duYXQwMTogZGVzY3JpYmUgd2hhdCB0aGlzIGNhc2UgZG9lcyBpbiBE
RVNDUklQVElPTgo+ICAgKiBmY2hvd25hdDAxOiB1c2UgVFNUX0VYUF9FUV9MSSgpOyBkbyBub3Qg
dXNlIHRlc3QgY2FzZSBzdHJ1Y3QKPiAgICogZmNob3duYXQwMjogdXNlIFRTVF9FWFBfRVhQUigp
Cj4gICAqIGZjaG93bmF0MDM6IHdyaXRlIGEgcHJvcGVyIGNvbW1pdCBtZXNzYWdlLCBhZGQgbW9y
ZSBlcnJub3MgdG8gdGVzdAo+IAo+IC0tLQo+ICAgLi4uL2tlcm5lbC9zeXNjYWxscy9mY2hvd25h
dC9mY2hvd25hdDAxLmMgICAgIHwgMTUzICsrKysrLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDExMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mY2hvd25hdC9mY2hvd25hdDAxLmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZjaG93bmF0L2ZjaG93bmF0MDEuYwo+IGluZGV4IDc3NzFj
MTExYS4uZmVkY2I4YWIyIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmNob3duYXQvZmNob3duYXQwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
Y2hvd25hdC9mY2hvd25hdDAxLmMKPiBAQCAtMSwxMzMgKzEsNjQgQEAKPiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiAgIC8qCj4gLSAqICAgQ29weXJpZ2h0
IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwNgo+IC0gKiAg
IEFVVEhPUjogWWkgWWFuZyA8eXlhbmdjZGxAY24uaWJtLmNvbT4KPiAtICoKPiAtICogICBUaGlz
IHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9v
ciBtb2RpZnkKPiAtICogICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1
YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQo+IC0gKiAgIHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCj4gLSAqICAgKGF0
IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KPiAtICoKPiAtICogICBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKPiAt
ICogICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQg
d2FycmFudHkgb2YKPiAtICogICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuICBTZWUKPiAtICogICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy4KPiAtICoKPiAtICogICBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2
ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQo+IC0gKiAgIGFsb25n
IHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLAo+IC0gKiAgIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3Is
IEJvc3RvbiwgTUEgMDIxMTAtMTMwMSBVU0EKPiArICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlv
bmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwNgo+ICsgKiBDb3B5cmlnaHQgKGMpIExp
bnV4IFRlc3QgUHJvamVjdCwgMjAwNy0yMDI1Cj4gICAgKi8KPiAtLyoKPiAtICogREVTQ1JJUFRJ
T04KPiAtICoJVGhpcyB0ZXN0IGNhc2Ugd2lsbCB2ZXJpZnkgYmFzaWMgZnVuY3Rpb24gb2YgZmNo
b3duYXQKPiAtICoJYWRkZWQgYnkga2VybmVsIDIuNi4xNiBvciB1cC4KPiArCj4gKy8qXAo+ICsg
KiBbRGVzY3JpcHRpb25dCj4gKyAqCj4gKyAqIFZlcmlmeSB0aGF0IGZjaG93bmF0KCkgc3VjY2Vl
ZHMgdG8gY2hhbmdlIGZpbGUncyBvd25lcnNoaXAgaWYgdGhlIGZpbGUKPiArICogZGVzY3JpcHRv
ciBpcyBBVF9GRENXRCBvciBzZXQgYnkgb3BlbmluZyBhIGRpcmVjdG9yeS4KPiAgICAqLwo+ICAg
Cj4gICAjZGVmaW5lIF9HTlVfU09VUkNFCj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICAgCj4g
LSNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPiAtI2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cj4gLSNpbmNs
dWRlIDx1bmlzdGQuaD4KPiAtI2luY2x1ZGUgPHN0ZGxpYi5oPgo+IC0jaW5jbHVkZSA8ZXJybm8u
aD4KPiAtI2luY2x1ZGUgPHN0cmluZy5oPgo+IC0jaW5jbHVkZSA8c2lnbmFsLmg+Cj4gLQo+IC0j
aW5jbHVkZSAidGVzdC5oIgo+IC0jaW5jbHVkZSAic2FmZV9tYWNyb3MuaCIKPiAtI2luY2x1ZGUg
ImxhcGkvZmNudGwuaCIKPiArI2RlZmluZSBURVNURklMRTEJInRlc3RmaWxlMSIKPiArI2RlZmlu
ZSBURVNURklMRTIJInRlc3RmaWxlMiIKPiAgIAo+IC0jZGVmaW5lIFRFU1RGSUxFCSJ0ZXN0Zmls
ZSIKPiArc3RhdGljIHVpZF90IHNldF91aWQgPSAxMDAwOwo+ICtzdGF0aWMgZ2lkX3Qgc2V0X2dp
ZCA9IDEwMDA7Cj4gK3N0YXRpYyBpbnQgZGlyX2ZkID0gLTE7Cj4gICAKPiAtc3RhdGljIHZvaWQg
c2V0dXAodm9pZCk7Cj4gLXN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCk7Cj4gLQo+IC1zdGF0aWMg
aW50IGRpcl9mZDsKPiAtc3RhdGljIGludCBmZDsKPiAtc3RhdGljIGludCBub19mZCA9IC0xOwo+
IC1zdGF0aWMgaW50IGN1X2ZkID0gQVRfRkRDV0Q7Cj4gLQo+IC1zdGF0aWMgc3RydWN0IHRlc3Rf
Y2FzZV90IHsKPiAtCWludCBleHBfcmV0Owo+IC0JaW50IGV4cF9lcnJubzsKPiAtCWludCBmbGFn
Owo+IC0JaW50ICpmZHM7Cj4gLQljaGFyICpmaWxlbmFtZXM7Cj4gLX0gdGVzdF9jYXNlc1tdID0g
ewo+IC0JezAsIDAsIDAsICZkaXJfZmQsIFRFU1RGSUxFfSwKPiAtCXstMSwgRU5PVERJUiwgMCwg
JmZkLCBURVNURklMRX0sCj4gLQl7LTEsIEVCQURGLCAwLCAmbm9fZmQsIFRFU1RGSUxFfSwKPiAt
CXstMSwgRUlOVkFMLCA5OTk5LCAmZGlyX2ZkLCBURVNURklMRX0sCj4gLQl7MCwgMCwgMCwgJmN1
X2ZkLCBURVNURklMRX0sCj4gLX07Cj4gLQo+IC1jaGFyICpUQ0lEID0gImZjaG93bmF0MDEiOwo+
IC1pbnQgVFNUX1RPVEFMID0gQVJSQVlfU0laRSh0ZXN0X2Nhc2VzKTsKPiAtc3RhdGljIHZvaWQg
ZmNob3duYXRfdmVyaWZ5KGNvbnN0IHN0cnVjdCB0ZXN0X2Nhc2VfdCAqKTsKPiAtCj4gLWludCBt
YWluKGludCBhYywgY2hhciAqKmF2KQo+ICtzdGF0aWMgdm9pZCBmY2hvd25hdF92ZXJpZnkodm9p
ZCkKPiAgIHsKPiAtCWludCBsYzsKPiAtCWludCBpOwo+ICsJc3RydWN0IHN0YXQgc3RhdF9idWY7
Cj4gICAKPiAtCXRzdF9wYXJzZV9vcHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Cj4gKwlUU1RfRVhQ
X1BBU1MoZmNob3duYXQoQVRfRkRDV0QsIFRFU1RGSUxFMSwgc2V0X3VpZCwgc2V0X2dpZCwgMCks
Cj4gKwkJICAgICAiZmNob3duYXQoJWQsICVzLCAlZCwgJWQsIDApIiwKPiArCQkgICAgIEFUX0ZE
Q1dELCBURVNURklMRTEsIHNldF91aWQsIHNldF9naWQpOwo+ICAgCj4gLQlzZXR1cCgpOwo+ICsJ
U0FGRV9TVEFUKFRFU1RGSUxFMSwgJnN0YXRfYnVmKTsKPiArCVRTVF9FWFBfRVFfTEkoc3RhdF9i
dWYuc3RfdWlkLCBzZXRfdWlkKTsKPiArCVRTVF9FWFBfRVFfTEkoc3RhdF9idWYuc3RfZ2lkLCBz
ZXRfZ2lkKTsKPiAgIAo+IC0JZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsK
PiAtCQl0c3RfY291bnQgPSAwOwo+IC0JCWZvciAoaSA9IDA7IGkgPCBUU1RfVE9UQUw7IGkrKykK
PiAtCQkJZmNob3duYXRfdmVyaWZ5KCZ0ZXN0X2Nhc2VzW2ldKTsKPiAtCX0KPiArCVRTVF9FWFBf
UEFTUyhmY2hvd25hdChkaXJfZmQsIFRFU1RGSUxFMiwgc2V0X3VpZCwgc2V0X2dpZCwgMCksCj4g
KwkJICAgICAiZmNob3duYXQoJWQsICVzLCAlZCwgJWQsIDApIiwKPiArCQkgICAgIGRpcl9mZCwg
VEVTVEZJTEUyLCBzZXRfdWlkLCBzZXRfZ2lkKTsKPiAgIAo+IC0JY2xlYW51cCgpOwo+IC0JdHN0
X2V4aXQoKTsKPiArCVNBRkVfU1RBVChURVNURklMRTIsICZzdGF0X2J1Zik7Cj4gKwlUU1RfRVhQ
X0VRX0xJKHN0YXRfYnVmLnN0X3VpZCwgc2V0X3VpZCk7Cj4gKwlUU1RfRVhQX0VRX0xJKHN0YXRf
YnVmLnN0X2dpZCwgc2V0X2dpZCk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gICB7Cj4gLQl0c3Rfc2lnKE5PRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOwo+IC0K
PiAtCVRFU1RfUEFVU0U7Cj4gLQo+IC0JdHN0X3RtcGRpcigpOwo+IC0KPiAtCWRpcl9mZCA9IFNB
RkVfT1BFTihjbGVhbnVwLCAiLi8iLCBPX0RJUkVDVE9SWSk7Cj4gLQo+IC0JU0FGRV9UT1VDSChj
bGVhbnVwLCBURVNURklMRSwgMDYwMCwgTlVMTCk7Cj4gLQo+IC0JZmQgPSBTQUZFX09QRU4oY2xl
YW51cCwgInRlc3RmaWxlMiIsIE9fQ1JFQVQgfCBPX1JEV1IsIDA2MDApOwo+IC19Cj4gLQo+IC1z
dGF0aWMgdm9pZCBmY2hvd25hdF92ZXJpZnkoY29uc3Qgc3RydWN0IHRlc3RfY2FzZV90ICp0ZXN0
KQo+IC17Cj4gLQlURVNUKGZjaG93bmF0KCoodGVzdC0+ZmRzKSwgdGVzdC0+ZmlsZW5hbWVzLCBn
ZXRldWlkKCksCj4gLQkJICAgICAgZ2V0ZWdpZCgpLCB0ZXN0LT5mbGFnKSk7Cj4gLQo+IC0JaWYg
KFRFU1RfUkVUVVJOICE9IHRlc3QtPmV4cF9yZXQpIHsKPiAtCQl0c3RfcmVzbShURkFJTCB8IFRU
RVJSTk8sCj4gLQkJCSAiZmNob3duYXQoKSByZXR1cm5lZCAlbGQsIGV4cGVjdGVkICVkLCBlcnJu
bz0lZCIsCj4gLQkJCSBURVNUX1JFVFVSTiwgdGVzdC0+ZXhwX3JldCwgdGVzdC0+ZXhwX2Vycm5v
KTsKPiAtCQlyZXR1cm47Cj4gLQl9Cj4gLQo+IC0JaWYgKFRFU1RfRVJSTk8gPT0gdGVzdC0+ZXhw
X2Vycm5vKSB7Cj4gLQkJdHN0X3Jlc20oVFBBU1MgfCBUVEVSUk5PLAo+IC0JCQkgImZjaG93bmF0
KCkgcmV0dXJuZWQgdGhlIGV4cGVjdGVkIGVycm5vICVkOiAlcyIsCj4gLQkJCSB0ZXN0LT5leHBf
cmV0LCBzdHJlcnJvcih0ZXN0LT5leHBfZXJybm8pKTsKPiAtCX0gZWxzZSB7Cj4gLQkJdHN0X3Jl
c20oVEZBSUwgfCBUVEVSUk5PLAo+IC0JCQkgImZjaG93bmF0KCkgZmFpbGVkIHVuZXhwZWN0ZWRs
eTsgZXhwZWN0ZWQ6ICVkIC0gJXMiLAo+IC0JCQkgdGVzdC0+ZXhwX2Vycm5vLCBzdHJlcnJvcih0
ZXN0LT5leHBfZXJybm8pKTsKPiAtCX0KPiArCWRpcl9mZCA9IFNBRkVfT1BFTigiLi8iLCBPX0RJ
UkVDVE9SWSk7Cj4gKwlTQUZFX1RPVUNIKFRFU1RGSUxFMSwgMDYwMCwgTlVMTCk7Cj4gKwlTQUZF
X1RPVUNIKFRFU1RGSUxFMiwgMDYwMCwgTlVMTCk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lk
IGNsZWFudXAodm9pZCkKPiAgIHsKPiAtCWlmIChmZCA+IDApCj4gLQkJY2xvc2UoZmQpOwo+IC0K
PiAtCWlmIChkaXJfZmQgPiAwKQo+IC0JCWNsb3NlKGRpcl9mZCk7Cj4gLQo+IC0JdHN0X3JtZGly
KCk7Cj4gKwlpZiAoZGlyX2ZkICE9IC0xKQo+ICsJCVNBRkVfQ0xPU0UoZGlyX2ZkKTsKPiAgIH0K
PiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiArCS5uZWVkc190bXBkaXIg
PSAxLAo+ICsJLm5lZWRzX3Jvb3QgPSAxLAo+ICsJLnRlc3RfYWxsID0gZmNob3duYXRfdmVyaWZ5
LAo+ICsJLnNldHVwID0gc2V0dXAsCj4gKwkuY2xlYW51cCA9IGNsZWFudXAsCj4gK307CgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
