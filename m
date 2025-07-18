Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4BFC83F1A
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 04:00:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EAB83CC5BE
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 06:00:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A7473CC38B
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 06:00:08 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id B4836200346
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 06:00:05 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8AxDGvBxnlopKksAQ--.26743S3;
 Fri, 18 Jul 2025 12:00:01 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJAxQMLAxnlog9kbAA--.12232S3;
 Fri, 18 Jul 2025 12:00:00 +0800 (CST)
To: Petr Vorel <pvorel@suse.cz>
References: <20250711080155.7473-1-yangtiezhu@loongson.cn>
 <6479ff64-d82c-401c-89f3-c4adbf3f330f@suse.com>
 <51cdca77-e93e-7df5-e50a-7604c2a3cb10@loongson.cn>
 <20250717140907.GA11016@pevik>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bba4b00c-e75c-4cda-9b92-9692edac2c73@loongson.cn>
Date: Fri, 18 Jul 2025 11:59:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250717140907.GA11016@pevik>
Content-Language: en-US
X-CM-TRANSID: qMiowJAxQMLAxnlog9kbAA--.12232S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurWUAF4ktFykKryfCr47ZFc_yoW5AFy8pF
 ZFkF4jkF4DGF4UGF4kAFn0gFy5Jwn3A34fGrWkCrykCayIgrZ5Ar9rury2qry8urWkXay0
 9FW7GFn5Kr4UZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] device-drivers/acpi/ltp_acpi_cmds: Fix build
 errors
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
Cc: "Ricardo B. Marliere" <rbm@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNS83LzE3IOS4i+WNiDEwOjA5LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIFRpZXpodSwg
YWxsLAoKLi4uCgo+IER1ZSB0aGUgYWJvdmUgY291bGQgeW91IHBsZWFzZSB0YWtlIHRoZSBhcHBy
b2FjaCBSaWNhcmRvIGRpZCBpbiA4MmUzOGExZjI0Cj4gKCJibG9ja19kZXY6IENvbnZlcnQgdG8g
bmV3IEFQSSIpIC0gd3JhcCB3aXRoIGlmbmRlZj8KPiAKPiAjaWZuZGVmIERJU0tfTkFNRV9MRU4K
PiAjIGluY2x1ZGUgPGxpbnV4L2dlbmhkLmg+Cj4gI2VuZGlmCj4gCj4gQlRXIEkgd291bGQgcGVy
c29uYWxseSB1c2UgI2lmbmRlZiBIQVZFX0xJTlVYX0JMS0RFVl9IIHRoYW4gY2hlY2tpbmcgZm9y
Cj4gRElTS19OQU1FX0xFTiBhcyB3ZSBhbHJlYWR5IGNoZWNrIGZvciBsaW51eC9ibGtkZXYuaCBp
biBjb25maWd1cmUuYWMsIGJ1dCB0aGF0J3MKPiBhIG1pbm9yIGRldGFpbC4KCkkgdGhpbmsgdXNl
ICIjaWZuZGVmIERJU0tfTkFNRV9MRU4iIGlzIHByb3Blci4KCkJlY2F1c2UgYm90aCBnZW5oZC5o
IGFuZCBibGtkZXYuaCBhcmUgZXhpc3QgYmVmb3JlIHRoZSBrZXJuZWwKY29tbWl0IDMyMmNiYjUw
ZGU3MSAoImJsb2NrOiByZW1vdmUgZ2VuaGQuaCIpLCBIQVZFX0xJTlVYX0JMS0RFVl9ICnNlZW1z
IGFsd2F5cyBkZWZpbmUgYXMgMSBmb3IgdGhlIG5ldyBhbmQgb2xkIGtlcm5lbCB2ZXJzaW9ucy4K
CkJ1dCB0aGUgZGVmaW5pdGlvbiBESVNLX05BTUVfTEVOIHdhcyBtb3ZlZCBmcm9tIGdlbmhkLmgg
aW50byBibGtkZXYuaAphZnRlciB0aGF0IGNvbW1pdCwgYmVjYXVzZSBibGtkZXYuaCBpcyBpbmNs
dWRlZCBmaXJzdCwgc28gd2UgY2FuIGNoZWNrCkRJU0tfTkFNRV9MRU4sIGl0IHNob3VsZCBpbmNs
dWRlIGdlbmhkLmggaWZuZGVmIERJU0tfTkFNRV9MRU4uCgo+IFllcyB3ZSBuZWVkIHRvICNpZiAj
ZWxzZSBtYWNyb3MgZm9yIGFjcGlfYnVzX2dldF9kZXZpY2UoKSB2cy4KPiBhY3BpX2ZldGNoX2Fj
cGlfZGV2KCkuCgpIZXJlIGlzIGEgZHJhZnQgY2hhbmdlLCBJIHdpbGwgcG9zdCBhIGZvcm1hbCB2
MiBwYXRjaCBpZiB5b3UgYXJlIE9LLgoKLS0tLS0+OC0tLS0tCmRpZmYgLS1naXQgYS9jb25maWd1
cmUuYWMgYi9jb25maWd1cmUuYWMKaW5kZXggMTFlNTk5YTgxLi4xZjZlMmIxYjkgMTAwNjQ0Ci0t
LSBhL2NvbmZpZ3VyZS5hYworKysgYi9jb25maWd1cmUuYWMKQEAgLTEwMCw2ICsxMDAsNyBAQCBB
Q19TVUJTVChIQVZFX0ZUU19ILCAkaGF2ZV9mdHMpCiAgQUNfQ0hFQ0tfSEVBREVSUyhsaW51eC92
bV9zb2NrZXRzLmgsIFtdLCBbXSwgWyNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+XSkKCiAgQUNfQ0hF
Q0tfRlVOQ1NfT05DRShbIFwKKyAgICBhY3BpX2J1c19nZXRfZGV2aWNlIFwKICAgICAgY2FjaGVz
dGF0IFwKICAgICAgY2xvbmUzIFwKICAgICAgY2xvc2VfcmFuZ2UgXApkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9hY3BpL2x0cF9hY3BpX2NtZHMuYyAKYi90ZXN0
Y2FzZXMva2VybmVsL2RldmljZS1kcml2ZXJzL2FjcGkvbHRwX2FjcGlfY21kcy5jCmluZGV4IGQx
MmRkNmI5NC4uZjY4MDE0NzMyIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2RldmljZS1k
cml2ZXJzL2FjcGkvbHRwX2FjcGlfY21kcy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZGV2aWNl
LWRyaXZlcnMvYWNwaS9sdHBfYWNwaV9jbWRzLmMKQEAgLTM2LDcgKzM2LDkgQEAKICAjaW5jbHVk
ZSA8bGludXgvaW9jdGwuaD4KICAjaW5jbHVkZSA8bGludXgvcG0uaD4KICAjaW5jbHVkZSA8bGlu
dXgvYWNwaS5oPgorI2lmbmRlZiBESVNLX05BTUVfTEVOCiAgI2luY2x1ZGUgPGxpbnV4L2dlbmhk
Lmg+CisjZW5kaWYKICAjaW5jbHVkZSA8bGludXgvZG1pLmg+CiAgI2luY2x1ZGUgPGxpbnV4L25s
cy5oPgoKQEAgLTEyMywxNCArMTI1LDIwIEBAIHN0YXRpYyB2b2lkIGdldF9jcnNfb2JqZWN0KGFj
cGlfaGFuZGxlIGhhbmRsZSkKCiAgc3RhdGljIHZvaWQgZ2V0X3N5c2ZzX3BhdGgoYWNwaV9oYW5k
bGUgaGFuZGxlKQogIHsKLSAgICAgICBhY3BpX3N0YXR1cyBzdGF0dXM7CiAgICAgICAgIHN0cnVj
dCBhY3BpX2RldmljZSAqZGV2aWNlOwoKICAgICAgICAga2ZyZWUoc3lzZnNfcGF0aCk7CiAgICAg
ICAgIHN5c2ZzX3BhdGggPSBOVUxMOwoKKyNpZmRlZiBIQVZFX0FDUElfQlVTX0dFVF9ERVZJQ0UK
KyAgICAgICBhY3BpX3N0YXR1cyBzdGF0dXM7CisKICAgICAgICAgc3RhdHVzID0gYWNwaV9idXNf
Z2V0X2RldmljZShoYW5kbGUsICZkZXZpY2UpOwogICAgICAgICBpZiAoQUNQSV9TVUNDRVNTKHN0
YXR1cykpCisjZWxzZQorICAgICAgIGRldmljZSA9IGFjcGlfZmV0Y2hfYWNwaV9kZXYoaGFuZGxl
KTsKKyAgICAgICBpZiAoZGV2aWNlKQorI2VuZGlmCiAgICAgICAgICAgICAgICAgc3lzZnNfcGF0
aCA9IGtvYmplY3RfZ2V0X3BhdGgoJmRldmljZS0+ZGV2LmtvYmosIApHRlBfS0VSTkVMKTsKICB9
CgpAQCAtMzk4LDkgKzQwNiwxNSBAQCBzdGF0aWMgaW50IGFjcGlfdGVzdF9idXModm9pZCkKICAg
ICAgICAgaWYgKGFjcGlfZmFpbHVyZShzdGF0dXMsICJhY3BpX2dldF9oYW5kbGUiKSkKICAgICAg
ICAgICAgICAgICByZXR1cm4gMTsKCisjaWZkZWYgSEFWRV9BQ1BJX0JVU19HRVRfREVWSUNFCiAg
ICAgICAgIHBya19hbGVydCgiVEVTVCAtLSBhY3BpX2J1c19nZXRfZGV2aWNlIik7CiAgICAgICAg
IHN0YXR1cyA9IGFjcGlfYnVzX2dldF9kZXZpY2UoYnVzX2hhbmRsZSwgJmRldmljZSk7CiAgICAg
ICAgIGlmIChhY3BpX2ZhaWx1cmUoc3RhdHVzLCAiYWNwaV9idXNfZ2V0X2RldmljZSIpKQorI2Vs
c2UKKyAgICAgICBwcmtfYWxlcnQoIlRFU1QgLS0gYWNwaV9mZXRjaF9hY3BpX2RldiIpOworICAg
ICAgIGRldmljZSA9IGFjcGlfZmV0Y2hfYWNwaV9kZXYoYnVzX2hhbmRsZSk7CisgICAgICAgaWYg
KCFkZXZpY2UpCisjZW5kaWYKICAgICAgICAgICAgICAgICByZXR1cm4gMTsKCiAgICAgICAgIHBy
a19hbGVydCgiVEVTVCAtLSBhY3BpX2J1c191cGRhdGVfcG93ZXIgIik7CgpUaGFua3MsClRpZXpo
dQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
