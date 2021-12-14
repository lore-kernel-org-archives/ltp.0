Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EC4C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 02:59:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F1473C8B34
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 03:59:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0B143C0939
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 03:58:54 +0100 (CET)
Received: from smtpproxy21.qq.com (smtpbg704.qq.com [203.205.195.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E90D601F01
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 03:58:46 +0100 (CET)
X-QQ-mid: bizesmtp53t1639450719tejnskg8
Received: from [10.4.23.202] (unknown [58.240.82.166])
 by esmtp6.qq.com (ESMTP) with 
 id ; Tue, 14 Dec 2021 10:58:19 +0800 (CST)
X-QQ-SSF: 0040000000000070E000B00D0000000
X-QQ-FEAT: 3uawQE1sH+1w4E+y4CpRTyZrAyCCEJTaPs7hyaUngiBB3ibNW7mIVN3d42EzY
 OxqHzWxfjaW7szzQ33WfRAm6mp4yrEj2Ujj08ll1eHOD4ke62oFdcYXEs8uadu7HjEFCRx3
 bE4rBdoMaEhf48jEum3GHFKDJZp9dMD6JdEe7ZZI93bFq0XwMpbyypDeZ+8nFfhHmJlJ0AO
 QQU5thojhWfFxurAhf2Wp+Zp/UwI7vPgrYmkpsu0AoXAWlakKRrkdV2XQgeSwqYDbEYE3A8
 Qv/9TJBaLqehnxd3LSUIk8wjVFQ+7UPhZw0coXvQgLwBQIOxpBsJlKE4ZNiWYP5CM5R8ynJ
 JmojxBDPYPCKq2qfEId9PZ/KRaUew==
X-QQ-GoodBg: 2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20211213034213.10306-1-sujiaxun@uniontech.com>
 <YbdvYXQ1CwjzhjO6@yuki>
From: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <f0d90607-733c-6635-60d1-8405751d0fe0@uniontech.com>+23844CAD7E7B1ECD
Date: Tue, 14 Dec 2021 10:58:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YbdvYXQ1CwjzhjO6@yuki>
Content-Language: en-US
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v1] syscalls/symlinkat01: Convert to new API
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

1NogMjAyMS8xMi8xNCDJz87nMTI6MDUsIEN5cmlsIEhydWJpcyDQtLXAOgo+IEhpIQo+PiAtc3Rh
dGljIHZvaWQgbXlzeW1saW5rYXRfdGVzdChzdHJ1Y3QgdGVzdF9zdHJ1Y3QgKmRlc2MpCj4+ICtz
dGF0aWMgdm9pZCBydW5fdGVzdCh1bnNpZ25lZCBpbnQgbnIpCj4+ICAgewo+PiAgIAlpbnQgZmQ7
Cj4+ICsJc3RydWN0IHRlc3RfY2FzZSAqdGMgPSAmdGNhc2VzW25yXTsKPj4gKwo+PiArCXNldHVw
X2V2ZXJ5X2NvcHkoKTsKPj4KPj4gLQlURVNUKG15c3ltbGlua2F0KGRlc2MtPm9sZGZuLCAqZGVz
Yy0+bmV3ZmQsIGRlc2MtPm5ld2ZuKSk7Cj4+IC0KPj4gLQkvKiBjaGVjayByZXR1cm4gY29kZSAq
Lwo+PiAtCWlmIChURVNUX0VSUk5PID09IGRlc2MtPmV4cGVjdGVkX2Vycm5vKSB7Cj4+IC0JCWlm
IChURVNUX1JFVFVSTiA9PSAwICYmIGRlc2MtPnJlZmVyZW5jZWZuMSAhPSBOVUxMKSB7Cj4+ICsJ
VEVTVCh0c3Rfc3lzY2FsbChfX05SX3N5bWxpbmthdCwgdGMtPm9sZGZuLCAqdGMtPm5ld2ZkLCB0
Yy0+bmV3Zm4pKTsKPj4gKwlpZiAoVFNUX0VSUiA9PSB0Yy0+ZXhwZWN0ZWRfZXJybm8pIHsKPj4g
KwkJaWYgKFRTVF9SRVQgPT0gMCAmJiB0Yy0+cmVmZXJlbmNlZm4xICE9IE5VTEwpIHsKPj4gICAJ
CQlpbnQgdG51bSA9IHJhbmQoKSwgdm51bSA9IH50bnVtOwo+Pgo+PiAtCQkJZmQgPSBTQUZFX09Q
RU4oY2xlYW51cCwgZGVzYy0+cmVmZXJlbmNlZm4xLCBPX1JEV1IpOwo+PiAtCQkJU0FGRV9XUklU
RShjbGVhbnVwLCAxLCBmZCwgJnRudW0sIHNpemVvZih0bnVtKSk7Cj4+IC0JCQlTQUZFX0NMT1NF
KGNsZWFudXAsIGZkKTsKPj4gKwkJCWZkID0gU0FGRV9PUEVOKHRjLT5yZWZlcmVuY2VmbjEsIE9f
UkRXUik7Cj4+ICsJCQlTQUZFX1dSSVRFKDEsIGZkLCAmdG51bSwgc2l6ZW9mKHRudW0pKTsKPj4g
KwkJCVNBRkVfQ0xPU0UoZmQpOwo+Pgo+PiAtCQkJZmQgPSBTQUZFX09QRU4oY2xlYW51cCwgZGVz
Yy0+cmVmZXJlbmNlZm4yLCBPX1JET05MWSk7Cj4+IC0JCQlTQUZFX1JFQUQoY2xlYW51cCwgMSwg
ZmQsICZ2bnVtLCBzaXplb2Yodm51bSkpOwo+PiAtCQkJU0FGRV9DTE9TRShjbGVhbnVwLCBmZCk7
Cj4+ICsJCQlmZCA9IFNBRkVfT1BFTih0Yy0+cmVmZXJlbmNlZm4yLCBPX1JET05MWSk7Cj4+ICsJ
CQlTQUZFX1JFQUQoMSwgZmQsICZ2bnVtLCBzaXplb2Yodm51bSkpOwo+PiArCQkJU0FGRV9DTE9T
RShmZCk7Cj4+Cj4+ICAgCQkJaWYgKHRudW0gPT0gdm51bSkKPj4gLQkJCQl0c3RfcmVzbShUUEFT
UywgIlRlc3QgcGFzc2VkIik7Cj4+ICsJCQkJdHN0X3JlcyhUUEFTUywgIlRlc3QgcGFzc2VkIik7
Cj4+ICAgCQkJZWxzZQo+PiAtCQkJCXRzdF9yZXNtKFRGQUlMLAo+PiArCQkJCXRzdF9yZXMoVEZB
SUwsCj4+ICAgCQkJCQkgIlRoZSBsaW5rIGZpbGUncyBjb250ZW50IGlzbid0IGFzIHNhbWUgYXMg
dGhlIG9yaWdpbmFsIGZpbGUncyAiCj4+ICAgCQkJCQkgImFsdGhvdWdoIHN5bWxpbmthdCByZXR1
cm5lZCAwIik7Cj4+ICAgCQl9IGVsc2Ugewo+PiAtCQkJdHN0X3Jlc20oVFBBU1MsCj4+ICsJCQl0
c3RfcmVzKFRQQVNTLAo+PiAgIAkJCQkgInN5bWxpbmthdCgpIHJldHVybmVkIHRoZSBleHBlY3Rl
ZCAgZXJybm8gJWQ6ICVzIiwKPj4gLQkJCQkgVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJO
TykpOwo+PiArCQkJCSBUU1RfRVJSLCBzdHJlcnJvcihUU1RfRVJSKSk7Cj4+ICAgCQl9Cj4gCj4g
SSB0aGluayB0aGF0IHRoZSB0ZXN0IHdvdWxkIGJlIG11Y2ggY2xlYXJlciB0byByZWFkIGlmIHdl
IHNwbGl0IGl0IGludG8KPiB0d28gdGVzdGNhc2VzLCBvbmUgdGhhdCBjaGVja3MgZm9yIHN1Y2Nl
c3NmdWxsIHN5bWxpbmsgY3JlYXRpbmcgYW5kIG9uZQo+IHRoYXQgY2hlY2tzIGZvciBlcnJvcnMu
IFRoZW4gd2UgY291bGQgZWFzaWx5IHVzZSB0aGUgVFNUX0VYUF9GQUlMKCkKPiBtYWNyb3MgZXRj
Lgo+IAo+PiAgIAl9IGVsc2Ugewo+PiAtCQl0c3RfcmVzbShURkFJTCwKPj4gLQkJCSBURVNUX1JF
VFVSTiA9PQo+PiArCQl0c3RfcmVzKFRGQUlMLAo+PiArCQkJIFRTVF9SRVQgPT0KPj4gICAJCQkg
MCA/ICJzeW1saW5rYXQoKSBzdXJwcmlzaW5nbHkgc3VjY2VlZGVkIiA6Cj4+IC0JCQkgInN5bWxp
bmthdCgpIEZhaWxlZCwgZXJybm89JWQgOiAlcyIsIFRFU1RfRVJSTk8sCj4+IC0JCQkgc3RyZXJy
b3IoVEVTVF9FUlJOTykpOwo+PiArCQkJICJzeW1saW5rYXQoKSBGYWlsZWQsIGVycm5vPSVkIDog
JXMiLCBUU1RfRVJSLAo+PiArCQkJIHN0cmVycm9yKFRTVF9FUlIpKTsKPj4gICAJfQo+PiAgIH0K
Pj4KPj4gQEAgLTIxNCwyNyArMTQ1LDI0IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4+ICAg
ewo+PiAgIAljaGFyICp0bXA7Cj4+ICAgCWludCBmZDsKPj4gLQo+PiAtCXRzdF9zaWcoTk9GT1JL
LCBERUZfSEFORExFUiwgY2xlYW51cCk7Cj4+IC0KPj4gLQl0c3RfdG1wZGlyKCk7Cj4+IC0KPj4g
LQlTQUZFX01LRElSKGNsZWFudXAsIFRFU1RfRElSMSwgMDcwMCk7Cj4+IC0JU0FGRV9NS0RJUihj
bGVhbnVwLCBURVNUX0RJUjMsIDA3MDApOwo+PiAtCW9sZGRpcmZkID0gU0FGRV9PUEVOKGNsZWFu
dXAsIFRFU1RfRElSMSwgT19ESVJFQ1RPUlkpOwo+PiAtCWRlbGRpcmZkID0gU0FGRV9PUEVOKGNs
ZWFudXAsIFRFU1RfRElSMywgT19ESVJFQ1RPUlkpOwo+PiAtCVNBRkVfUk1ESVIoY2xlYW51cCwg
VEVTVF9ESVIzKTsKPj4gLQlmZCA9IFNBRkVfT1BFTihjbGVhbnVwLCBURVNUX0RJUjEgIi8iIFRF
U1RfRklMRTEsIE9fQ1JFQVQgfCBPX0VYQ0wsIDA2MDApOwo+PiAtCVNBRkVfQ0xPU0UoY2xlYW51
cCwgZmQpOwo+PiArCj4+ICsJU0FGRV9NS0RJUihURVNUX0RJUjEsIDA3MDApOwo+PiArCVNBRkVf
TUtESVIoVEVTVF9ESVIzLCAwNzAwKTsKPj4gKwlvbGRkaXJmZCA9IFNBRkVfT1BFTihURVNUX0RJ
UjEsIE9fRElSRUNUT1JZKTsKPj4gKwlkZWxkaXJmZCA9IFNBRkVfT1BFTihURVNUX0RJUjMsIE9f
RElSRUNUT1JZKTsKPj4gKwlTQUZFX1JNRElSKFRFU1RfRElSMyk7Cj4+ICsJZmQgPSBTQUZFX09Q
RU4oVEVTVF9ESVIxICIvIiBURVNUX0ZJTEUxLCBPX0NSRUFUIHwgT19FWENMLCAwNjAwKTsKPj4g
KwlTQUZFX0NMT1NFKGZkKTsKPj4KPj4gICAJLyogZ3JhdHVpdG91cyBtZW1vcnkgbGVhayBoZXJl
ICovCj4+ICAgCXRtcCA9IHN0cmR1cChkcGF0aG5hbWUpOwo+PiAgIAlzbnByaW50ZihkcGF0aG5h
bWUsIHNpemVvZihkcGF0aG5hbWUpLCB0bXAsIGdldF9jdXJyZW50X2Rpcl9uYW1lKCkpOwo+IAo+
IENhbiB3ZSBmaXggdGhpcyBtZXNzIGFzIHdlbGw/IFRoZXJlIGlzIG5vIHBvaW50IGFjdHVhbGx5
IGluIGhhdmluZyB0aGUKPiBmb3JtYXQgaW4gYSB2YXJpYWJsZSBsaWtlIHRoaXMgd2UgY2FuIGVh
c2lseSBpbnN0ZWFkIGRvOgo+IAo+IAljaGFyICpwd2Q7Cj4gCj4gCXB3ZCA9IGdldF9jdXJyZW50
X2Rpcl9uYW1lKCk7Cj4gCXNucHJpbnRmKGRwYXRobmFtZSwgc2l6ZW9mKGRwYWh0bmFtZSksICIl
cy8iIFRFU1RESVIyICIvIiBURVNUX0ZJTEUxLCBwd2QpOwo+IAlmcmVlKHB3ZCk7Cj4gCj4gQW5k
IHRoYXQgZml4ZXMgdHdvIG1lbW9yeSBsZWFrcyB3ZSBoYWQgdGhlcmUuCj4gCj4+IC0KPj4gLQlU
RVNUX1BBVVNFOwo+PiAgIH0KPj4KPj4gLXN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPj4gLXsK
Pj4gLQl0c3Rfcm1kaXIoKTsKPj4gLX0KPj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9
IHsKPj4gKyAgICAubWluX2t2ZXIgPSAiMi42LjE2IiwKPj4gKwkuc2V0dXAgPSBzZXR1cCwKPj4g
KyAgICAudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPj4gKyAgICAudGVzdCA9IHJ1bl90ZXN0
LAo+PiArICAgIC5uZWVkc190bXBkaXIgPSAxLAo+PiArfTsKPiAKPiBPdGhlciB0aGFuIHRoYXQg
dGhlcmUgYXJlIGEgZmV3IHdoaXRlc3BhY2VzIHdyb25nLCBzZWUgb3V0cHV0IG9mCj4gJ21ha2Ug
Y2hlY2snCj4gClRoYW5rIHlvdSwgSSB3aWxsIHJlc3VibWl0IGFmdGVyIG1ha2luZyBjaGFuZ2Vz
LgoKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
