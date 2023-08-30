Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B8C71153
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 03:28:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7A23CD02C
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 05:28:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E1D33C5DFD
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 05:28:22 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 7A0E4200278
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 05:28:19 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.176])
 by gateway (Coremail) with SMTP id _____8BxyepQt+5kfPkcAA--.49733S3;
 Wed, 30 Aug 2023 11:28:17 +0800 (CST)
Received: from [10.180.13.176] (unknown [10.180.13.176])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxHCNPt+5kW+9mAA--.33047S3; 
 Wed, 30 Aug 2023 11:28:15 +0800 (CST)
To: rpalethorpe@suse.de
References: <20230609012740.19097-1-zhanghongchen@loongson.cn>
 <f847e7db-f894-4ce8-6ea5-95817531ea89@suse.cz>
 <5b76add3-4bdf-a1e3-d09c-734f2bdeb9f5@loongson.cn>
 <a4057bbd-1ff0-5bd4-8573-7872b23f20ce@suse.cz>
 <8d553b8e-88ba-79c5-2dfe-893a82be1046@loongson.cn>
 <14c9865f-9300-b1af-1594-a95a98cd85ba@loongson.cn> <87zg2ai2is.fsf@suse.de>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <e353a525-e5e8-7d02-6f39-1efe713473a5@loongson.cn>
Date: Wed, 30 Aug 2023 11:28:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87zg2ai2is.fsf@suse.de>
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxHCNPt+5kW+9mAA--.33047S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQARB2TsHrQCeAAtsi
X-Coremail-Antispam: 1Uk129KBj93XoWxuF47ArWDXF15tr1kXF1fuFX_yoW5Gw47pF
 Wxta4YyF4DGFyxCr42v3WUZrySyry8JF45Xry5tryUA3Z093Z3Gr4UJrWYk3ZrCw1fCF4j
 kw4jqasrXa4UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuset_memory_spread: change lowerlimit to 5000kb
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

SGkgUmljaGFyZCAsCiAgIFRoYW5rcyBmb3IgeW91ciByZXZpZXcsCk9uIDIwMjMvOC8yOSDkuIvl
jYg1OjI1LCBSaWNoYXJkIFBhbGV0aG9ycGUgd3JvdGU6Cj4gSGVsbG8sCj4gCj4gSG9uZ2NoZW4g
WmhhbmcgPHpoYW5naG9uZ2NoZW5AbG9vbmdzb24uY24+IHdyaXRlczoKPiAKPj4gSGkgQ2hyaWws
Cj4+IEFueSBzdWdnZXN0aW9uIGFib3V0IHRoaXMgcGF0Y2g/Cj4+Cj4+IE9uIDIwMjMvNi8xNiBw
bSA2OjEzLCBIb25nY2hlbiBaaGFuZyB3cm90ZToKPj4+IEhpIE1hcnRpbiwKPj4+IE9uIDIwMjMv
Ni8xNiBwbSA1OjMxLCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+Pj4+IE9uIDE2LiAwNi4gMjMgNDox
MCwgSG9uZ2NoZW4gWmhhbmcgd3JvdGU6Cj4+Pj4+IEhpIE1hcnRpbiwKPj4+Pj4KPj4+Pj4gT24g
MjAyMy82LzE1IHBtIDEwOjI3LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+Pj4+Pj4gSGksCj4+Pj4+
Pgo+Pj4+Pj4gT24gMDkuIDA2LiAyMyAzOjI3LCBIb25nY2hlbiBaaGFuZyB3cm90ZToKPj4+Pj4+
PiBXaGVuIEkgdGVzdCB0aGUgY3B1c2V0X21lbW9yeV9zcHJlYWQgY2FzZSx0aGlzIGNhc2UgRkFJ
TCB0b28gb2Z0ZW4uCj4+Pj4+Pj4gQWZ0ZXIgZGlnIGludG8gdGhlIGNvZGUsIEkgZmluZCBvdXQg
dGhhdCB0aGUgZm93bGxvaW5nIHRoaW5ncyB0cmlnZ2VyCj4+Pj4+Pj4gdGhlIEZBSUw6Cj4+Pj4+
Pj4gMSkgcmFuZG9tIGV2ZW50cyx0aGUgcHJvYmFiaWxpdHkgaXMgdmVyeSBzbWFsbCBhbmQgY2Fu
IGJlIGlnbm9yZWQKPj4+Pj4+PiAyKSBnZXRfbWVtaW5mbyB3aGljaCBiZWZvcmUgc2VuZCBzaWdu
YWwgdG8gdGVzdF9waWQKPj4+Pj4+PiAzKSBhY2NvdW50X21lbXNpbmZvIGJlZm9yZSByZXN1bHRf
Y2hlY2sKPj4+Pj4+Pgo+Pj4+Pj4+IEFib3V0IDIpIGFuZCAzKSwgd2UgY2FuIGluY3JlYXNlIHRo
ZSB2YWx1ZSBvZiBsb3dlcmxpbWl0IHRvIGtlZXAKPj4+Pj4+PiB0aGUgcmVzdWx0IGFzIFNVQ0NF
U1MuQWZ0ZXIgbXkgdGVzdGluZywgNTAwMGtiIGlzIGEgcmVhc29uYWJsZSB2YWx1ZS4KPj4+Pj4+
Cj4+Pj4+PiB3ZSdyZSBhbHNvIHNlZWluZyB0aGVzZSBmYWlsdXJlcyBidXQgb25seSBvbiBhcmNo
aXRlY3R1cmVzIGxpa2UKPj4+Pj4+IFBvd2VyUEMgd2l0aCBwYWdlc2l6ZSBoaWdoZXIgdGhhbiB0
aGUgdXN1YWwgNEtCLiBPbiB3aGljaAo+Pj4+Pj4gYXJjaGl0ZWN0dXJlcyBkbyB5b3Ugc2VlIGZh
aWx1cmVzIGFuZCB3aGF0J3MgdGhlIHBhZ2VzaXplIHRoZXJlPwo+Pj4+PiBJIHRlc3Qgb24gM0M1
MDAwKzdBMjAwMCBtYWNoaW5lLCB0aGUgYXJjaGl0ZWN0dXJlIGlzIExvb25nQXJjaC5UaGUKPj4+
Pj4gcGFnZXNpemUgd2UgdXNlZCBpcyAxNktCLgo+Pj4+Cj4+Pj4gU28gdGhlIHVuZGVybHlpbmcg
Y2F1c2UgaXMgdGhlIHNhbWUgLSBoaWdoZXIgcGFnZXNpemUuIFRoYXQgbWVhbnMKPj4+PiB0aGUg
dXBwZXJsaW1pdCwgbG93ZXJsaW1pdCBhbmQgREFUQUZJTEUgc2l6ZSBzaG91bGQgYmUgY2FsY3Vs
YXRlZAo+Pj4+IGZyb20gcGFnZXNpemUgaW5zdGVhZC5JTU8sdXBwZXJsaW1pdCBhbmQgREFUQUZJ
TEUgc2l6ZSB3aWxsIG5vdAo+Pj4+IGFmZmVjdCB0aGUgcmVzdWx0Lgo+Pj4gQ2hhbmdlIHRoZSBs
b3dlcmxpbWl0IGxpa2UgZm9sbG93aW5nPwo+Pj4gbG93ZXJsaW1pdCA9IDIwMDBrYipnZXRfcGFn
ZXNpemUoKS9TSVpFXzRLOwo+IAo+IFRoaXMgZm9ybXVsYSBsb29rcyBvaywgYnV0IHlvdSBuZWVk
IHRvIHNjYWxlIHRoZSBvdGhlciB2YWx1ZXMgYnkgdGhlCj4gcGFnZSBzaXplIGFzIHdlbGwuCj4g
Cj4gQWxzbyBJIHdvdWxkIHJlY29tbWVuZCBlbnN1cmluZyBhbGwgdmFsdWVzIGFyZSBtdWx0aXBs
ZXMgb2YgdGhlIHBhZ2UKPiBzaXplIGJlY2F1c2UgdGhlIGtlcm5lbCB3aWxsIHJvdW5kIHVwIHRv
IHRoZSBuZWFyZXN0IHBhZ2UKPiBzaXplLgo+IAo+IFNvIGxvd2VybGltaXQgPSA0MDk2ICogNSA9
IDIwNDhLYgo+IG9yIGxvd2VybGltaXQgPSAxNjM4NCAqIDUgPSA4MTkyS2IKPiAKPiBNYXliZSB0
aGUgdXBwZXJsaW1pdCBzaG91bGQgYmUgNSAqIGxvd2VybGltaXQ/IEJlY2F1c2Ugd2Ugd2FudCB0
aGUKPiBnYXAvc3ByZWFkIHRvIGdldCBiaWdnZXIgdG9vLiBJIGRvbid0IGtub3cgaWYgdGhlIERB
VEFGSUxFIG5lZWRzIHRvCj4gY2hhbmdlIGluIHNpemUgaXQgaXMgYWxyZWFkeSA1MDBNQi4KPiAK
PiBBbHRlcm5hdGl2ZWx5IHlvdSBjb3VsZCBqdXN0IGNyZWF0ZSBhIGxvb2t1cCB0YWJsZSB3aXRo
IHZhbHVlcyBmb3IgZWFjaAo+IHBhZ2Ugc2l6ZSB3ZSBoYXZlIHRlc3RlZC4gZS5nLgo+IAo+IHN3
aXRjaCAoZ2V0X3BhZ2VzaXplKCkpIHsKPiAgICAgICAgIGNhc2UgNDA5NjogMjA0OEtiCj4gICAg
ICAgICBjYXNlIDE2Mzg0OiA4MTkyS2IKPiAgICAgICAgIGRlZmF1bHQ6IC4uLgo+IH0KPiAKPiBU
aGlzIG1heSBiZSBiZXR0ZXIgaWYgdGhlIHZhbHVlcyB0byBkbyBub3Qgc2NhbGUgbGluZWFybHku
IFdoaWNoIGlzCj4gdG90YWxseSBwb3NzaWJsZSBiZWNhdXNlIHRoZSBwYWdlIHNpemUgZWZmZWN0
cyBtb3N0IHRoaW5ncyBhbmQgdGhlcmUKPiBjb3VsZCBiZSBmZWVkYmFjayBsb29wcy4KPiAKPiBQ
bGVhc2Ugc3VibWl0IGFub3RoZXIgcGF0Y2ggaWYgeW91IGFyZSBzdGlsbCBpbnRlcmVzdGVkLgpP
SywgbGV0IG1lIHNlbmQgdGhlIFYyIHBhdGNoLgo+IAoKCi0tIApCZXN0IFJlZ2FyZHMKSG9uZ2No
ZW4gWmhhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
