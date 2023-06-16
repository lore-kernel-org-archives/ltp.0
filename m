Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFB5EB64D9
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 02:11:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D87693CC879
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 04:11:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 531BA3CB0C9
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 04:10:57 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id EC619100065A
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 04:10:54 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.185])
 by gateway (Coremail) with SMTP id _____8BxZ+mrxItkYMsFAA--.10429S3;
 Fri, 16 Jun 2023 10:10:51 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxKeWrxItkK8AcAA--.15510S3; 
 Fri, 16 Jun 2023 10:10:51 +0800 (CST)
To: Martin Doucha <mdoucha@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 Petr Vorel <petr.vorel@gmail.com>
References: <20230609012740.19097-1-zhanghongchen@loongson.cn>
 <f847e7db-f894-4ce8-6ea5-95817531ea89@suse.cz>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <5b76add3-4bdf-a1e3-d09c-734f2bdeb9f5@loongson.cn>
Date: Fri, 16 Jun 2023 10:10:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f847e7db-f894-4ce8-6ea5-95817531ea89@suse.cz>
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxKeWrxItkK8AcAA--.15510S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAEB2SK-4IN1AAAsI
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWxGF13uw4DXFyxtF48KrX_yoW8ZrykpF
 WfCa98t3WDtFn3Ca1xu3Z0yr1Iva45XF48GFs3CF1DuF9xJa1fCF18Ars8GF1jvr1FgryY
 ka4UC39rWasrt3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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

SGkgTWFydGluLAoKT24gMjAyMy82LzE1IHBtIDEwOjI3LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+
IEhpLAo+IAo+IE9uIDA5LiAwNi4gMjMgMzoyNywgSG9uZ2NoZW4gWmhhbmcgd3JvdGU6Cj4+IFdo
ZW4gSSB0ZXN0IHRoZSBjcHVzZXRfbWVtb3J5X3NwcmVhZCBjYXNlLHRoaXMgY2FzZSBGQUlMIHRv
byBvZnRlbi4KPj4gQWZ0ZXIgZGlnIGludG8gdGhlIGNvZGUsIEkgZmluZCBvdXQgdGhhdCB0aGUg
Zm93bGxvaW5nIHRoaW5ncyB0cmlnZ2VyCj4+IHRoZSBGQUlMOgo+PiAxKSByYW5kb20gZXZlbnRz
LHRoZSBwcm9iYWJpbGl0eSBpcyB2ZXJ5IHNtYWxsIGFuZCBjYW4gYmUgaWdub3JlZAo+PiAyKSBn
ZXRfbWVtaW5mbyB3aGljaCBiZWZvcmUgc2VuZCBzaWduYWwgdG8gdGVzdF9waWQKPj4gMykgYWNj
b3VudF9tZW1zaW5mbyBiZWZvcmUgcmVzdWx0X2NoZWNrCj4+Cj4+IEFib3V0IDIpIGFuZCAzKSwg
d2UgY2FuIGluY3JlYXNlIHRoZSB2YWx1ZSBvZiBsb3dlcmxpbWl0IHRvIGtlZXAKPj4gdGhlIHJl
c3VsdCBhcyBTVUNDRVNTLkFmdGVyIG15IHRlc3RpbmcsIDUwMDBrYiBpcyBhIHJlYXNvbmFibGUg
dmFsdWUuCj4gCj4gd2UncmUgYWxzbyBzZWVpbmcgdGhlc2UgZmFpbHVyZXMgYnV0IG9ubHkgb24g
YXJjaGl0ZWN0dXJlcyBsaWtlIFBvd2VyUEMgCj4gd2l0aCBwYWdlc2l6ZSBoaWdoZXIgdGhhbiB0
aGUgdXN1YWwgNEtCLiBPbiB3aGljaCBhcmNoaXRlY3R1cmVzIGRvIHlvdSAKPiBzZWUgZmFpbHVy
ZXMgYW5kIHdoYXQncyB0aGUgcGFnZXNpemUgdGhlcmU/CkkgdGVzdCBvbiAzQzUwMDArN0EyMDAw
IG1hY2hpbmUsIHRoZSBhcmNoaXRlY3R1cmUgaXMgTG9vbmdBcmNoLlRoZSAKcGFnZXNpemUgd2Ug
dXNlZCBpcyAxNktCLgo+IAo+PiBTaWduZWQtb2ZmLWJ5OiBIb25nY2hlbiBaaGFuZyA8emhhbmdo
b25nY2hlbkBsb29uZ3Nvbi5jbj4KPj4gLS0tCj4+IMKgIC4uLi9jcHVzZXRfbWVtb3J5X3NwcmVh
ZF90ZXN0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3RzZXQuc2jCoMKgIHwgMiArLQo+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAt
LWdpdCAKPj4gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfbWVt
b3J5X3NwcmVhZF90ZXN0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3RzZXQuc2ggCj4+IGIvdGVz
dGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9zcHJlYWRfdGVz
dC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0c2V0LnNoIAo+Pgo+PiBpbmRleCBlMjc2N2VmMDUu
LmQzMzQ2ODUyNSAxMDA3NTUKPj4gLS0tIAo+PiBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxl
cnMvY3B1c2V0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3QvY3B1c2V0X21lbW9yeV9zcHJlYWRf
dGVzdHNldC5zaCAKPj4KPj4gKysrIAo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMv
Y3B1c2V0L2NwdXNldF9tZW1vcnlfc3ByZWFkX3Rlc3QvY3B1c2V0X21lbW9yeV9zcHJlYWRfdGVz
dHNldC5zaCAKPj4KPj4gQEAgLTM4LDcgKzM4LDcgQEAgbnJfbWVtcz0kTl9OT0RFUwo+PiDCoCAj
IG9uIHdoaWNoIGl0IGlzIHJ1bm5pbmcuIFRoZSBvdGhlciBub2Rlcycgc2xhYiBzcGFjZSBoYXMg
bGl0dGxlciAKPj4gY2hhbmdlLihsZXNzCj4+IMKgICMgdGhhbiAxMDAwIGtiKS4KPj4gwqAgdXBw
ZXJsaW1pdD0xMDAwMAo+PiAtbG93ZXJsaW1pdD0yMDAwCj4+ICtsb3dlcmxpbWl0PTUwMDAKPj4g
wqAgY3B1c19hbGw9IiQoc2VxIC1zLCAwICQoKG5yX2NwdXMtMSkpKSIKPj4gwqAgbWVtc19hbGw9
IiQoc2VxIC1zLCAwICQoKG5yX21lbXMtMSkpKSIKPiAKCkJlc3QgUmVnYXJkcwpIb25nY2hlbiBa
aGFuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
