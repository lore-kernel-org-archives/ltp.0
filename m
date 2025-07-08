Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4780EC8303C
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE79E3CA1EC
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:16:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C61B43C647F
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:16:10 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id B51441BBC6F3
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:16:05 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8BxJHDS4WxoAUkkAQ--.36946S3;
 Tue, 08 Jul 2025 17:16:03 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJBxZOTQ4WxodC0OAA--.16281S3;
 Tue, 08 Jul 2025 17:16:01 +0800 (CST)
To: ltp@lists.linux.it
References: <20250708071706.19639-1-yangtiezhu@loongson.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ca899670-c391-c214-f0ad-c762cccd201b@loongson.cn>
Date: Tue, 8 Jul 2025 17:15:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250708071706.19639-1-yangtiezhu@loongson.cn>
Content-Language: en-US
X-CM-TRANSID: qMiowJBxZOTQ4WxodC0OAA--.16281S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7trWDZF1UKryUZFyfXrykXrc_yoW8ur18pr
 4Syay7tFs8tFyUAw1xAF9xZFZ2q34xCrWIgry5trykAan8J3s5GF4Iga45Zw42qryfK34I
 yF48tFWqk3WUXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit not implemented
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNS83Lzgg5LiL5Y2IMzoxNywgVGllemh1IFlhbmcgd3JvdGU6Cj4gSW4gdGhlIExpbnV4
IGtlcm5lbCwgTG9vbmdBcmNoIHVzZXMgdGhlIGdlbmVyaWMgc3lzY2FsbCB0YWJsZSB3aGljaAo+
IGlzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL3VuaXN0ZC5oLCBhbmQgYWxz
byB0aGVyZSBpcwo+IG5vIF9fQVJDSF9XQU5UX1NFVF9HRVRfUkxJTUlUIGluIGFyY2gvbG9vbmdh
cmNoL2luY2x1ZGUvYXNtL3VuaXN0ZC5oLAo+IHNvIF9fTlJfZ2V0cmxpbWl0IGlzIG5vdCBpbXBs
ZW1lbnRlZCBvbiBMb29uZ0FyY2guCj4gCj4gVGhhdCBpcyB0byBzYXksIGdldHJsaW1pdCBhcmUg
c3VwZXJzZWRlZCB3aXRoIHBybGltaXQ2NC4gVGhlcmUgaXMgbm8KPiBuZWVkIHRvIGNvbXBhcmUg
dGhlIHJldHVybiB2YWx1ZSBhbmQgZXJybm8gYWJvdXQgdGhlIHN5c2NhbGwgbnVtYmVycwo+IF9f
TlJfcHJsaW1pdDY0IGFuZCBfX05SX2dldHJsaW1pdCwganVzdCBjaGVjayB0aGlzIGNhc2UgYW5k
IHRoZW4gc2tpcAo+IHRoZSB0ZXN0LgoKLi4uCgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRpZXpodSBZ
YW5nIDx5YW5ndGllemh1QGxvb25nc29uLmNuPgo+IC0tLQo+ICAgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9nZXRybGltaXQvZ2V0cmxpbWl0MDMuYyB8IDUgKysrKysKPiAgIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9nZXRybGltaXQvZ2V0cmxpbWl0MDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZ2V0cmxpbWl0L2dldHJsaW1pdDAzLmMKPiBpbmRleCA2MDQwODJjY2YuLjJkNzkwNTdkYSAx
MDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHJsaW1pdC9nZXRybGlt
aXQwMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQvZ2V0cmxp
bWl0MDMuYwo+IEBAIC0xNjIsNiArMTYyLDExIEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBp
bnQgcmVzb3VyY2UpCj4gICAJZXJybm8gPSAwOwo+ICAgCXJldF91bCA9IGdldHJsaW1pdF91bG9u
ZyhyZXNvdXJjZSwgJnJsaW1fdWwpOwo+ICAgCWVycm5vX3VsID0gZXJybm87Cj4gKwlpZiAoZXJy
bm9fdWwgPT0gRU5PU1lTKSB7Cj4gKwkJdHN0X3JlcyhUQ09ORiB8IFRFUlJOTywKPiArCQkJIiVz
IG5vdCBpbXBsZW1lbnRlZCIsIF9fTlJfZ2V0cmxpbWl0X3Vsb25nX3N0cik7CgpTZWxmIHJldmll
dzoKCkkgYW0gbm90IHN1cmUgd2hldGhlciBpdCBzaG91bGQgYWRkIHRoZSBmb2xsb3dpbmcgY29k
ZToKCisgICAgICAgICAgICAgICB0ZXN0LnRjbnQgPSAxOwoKdG8gc2tpcCBvbmx5IG9uY2UgaWYg
X19OUl9nZXRybGltaXRfdWxvbmdfc3RyIChtYXliZSBfX05SX2dldHJsaW1pdApvciBfX05SX3Vn
ZXRybGltaXQpIG5vdCBpbXBsZW1lbnRlZC4KCj4gKwkJcmV0dXJuOwo+ICsJfQo+ICAgCj4gICAJ
aWYgKGNvbXBhcmVfcmV0dmFsKHJlc291cmNlLCByZXRfdTY0LCBlcnJub191NjQsIHJldF91bCwg
ZXJybm9fdWwsCj4gICAJCQkgICBfX05SX2dldHJsaW1pdF91bG9uZ19zdHIpIHx8Cj4gCgpJZiB5
ZXMsIGl0IGlzIG5lY2Vzc2FyeSB0byBtb2RpZnkgYW5vdGhlciBwbGFjZSBpbiB0aGlzIGZ1bmN0
aW9uLApzb21ldGhpbmcgbGlrZSB0aGlzOgoKQEAgLTE4Niw2ICsxODcsNyBAQCBzdGF0aWMgdm9p
ZCBydW4odW5zaWduZWQgaW50IHJlc291cmNlKQogICAgICAgICBpZiAoZXJybm9fbCA9PSBFTk9T
WVMpIHsKICAgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GIHwgVEVSUk5PLAogICAgICAgICAg
ICAgICAgICAgICAgICAgIl9fTlJfZ2V0cmxpbWl0KCVkKSBub3QgaW1wbGVtZW50ZWQiLCAKX19O
Ul9nZXRybGltaXQpOworICAgICAgICAgICAgICAgdGVzdC50Y250ID0gMTsKICAgICAgICAgICAg
ICAgICByZXR1cm47CiAgICAgICAgIH0KClBsZWFzZSBsZXQgbWUga25vdyB5b3VyIG9waW5pb25z
LCBzaG91bGQgSSBzcXVhc2ggdGhlIGFib3ZlIGNoYW5nZXMKaW50byB0aGlzIHBhdGNoIG9yIHNo
b3VsZCBJIHNlbmQgYSBzbWFsbCBwYXRjaCBzZXJpZXMgd2l0aCB0d28gcGF0Y2hlcz8KClRoYW5r
cywKVGllemh1CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
