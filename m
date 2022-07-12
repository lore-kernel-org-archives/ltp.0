Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A861C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 07:01:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E40D3CA755
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 09:01:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D9373CA592
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 09:01:35 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id B11E21400BE5
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 09:01:31 +0200 (CEST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP9JIHM1iA8EYAA--.15448S3; 
 Tue, 12 Jul 2022 15:01:29 +0800 (CST)
To: Petr Vorel <pvorel@suse.cz>
References: <1656937069-17098-1-git-send-email-zhanghongchen@loongson.cn>
 <Ysu+mbkO8eUP4A2+@pevik>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <bcea5018-eb43-ac4e-184c-4fddf3b90aa0@loongson.cn>
Date: Tue, 12 Jul 2022 15:01:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Ysu+mbkO8eUP4A2+@pevik>
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxP9JIHM1iA8EYAA--.15448S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47Jw4kZr43JFW3JrykAFb_yoW5Xw1xpF
 WSvFWYkFWkWF15Aw47ArZ5Wr4rAFnxXr4qkr4Fyrn7Zryq9ryrWF40vFWjq3ZIkr47Gr4U
 Zr4rG3Z5W3WDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
 c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
 twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
 0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
 wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
 7IU8P5r7UUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc01: fix variable not initialized
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
Cc: libtirpc-devel@lists.sourceforge.net, ltp@lists.linux.it,
 Steve Dickson <steved@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyMi83LzExIOS4i+WNiDI6MDksIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgYWxsLAo+IAo+
IFsgQ2MgU3RldmUgYW5kIGxpYnRpcnBjLWRldmVsIE1MIF0KPiAKPj4gd2hlbiBlcnJvciBvY2N1
cnJlZCBpbiBmdW5jdGlvbiBjYWxscnBjL2NsbnRfY2FsbCwgcmV0dXJuX2J1ZmZlciBtYXkKPj4g
YmUgbGVhdmVkIG5vdCBpbml0aWFsaXplZC5TbyBpbml0aWFsaXplIHJldHVybl9idWZmZXIgdG8g
TlVMTCxhbmQKPj4gcmV0cmlldmUgdGhlIHJldHVybl9idWZmZXItPmRhdGEgd2hlbiByZXR1cm5f
YnVmZmVyIGlzIHJlYWxseSBhc3NpZ25lZC4KPiAKPiBTaG91bGRuJ3QgYmUgcmMgdXNlZCBmb3Ig
dmVyaWZpY2F0aW9uPwo+IAo+IG1hbiBjYWxscnBjKDMpOgo+IGludCBjYWxscnBjKC4uLik7Cj4g
Li4uCj4gVGhpcyByb3V0aW5lIHJldHVybnMgemVybyBpZiBpdCBzdWNjZWVkcywgb3IgdGhlIHZh
bHVlIG9mIGVudW0gY2xudF9zdGF0IGNhc3QgdG8KPiBhbiBpbnRlZ2VyIGlmIGl0IGZhaWxzLiBU
aGUgcm91dGluZSBjbG50X3BlcnJubygpIGlzIGhhbmR5IGZvciB0cmFuc2xhdGluZwo+IGZhaWx1
cmUgc3RhdHVzZXMgaW50byBtZXNzYWdlcy4KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+
PiBTaWduZWQtb2ZmLWJ5OiBIb25nY2hlbiBaaGFuZyA8emhhbmdob25nY2hlbkBsb29uZ3Nvbi5j
bj4KPj4gLS0tCj4+ICAgdGVzdGNhc2VzL25ldHdvcmsvcnBjL2Jhc2ljX3Rlc3RzL3JwYzAxL3Jw
YzEuYyB8IDExICsrKysrKystLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPiAKPj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9uZXR3b3JrL3Jw
Yy9iYXNpY190ZXN0cy9ycGMwMS9ycGMxLmMgYi90ZXN0Y2FzZXMvbmV0d29yay9ycGMvYmFzaWNf
dGVzdHMvcnBjMDEvcnBjMS5jCj4+IGluZGV4IGJjOWYzNWIuLjU2OTFjMDYgMTAwNjQ0Cj4+IC0t
LSBhL3Rlc3RjYXNlcy9uZXR3b3JrL3JwYy9iYXNpY190ZXN0cy9ycGMwMS9ycGMxLmMKPj4gKysr
IGIvdGVzdGNhc2VzL25ldHdvcmsvcnBjL2Jhc2ljX3Rlc3RzL3JwYzAxL3JwYzEuYwo+PiBAQCAt
MjQsNyArMjQsNyBAQCB2b2lkIHVzYWdlX2Vycm9yKGNoYXIgKnByb2dyYW1fbmFtZSk7Cj4+ICAg
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKPj4gICB7Cj4+ICAgCXN0cnVjdCBob3N0
ZW50ICpocDsKPj4gLQlzdHJ1Y3QgZGF0YSBidWZmZXIsICpyZXR1cm5fYnVmZmVyOwo+PiArCXN0
cnVjdCBkYXRhIGJ1ZmZlciwgKnJldHVybl9idWZmZXIgPSBOVUxMOwo+PiAgIAlpbnQgaSwgbiwg
cmM7Cj4+ICAgCUZJTEUgKmZwOwo+PiAgIAlzdHJ1Y3Qgc3RhdCBzdGF0X2J1ZmZlcjsKPj4gQEAg
LTEyOCw3ICsxMjgsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+PiAgIAly
YyA9IGNhbGxycGMoc2VydmVyLCBwcm9ncmFtLCB2ZXJzaW9uLCAxLCAoeGRycHJvY190KXhkcl9z
ZW5kX2RhdGEsCj4+ICAgCQkJKGNoYXIgKikmYnVmZmVyLCAoeGRycHJvY190KXhkcl9yZWNlaXZl
X2RhdGEsCj4+ICAgCQkJKGNoYXIgKikmcmV0dXJuX2J1ZmZlcik7Cj4+IC0JZG9fY29tcGFyZShy
YywgImNhbGxycGMiLCAmYnVmZmVyLCByZXR1cm5fYnVmZmVyLT5kYXRhKTsKPj4gKwlkb19jb21w
YXJlKHJjLCAiY2FsbHJwYyIsICZidWZmZXIsCj4+ICsJCQkJcmV0dXJuX2J1ZmZlciA/IHJldHVy
bl9idWZmZXItPmRhdGEgOiBOVUxMKTsKPiAKPj4gICAJc2VydmVyX3Npbi5zaW5fcG9ydCA9IDA7
Cj4+ICAgCXNvY2sgPSBSUENfQU5ZU09DSzsKPj4gQEAgLTE0NSw3ICsxNDYsOCBAQCBpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+PiAgIAkJCQkoY2hhciAqKSZidWZmZXIsICh4ZHJw
cm9jX3QpeGRyX3JlY2VpdmVfZGF0YSwKPj4gICAJCQkJKGNoYXIgKikmcmV0dXJuX2J1ZmZlciwg
dGltZW91dCk7Cj4+ICAgCWNsbnRfZGVzdHJveShjbG50KTsKPj4gLQlkb19jb21wYXJlKHJjLCAi
dWRwIHRyYW5zcG9ydCIsICZidWZmZXIsIHJldHVybl9idWZmZXItPmRhdGEpOwo+PiArCWRvX2Nv
bXBhcmUocmMsICJ1ZHAgdHJhbnNwb3J0IiwgJmJ1ZmZlciwKPj4gKwkJCQlyZXR1cm5fYnVmZmVy
ID8gcmV0dXJuX2J1ZmZlci0+ZGF0YSA6IE5VTEwpOwo+IAo+PiAgIAlzZXJ2ZXJfc2luLnNpbl9w
b3J0ID0gMDsKPj4gICAJc29jayA9IFJQQ19BTllTT0NLOwo+PiBAQCAtMTYwLDcgKzE2Miw4IEBA
IGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCj4+ICAgCQkJCShjaGFyICopJmJ1ZmZl
ciwgKHhkcnByb2NfdCl4ZHJfcmVjZWl2ZV9kYXRhLAo+PiAgIAkJCQkoY2hhciAqKSZyZXR1cm5f
YnVmZmVyLCB0aW1lb3V0KTsKPj4gICAJY2xudF9kZXN0cm95KGNsbnQpOwo+PiAtCWRvX2NvbXBh
cmUocmMsICJ0Y3AgdHJhbnNwb3J0IiwgJmJ1ZmZlciwgcmV0dXJuX2J1ZmZlci0+ZGF0YSk7Cj4+
ICsJZG9fY29tcGFyZShyYywgInRjcCB0cmFuc3BvcnQiLCAmYnVmZmVyLAo+PiArCQkJCXJldHVy
bl9idWZmZXIgPyByZXR1cm5fYnVmZmVyLT5kYXRhIDogTlVMTCk7Cj4gCj4+ICAgCWV4aXQoMCk7
Cj4+ICAgfQpIaSBQZXRyLAogICBJIGhhdmUgbW9kaWZpZWQgYXMgeW91IHNhaWQgYW5kIGhhdmUg
c2VuZCBhbm90aGVyIHBhdGNoLHRoZSBuZXcgCm1ldGhvZCBpcyB0byBjaGFuZ2UgdGhlIHBhcmFt
ZXRlciBwYXNzZWQgdG8gZG9fY29tcGFyZSwgcGxlYXNlIGNoZWNrIGFnYWluLgoKQmVzdCBSZWdh
cmRzLApIb25nY2hlbgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
