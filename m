Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A3EC83F17
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 09:43:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BB8E3CC61C
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 11:43:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 541573C9AFA
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 11:43:37 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id E772520092F
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 11:43:34 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8Cx_eJCF3popeIsAQ--.51970S3;
 Fri, 18 Jul 2025 17:43:31 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJCxM+RBF3po+DIcAA--.18728S3;
 Fri, 18 Jul 2025 17:43:29 +0800 (CST)
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250718090523.1411073-1-pvorel@suse.cz>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9d515fb4-970f-6b90-e6db-7c5037348d4b@loongson.cn>
Date: Fri, 18 Jul 2025 17:43:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250718090523.1411073-1-pvorel@suse.cz>
Content-Language: en-US
X-CM-TRANSID: qMiowJCxM+RBF3po+DIcAA--.18728S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw43uF1DArykCFW5Zr13Awc_yoW8GFWxpr
 yfAa17tFs8tFWqywsFqasavFy7tF97JrZ2gr4fGrykGrn8t3Z3KF1I9a15Ww47XryS93WI
 vF4YgFWvvw4UXFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7pnQ
 UUUUU
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] getrlimit03: Simplify TCONF code
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

T24gMjAyNS83LzE4IOS4i+WNiDU6MDUsIFBldHIgVm9yZWwgd3JvdGU6Cj4gRU5PU1lTIGNoZWNr
cyBhZGRlZCBpbiBmYWM3ODNiNWQ2IGFuZCBkMDcxZGUwMmU4IGFyZSB2ZXJib3NlLCB1c2UKPiB0
c3Rfc3lzY2FsbCgpIHRvIGhhbmRsZSBFTk9TWVMuCj4gCj4gQWxzbyBjaGVjayBmb3IgX19OUl9n
ZXRybGltaXQgY2F1c2VkIFRDT05GIG1lc3NhZ2UgYmVpbmcgcHJpbnRlZCBtb3JlCj4gdGltZXMg
KFJMSU1fTkxJTUlUUyA9PiAxNiBvbiB4ODZfNjQpLCB3aGljaCBpcyBhbHNvIGZpeGVkIGJ5IHVz
aW5nCj4gdHN0X3N5c2NhbGwoKS4KPiAKPiBCZWNhdXNlIGl0IHNob3VsZCBiZSBzYWZlIHRvIG5v
dCB1c2Ugc3BlY2lmaWMgZXJybm8gdmFyaWFibGVzIHJlbW92ZQo+IGVycm5vX2wgYW5kIGVycm5v
X3VsLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0t
LQo+IEhpIGFsbCwKPiAKPiBAVGllemh1IGNhbiB5b3UgcGxlYXNlIHRlc3QgdGhpcyBwYXRjaD8K
CkhlcmUgaXMgdGhlIHRlc3QgcmVzdWx0IG9uIExvb25nQXJjaCwgdGhpcyBpcyBleHBlY3RlZDoK
CiQgL29wdC9sdHAvdGVzdGNhc2VzL2Jpbi9nZXRybGltaXQwMwp0c3RfdGVzdC5jOjIwMDM6IFRJ
TkZPOiBMVFAgdmVyc2lvbjogMjAyNTA1MzAtODEtZ2UxYmI2M2FlNQp0c3RfdGVzdC5jOjIwMDY6
IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE2LjAtcmM2KyAjMzYgU01QIApQUkVFTVBUX0RZTkFN
SUMgRnJpIEp1bCAxOCAxNjo0ODoyOSBDU1QgMjAyNSBsb29uZ2FyY2g2NAp0c3Rfa2NvbmZpZy5j
Ojg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCnRzdF90
ZXN0LmM6MTgyNDogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMK
Z2V0cmxpbWl0MDMuYzo4MDogVENPTkY6IHN5c2NhbGwoLTEpIF9fTlJfZ2V0cmxpbWl0X3Vsb25n
IG5vdCBzdXBwb3J0ZWQgCm9uIHlvdXIgYXJjaAoKU3VtbWFyeToKcGFzc2VkICAgMApmYWlsZWQg
ICAwCmJyb2tlbiAgIDAKc2tpcHBlZCAgMQp3YXJuaW5ncyAwCgpUZXN0ZWQtYnk6IFRpZXpodSBZ
YW5nIDx5YW5ndGllemh1QGxvb25nc29uLmNuPiAjIG9uIExvb25nQXJjaAoKSXQgd291bGQgYmUg
YmV0dGVyIGlmIF9fTlJfZ2V0cmxpbWl0X3Vsb25nIGNhbiBiZSBwcmludGVkIGFzCl9fTlJfdWdl
dHJsaW1pdCBvciBfX05SX2dldHJsaW1pdDoKCmdldHJsaW1pdDAzLmM6ODA6IFRDT05GOiBzeXNj
YWxsKC0xKSBfX05SX2dldHJsaW1pdF91bG9uZyBub3Qgc3VwcG9ydGVkCgpObyBzdHJvbmcgb3Bp
bmlvbiwgbGV0J3Mgc2VlIGlmIG90aGVyIHBlb3BsZSBoYXZlIGNvbmNlcm4gYWJvdXQgaXQuCgpU
aGFua3MsClRpZXpodQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
