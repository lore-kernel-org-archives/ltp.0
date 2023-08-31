Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5EDC83F29
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 08:51:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6CC83CBF3C
	for <ltp@archiver.kernel.org>; Thu, 31 Aug 2023 10:51:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FAC93C9422
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 10:51:30 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id B32A214044B9
 for <ltp@lists.linux.it>; Thu, 31 Aug 2023 10:51:26 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.176])
 by gateway (Coremail) with SMTP id _____8BxXeuMVPBkZGAdAA--.54940S3;
 Thu, 31 Aug 2023 16:51:24 +0800 (CST)
Received: from [10.180.13.176] (unknown [10.180.13.176])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx_c6LVPBkDPtnAA--.54954S3; 
 Thu, 31 Aug 2023 16:51:23 +0800 (CST)
To: rpalethorpe@suse.de
References: <20230830064250.31904-1-zhanghongchen@loongson.cn>
 <87r0nlhsh7.fsf@suse.de> <d9b87423-f3e3-1585-1f3a-3821622ef040@loongson.cn>
 <871qfjiowk.fsf@suse.de>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <442a6c1d-8410-5e94-bba0-96980472c68c@loongson.cn>
Date: Thu, 31 Aug 2023 16:51:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871qfjiowk.fsf@suse.de>
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx_c6LVPBkDPtnAA--.54954S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAAB2TwEzQD5gABsR
X-Coremail-Antispam: 1Uk129KBj93XoWxGr4UJF43Zw4fXryrGrWUZFc_yoW5Ww43pF
 WSyay2yr4DJFnxCa1IkasxAr1Iva48tF48WrZ3Cr1kZrnIyF1fCF18Gr4FkF9FgryFga45
 Ka4UCFZxWas8tFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cpuset_memory_spread: set lowerlimit according
 to pagesize
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

T24gMjAyMy84LzMxIOS4i+WNiDQ6MjcsIFJpY2hhcmQgUGFsZXRob3JwZSB3cm90ZToKPiBIZWxs
bywKPiAKPiBIb25nY2hlbiBaaGFuZyA8emhhbmdob25nY2hlbkBsb29uZ3Nvbi5jbj4gd3JpdGVz
Ogo+IAo+PiBIaSBSaWNoYXJkLAo+Pgo+PiBPbiAyMDIzLzgvMzAg5LiL5Y2IMzo0NSwgUmljaGFy
ZCBQYWxldGhvcnBlIHdyb3RlOgo+Pj4gSGVsbG8sCj4+PiBIb25nY2hlbiBaaGFuZyA8emhhbmdo
b25nY2hlbkBsb29uZ3Nvbi5jbj4gd3JpdGVzOgo+Pj4KPj4+PiBXaGVuIEkgdGVzdCB0aGUgY3B1
c2V0X21lbW9yeV9zcHJlYWQgY2FzZSx0aGlzIGNhc2UgRkFJTCB0b28gb2Z0ZW4uCj4+Pj4gQWZ0
ZXIgZGlnIGludG8gdGhlIGNvZGUsIEkgZmluZCBvdXQgdGhhdCB0aGUgZm93bGxvaW5nIHRoaW5n
cyB0cmlnZ2VyCj4+Pj4gdGhlIEZBSUw6Cj4+Pj4gMSkgcmFuZG9tIGV2ZW50cyx0aGUgcHJvYmFi
aWxpdHkgaXMgdmVyeSBzbWFsbCBhbmQgY2FuIGJlIGlnbm9yZWQKPj4+PiAyKSBnZXRfbWVtaW5m
byB3aGljaCBiZWZvcmUgc2VuZCBzaWduYWwgdG8gdGVzdF9waWQKPj4+PiAzKSBhY2NvdW50X21l
bXNpbmZvIGJlZm9yZSByZXN1bHRfY2hlY2sKPj4+Pgo+Pj4+IEFib3V0IDIpIGFuZCAzKSwgd2Ug
Y2FuIGluY3JlYXNlIHRoZSB2YWx1ZSBvZiBsb3dlcmxpbWl0IHRvIGtlZXAKPj4+PiB0aGUgcmVz
dWx0IGFzIFNVQ0NFU1MuCj4+Pj4KPj4+PiBBZnRlciBkaXNjdXNzaW5nIHdpdGggUmljaGFyZCwg
d2UgYWxsIGFncmVlIHRvIHVzZSB0aGUgZm9sbG93aW5nCj4+Pj4gZm9ybXVsYSB0byBjYWxjdWxh
dGUgdGhlIGxvd2VybGltaXQ6Cj4+Pj4gbG93ZXJsaW1pdChrYikgPSBwYWdlc2l6ZShieXRlKSAq
IDUxMiAvIDEwMjQKPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEhvbmdjaGVuIFpoYW5nIDx6aGFu
Z2hvbmdjaGVuQGxvb25nc29uLmNuPgo+Pj4+IC0tLQo+Pj4+ICAgIC4uLi9jcHVzZXRfbWVtb3J5
X3NwcmVhZF90ZXN0c2V0LnNoICAgICAgICAgICAgICAgICAgICB8IDEwICsrKysrKysrKy0KPj4+
PiAgICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pj4K
Pj4+PiBkaWZmIC0tZ2l0Cj4+Pj4gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNl
dC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3RzZXQu
c2gKPj4+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9tZW1v
cnlfc3ByZWFkX3Rlc3QvY3B1c2V0X21lbW9yeV9zcHJlYWRfdGVzdHNldC5zaAo+Pj4+IGluZGV4
IGUyNzY3ZWYwNS4uZjcyMzBhNGVhIDEwMDc1NQo+Pj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
Y29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3QvY3B1c2V0X21lbW9y
eV9zcHJlYWRfdGVzdHNldC5zaAo+Pj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxl
cnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3QvY3B1c2V0X21lbW9yeV9zcHJlYWRf
dGVzdHNldC5zaAo+Pj4+IEBAIC0zOCw3ICszOCwxNSBAQCBucl9tZW1zPSROX05PREVTCj4+Pj4g
ICAgIyBvbiB3aGljaCBpdCBpcyBydW5uaW5nLiBUaGUgb3RoZXIgbm9kZXMnIHNsYWIgc3BhY2Ug
aGFzIGxpdHRsZXIgY2hhbmdlLihsZXNzCj4+Pj4gICAgIyB0aGFuIDEwMDAga2IpLgo+Pj4+ICAg
IHVwcGVybGltaXQ9MTAwMDAKPj4+PiAtbG93ZXJsaW1pdD0yMDAwCj4+Pj4gKwo+Pj4+ICsjIHNl
dCBsb3dlcmxpbWl0IGFjY29yZGluZyB0byBwYWdlc2l6ZQo+Pj4+ICsjIHBhZ2VzaXplKGJ5dGVz
KSAgfCBsb3dlcmxpbWl0KGtiKQo+Pj4+ICsjIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+Pj4+ICsjICA0MDk2ICAgICAgICAgICAgfCAyMDQ4Cj4+Pj4gKyMgIDE2Mzg0ICAg
ICAgICAgICB8IDgxOTIKPj4+PiArCj4+Pj4gK1BBR0VfU0laRT1gdHN0X2dldGNvbmYgUEFHRVNJ
WkVgCj4+Pj4gK2xvd2VybGltaXQ9JCgoUEFHRV9TSVpFICogNTEyIC8gMTAyNCkpCj4+Pj4gICAg
ICBjcHVzX2FsbD0iJChzZXEgLXMsIDAgJCgobnJfY3B1cy0xKSkpIgo+Pj4+ICAgIG1lbXNfYWxs
PSIkKHNlcSAtcywgMCAkKChucl9tZW1zLTEpKSkiCj4+Pj4KPj4+PiBiYXNlLWNvbW1pdDogMDIw
ZjM5ODVhNWNhODZjOGJiZWNlMjdlZWY4ZmIwMzE1YTEwNDYzZQo+Pj4gSWYgd2UgZG9uJ3Qgc2V0
IHRoZSB1cHBlcmxpbWl0IHdoYXQgaGFwcGVucyBpZiB3ZSBoYXZlIDY0S2IgcGFnZXMKPj4+IGFu
ZAo+Pj4gdGhlIGxvd2VybGltaXQgPiB1cHBlcmxpbWl0Pwo+Pgo+PiBUaGUgbG93ZXJsaW1pdCBp
cyB1c2VkIHRvIGxpbWl0IHRoZSBtYXggdmFsdWUgb24gb3RoZXIgbm9kZXMgYW5kIHRoZQo+PiB1
cHBlcmxpbWl0IGlzIHVzZWQgdG8gbGltaXQgdGhlIG1pbiB2YWx1ZSBvbiB0aGUgZXhwZWN0ZWQg
bm9kZS4KPj4gU28gdGhlcmUgaXMgbm8gcHJvYmxlbSBpZiBsb3dlcmxpbWl0ID4gdXBwZXJsaW1p
dC4KPj4+Cj4gCj4gV29uJ3QgdGhpcyBjYXVzZSBmYWxzZSBuZWdhdGl2ZXMgb24gc3lzdGVtcyB3
aXRoIGxhcmdlciBwYWdlIHNpemVzPwpZZXMsIG5vIHByb2JsZW0gd2l0aCBsYXJnZXIgcGFnZSBz
aXplLgo+IAo+IEkgaGF2ZSBtZXJnZWQgaXQgaG93ZXZlciBiZWNhdXNlIHJpZ2h0IG5vdyB0aGUg
dGVzdCBpcyBtb3N0IGxpa2VseSBqdXN0Cj4gYSBzb3VyY2Ugb2YgZmFsc2UgcG9zaXRpdmVzLgpP
Syx0aGFua3MuCklmIHRoZXJlIGFyZSBhbnkgcHJvYmxlbSwgd2UgY2FuIGNvbnRpbnVlIHRvIGRp
c2N1c3MuCj4gCgoKLS0gCkJlc3QgUmVnYXJkcwpIb25nY2hlbiBaaGFuZwoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
