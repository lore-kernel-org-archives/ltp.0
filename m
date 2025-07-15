Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0887DC83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 11:24:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F8D93CCFC2
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 13:24:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52EF93CCD5A
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 13:23:57 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 130261A00A37
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 13:23:54 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8AxWXFGOnZowDwqAQ--.22952S3;
 Tue, 15 Jul 2025 19:23:51 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJCxocJDOnZo0FAYAA--.170S3;
 Tue, 15 Jul 2025 19:23:47 +0800 (CST)
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20250711080155.7473-1-yangtiezhu@loongson.cn>
 <6479ff64-d82c-401c-89f3-c4adbf3f330f@suse.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <51cdca77-e93e-7df5-e50a-7604c2a3cb10@loongson.cn>
Date: Tue, 15 Jul 2025 19:23:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6479ff64-d82c-401c-89f3-c4adbf3f330f@suse.com>
Content-Language: en-US
X-CM-TRANSID: qMiowJCxocJDOnZo0FAYAA--.170S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr17Aw1kJw43Wry8JFWDtrc_yoW8ur4kpF
 WYgFZ8Kr1DJr1UJwn5t3yF9a4Fk3ykAr15Jr4DG3s29rs09rZYvrWkWF45uFy29rWv9ayI
 kr1aqa4Ygw1DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNS83LzE1IOS4i+WNiDU6MjQsIEFuZHJlYSBDZXJ2ZXNhdG8gd3JvdGU6Cj4gSGkhCj4g
Cj4gT24gNy8xMS8yNSAxMDowMSBBTSwgVGllemh1IFlhbmcgd3JvdGU6Cj4+IFRoZXJlIGV4aXN0
IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHdoZW4gYnVpbGRpbmcgTFRQOgo+Pgo+PiDCoMKgIGx0cF9h
Y3BpX2NtZHMuYzozOToxMDogZmF0YWwgZXJyb3I6IGxpbnV4L2dlbmhkLmg6IE5vIHN1Y2ggZmls
ZSBvciAKPj4gZGlyZWN0b3J5Cj4+IMKgwqAgbHRwX2FjcGlfY21kcy5jOjEzMToxODogZXJyb3I6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIAo+PiAnYWNwaV9idXNfZ2V0X2Rldmlj
ZScKPj4gwqDCoCBsdHBfYWNwaV9jbWRzLmM6NDAwOjE4OiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24gCj4+ICdhY3BpX2J1c19nZXRfZGV2aWNlJwo+Pgo+PiBGb3IgdGhl
IGZpcnN0IGVycm9yOgo+Pgo+PiBUaGlzIGlzIGJlY2F1c2UgZ2VuaGQuaCBoYXMgYmVlbiByZW1v
dmVkIGluIHRoZSBMaW51eCBrZXJuZWwsIHRoZSAKPj4gY29udGVudHMKPj4gb2YgZ2VuaGQuaCB3
YXMgZm9sZGVkIGludG8gYmxrZGV2LmggWzFdLiBTaW5jZSBibGtkZXYuaCBoYXMgYmVlbiBpbmNs
dWRlZAo+PiBpbiB0aGUgQyBmaWxlLCBqdXN0IHJlbW92ZSB1bnVzZWQgaW5jbHVkZSBnZW5oZC5o
IHRvIGZpeCB0aGUgYnVpbGQgZXJyb3IuCj4+Cj4+IEZvciB0aGUgc2Vjb25kIGFuZCB0aGlyZCBl
cnJvcnM6Cj4+Cj4+IFRoaXMgaXMgYmVjYXVzZSBhY3BpX2J1c19nZXRfZGV2aWNlKCkgaGFzIGJl
ZW4gZHJvcGVkIGluIHRoZSBMaW51eCAKPj4ga2VybmVsLAo+PiBpbiBvcmRlciB0byBmaXggdGhl
IGJ1aWxkIGVycm9ycywganVzdCByZXBsYWNlIGFjcGlfYnVzX2dldF9kZXZpY2UoKSB3aXRoCj4+
IGFjcGlfZmV0Y2hfYWNwaV9kZXYoKSBsaWtlIHRoZSBrZXJuZWwgY29tbWl0IFsyXS4KPj4KPj4g
WzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdG9ydmFsZHMvYy8zMjJjYmI1MGRlNzEKPj4gWzJd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdG9ydmFsZHMvYy9hYzJhM2ZlZWZhZDUKPiAKPiBUaGVz
ZSBwYXRjaGVzIGhhdmUgYmVlbiBpbnRyb2R1Y2VkIGluIHY1LjE4LCBidXQgd2Ugc3VwcG9ydCBr
ZXJuZWwgdW50aWwgCj4gdjQuNC4gSWYgd2UgcmVhbGx5IHdhbnQgdG8ga2VlcCB0aGlzIGNvZGUs
IAoKVGhlcmUgYXJlIGZhdGFsIGVycm9ycyBhYm91dCB0aGUgZm9sbG93aW5nIHR3byBmaWxlczoK
CnRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvdGJpby90YmlvX2tlcm5lbC9sdHBfdGJp
by5jCnRlc3RjYXNlcy9rZXJuZWwvZGV2aWNlLWRyaXZlcnMvYWNwaS9sdHBfYWNwaV9jbWRzLmMK
CkkgZ3Vlc3MgdGhleSBhcmUgbm90IHVzZWQgZnJlcXVlbnRseS4KSSBhbSBub3Qgc3VyZSB3aGF0
IGlzIHRoZSBwcm9wZXIgd2F5IHRvIGhhbmRsZSB0aGlzIGNhc2UuCgooMSkganVzdCBrZWVwIGl0
IGFzIGlzCigyKSByZW1vdmUgdGhlbSBlbnRpcmVseQooMykgYWRqdXN0IHRoZW0gZm9yIGRpZmZl
cmVudCBrZXJuZWwgdmVyc2lvbnMKCkZ1cnRoZXJtb3JlLCBJIGZvdW5kIHRoZXJlIGFyZSBtYW55
IHdhcm5pbmdzIGV4Y2VwdCB0aGUgYWJvdmUKZmF0YWwgZXJyb3JzLCBpcyBpdCBuZWNlc3Nhcnkg
dG8gc2lsZW5jZSB0aGVtIG9yIGtlZXAgaXQgYXMgaXM/Cgo+IHdlIG5lZWQgdG8gdXNlIGF1dG9j
b25mIGluIAo+IG9yZGVyIHRvIHJlY29nbml6ZSBhY3BpIGZ1bmN0aW9ucyBhbmQgdG8gY3JlYXRl
IGEgZmFsbGJhY2sgZmlsZSBpbiAKPiBsYXBpL2dlbmhkLmggbGlrZSB3ZSB1c3VhbGx5IGRvIGZv
ciB0aGUgb2xkZXIgQVBJLgo+IAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2pl
Y3QvbHRwL2Jsb2IvbWFzdGVyL2NvbmZpZ3VyZS5hYwo+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51
eC10ZXN0LXByb2plY3QvbHRwL3RyZWUvbWFzdGVyL2luY2x1ZGUvbGFwaQoKSWYgbmVjZXNzYXJ5
LCB3aWxsIHRyeS4KClRoYW5rcywKVGllemh1CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
