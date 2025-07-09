Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3AEC8303C
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 01:42:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79D553CA6A4
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 03:42:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EBCB3C6AE2
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 03:42:11 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id BF80D600FF0
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 03:42:08 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Axx2nsyG1oKfMkAQ--.44612S3;
 Wed, 09 Jul 2025 09:42:04 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJAxT+bryG1ofEIPAA--.22453S3;
 Wed, 09 Jul 2025 09:42:04 +0800 (CST)
To: Li Wang <liwang@redhat.com>
References: <20250708112810.3298-1-yangtiezhu@loongson.cn>
 <CAEemH2ejmvUVrYTgeCM-i=GAZLZ4aDStLWtGKTor2sFKgXq7mQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e136794c-086d-ea25-9dac-e523c8455279@loongson.cn>
Date: Wed, 9 Jul 2025 09:42:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEemH2ejmvUVrYTgeCM-i=GAZLZ4aDStLWtGKTor2sFKgXq7mQ@mail.gmail.com>
Content-Language: en-US
X-CM-TRANSID: qMiowJAxT+bryG1ofEIPAA--.22453S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4xJryrGr17tFyfZry3Jrc_yoW8uFWfpr
 4Sya47KFZ8tF18AF1Ik3yfXFy3Jr4xG3y3tryrKF95A3W5Gw1SgFn29a909F17XrZ5Ka17
 tF1jqayDZa1DJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit_ulong not implemented
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

T24gMjAyNS83Lzgg5LiL5Y2IOToxMCwgTGkgV2FuZyB3cm90ZToKPiAKPiAKPiBPbiBUdWUsIEp1
bCA4LCAyMDI1IGF0IDc6MjjigK9QTSBUaWV6aHUgWWFuZyA8eWFuZ3RpZXpodUBsb29uZ3Nvbi5j
biAKPiA8bWFpbHRvOnlhbmd0aWV6aHVAbG9vbmdzb24uY24+PiB3cm90ZToKPiAKPiAgICAgSW4g
dGhlIExUUCBjb2RlLCBfX05SX2dldHJsaW1pdF91bG9uZyBpcyBkZWZpbmVkIGFzIF9fTlJfdWdl
dHJsaW1pdAo+ICAgICBvciBfX05SX2dldHJsaW1pdC4KPiAKPiAgICAgSW4gdGhlIExpbnV4IGtl
cm5lbCwgTG9vbmdBcmNoIHVzZXMgdGhlIGdlbmVyaWMgc3lzY2FsbCB0YWJsZQo+ICAgICB3aGlj
aCBpcyBkZWZpbmVkIGluIGluY2x1ZGUvdWFwaS9hc20tZ2VuZXJpYy91bmlzdGQuaC4gV2UgY2Fu
Cj4gICAgIHNlZSB0aGF0IF9fTlJfdWdldHJsaW1pdCBpcyBub3QgZGVmaW5lZCBpbiB0aGUgZ2Vu
ZXJpYyBoZWFkZXIsCj4gICAgIGFuZCBhbHNvIHRoZXJlIGlzIG5vIF9fQVJDSF9XQU5UX1NFVF9H
RVRfUkxJTUlUIGRlZmluaXRpb24gaW4KPiAgICAgdGhlIGFyY2ggc3BlY2lmaWMgaGVhZGVyIGFy
Y2gvbG9vbmdhcmNoL2luY2x1ZGUvYXNtL3VuaXN0ZC5oLAo+ICAgICBzbyBib3RoIF9fTlJfdWdl
dHJsaW1pdCBhbmQgX19OUl9nZXRybGltaXQgYXJlIG5vdCBpbXBsZW1lbnRlZAo+ICAgICBvbiBM
b29uZ0FyY2guCj4gCj4gICAgIFRoYXQgaXMgdG8gc2F5LCBubyBuZWVkIHRvIGNvbXBhcmUgdGhl
IHJldHVybiB2YWx1ZSBhbmQgZXJybm8KPiAgICAgYWJvdXQgdGhlIHN5c2NhbGwgbnVtYmVycyBf
X05SX3BybGltaXQ2NCBhbmQgX19OUl97dX1nZXRybGltaXQsCj4gICAgIGp1c3QgY2hlY2sgdGhp
cyBjYXNlIGFuZCB0aGVuIHNraXAgdGhlIHRlc3QuCj4gCj4gICAgIFdoaWxlIGF0IGl0LCBtb2Rp
ZnkgdGhlIHZhbHVlIG9mIHRlc3QudGNudCBhcyAxIHRvIHNraXAgb25seQo+ICAgICBvbmNlIGlm
IHRoZSBlcnJubyBvZiBnZXRybGltaXRfdWxvbmcoKSBvciBnZXRybGltaXRfbG9uZygpIGlzCj4g
ICAgIEVOT1NZUy4KCi4uLgoKPiAgICAgQEAgLTE4MSw2ICsxODcsNyBAQCBzdGF0aWMgdm9pZCBy
dW4odW5zaWduZWQgaW50IHJlc291cmNlKQo+ICAgICAgwqAgwqAgwqAgwqAgaWYgKGVycm5vX2wg
PT0gRU5PU1lTKSB7Cj4gICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0c3RfcmVzKFRDT05G
IHwgVEVSUk5PLAo+ICAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgIl9f
TlJfZ2V0cmxpbWl0KCVkKSBub3QgaW1wbGVtZW50ZWQiLAo+ICAgICBfX05SX2dldHJsaW1pdCk7
Cj4gCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRlc3QudGNudCA9IDE7Cj4gCj4gCj4g
VGhpcyBzZWNvbmQgdGVzdC50Y250IHJlc2V0dGluZyBpcyByZWR1bmRhbnQsIGlmIHRoZSBTSUdO
RURfR0VUUkxJTUlUCj4gZ2V0IGRlZmluZWQsIHRoYXQgbWVhbnMgYm90aCBfX05SX2dldHJsaW1p
dCBhbmQgX19OUl91Z2V0cmxpbWl0IGFyZSAKPiBkZXRlY3RlZCwKPiBhbmQgdGhlIG9ubHkgbmVn
YXRpdmUgc2l0dWF0aW9uIGlzIGdldHJsaW1pdF91bG9uZyhyZXNvdXJjZSwgJnJsaW1fdWwpOwo+
IHdvcmtzIHdlbGwsIGJ1dCBnZXRybGltaXRfbG9uZyhyZXNvdXJjZSwgJnJsaW1fbCk7IHJldHVy
biBFTk9TWVMsIHRvIAo+IG1ha2UgdGhlCj4gdGVzdCBjYW4gYmUgaW50ZXJhY3Rpb24gdGhlIHNl
Y29uZCBzaG91bGQgbm8gdGVzdC50Y250ID0gMS4KPiAKPiBTZWU6IAo+IGh0dHBzOi8vZ2l0aHVi
LmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC9mYWM3ODNiNWQ2NjMxZWZhNzBkMmVh
MzI1NzE0Mjc2M2Q5NDRiYTMyCj4gCj4gQW55d2F5LCBJIG1vZGlmaWVkIHRoZSBwYXRjaCBhbmQg
bWVyZ2VkIQoKVGhhbmsgeW91LiBJZiBzbywgaXQgaXMgYmV0dGVyIHRvIHJlbW92ZSAib3IgZ2V0
cmxpbWl0X2xvbmcoKSIgaW4gdGhlCmNvbW1pdCBtZXNzYWdlIHRvIHJlZmxlY3QgdGhlIHJlYWxp
dHksIGxpa2UgdGhpczoKCiJXaGlsZSBhdCBpdCwgbW9kaWZ5IHRoZSB2YWx1ZSBvZiB0ZXN0LnRj
bnQgYXMgMSB0byBza2lwIG9ubHkKb25jZSBpZiB0aGUgZXJybm8gb2YgZ2V0cmxpbWl0X3Vsb25n
KCkgaXMgRU5PU1lTLiIKCklmIHBvc3NpYmxlLCBnaXQgY29tbWl0IC0tYW1lbmQgYW5kIGdpdCBw
dXNoIC0tZm9yY2UgY2FuIG1ha2UgdGhlIGxvZwptb3JlIGNsZWFyLgoKVGhhbmtzLApUaWV6aHUK
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
