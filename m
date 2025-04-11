Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB9DC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 06:02:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 741433CB540
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 08:02:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EE623CB355
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 08:02:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=18.169.211.239; helo=smtpbg151.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C2B91A0079C
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 08:02:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
 s=onoh2408; t=1744351323;
 bh=b6gOVEWIrAss549szBwVbpxMv09YBMgxWBcTYpqEEgk=;
 h=Date:From:To:Subject:Message-ID:MIME-Version;
 b=Ne/OL1xCvg3ZC8xbiTDA7l5rGcPh9GeoZHKfCr4/CmQYA1NURUhu9TmDVGjWgNzr6
 AmM09Gv48coyBteNhE1+KSGi4Dz+xIx3TMaC7RLmqQql0GVFmI/fTHUGa0e6nCsSRk
 nqF9xpurLGggWA2BV6Gu9LqskRyrG1nS/RX/Nd1Y=
X-QQ-mid: bizesmtpsz4t1744351320t3235f4
X-QQ-Originating-IP: 9SsId1247/YlSeyPt+pRNNC9kb2tZQfpjgIoKyQ3dIA=
Received: from rocky ( [125.76.217.162]) by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 11 Apr 2025 14:01:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10255719200985136271
Date: Fri, 11 Apr 2025 14:01:56 +0800
From: Lu Fei <lufei@uniontech.com>
To: Li Wang <liwang@redhat.com>, Jan Stancek <jstancek@redhat.com>
Message-ID: <E235D2DBCAA80A8D+Z/iwVNmdnxoxZyrN@rocky>
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <20250409074906.128290-1-lufei@uniontech.com>
 <CAEemH2ef7SZ_U5Z-rHst3Wcg-+fuRjSSOU9NxZOSW2Hjx3kiEg@mail.gmail.com>
 <CAEemH2ciHq6EVe8ChfJrHCx=FXRsxUpgbCR=9d5QsgX_K_Fjpw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ciHq6EVe8ChfJrHCx=FXRsxUpgbCR=9d5QsgX_K_Fjpw@mail.gmail.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: NDxI9psdf3YV1jrDUP7A8SGE8R1optLr791vw74v9hOfcFUm9hH1gBBz
 vV72psr8LG7H6RgxA1hC+wawStGf2ij88jVEbL1xrlRsq4KXOf4rrKJBxaKyX52V6EgSyg4
 kaDhS/UU4BR/eHvnzeyGsLvt/to01xeKM3Nx4Yu8ktI+TIYM/ZarTU8BjeKNKVW7ShLXjsd
 J7hhnBg4Fjhv4ny1CSBcqVg7wUW5ZFWko9QwY5nxfySO9O9f0jzsBU3X/mlyPrQxGqpildh
 JqYnDe0v77oyCjtOsZ9Zuzn07mBrBcZk9eks0Oi9aBQ1yfl5Af79nViS+pW+fmoD0YT8wRd
 BnTXg0qpC70kwHy8IbCBxpTB99mz9mGm722/xgSKr/V0j6vPtMWmU36aZXjrdIN5tqcyQ+B
 /00Z2PC276xmnKZxQMfwZAdyt6pkEXVz57yjBp1Y0N+KeIbCYcYNn/whtMGc8t5zFaeczwL
 PcEc6xS/B3FBmAUhqzuEC0qIf48mOdjntJTwrA+KhIx5116CzFTIZUzNJ+F28fm0KQvNtbS
 eaBQJ4qLmFdw7cB8eEKhGWJwbEyX5U702vyD0vXmlMevQHuSfeLaEka5aTc4fWkHzp/J/Yn
 +V1SerlbV2xOUKSBbsCqO5xAzqEWqWYJEkTznz+uYiRvG9WKu1NEYN0rOW1u+uF4eqSYNTG
 NX7OBuBdD+wN7EAA0PhrHU8o8QFxciYWoNCLV0GN4LYzhq7am9lTCRNeeIpXe8UMhmUeWkd
 ABxmRxy0O7WX08TldluRThy7BIxIIvpJ3E1/ymtN68WcsjmhvSFGztAxFvoi04vIjlMXPAQ
 R2Mxem6NcAy7Rz8V3S8yf0Qn22BzdLovXgI0y5CroL2FH67ueYEDMAQJiDm+cCaWLuMxop6
 j59EXHoxqUfjsy1KcYyQYmxF2Y+0XStCK/zzAYW+lnWFC5pT6esnYm85EBFQRvVPEiNlQL4
 Ocd5KH+d+x5ZhP96BYG1Bbuqh
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] unshare03: set nr_open with sizeof(long)*8
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
Cc: viro <viro@zeniv.linux.org.uk>, ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksIExpLCBKYW4uCgpTb3JyeSBmb3Igc28gZmV3IGRldGFpbHMgYWJvdXQgdGhlIHBhdGNoLgoK
VGhlIG9yaWdpbiBjb2RlIGlzIHVzaW5nIG5yX29wZW4gKzEwMjQgYXMgZmQgbnVtYmVyIGxpbWl0
IGFuZCB0aGVuIHNldApmZCB0byBucl9vcGVuICsgNjQsIHRoZW4gc2V0IG5yX29wZW4gdG8gb3Jp
Z2luIG5yX29wZW4gaW4gY2hpbGQgcHJvY2Vzcwp0byBtYWtlIHVuc2hhcmUoQ0xPTkVfRklMRVMp
IGZhaWxzIHdpdGggRU1GSUxFLiBJIHRlc3RlZCB0aGlzIG9uIG15IHZtCigxY3B1LCAyR0IgbWVt
KSwgbWV0IGR1cDIgZmFpbHMgd2l0aCBFTk9NRU0sIHRoaXMgbWFrZSB0aGUgdGVzdCBjYXNlCkJS
T0tFTi4gSSB3YXMgdHJ5IHRvIGZpeCB0aGlzLgoKSW4gcGF0Y2ggdjIsIEkgd2FzIHRyeSB0byB1
c2UgcmxpbWl0LnJsaW1fbWF4IGluc3RlYWQgb2YgdXNpbmcKbnJfb3BlbihyZWFkIGZyb20gL3By
b2Mvc3lzL2ZzL25yX29wZW4pLCB0aGlzIHdvcmtzIHdlbGwuIEJ1dCBDeXJpbApnaXZlcyBhIGJl
dHRlciBhcHByb2NoLCBzbywgSSBzdWJtaXQgcGF0Y2ggdjMuCgpRdW90ZWQgZnJvbSBDeXJpbCdz
IGNvbW1lbnQ6Cj4KPkFoLCB3ZSBjYW5ub3Qgc2V0IG5yX29wZW4gdG8gYW55dGhpbmcgdGhhdCBp
cyBzbWFsbGVyIHRoYW4gQklUU19QRVJfTE9ORzoKPi4uLgo+dW5zaWduZWQgaW50IHN5c2N0bF9u
cl9vcGVuIF9fcmVhZF9tb3N0bHkgPSAxMDI0KjEwMjQ7Cj51bnNpZ25lZCBpbnQgc3lzY3RsX25y
X29wZW5fbWluID0gQklUU19QRVJfTE9ORzsKPi8qIG91ciBtaW4oKSBpcyB1bnVzYWJsZSBpbiBj
b25zdGFudCBleHByZXNzaW9ucyA7LS8gKi8KPiNkZWZpbmUgX19jb25zdF9taW4oeCwgeSkgKCh4
KSA8ICh5KSA/ICh4KSA6ICh5KSkKPnVuc2lnbmVkIGludCBzeXNjdGxfbnJfb3Blbl9tYXggPQo+
ICAgICAgICBfX2NvbnN0X21pbihJTlRfTUFYLCB+KHNpemVfdCkwL3NpemVvZih2b2lkICopKSAm
IC1CSVRTX1BFUl9MT05HOwo+Li4uCgo+VGhlbiB3ZSBuZWVkIGEgZmlsZWRlc2NyaXB0b3IgdGhh
dCBpcyA+PSA2NCBhbmQgc2V0IHRoZSBucl9vcGVuIHRvIDY0LgoKSSdtIHVzaW5nIHNpemVvZihs
b25nKSo4IGlzIGJlY2F1c2UgSSB3YXMgdGhpbmtpbmcgb25seSBzZXQKZmlsZWRpc2NyaXB0b3Ig
Pj0gQklUU19QRVJfTE9ORyBhbmQgdGhlbiBzZXQgbnJfb3BlbiA9IEJJVFNfUEVSX0xPTkcKY291
bGQgbWFrZSBFTUZJTEUgaGFwcGVuLiBMZXNzIHRoYW4gQklUU19QRVJfTE9ORyB3b3VsZCB0cmln
Z2VyIG90aGVyIAplcnJvciB0aGFuIEVNRklMRS4KCkFtIEkgbWlzdW5kZXJzdG9vZCBDeXJpbD8K
ClRoYW5rcyBmb3IgcmVwbHkuCgpPbiBGcmksIEFwciAxMSwgMjAyNSBhdCAxMToyMToyM0FNICsw
ODAwLCBMaSBXYW5nIHdyb3RlOgo+IE9uIEZyaSwgQXByIDExLCAyMDI1IGF0IDExOjA54oCvQU0g
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+ID4KPiA+Cj4gPiBPbiBXZWQs
IEFwciA5LCAyMDI1IGF0IDM6NTDigK9QTSBsdWZlaSA8bHVmZWlAdW5pb250ZWNoLmNvbT4gd3Jv
dGU6Cj4gPgo+ID4+IFNldCBucl9vcGVuIHdpdGggc2l6ZW9mKGxvbmcpKjggdG8gdHJpZ2dlciBF
TUZJTEUsIGluc3RlYWQgb2YgcmVhZGluZwo+ID4+IG51bWJlciBvZiBmaWxlZGVzY3JpcHRvcnMg
bGltaXQuCj4gPj4KPiA+Cj4gPiBBbnkgbmV3IGNoYW5nZXMgaW4gTGludXggdGhhdCBoYXZlIG1h
ZGUgdGhlIHByZXZpb3VzIHdheSBub3Qgd29yayBub3c/Cj4gPgo+IAo+IEFoLCBJIHNlZS4gQXMg
eW91IHBvaW50ZWQgb3V0IGluIHYxLCB0aGF0IGhhcmQgbGltaXQgbWF5IGxlYWQgdG8gZHVwMgo+
IEVOT01FTSBlcnJvciB3aGljaCBicmluZ3MgdGhlIHJlc3VsdCB0byBUQlJPSyBvbmEgc21hbGwg
UkFNIHN5c3RlbS4KPiAKPiBTbywgSSBhZ3JlZSBKYW4sIHdlJ2QgYmV0dGVyIGFkZCBtb3JlIGRl
c2NyaXB0aW9uIHRvIHRoZSBwYXRjaC4KPiAKPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+Cj4gCj4gCj4gCj4gPgo+ID4KPiA+Cj4gPj4KPiA+PiBTaWduZWQtb2ZmLWJ5
OiBsdWZlaSA8bHVmZWlAdW5pb250ZWNoLmNvbT4KPiA+PiAtLS0KPiA+PiAgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwMy5jIHwgMjMgKystLS0tLS0tLS0tLS0tLS0t
LQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkK
PiA+Pgo+ID4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUv
dW5zaGFyZTAzLmMKPiA+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNo
YXJlMDMuYwo+ID4+IGluZGV4IDdjNWU3MWM0ZS4uYzNiOTg5MzBkIDEwMDY0NAo+ID4+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDMuYwo+ID4+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDMuYwo+ID4+IEBAIC0x
Nyw0NCArMTcsMjUgQEAKPiA+PiAgI2luY2x1ZGUgImxhcGkvc2NoZWQuaCIKPiA+Pgo+ID4+ICAj
ZGVmaW5lIEZTX05SX09QRU4gIi9wcm9jL3N5cy9mcy9ucl9vcGVuIgo+ID4+IC0jZGVmaW5lIE5S
X09QRU5fTElNSVQgMTAyNAo+ID4+IC0jZGVmaW5lIE5SX09QRU5fRFVQIDY0Cj4gPj4KPiA+PiAg
I2lmZGVmIEhBVkVfVU5TSEFSRQo+ID4+Cj4gPj4gIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ID4+
ICB7Cj4gPj4gLSAgICAgICBpbnQgbnJfb3BlbjsKPiA+PiAtICAgICAgIGludCBucl9saW1pdDsK
PiA+PiAtICAgICAgIHN0cnVjdCBybGltaXQgcmxpbWl0Owo+ID4+ICAgICAgICAgc3RydWN0IHRz
dF9jbG9uZV9hcmdzIGFyZ3MgPSB7Cj4gPj4gICAgICAgICAgICAgICAgIC5mbGFncyA9IENMT05F
X0ZJTEVTLAo+ID4+ICAgICAgICAgICAgICAgICAuZXhpdF9zaWduYWwgPSBTSUdDSExELAo+ID4+
ICAgICAgICAgfTsKPiA+Pgo+ID4+IC0gICAgICAgU0FGRV9GSUxFX1NDQU5GKEZTX05SX09QRU4s
ICIlZCIsICZucl9vcGVuKTsKPiA+PiAtICAgICAgIHRzdF9yZXMoVERFQlVHLCAiTWF4aW11bSBu
dW1iZXIgb2YgZmlsZSBkZXNjcmlwdG9yczogJWQiLAo+ID4+IG5yX29wZW4pOwo+ID4+ICsgICAg
ICAgaW50IG5yX29wZW4gPSBzaXplb2YobG9uZykgKiA4Owo+ID4+Cj4gPj4gLSAgICAgICBucl9s
aW1pdCA9IG5yX29wZW4gKyBOUl9PUEVOX0xJTUlUOwo+ID4+IC0gICAgICAgU0FGRV9GSUxFX1BS
SU5URihGU19OUl9PUEVOLCAiJWQiLCBucl9saW1pdCk7Cj4gPj4gLQo+ID4+IC0gICAgICAgU0FG
RV9HRVRSTElNSVQoUkxJTUlUX05PRklMRSwgJnJsaW1pdCk7Cj4gPj4gLQo+ID4+IC0gICAgICAg
cmxpbWl0LnJsaW1fY3VyID0gbnJfbGltaXQ7Cj4gPj4gLSAgICAgICBybGltaXQucmxpbV9tYXgg
PSBucl9saW1pdDsKPiA+PiAtCj4gPj4gLSAgICAgICBTQUZFX1NFVFJMSU1JVChSTElNSVRfTk9G
SUxFLCAmcmxpbWl0KTsKPiA+PiAtICAgICAgIHRzdF9yZXMoVERFQlVHLCAiU2V0IG5ldyBtYXhp
bXVtIG51bWJlciBvZiBmaWxlIGRlc2NyaXB0b3JzIHRvIDoKPiA+PiAlZCIsCj4gPj4gLSAgICAg
ICAgICAgICAgIG5yX2xpbWl0KTsKPiA+PiAtCj4gPj4gLSAgICAgICBTQUZFX0RVUDIoMiwgbnJf
b3BlbiArIE5SX09QRU5fRFVQKTsKPiA+PiArICAgICAgIFNBRkVfRFVQMigyLCBucl9vcGVuICsg
MSk7Cj4gPj4KPiA+PiAgICAgICAgIGlmICghU0FGRV9DTE9ORSgmYXJncykpIHsKPiA+PiAgICAg
ICAgICAgICAgICAgU0FGRV9GSUxFX1BSSU5URihGU19OUl9PUEVOLCAiJWQiLCBucl9vcGVuKTsK
PiA+PiAgICAgICAgICAgICAgICAgVFNUX0VYUF9GQUlMKHVuc2hhcmUoQ0xPTkVfRklMRVMpLCBF
TUZJTEUpOwo+ID4+ICAgICAgICAgICAgICAgICBleGl0KDApOwo+ID4+ICAgICAgICAgfQo+ID4+
IC0KPiA+PiAgfQo+ID4+Cj4gPj4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPj4gLS0KPiA+
PiAyLjM5LjMKPiA+Pgo+ID4+Cj4gPj4gLS0KPiA+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiA+Pgo+ID4+Cj4gPgo+ID4gLS0KPiA+IFJl
Z2FyZHMsCj4gPiBMaSBXYW5nCj4gPgo+IAo+IAo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
