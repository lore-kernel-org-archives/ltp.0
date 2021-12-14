Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7195C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 02:59:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70BB33C8B60
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 03:59:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2E73C0939
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 03:59:18 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F37961A0144B
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 03:59:16 +0100 (CET)
X-QQ-mid: bizesmtp46t1639450751tlvc43qa
Received: from [10.4.23.202] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 14 Dec 2021 10:59:10 +0800 (CST)
X-QQ-SSF: 0040000000000070E000B00D0000000
X-QQ-FEAT: TskX/GkkryDv58Hjf52oSKaMBVfp10zsi2juyIEubYeWId/WVW8LAZr9xrVTD
 8XErLnXjWQz8TXk/NO1KA1i+6hcm+CwAnV7/xDAqSkmaAP1k9TYnnwiOzwqGbNkHaef6t3F
 c6PbEroAGcXoOCAWKw64ARBFpHrnC7wp5pM+3bR2xD+6dBSU2uIy9DLGUXHpMZHdkLgtGAz
 CsxxfXbGVuf6KH2vgN1+F/dW/ilM5ZzH7PGaKqVOK4ul49CwZsqT4jGGT0qnfT9lcK5x3UE
 IpaHx791pwf6lTjp0YE/fMAR6w46f/5NKYLOsseXC2u+8AjeYAv8eIR73AftBM07TQFI+b2
 vUqe1ghOVh/5WsTDoyNbGnkoGSYmCSxUD+QrORAqvMa481bRPM=
X-QQ-GoodBg: 2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211213034252.13698-1-sujiaxun@uniontech.com>
 <Ybd1q80bXbPqzG4l@yuki>
From: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <32f1fcc7-d05c-0248-cc6b-8908a80ecc10@uniontech.com>+EEA98DCD05635C1A
Date: Tue, 14 Dec 2021 10:59:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <Ybd1q80bXbPqzG4l@yuki>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v1,
 1/2] syscalls/sched_get_priority_max01: Convert to new API
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

1NogMjAyMS8xMi8xNCDJz87nMTI6MzIsIEN5cmlsIEhydWJpcyDQtLXAOgo+IEhpIQo+PiArLypc
Cj4+ICsgKiBbRGVzY3JpcHRpb25dCj4+ICsgKgo+PiAgICAqCVRoaXMgaXMgYSBQaGFzZSBJIHRl
c3QgZm9yIHRoZSBzY2hlZF9nZXRfcHJpb3JpdHlfbWF4KDIpIHN5c3RlbSBjYWxsLgo+PiAgICAq
CUl0IGlzIGludGVuZGVkIHRvIHByb3ZpZGUgYSBsaW1pdGVkIGV4cG9zdXJlIG9mIHRoZSBzeXN0
ZW0gY2FsbC4KPiAKPiBDYW4gd2UgcGxlYXNlIGdldCBhIGJldHRlciBkZXNjcmlwdGlvbiB0aGFu
IHRoaXM/Cj4gCj4gU29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcyB0aGF0IGl0IGdldHMgbWF4IHBy
aW8gZm9yIGRpZmZlcmVudAo+IHNjaGVkdWxsaW5nIHBvbGljaWVzIGFuZCBjb21wYXJlcyB0aGF0
IHdpdGggZXhwZWN0ZWQgdmFsdWU/Cj4gCj4+ICAgI2luY2x1ZGUgPGVycm5vLmg+Cj4+ICAgI2lu
Y2x1ZGUgPHNjaGVkLmg+Cj4+IC0jaW5jbHVkZSAidGVzdC5oIgo+PiAtCj4+IC1zdGF0aWMgdm9p
ZCBzZXR1cCgpOwo+PiAtc3RhdGljIHZvaWQgY2xlYW51cCgpOwo+PiArI2luY2x1ZGUgImxhcGkv
c3lzY2FsbHMuaCIKPj4gKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+Pgo+PiAtY2hhciAqVENJRCA9
ICJzY2hlZF9nZXRfcHJpb3JpdHlfbWF4MDEiOwo+PiAtCj4+IC1zdGF0aWMgc3RydWN0IHRlc3Rf
Y2FzZV90IHsKPj4gK3N0YXRpYyBzdHJ1Y3QgdGVzdF9jYXNlIHsKPj4gICAJY2hhciAqZGVzYzsK
Pj4gICAJaW50IHBvbGljeTsKPj4gICAJaW50IHJldHZhbDsKPj4gLX0gdGVzdF9jYXNlc1tdID0g
ewo+PiArfSB0Y2FzZXNbXSA9IHsKPj4gICAJewo+PiAgIAkiVGVzdCBmb3IgU0NIRURfT1RIRVIi
LCBTQ0hFRF9PVEhFUiwgMH0sIHsKPj4gICAJIlRlc3QgZm9yIFNDSEVEX0ZJRk8iLCBTQ0hFRF9G
SUZPLCA5OX0sIHsKPj4gICAJIlRlc3QgZm9yIFNDSEVEX1JSIiwgU0NIRURfUlIsIDk5fQo+IAo+
IFRoaXMgZm9ybWF0dGluZyBsb29rcyByZWFsbHkgc3RyYW5nZSwgdGhlIG9wZW5pbmcgYW5kIGNs
b3NpbmcgYnJhY2VzCj4gc2hvdWxkIGJlIG9uIHRoZSBzYW1lIGxpbmUgYXM6Cj4gCj4gCXsiZm9v
IiwgZm9vLCAwfSwKPiAJLi4uCj4gCj4gQWxzbyB0aGVyZSBpcyBubyBwb2ludCB0byByZXBlYXQg
dGhlICJUZXN0IGZvciIgaW4gZWFjaCBzdHJpbmcsIGFsbCB0aGF0Cj4gbmVlZHMgdG8gYmUgc3Rv
cmVkIGluIHRoZSBkZXNjIGlzIHRoZSBuYW1lIG9mIHRoZSBtYWNybyBhcyBhIHN0cmluZy4KPiAK
Pj4gICB9Owo+Pgo+PiAtaW50IFRTVF9UT1RBTCA9IHNpemVvZih0ZXN0X2Nhc2VzKSAvIHNpemVv
Zih0ZXN0X2Nhc2VzWzBdKTsKPj4KPj4gLWludCBtYWluKGludCBhYywgY2hhciAqKmF2KQo+PiAr
c3RhdGljIHZvaWQgcnVuX3Rlc3QodW5zaWduZWQgaW50IG5yKQo+PiAgIHsKPj4KPj4gLQlpbnQg
bGMsIGluZDsKPj4gLQo+PiAtCXRzdF9wYXJzZV9vcHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Cj4+
IC0KPj4gLQlzZXR1cCgpOwo+PiArCXN0cnVjdCB0ZXN0X2Nhc2UgKnRjID0gJnRjYXNlc1tucl07
Cj4+Cj4+IC0JZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKPj4gKwlURVNU
KHRzdF9zeXNjYWxsKF9fTlJfc2NoZWRfZ2V0X3ByaW9yaXR5X21heCwgdGMtPnBvbGljeSkpOwo+
IAo+IENhbiB3ZSBwbGVhc2Ugc3dpdGNoIHRvIFRTVF9FWFBfUE9TSVRJVkUoKSBoZXJlPwo+IAo+
IFRoaXMgcGFydCBzaG91bGQgbG9vayBsaWtlOgo+IAo+IAlUU1RfRVhQX1BPU0lUSVZFKC4uLik7
Cj4gCj4gCWlmICghVFNUX1BBU1MpCj4gCQlyZXR1cm47Cj4gCj4gCWlmIChUU1RfUkVUID09IHRj
LT5yZXR2YWwpCj4gCQl0c3RfcmVzKFRQQVNTLCAuLi4pOwo+IAllbHNlCj4gCQl0c3RfcmVzKEZB
SUwsIC4uLik7Cj4gCj4+IC0JCXRzdF9jb3VudCA9IDA7Cj4+IC0KPj4gLQkJZm9yIChpbmQgPSAw
OyBpbmQgPCBUU1RfVE9UQUw7IGluZCsrKSB7Cj4+IC0JCQkvKgo+PiAtCQkJICogQ2FsbCBzY2hl
ZF9nZXRfcHJpb3JpdHlfbWF4KDIpCj4+IC0JCQkgKi8KPj4gLQkJCVRFU1Qoc2NoZWRfZ2V0X3By
aW9yaXR5X21heCh0ZXN0X2Nhc2VzW2luZF0ucG9saWN5KSk7Cj4+IC0KPj4gLQkJCWlmIChURVNU
X1JFVFVSTiA9PSB0ZXN0X2Nhc2VzW2luZF0ucmV0dmFsKSB7Cj4+IC0JCQkJdHN0X3Jlc20oVFBB
U1MsICIlcyBQYXNzZWQiLAo+PiAtCQkJCQkgdGVzdF9jYXNlc1tpbmRdLmRlc2MpOwo+PiAtCQkJ
fSBlbHNlIHsKPj4gLQkJCQl0c3RfcmVzbShURkFJTCB8IFRURVJSTk8sICIlcyBGYWlsZWQsICIK
Pj4gLQkJCQkJICJzY2hlZF9nZXRfcHJpb3JpdHlfbWF4KCkgcmV0dXJuZWQgJWxkIiwKPj4gLQkJ
CQkJIHRlc3RfY2FzZXNbaW5kXS5kZXNjLCBURVNUX1JFVFVSTik7Cj4+IC0JCQl9Cj4+IC0JCX0K
Pj4gKwlpZiAoVFNUX1JFVCA9PSB0Yy0+cmV0dmFsKSB7Cj4+ICsJCXRzdF9yZXMoVFBBU1MsICIl
cyBQYXNzZWQiLAo+PiArCQkJIHRjLT5kZXNjKTsKPj4gKwl9IGVsc2Ugewo+PiArCQl0c3RfcmVz
KFRGQUlMIHwgVFRFUlJOTywgIiVzIEZhaWxlZCwgIgo+PiArCQkJICJzY2hlZF9nZXRfcHJpb3Jp
dHlfbWF4KCkgcmV0dXJuZWQgJWxkIiwKPj4gKwkJCSB0Yy0+ZGVzYywgVFNUX1JFVCk7Cj4+ICAg
CX0KPj4KPj4gLQkvKiBjbGVhbnVwIGFuZCBleGl0ICovCj4+IC0JY2xlYW51cCgpOwo+PiAtCj4+
IC0JdHN0X2V4aXQoKTsKPj4gLQo+PiAtfQo+PiAtCj4+IC0vKiBzZXR1cCgpIC0gcGVyZm9ybXMg
YWxsIE9ORSBUSU1FIHNldHVwIGZvciB0aGlzIHRlc3QgKi8KPj4gLXZvaWQgc2V0dXAodm9pZCkK
Pj4gLXsKPj4gLQo+PiAtCXRzdF9zaWcoTk9GT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7Cj4+
IC0KPj4gLQlURVNUX1BBVVNFOwo+PiAtCj4+ICAgfQo+Pgo+PiAtLyoKPj4gLSAqY2xlYW51cCgp
IC0gIHBlcmZvcm1zIGFsbCBPTkUgVElNRSBjbGVhbnVwIGZvciB0aGlzIHRlc3QgYXQKPj4gLSAq
CQljb21wbGV0aW9uIG9yIHByZW1hdHVyZSBleGl0Lgo+PiAtICovCj4+IC12b2lkIGNsZWFudXAo
dm9pZCkKPj4gLXsKPj4gLQo+PiAtfQo+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0g
ewo+PiArCS50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+PiArCS50ZXN0ID0gcnVuX3Rlc3Qs
Cj4+ICt9Owo+PiAtLQo+PiAyLjIwLjEKPj4KPj4KPj4KPj4KPj4gLS0gCj4+IE1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+IApUaGFuayB5b3Us
IEkgd2lsbCByZXN1Ym1pdCBhZnRlciBtYWtpbmcgY2hhbmdlcy4KCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
