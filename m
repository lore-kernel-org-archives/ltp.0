Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E179FC00144
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 01:36:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D2933C1ADE
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 03:36:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 102CC3C0F97
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 03:35:47 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 35DFE2000D9
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 03:35:43 +0200 (CEST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeBsluBiQh87AA--.37557S3; 
 Wed, 27 Jul 2022 09:35:40 +0800 (CST)
To: Petr Vorel <pvorel@suse.cz>
References: <1658386911-890-1-git-send-email-zhanghongchen@loongson.cn>
 <Yt/WI0ABJpMfXLjk@pevik>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <c380d186-e0b8-9613-3c5f-6eb21bc6e03c@loongson.cn>
Date: Wed, 27 Jul 2022 09:35:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yt/WI0ABJpMfXLjk@pevik>
Content-Language: en-US
X-CM-TRANSID: AQAAf9AxWeBsluBiQh87AA--.37557S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4rWw1UXw1UWrW8ArWxCrg_yoW5CFyrpa
 9xt3W2yr48Jr42yrs7ZayDZ34fZ3y8GF47uws0qay8ZFs3u3s3KF4vg3yF9ryUurWIkr4r
 Zw40yr9xGFWDAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
 0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
 r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
 0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
 XVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
 CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
 67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
 9x07bOoGdUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] float: convert to new LTP API
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

T24gMjAyMi83LzI2IOS4i+WNiDc6NTUsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgSG9uZ2NoZW4s
Cj4gCj4gdGhhbmsgeW91IGZvciB5b3VyIGVmZm9ydCwgYnV0IG11Y2ggbW9yZSBuZWVkcyB0byBi
ZSBkb25lLgo+IAo+IENvZGUgaW4gd2hvbGUgcHJvamVjdCAoYWxsIHNvdXJjZXMgaW4gdGVzdGNh
c2VzL21pc2MvbWF0aC9mbG9hdCkgaXMgdmVyeSBvbGQgYW5kCj4gSU1ITyB3ZWlyZC4gSSBzdGls
bCB3b25kZXIgd2h5IHRlc3RpbmcgZmxvYXQgLyBtYXRoIGZ1bmN0aW9ucyByZXF1aXJlcyBjcmVh
dGluZwo+IGZpbGVzLCB1c2luZyBwdGhyZWFkIChpbiB0aHJlYWRfY29kZS5jKSwgLi4uIEl0J2Qg
YmUgd29ydGggdG8gaGF2ZSBsb29rIHdoZXRoZXIKPiBjdXJyZW50IGFwcHJvYWNoIGlzIHJlYWxs
eSB1c2VmdWwgYmVmb3JlIHNwZW5kaW5nIHRpbWUgdG8gcmV3cml0ZSBpdC4KPiAKPiBTb21lIG5v
dGVzIHRvIHlvdXIgcmV3cml0ZS4gbWFpbi5jIGFuZCB0aHJlYWRfY29kZS5jIHNob3VsZCBiZSB0
dXJuZWQgaW50bwo+IGhlYWRlciBmaWxlIChlLmcuIGZsb2F0LmgpIHdpdGggZnVuY3Rpb25zIGJl
aW5nIHN0YXRpYyBpbmxpbmUuIEJlY2F1c2UKPiBpbmNsdWRpbmcgQyBmaWxlcyBpcyBuby1nby4K
PiAKPj4gICB0ZXN0Y2FzZXMvbWlzYy9tYXRoL2Zsb2F0L21haW4uYyB8IDQ0NiArKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAuLi4KPj4gLWNvbnN0IGludCBuYl9mdW5j
ID0gTkJfRlVOQzsKPj4gK3N0YXRpYyBjaGFyICpEb3B0LCAqbG9wdCwgKm5vcHQsICp2b3B0Owo+
PiArc3RhdGljIHN0cnVjdCB0c3Rfb3B0aW9uIG9wdFtdID0gewo+PiArCXsiRDoiLCAmRG9wdCwg
ICAiREFUQSBkaXJlY3RvcnkncyBhYnNvbHV0ZSBwYXRoIn0sCj4gSU1ITyB0aGlzIHNob3VsZCBu
b3QgYmUgbmVlZGVkLCBldmVyeXRoaW5nIHNob3VsZCBiZSBpbiB0ZXN0IHRlbXBvcmFyeQo+IGRp
cmVjdG9yeSwgdGhlcmUgaXMgbm8gbmVlZCB0byBwdXQgaXQgZWxzZXdoZXJlLgo+PiArCXsibDoi
LCAmbG9wdCwgInNldCBudW1iZXIgb2YgbG9vcHMgcGVyIGZ1bmN0aW9uIn0sCj4+ICsJeyJuOiIs
ICZub3B0LCAic2V0IG51bWJlciBvZiB0aHJlYWRzIHBlciBmdW5jdGlvbiJ9LAo+PiArCXsidiIs
ICZ2b3B0LCAiZGVidWcgbGV2ZWwifSwKPiBJJ2QgZ2V0IHJpZCBvZiB0aGUgZGVidWdnaW5nIChp
bXBvcnRhbnQgdGhpbmdzIHNob3VsZCBiZSBhbHdheXMgcHJpbnRlZCkuCj4gCj4+ICsJe30KPj4g
K307Cj4gCj4+ICAgaW50IGdlbmVyYXRlKGNoYXIgKmRhdGFkaXIsIGNoYXIgKmJpbl9wYXRoKQo+
PiAgIHsKPj4gICAJY2hhciAqY21kbGluZTsKPj4gICAJY2hhciAqZm10ID0gImNkICVzOyAlcy8l
cyAlcyI7Cj4gCj4+IC0JY21kbGluZSA9IG1hbGxvYygyICogc3RybGVuKGJpbl9wYXRoKSArIHN0
cmxlbihkYXRhZGlyKSArIHN0cmxlbihHRU5FUkFUT1IpICsgc3RybGVuKGZtdCkpOwo+PiArCWNt
ZGxpbmUgPSBtYWxsb2MoMiAqIHN0cmxlbihiaW5fcGF0aCkgKyBzdHJsZW4oZGF0YWRpcikgKwo+
PiArCQkJCXN0cmxlbihHRU5FUkFUT1IpICsgc3RybGVuKGZtdCkpOwo+PiAgIAlpZiAoY21kbGlu
ZSA9PSBOVUxMKQo+PiAgIAkJcmV0dXJuICgxKTsKPiBUaGVyZSBpcyBTQUZFX01BTExPQygpLCBu
byBuZWVkIHRvIGNoZWNrIGZvciBOVUxMLgo+IAo+PiAgIAlzcHJpbnRmKGNtZGxpbmUsIGZtdCwg
ZGF0YWRpciwgYmluX3BhdGgsIEdFTkVSQVRPUiwgYmluX3BhdGgpOwo+PiBAQCAtOTMsMzQ1ICs1
NSwxMzcgQEAgaW50IGdlbmVyYXRlKGNoYXIgKmRhdGFkaXIsIGNoYXIgKmJpbl9wYXRoKQo+PiAg
IAlyZXR1cm4gKDApOwo+IAo+IEFsc28gY29kZSBzdHlsZSBzdWdnZXN0cyBpdCdzIHZlcnkgb2xk
LiBicmFja2V0cyBhcm91bmQgaW50ZWdlciBpbiByZXR1cm4gaXMKPiBxdWl0ZSBzdHJhbmdlIChp
LmUuICJyZXR1cm4gKDApOyIpLgo+PiAgIH0KPiAKPiAKPj4gICAJbHRwcm9vdCA9IGdldGVudigi
TFRQUk9PVCIpOwo+PiAgIAlpZiAobHRwcm9vdCA9PSBOVUxMIHx8IHN0cmxlbihsdHByb290KSA9
PSAwKSB7Cj4+IC0JCXRzdF9icmttKFRCUk9LLCBOVUxMLAo+PiArCQl0c3RfYnJrKFRCUk9LLAo+
PiAgIAkJCSAiWW91IG11c3Qgc2V0ICRMVFBST09UIGJlZm9yZSBleGVjdXRpbmcgdGhpcyB0ZXN0
Iik7Cj4gCj4gZ2VuZXJhdGUoKSBmdW5jdGlvbiB3aGljaCBydW5zIGJpbmFyeSBzaG91bGQgYmUg
cmVwbGFjZWQgd2l0aCB0c3RfY21kKCkuCj4gSU1ITyB3ZSBkb24ndCBuZWVkIHRvIGNoZWNrIGZv
ciAkTFRQUk9PVCwgYmVjYXVzZSB3ZSBleHBlY3QgUEFUSCB0byBiZSBzZXQKPiBjb3JyZWN0bHku
Cj4gCj4+ICAgCX0KPj4gICAJYmluX3BhdGggPSBtYWxsb2Moc3RybGVuKGx0cHJvb3QpICsgMTYp
Owo+PiAgIAlpZiAoYmluX3BhdGggPT0gTlVMTCkgewo+IFNBRkVfTUFMTE9DKCkgKGluIG1hbnkg
cGxhY2VzKQo+PiAtCQl0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywgTlVMTCwgIm1hbGxvYyBmYWls
ZWQiKTsKPj4gKwkJdHN0X2JyayhUQlJPSywgIm1hbGxvYyBmYWlsZWQiKTsKPj4gICAJfQo+IC4u
Lgo+IAo+PiArdm9pZCBydW4odW5zaWduZWQgaW50IG4pCj4+ICt7Cj4+ICsJdm9pZCAqZXhpdF92
YWx1ZTsKPj4gKwlwdGhyZWFkX2F0dHJfdCBuZXdhdHRyOwo+PiArCXNpemVfdCBzdGFja3NpemUg
PSAyMDkzMDU2Owo+IEknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHBvcnRhYmxlIGZvciBhbGwgYXJj
aHMgYW5kIEknZCB1c2UgI2RlZmluZSBhdCB0aGUgdG9wLgo+IAo+IC4uLgo+PiArc3RhdGljIHN0
cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+PiArCS50ZXN0ID0gcnVuLAo+PiArCS5zZXR1cCA9IHNl
dHVwLAo+PiArCS5vcHRpb25zID0gb3B0LAo+PiArCS5uZWVkc19yb290ID0gMSwKPj4gKwkubmVl
ZHNfdG1wZGlyID0gMSwKPj4gKwkudGNudCA9IE5CX0ZVTkMsCj4+ICt9Owo+IAo+IHN0cnVjdCB0
c3RfdGVzdCB0ZXN0IHNob3VsZCBiZSBkZWZpbmVkIGluIGZsb2F0Ki5jIHRlc3RzLCBub3QgaW4g
dGhpcwo+IGNvbW1vbiBmaWxlIGluY2x1ZGVkIGJ5IHRlc3RzLgo+IAo+IEtpbmQgcmVnYXJkcywK
PiBQZXRyCj4gCkhpIFBldHIsCgpUaGFua3MgZm9yIHlvdSByZXZpZXcsSSB3aWxsIGNoYW5nZSB0
aGUgY29kZSBhcyB5b3Ugc2FpZCBsYXRlci4KCkJlc3QgUmVnYXJkcy4KCkhvbmdjaGVuIFpoYW5n
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
