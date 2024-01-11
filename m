Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1801C4707B
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 02:11:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 194EF3CFDB4
	for <ltp@archiver.kernel.org>; Thu, 11 Jan 2024 03:11:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4150D3C75A3
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:10:56 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.117;
 helo=esa4.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com
 [68.232.139.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 863D41000CFB
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 03:10:54 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="146035792"
X-IronPort-AV: E=Sophos;i="6.04,185,1695654000"; d="scan'208";a="146035792"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2024 11:10:51 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8ACF9D619A
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:10:49 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D1446D5E99
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:10:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5CFC06B349
 for <ltp@lists.linux.it>; Thu, 11 Jan 2024 11:10:48 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id D91DD1A0070;
 Thu, 11 Jan 2024 10:10:47 +0800 (CST)
Message-ID: <e1000481-f5d2-48f5-9de0-8831ef4f8938@fujitsu.com>
Date: Thu, 11 Jan 2024 10:10:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20240109095026.792527-1-ruansy.fnst@fujitsu.com>
 <20240110182913.GA1768734@pevik>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <20240110182913.GA1768734@pevik>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28112.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28112.003
X-TMASE-Result: 10--12.251400-10.000000
X-TMASE-MatchedRID: LUUEnUEr1laPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxgPgeggVwCFsiq
 4e+BcPI5IvrftAIhWmLy9zcRSkKatcOJmY4XRXkVQQp1SVSsqYA6En2bnefhoOTpBuL72LoPVXF
 z93jC3xf4XJPAGTaiPNCI+SHeKBbaVoG8mkAKgzxZNYSHk3Zr0UxhUFgrZenKX2NpTiP/gVA+Sq
 ubchsr85ZAaKsAarTBcYC+Zsu+gTyaYlNpIKBgCwrcxrzwsv5uC//1TMV5chMvPRFFhcWhYMhmG
 Vf5QASG7foLApH+eB4OTbJs4YOJk/vwmMFLImuhuce7gFxhKa02nLo2hN48IZsoi2XrUn/Jsuf7
 RWbvUtz7H+hZKy6/KwtuKBGekqUpIG4YlbCDECtruV6hT84yE1iwJprBIi4pI3xbqsA9/gwLO3G
 T7a+K5ZgtnqxsZf4IP9XeAAa+zgB+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dup06: Convert to new API
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgrlnKggMjAyNC8xLzExIDI6MjksIFBldHIgVm9yZWwg5YaZ6YGTOgo+IEhpIFNoaXlhbmcsCj4g
Cj4+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+
Cj4+IC0tLQo+PiAgIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZHVwL2R1cDA2LmMgfCAxNDEg
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0
aW9ucygrKSwgODkgZGVsZXRpb25zKC0pCj4gCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2R1cC9kdXAwNi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kdXAv
ZHVwMDYuYwo+PiBpbmRleCBlM2Y4MDcwYmYuLjg0ZmMyNjBhMSAxMDA2NDQKPj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kdXAvZHVwMDYuYwo+PiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2R1cC9kdXAwNi5jCj4+IEBAIC0xLDQyICsxLDIyIEBACj4+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+PiAgIC8qCj4+IC0gKiAgIENv
cHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBCdXNpbmVzcyBNYWNoaW5lcyAgQ29ycC4sIDIwMDIK
Pj4gLSAqICAgIHBvcnRlZCBmcm9tIFNQSUUsIHNlY3Rpb24yL2lvc3VpdGUvZHVwMS5jLCBieSBB
aXJvbmcgWmhhbmcKPj4gLSAqICAgQ29weXJpZ2h0IChjKSAyMDEzIEN5cmlsIEhydWJpcyA8Y2hy
dWJpc0BzdXNlLmN6Pgo+IC4uLgo+PiArICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1
c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMgo+PiArICogIHBvcnRlZCBmcm9tIFNQSUUsIHNl
Y3Rpb24yL2lvc3VpdGUvZHVwMS5jLCBieSBBaXJvbmcgWmhhbmcKPj4gKyAqIENvcHlyaWdodCAo
YykgMjAxMyBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiBDb3VsZCB5b3UgcGxlYXNl
IGFsc28gYWRkIHlvdXIgb3IgTFRQIGNvcHlyaWdodCBmb3IgdGhpcyByZXdyaXRlPwo+IEUuZy4K
PiAqIENvcHlyaWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0LCAyMDAzLTIwMTUKPiArIHlvdXIg
Y29weXJpZ2h0LCBvciBqdXN0Ogo+ICogQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2plY3Qs
IDIwMDMtMjAyNAo+IAo+ICQgbWFrZSBjaGVjay1kdXAwNgo+IENIRUNLIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvZHVwL2R1cDA2LmMKPiBkdXAwNi5jOjI4OiBFUlJPUjogcmV0dXJuIGlzIG5v
dCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCj4gZHVwMDYuYzo1Mzog
RVJST1I6IGRvIG5vdCB1c2UgYXNzaWdubWVudCBpbiBpZiBjb25kaXRpb24KPiBkdXAwNi5jOjU2
OiBXQVJOSU5HOiBicmFjZXMge30gYXJlIG5vdCBuZWNlc3NhcnkgZm9yIGFueSBhcm0gb2YgdGhp
cyBzdGF0ZW1lbnQKPiAKPiBUaGVyZWZvcmUgSSdtIGdvaW5nIHRvIG1lcmdlIHdpdGggZm9sbG93
aW5nIGNoYW5nZSAoKyBwbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91Cj4gd2FudCB0byBhZGQgeW91
ciBjb3B5cmlnaHQpLgo+IAo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4KClRoYW5rcywgYWRkaW5nIExUUCBjb3B5cmlnaHQgaXMgZmluZS4KCkxldCBtZSBzZW5kIGEg
bmV3IHZlcnNpb24gb2YgdGhlc2UgdHdvIHBhdGNoZXMgYmVjYXVzZSB0aGUgbmV4dCBvbmUgaGFz
IAp0aGUgc2FtZSBpc3N1ZS4gIEkndmUgZml4ZWQgaXQuCgoKLS0KUnVhbi4KCj4gCj4gS2luZCBy
ZWdhcmRzLAo+IFBldHIKPiAKPiBkaWZmIC0tZ2l0IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZHVwL2R1cDA2LmMgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kdXAvZHVwMDYuYwo+IGluZGV4
IDg0ZmMyNjBhMS4uZTdlMjdiOGY5IDEwMDY0NAo+IC0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2R1cC9kdXAwNi5jCj4gKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZHVwL2R1cDA2
LmMKPiBAQCAtMSw4ICsxLDkgQEAKPiAgIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCj4gICAvKgo+ICAgICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1
c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMgo+IC0gKiAgcG9ydGVkIGZyb20gU1BJRSwgc2Vj
dGlvbjIvaW9zdWl0ZS9kdXAxLmMsIGJ5IEFpcm9uZyBaaGFuZwo+ICsgKiBwb3J0ZWQgZnJvbSBT
UElFLCBzZWN0aW9uMi9pb3N1aXRlL2R1cDEuYywgYnkgQWlyb25nIFpoYW5nCj4gICAgKiBDb3B5
cmlnaHQgKGMpIDIwMTMgQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gKyAqIENvcHly
aWdodCAoYykgTGludXggVGVzdCBQcm9qZWN0LCAyMDAzLTIwMjQKPiAgICAqLwo+ICAgCj4gICAv
KlwKPiBAQCAtMTcsNiArMTgsNyBAQAo+ICAgc3RhdGljIGludCAqcGZpbGRlczsKPiAgIHN0YXRp
YyBpbnQgbWluZmQsIG1heGZkLCBmcmVlZmRzOwo+ICAgc3RhdGljIGNoYXIgcGZpbG5hbWVbNDBd
Owo+ICsKPiAgIHN0YXRpYyBpbnQgY250X2ZyZWVfZmRzKGludCBtYXhmZCkKPiAgIHsKPiAgIAlp
bnQgZnJlZWZkcyA9IDA7Cj4gQEAgLTI1LDcgKzI3LDcgQEAgc3RhdGljIGludCBjbnRfZnJlZV9m
ZHMoaW50IG1heGZkKQo+ICAgCQlpZiAoZmNudGwobWF4ZmQsIEZfR0VURkQpID09IC0xICYmIGVy
cm5vID09IEVCQURGKQo+ICAgCQkJZnJlZWZkcysrOwo+ICAgCj4gLQlyZXR1cm4gKGZyZWVmZHMp
Owo+ICsJcmV0dXJuIGZyZWVmZHM7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gQEAgLTUwLDE2ICs1MiwxNyBAQCBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiAgIAo+ICAg
CXBmaWxkZXNbMF0gPSBTQUZFX0NSRUFUKHBmaWxuYW1lLCAwNjY2KTsKPiAgIAlmb3IgKGkgPSAx
OyBpIDwgbWF4ZmQ7IGkrKykgewo+IC0JCWlmICgocGZpbGRlc1tpXSA9IGR1cChwZmlsZGVzW2kg
LSAxXSkpID09IC0xKQo+ICsJCXBmaWxkZXNbaV0gPSBkdXAocGZpbGRlc1tpIC0gMV0pOwo+ICsJ
CWlmIChwZmlsZGVzW2ldID09IC0xKQo+ICAgCQkJYnJlYWs7Cj4gICAJfQo+IC0JaWYgKGkgPCBm
cmVlZmRzKSB7Cj4gKwo+ICsJaWYgKGkgPCBmcmVlZmRzKQo+ICAgCQl0c3RfcmVzKFRGQUlMLCAi
Tm90IGVub3VnaCBmaWxlcyBkdXBlZCIpOwo+IC0JfSBlbHNlIGlmIChpID4gZnJlZWZkcykgewo+
ICsJZWxzZSBpZiAoaSA+IGZyZWVmZHMpCj4gICAJCXRzdF9yZXMoVEZBSUwsICJUb28gbWFueSBm
aWxlcyBkdXBlZCIpOwo+IC0JfSBlbHNlIHsKPiAtCQl0c3RfcmVzKFRQQVNTLCAiVGVzdCBwYXNz
ZWQuIik7Cj4gLQl9Cj4gKwllbHNlCj4gKwkJdHN0X3JlcyhUUEFTUywgIlRlc3QgcGFzc2VkIik7
Cj4gICAKPiAgIAlTQUZFX1VOTElOSyhwZmlsbmFtZSk7Cj4gICAKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
