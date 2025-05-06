Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01742C3ABBF
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:14:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8172F3CBF51
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:14:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD3373CBEED
 for <ltp@lists.linux.it>; Tue,  6 May 2025 03:03:19 +0200 (CEST)
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
 by in-2.smtp.seeweb.it (Postfix) with ESMTP id 300ED600715
 for <ltp@lists.linux.it>; Tue,  6 May 2025 03:03:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
 Content-Type; bh=8k6Ps8XICsFhOHDP7swZ2/xt72JdkII/mDhpJpn0XEI=;
 b=R+75KhZ3Hb+OEeTn4FpnvfPxY7dY5gZhgtChENW6/t/2RhCfephJNeZUNkeIVP
 tfboDDK4jg02qzDjWD54mwMX9pst4o19m5ENhFCTgcZsBmrTsMwXv1uFe2NRyxbT
 sGXvOqmaHA+suJdWq/sn5Va1rU87hCIo4GPsp5ZqhaQeY=
Received: from [192.168.109.86] (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wD3P0rOXxloeUZNBw--.59553S2; 
 Tue, 06 May 2025 09:03:10 +0800 (CST)
Message-ID: <5c48d7da-84b2-478e-854e-e7f4dd68de68@126.com>
Date: Tue, 6 May 2025 09:03:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>, Petr Vorel <pvorel@suse.cz>
References: <20241120005926.1644064-1-zhaomzhao@126.com>
 <20241217214803.GC29863@pevik>
 <843bd60c-9829-46cc-9dc9-27a59b4668bd@suse.com>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <843bd60c-9829-46cc-9dc9-27a59b4668bd@suse.com>
X-CM-TRANSID: _____wD3P0rOXxloeUZNBw--.59553S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyUXF1fWF4ftw1kKr47twb_yoW8XFyfpa
 y8Ka1UAFyjqFZYk34293Z5Kr1jqa43tF4UJa1qkw1kXrZrJFyUZFy5Jw1rW3WDZr48Ka1x
 CFnF9ayFqw1kJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhZ2fUUUUU=
X-Originating-IP: [1.193.37.141]
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbigQlFd2gZX2AMmgAAsi
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 07 May 2025 17:14:16 +0200
Subject: Re: [LTP] [PATCH] controllers/cpuset: Add backslash to dump full
 fail log
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNS80LzI5IDE1OjU1LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+IEhpIQo+IAo+IEkn
bSBnb25uYSBtZXJnZSB0aGlzLCByZW1vdmluZyBiYWNrbGFzaCBhbmQgam9pbmluZyB0aGUgc3Ry
aW5ncy4KPiAKPiBSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbT4KPiAKPiBPbiAxMi8xNy8yNCAyMjo0OCwgUGV0ciBWb3JlbCB3cm90ZToKPj4g
SGkgWmhhbyBNZW5nbWVuZywKPj4KPj4+IFdoaWxlIGRlYnVnZ2luZyBMVFAgY3B1c2V0X2xvYWRf
YmFsYW5jZV90ZXN0LCB3aGVuIHJtZGlyIGEgcGF0aCBmYWlsZWQsCj4+PiBpdCBvbmx5IGR1bXBz
IHBhcnQgb2YgdGhlIGxvZywgbWlzc2luZyB0aGUgJHN1YmRpci4gQWRkIGJhY2tzbGFzaCB0byBm
aXgKPj4+IGl0Lgo+PiArMSBnb29kIGNhdGNoLgo+Pgo+PiBSZXZpZXdlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGFvIE1lbmdtZW5nIDx6
aGFvbWVuZ21lbmdAa3lsaW5vcy5jbj4KPj4+IC0tLQo+Pj4gwqAgdGVzdGNhc2VzL2tlcm5lbC9j
b250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNzLnNoIHwgMiArLQo+Pj4gwqAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+PiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNzLnNoIGIvdGVzdGNh
c2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNzLnNoCj4+PiBpbmRleCA1
NjcxNzhlM2ZkNTIuLmEzNzRmZDcxZjc5MCAxMDA3NTUKPj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9mdW5jcy5zaAo+Pj4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNzLnNoCj4+PiBAQCAtMTk1LDcg
KzE5NSw3IEBAIGNsZWFudXAoKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRvbmUgPCAiJHN1YmRp
ci90YXNrcyIKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBybWRpciAiJHN1YmRpciIKPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiBbICQ/IC1uZSAwIF07IHRoZW4KPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRzdF9icmttIFRGQUlMICJDb3VsZG4ndCByZW1vdmUgc3ViZGlyIC0gIgo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdHN0X2Jya20gVEZBSUwgIkNvdWxkbid0IHJlbW92ZSBzdWJk
aXIgLSAiXAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIiRzdWJkaXIgaW4gdGhlIGNwdXNldCIKPj4gQ291bGQgd2UgcGxlYXNlIGp1c3Qgam9p
biB0aGUgc3RyaW5nPwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRzdF9icmttIFRGQUlMICJD
b3VsZG4ndCByZW1vdmUgc3ViZGlyIC0gJHN1YmRpciBpbiB0aGUgY3B1c2V0Igo+Pgo+PiBLaW5k
IHJlZ2FyZHMsCj4+IFBldHIKPj4KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmaQo+Pj4gwqDCoMKg
wqDCoCBkb25lCgpUaGFua3MsIEFuZHJlYS4gQWN0dWFsbHkgSSBoYXZlIGFscmVhZHkgc2VudCBh
IHYyIHBhdGNoIHJlbW92aW5nIGJhY2tsYXNoIGFuZCBqb2luaW5nIHRoZSBzdHJpbmdzCnRvIExU
UCBhdCAyMDI0LzEyLzE4LCBidXQgZ290IG5vIHJlcGx5IG9uIGl0LgoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
