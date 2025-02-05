Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC334C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738750277; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=atvrf4/Zo5clWgz0xoyXZf5aBUxVjlW9iI13msloZ8Y=;
 b=LlkP/jLlZgZjewatpkMihvpytLic6qcC3c1CwIJuFg7EVVApOBZTsRiiggzmbT8shgwzI
 QOLtqfly72YyJ5/9c6u/eNUYsqmbIteLtLEYjO/YqeWwPNPLF6Ylk6cY8LLwU2nlVmFZe5n
 qDGhGQHFgvK8SyOnELd91DGG80idBTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59CD13C91EF
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 11:11:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBC273C293A
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:10:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.223;
 helo=esa9.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com
 [139.138.36.223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D53F648F73
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 11:10:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1738750254; x=1770286254;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=94JFT0D/k/cCBXH8ozLZxvOY2j/xd3CItiwDAXpH71Q=;
 b=B+1fszQQCWg0FovX67Cjd6QEnkO+I7xXWbk7rlpmlAYt9bD5ddPLiMS2
 aN/R0OLl7eH4a5kvbh0CzadAX7g5xI1kwxmrNMnc3/1po0muNicfUJD0n
 /TwrO5ojkrEzqhBsTWH4T8sXXrdIGfpD9keQUXD8EeoLxTxZ/3OyqErWp
 elD/RSvSfNTSSllO2hU5Vl+ILj9uCk/1w7fSgYcgY0odUCA0c6NYIPSth
 v6hOVsPKABHbijYAxAlh8FofS905EPU4T1ytZ1wRMYJBQN3AJS2TxGsz2
 hdAIw3T3v4tDXC/sCZw6/SNsHy7FVI0e+ePlnCMxDq8o/Xt0nzu6tpHHA Q==;
X-CSE-ConnectionGUID: 9n/DMjyxS8yzpQFP+7mzGw==
X-CSE-MsgGUID: J6r73LQ1Rim7tbl//Exh/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="177335027"
X-IronPort-AV: E=Sophos;i="6.13,261,1732546800"; d="scan'208";a="177335027"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2025 19:10:51 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4229BEA890
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 19:10:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 00339E6475
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 19:10:49 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 6AE391A000B;
 Wed,  5 Feb 2025 18:10:48 +0800 (CST)
Message-ID: <99fc1881-8cca-4769-af7e-08cdc65895f9@fujitsu.com>
Date: Wed, 5 Feb 2025 18:10:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, rbm@suse.com, pvorel@suse.cz
References: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
 <20250116084633.511484-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20250116084633.511484-1-ruansy.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] posix_fadvise: Convert docs to docparse
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

SGkKCnBpbmd+CgoK5ZyoIDIwMjUvMS8xNiAxNjo0NiwgU2hpeWFuZyBSdWFuIOWGmemBkzoKPiBT
aWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPgo+IC0t
LQo+ICAgLi4uL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZpc2UwMS5jIHwgMTgg
KysrKy0tLS0tLS0tLS0tLS0tCj4gICAuLi4va2VybmVsL3N5c2NhbGxzL2ZhZHZpc2UvcG9zaXhf
ZmFkdmlzZTAyLmMgfCAxOCArKysrLS0tLS0tLS0tLS0tLS0KPiAgIC4uLi9rZXJuZWwvc3lzY2Fs
bHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDMuYyB8IDE5ICsrKysrLS0tLS0tLS0tLS0tLS0KPiAg
IC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDQuYyB8IDE4ICsrKyst
LS0tLS0tLS0tLS0tLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA1NiBk
ZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YWR2aXNlL3Bvc2l4X2ZhZHZpc2UwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2
aXNlL3Bvc2l4X2ZhZHZpc2UwMS5jCj4gaW5kZXggNzFlNjQ1NGQ4Li4yYzZkNTc5NDEgMTAwNjQ0
Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZpc2Uw
MS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZp
c2UwMS5jCj4gQEAgLTEsMjMgKzEsMTMgQEAKPiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wLW9yLWxhdGVyCj4gICAvKgo+ICAgICogQ29weXJpZ2h0IChjKSBSZWQgSGF0IElu
Yy4sIDIwMDcKPiArICogQXV0aG9yOiBNYXNhdGFrZSBZQU1BVE8gPHlhbWF0b0ByZWRoYXQuY29t
Pgo+ICAgICovCj4gICAKPiAtLyoKPiAtICogTkFNRQo+IC0gKglwb3NpeF9mYWR2aXNlMDEuYwo+
IC0gKgo+IC0gKiBERVNDUklQVElPTgo+IC0gKglDaGVjayB0aGUgdmFsdWUgdGhhdCBwb3NpeF9m
YWR2aXNlIHJldHVybnMgZm9yIHdyb25nIEFEVklTRSB2YWx1ZS4KPiAtICoKPiAtICogVVNBR0UK
PiAtICoJcG9zaXhfZmFkdmlzZTAxCj4gLSAqCj4gLSAqIEhJU1RPUlkKPiAtICoJMTEvMjAwNyBJ
bml0aWFsIHZlcnNpb24gYnkgTWFzYXRha2UgWUFNQVRPIDx5YW1hdG9AcmVkaGF0LmNvbT4KPiAr
LypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiAgICAqCj4gLSAqIFJFU1RSSUNUSU9OUwo+IC0gKglO
b25lCj4gKyAqIFZlcmlmeSB0aGF0IHBvc2l4X2ZhZHZpc2UoKSByZXR1cm5zIDAgZm9yIHBlcm1p
c3NpYmxlIEFEVklTRSB2YWx1ZS4KPiAgICAqLwo+ICAgCj4gICAjaW5jbHVkZSA8ZmNudGwuaD4K
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2Zh
ZHZpc2UwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZp
c2UwMi5jCj4gaW5kZXggMzAzZjc3NmU0Li5iYmZiZDEwMmUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZpc2UwMi5jCj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZpc2UwMi5jCj4gQEAgLTEs
MjMgKzEsMTMgQEAKPiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyCj4gICAvKgo+ICAgICogQ29weXJpZ2h0IChjKSBSZWQgSGF0IEluYy4sIDIwMDcKPiArICog
QXV0aG9yOiBNYXNhdGFrZSBZQU1BVE8gPHlhbWF0b0ByZWRoYXQuY29tPgo+ICAgICovCj4gICAK
PiAtLyoKPiAtICogTkFNRQo+IC0gKglwb3NpeF9mYWR2aXNlMDIuYwo+IC0gKgo+IC0gKiBERVND
UklQVElPTgo+IC0gKglDaGVjayB0aGUgdmFsdWUgdGhhdCBwb3NpeF9mYWR2aXNlIHJldHVybnMg
Zm9yIHdyb25nIGZpbGUgZGVzY3JpcHRvci4KPiAtICoKPiAtICogVVNBR0UKPiAtICoJcG9zaXhf
ZmFkdmlzZTAyCj4gLSAqCj4gLSAqIEhJU1RPUlkKPiAtICoJMTEvMjAwNyBJbml0aWFsIHZlcnNp
b24gYnkgTWFzYXRha2UgWUFNQVRPIDx5YW1hdG9AcmVkaGF0LmNvbT4KPiArLypcCj4gKyAqIFtE
ZXNjcmlwdGlvbl0KPiAgICAqCj4gLSAqIFJFU1RSSUNUSU9OUwo+IC0gKglOb25lCj4gKyAqIFZl
cmlmeSB0aGF0IHBvc2l4X2ZhZHZpc2UoKSByZXR1cm5zIEVCQURGIGZvciB3cm9uZyBmaWxlIGRl
c2NyaXB0b3IuCj4gICAgKi8KPiAgIAo+ICAgI2luY2x1ZGUgPGZjbnRsLmg+Cj4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDMuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDMuYwo+IGlu
ZGV4IDk4ZDhkMjkzMC4uN2JmNTAwYTJiIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDMuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDMuYwo+IEBAIC0xLDIzICsxLDE0IEBA
Cj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICAgLyoK
PiAgICAqIENvcHlyaWdodCAoYykgUmVkIEhhdCBJbmMuLCAyMDA3Cj4gKyAqIEF1dGhvcjogTWFz
YXRha2UgWUFNQVRPIDx5YW1hdG9AcmVkaGF0LmNvbT4KPiAgICAqLwo+ICAgCj4gLS8qCj4gLSAq
IE5BTUUKPiAtICoJcG9zaXhfZmFkdmlzZTAzLmMKPiAtICoKPiAtICogREVTQ1JJUFRJT04KPiAt
ICoJQ2hlY2sgdGhlIHZhbHVlIHRoYXQgcG9zaXhfZmFkdmlzZSByZXR1cm5zIGZvciB3cm9uZyBB
RFZJU0UgdmFsdWUuCj4gLSAqCj4gLSAqIFVTQUdFCj4gLSAqCXBvc2l4X2ZhZHZpc2UwMwo+IC0g
Kgo+IC0gKiBISVNUT1JZCj4gLSAqCTExLzIwMDcgSW5pdGlhbCB2ZXJzaW9uIGJ5IE1hc2F0YWtl
IFlBTUFUTyA8eWFtYXRvQHJlZGhhdC5jb20+Cj4gKy8qXAo+ICsgKiBbRGVzY3JpcHRpb25dCj4g
ICAgKgo+IC0gKiBSRVNUUklDVElPTlMKPiAtICoJTm9uZQo+ICsgKiBWZXJpZnkgdGhhdCBwb3Np
eF9mYWR2aXNlKCkgcmV0dXJucyBFSU5WQUwgZm9yIHRoZSBBRFZJU0UgdmFsdWUgbm90Cj4gKyAq
IHBlcm1pc3NpYmxlIG9uIHRoZSBhcmNoaXRlY3R1cmUuCj4gICAgKi8KPiAgIAo+ICAgI2luY2x1
ZGUgPGZjbnRsLmg+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFk
dmlzZS9wb3NpeF9mYWR2aXNlMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFkdmlz
ZS9wb3NpeF9mYWR2aXNlMDQuYwo+IGluZGV4IDhiYWY5MWJiMC4uYmVlY2U2NDEwIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDQu
Ywo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNl
MDQuYwo+IEBAIC0xLDIzICsxLDEzIEBACj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcgo+ICAgLyoKPiAgICAqIENvcHlyaWdodCAoYykgUmVkIEhhdCBJbmMu
LCAyMDA3Cj4gKyAqIEF1dGhvcjogTWFzYXRha2UgWUFNQVRPIDx5YW1hdG9AcmVkaGF0LmNvbT4K
PiAgICAqLwo+ICAgCj4gLS8qCj4gLSAqIE5BTUUKPiAtICoJcG9zaXhfZmFkdmlzZTA0LmMKPiAt
ICoKPiAtICogREVTQ1JJUFRJT04KPiAtICoJQ2hlY2sgdGhlIHZhbHVlIHRoYXQgcG9zaXhfZmFk
dmlzZSByZXR1cm5zIGZvciBwaXBlIGRlc2NyaXB0b3IuCj4gLSAqCj4gLSAqIFVTQUdFCj4gLSAq
CXBvc2l4X2ZhZHZpc2UwNAo+IC0gKgo+IC0gKiBISVNUT1JZCj4gLSAqCTExLzIwMDcgSW5pdGlh
bCB2ZXJzaW9uIGJ5IE1hc2F0YWtlIFlBTUFUTyA8eWFtYXRvQHJlZGhhdC5jb20+Cj4gKy8qXAo+
ICsgKiBbRGVzY3JpcHRpb25dCj4gICAgKgo+IC0gKiBSRVNUUklDVElPTlMKPiAtICoJTm9uZQo+
ICsgKiBWZXJpZnkgdGhhdCBwb3NpeF9mYWR2aXNlKCkgcmV0dXJucyBFU1BJUEUgZm9yIHBpcGUg
ZGVzY3JpcHRvci4KPiAgICAqLwo+ICAgCj4gICAjaW5jbHVkZSA8ZmNudGwuaD4KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
