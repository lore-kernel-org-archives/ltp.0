Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F81DC6FA8F
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 10:46:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39083CE046
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 12:46:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 316183C6D29
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 12:46:29 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 0951A10009C7
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 12:46:26 +0200 (CEST)
Received: from loongson.cn (unknown [10.180.13.176])
 by gateway (Coremail) with SMTP id _____8AxZ+j_He9kXRIdAA--.23417S3;
 Wed, 30 Aug 2023 18:46:24 +0800 (CST)
Received: from [10.180.13.176] (unknown [10.180.13.176])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx_c7_He9k6S5nAA--.53186S3; 
 Wed, 30 Aug 2023 18:46:23 +0800 (CST)
To: rpalethorpe@suse.de
References: <20230830064250.31904-1-zhanghongchen@loongson.cn>
 <87r0nlhsh7.fsf@suse.de>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <d9b87423-f3e3-1585-1f3a-3821622ef040@loongson.cn>
Date: Wed, 30 Aug 2023 18:46:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87r0nlhsh7.fsf@suse.de>
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx_c7_He9k6S5nAA--.53186S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQATB2TuwbQFFAABs6
X-Coremail-Antispam: 1Uk129KBj93XoWxJryrCw4UKrW8JF4fKry3GFX_yoW8KF45pF
 WSva9rKr1DJFnrCa1xuasIyr10va48JF48GrZxCw1kurnxAFyrCr18Gr4rtFy2qryFga45
 Ka45CFZxWa4DtFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9U
 UUUU=
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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

SGkgUmljaGFyZCwKCk9uIDIwMjMvOC8zMCDkuIvljYgzOjQ1LCBSaWNoYXJkIFBhbGV0aG9ycGUg
d3JvdGU6Cj4gSGVsbG8sCj4gCj4gSG9uZ2NoZW4gWmhhbmcgPHpoYW5naG9uZ2NoZW5AbG9vbmdz
b24uY24+IHdyaXRlczoKPiAKPj4gV2hlbiBJIHRlc3QgdGhlIGNwdXNldF9tZW1vcnlfc3ByZWFk
IGNhc2UsdGhpcyBjYXNlIEZBSUwgdG9vIG9mdGVuLgo+PiBBZnRlciBkaWcgaW50byB0aGUgY29k
ZSwgSSBmaW5kIG91dCB0aGF0IHRoZSBmb3dsbG9pbmcgdGhpbmdzIHRyaWdnZXIKPj4gdGhlIEZB
SUw6Cj4+IDEpIHJhbmRvbSBldmVudHMsdGhlIHByb2JhYmlsaXR5IGlzIHZlcnkgc21hbGwgYW5k
IGNhbiBiZSBpZ25vcmVkCj4+IDIpIGdldF9tZW1pbmZvIHdoaWNoIGJlZm9yZSBzZW5kIHNpZ25h
bCB0byB0ZXN0X3BpZAo+PiAzKSBhY2NvdW50X21lbXNpbmZvIGJlZm9yZSByZXN1bHRfY2hlY2sK
Pj4KPj4gQWJvdXQgMikgYW5kIDMpLCB3ZSBjYW4gaW5jcmVhc2UgdGhlIHZhbHVlIG9mIGxvd2Vy
bGltaXQgdG8ga2VlcAo+PiB0aGUgcmVzdWx0IGFzIFNVQ0NFU1MuCj4+Cj4+IEFmdGVyIGRpc2N1
c3Npbmcgd2l0aCBSaWNoYXJkLCB3ZSBhbGwgYWdyZWUgdG8gdXNlIHRoZSBmb2xsb3dpbmcKPj4g
Zm9ybXVsYSB0byBjYWxjdWxhdGUgdGhlIGxvd2VybGltaXQ6Cj4+IGxvd2VybGltaXQoa2IpID0g
cGFnZXNpemUoYnl0ZSkgKiA1MTIgLyAxMDI0Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEhvbmdjaGVu
IFpoYW5nIDx6aGFuZ2hvbmdjaGVuQGxvb25nc29uLmNuPgo+PiAtLS0KPj4gICAuLi4vY3B1c2V0
X21lbW9yeV9zcHJlYWRfdGVzdHNldC5zaCAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysr
KystCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
Pgo+PiBkaWZmIC0tZ2l0Cj4+IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQv
Y3B1c2V0X21lbW9yeV9zcHJlYWRfdGVzdC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0c2V0LnNo
Cj4+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV9z
cHJlYWRfdGVzdC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0c2V0LnNoCj4+IGluZGV4IGUyNzY3
ZWYwNS4uZjcyMzBhNGVhIDEwMDc1NQo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xs
ZXJzL2NwdXNldC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0L2NwdXNldF9tZW1vcnlfc3ByZWFk
X3Rlc3RzZXQuc2gKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQv
Y3B1c2V0X21lbW9yeV9zcHJlYWRfdGVzdC9jcHVzZXRfbWVtb3J5X3NwcmVhZF90ZXN0c2V0LnNo
Cj4+IEBAIC0zOCw3ICszOCwxNSBAQCBucl9tZW1zPSROX05PREVTCj4+ICAgIyBvbiB3aGljaCBp
dCBpcyBydW5uaW5nLiBUaGUgb3RoZXIgbm9kZXMnIHNsYWIgc3BhY2UgaGFzIGxpdHRsZXIgY2hh
bmdlLihsZXNzCj4+ICAgIyB0aGFuIDEwMDAga2IpLgo+PiAgIHVwcGVybGltaXQ9MTAwMDAKPj4g
LWxvd2VybGltaXQ9MjAwMAo+PiArCj4+ICsjIHNldCBsb3dlcmxpbWl0IGFjY29yZGluZyB0byBw
YWdlc2l6ZQo+PiArIyBwYWdlc2l6ZShieXRlcykgIHwgbG93ZXJsaW1pdChrYikKPj4gKyMgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ICsjICA0MDk2ICAgICAgICAgICAg
fCAyMDQ4Cj4+ICsjICAxNjM4NCAgICAgICAgICAgfCA4MTkyCj4+ICsKPj4gK1BBR0VfU0laRT1g
dHN0X2dldGNvbmYgUEFHRVNJWkVgCj4+ICtsb3dlcmxpbWl0PSQoKFBBR0VfU0laRSAqIDUxMiAv
IDEwMjQpKQo+PiAgIAo+PiAgIGNwdXNfYWxsPSIkKHNlcSAtcywgMCAkKChucl9jcHVzLTEpKSki
Cj4+ICAgbWVtc19hbGw9IiQoc2VxIC1zLCAwICQoKG5yX21lbXMtMSkpKSIKPj4KPj4gYmFzZS1j
b21taXQ6IDAyMGYzOTg1YTVjYTg2YzhiYmVjZTI3ZWVmOGZiMDMxNWExMDQ2M2UKPiAKPiBJZiB3
ZSBkb24ndCBzZXQgdGhlIHVwcGVybGltaXQgd2hhdCBoYXBwZW5zIGlmIHdlIGhhdmUgNjRLYiBw
YWdlcyBhbmQKPiB0aGUgbG93ZXJsaW1pdCA+IHVwcGVybGltaXQ/CgpUaGUgbG93ZXJsaW1pdCBp
cyB1c2VkIHRvIGxpbWl0IHRoZSBtYXggdmFsdWUgb24gb3RoZXIgbm9kZXMgYW5kIHRoZQp1cHBl
cmxpbWl0IGlzIHVzZWQgdG8gbGltaXQgdGhlIG1pbiB2YWx1ZSBvbiB0aGUgZXhwZWN0ZWQgbm9k
ZS4KU28gdGhlcmUgaXMgbm8gcHJvYmxlbSBpZiBsb3dlcmxpbWl0ID4gdXBwZXJsaW1pdC4KPiAK
CgotLSAKQmVzdCBSZWdhcmRzCkhvbmdjaGVuIFpoYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
