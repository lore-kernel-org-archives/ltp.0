Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98DAC83F0F
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 09:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BCC13CA200
	for <ltp@archiver.kernel.org>; Tue,  8 Jul 2025 11:04:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF7B43C647F
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:04:20 +0200 (CEST)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id E110428049DD
 for <ltp@lists.linux.it>; Tue,  8 Jul 2025 11:04:15 +0200 (CEST)
Received: from loongson.cn (unknown [113.200.148.30])
 by gateway (Coremail) with SMTP id _____8AxquAM32xoDkckAQ--.37331S3;
 Tue, 08 Jul 2025 17:04:13 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
 by front1 (Coremail) with SMTP id qMiowJAxQMII32xoqSoOAA--.10988S3;
 Tue, 08 Jul 2025 17:04:10 +0800 (CST)
To: ltp@lists.linux.it
References: <20250708071215.17515-1-yangtiezhu@loongson.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <77bd7be1-17c2-66bc-058f-8f8f493ec89c@loongson.cn>
Date: Tue, 8 Jul 2025 17:04:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250708071215.17515-1-yangtiezhu@loongson.cn>
Content-Language: en-US
X-CM-TRANSID: qMiowJAxQMII32xoqSoOAA--.10988S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrur43Zw18JF17tF1ktw1xXrc_yoWDGwb_G3
 9akFsrC348Zr43trs7tF4av3W3Ww4xWFWqqrWkXw42g3sYkw48Ja1Skw13Ar1UtrWkCFs8
 Grsaqw4fuw4jkosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
 oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
 0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_
 Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
 xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
 CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU
 =
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrlimit/getrlimit03: Skip test if
 __NR_getrlimit not implemented
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

T24gMjAyNS83Lzgg5LiL5Y2IMzoxMiwgVGllemh1IFlhbmcgd3JvdGU6Cj4gSW4gdGhlIExpbnV4
IGtlcm5lbCwgTG9vbmdBcmNoIHVzZXMgdGhlIGdlbmVyaWMgc3lzY2FsbCB0YWJsZSB3aGljaAo+
IGlzIGRlZmluZWQgaW4gaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL3VuaXN0ZC5oLCBhbmQgYWxz
byB0aGVyZSBpcwo+IG5vIF9fQVJDSF9XQU5UX1NFVF9HRVRfUkxJTUlUIGluIGFyY2gvbG9vbmdh
cmNoL2luY2x1ZGUvYXNtL3VuaXN0ZC5oLAo+IHNvIF9fTlJfZ2V0cmxpbWl0IGlzIG5vdCBpbXBs
ZW1lbnRlZCBvbiBMb29uZ0FyY2guCj4gCj4gVGhhdCBpcyB0byBzYXksIGdldHJsaW1pdCBhcmUg
c3VwZXJzZWRlZCB3aXRoIHBybGltaXQ2NC4gVGhlcmUgaXMgbm8KPiBuZWVkIHRvIGNvbXBhcmUg
dGhlIHJldHVybiB2YWx1ZSBhbmQgZXJybm8gYWJvdXQgdGhlIHN5c2NhbGwgbnVtYmVycwo+IF9f
TlJfcHJsaW1pdDY0IGFuZCBfX05SX2dldHJsaW1pdCwganVzdCBjaGVjayB0aGlzIGNhc2UgYW5k
IHRoZW4gc2tpcAo+IHRoZSB0ZXN0LgoKSSByZWNlaXZlZCB0aGUgZm9sbG93aW5nIHJlcGx5CiJZ
b3VyIG1lc3NhZ2UgdG8gbHRwIGF3YWl0cyBtb2RlcmF0b3IgYXBwcm92YWwiCmFmdGVyIHNlbmRp
bmcgb3V0IHRoaXMgcGF0Y2gsIGJlY2F1c2UgSSBhbSBub3QKYSBtZW1iZXIgb2YgTFRQIG1haWxp
bmcgbGlzdCwgc28gSSBzdWJzY3JpYmUgdG8KdGhlIGxpc3QgYW5kIHRoZW4gc2VuZCBhbm90aGVy
IHNhbWUgcGF0Y2guCgpQbGVhc2UgaWdub3JlIHRoaXMgdGhyZWFkLiBJZiB5b3UgaGF2ZSBjb21t
ZW50cywKcGxlYXNlIHJlcGx5IHRvIHRoZSBvdGhlciB0aHJlYWQuCgpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sdHAvMjAyNTA3MDgwNzE3MDYuMTk2MzktMS15YW5ndGllemh1QGxvb25nc29uLmNu
L1QvI3UKClNvcnJ5IGZvciB0aGUgbm9pc2UuCgpUaGFua3MsClRpZXpodQoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
