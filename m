Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79DDF9D0E8
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 17:15:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 753843E5E13
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 19:15:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 522613CDC78
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:15:16 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BBA612009A6
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 19:15:15 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8d4f78fc9f6so696154385a.3
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776186914; x=1776791714; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhzLUZp9GsVH2UcRTGWD1JAzYQNOH4z+WhLOllUciLM=;
 b=GT0frdpzqu88zCGRV08T0cM8zpZpc4yj36oYj2wYm+3+NuZuweJjIXzV5D4hzbAvaM
 +oDRIzjZIPy7wl+iDjhUbDMR5sewNW6xaKDBX1LnWhsFDEpW7K8S7Lvv0/v6Ymz3Mllu
 muhdoSGek+o8B/ZSDZEEdKxurh2Lnj0kXoFY/0TnpWHK/ZSgKPRbv5KKYX4xxPfB4rC0
 3zZlBlbThob0z+W9u+L3G1C3IYqNEifUSEPf3YkwO+h7pwXhwxvbOMkvWf1NUyLtoFCp
 BusnYTfl2wbwxNOiHG6FMBNoKO2hWoRZAHyXnMWgfsoOPqT2/hDi9FNjtj46XxI4x20j
 unjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776186914; x=1776791714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JhzLUZp9GsVH2UcRTGWD1JAzYQNOH4z+WhLOllUciLM=;
 b=R4p0mrJhAAwPR3Vvq840uAXCCIetg9UuobCdkRTPDWpYWsILTyvWoeDkUthRKlYTwI
 6G+RLgjqKjthEjLJcLCnFCyOh+IIqcM/btqw1B5pIEcFRXOMyJu9EEeEP0PFgCH41NVI
 /C5QK8VIHY6I1l/RIPiLzECUK0VLAdZndk3AduaX5kjY49fr8KdQcLTipxEh//lawbC9
 qghUnyIngspYI1bnXD3lRfInuo/p1wYe8v0BctWQV9W35jZhlLSTOpWt0HTEmJWsITUW
 zsZwPt0nI1Q/a4U/JmIi6phnA087fKhcBlj+V+1OqrUE0slH6JHc9H+pb++36TdDnLGg
 j6tQ==
X-Gm-Message-State: AOJu0YxhiEQCx0/Pes64cdHmTYRj3C3wqAoF33JxZfAOlcdw2dODSi6F
 80S3Pm9FeB+F0pt3+8H9UYlAA+zhtAcqThQWSF82Zdkexy6pc5ezIs3o
X-Gm-Gg: AeBDieuvg6npvv+rSGHD+7f8PVHZqt0ZTKrOt51fLApUdJwvVsWmsQsuv/wf5g5yE5v
 SeLauKmfMxx5TP4vG6qbGrCMINHrr3iU6Pni0Bx/54+VqjfYGpGH0O4jkqoBV7rNIYbqv6m9R1+
 hczHa9XQd9N+TqoIZExRXucfsZ6JeNGQK1tOBsvwjdQ5unPzcxXZNYNAIfqgDXhmi3EDvwxakjk
 VuZ7b42exo95jynOsR5C+PZG1+3bW4eCqIIPONhV0EkBIiCPYoqqRdWoVR8uHuOKpW+hGjJF9SC
 ehJQB1++npily/JLcYcmG5mfp4fi6W60oCHGKRb05IM1VRjp/sS+O0p7326cxYsuCEhM7yzBgiN
 8Z9WSjVQyJJuCz036PJrb51oNRtMmg6qkKj46C1dJmSGnwnqEzBeimXmUA9j1c5vxVszmoaZYEZ
 YMQ/zpX+OJmPlyyT++8fwIGN/rLZLVzQSwk+FyXE/quYblZHkZ4fk9seP/ecVAgW191itP15wcQ
 tMYB4r/DYb45ewg5rxAfm6+
X-Received: by 2002:ad4:5e85:0:b0:8ac:bb62:fe52 with SMTP id
 6a1803df08f44-8acbb630fa4mr79382186d6.4.1776186913733; 
 Tue, 14 Apr 2026 10:15:13 -0700 (PDT)
Received: from
 runnervm35a4x.ccppip3scqvufedtrt4s1lh33h.bx.internal.cloudapp.net
 ([52.150.30.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8acb371b547sm47092016d6.37.2026.04.14.10.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:15:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Tue, 14 Apr 2026 17:15:12 +0000
Message-ID: <20260414171512.4014-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414164927.843200-1-sbertram@redhat.com>
References: <20260414164927.843200-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl: updates for multi worker testing.
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

SGkgU3RlcGhlbiwKCk9uIFR1ZSwgMTQgQXByIDIwMjYsIFN0ZXBoZW4gQmVydHJhbSB3cm90ZToK
PiBzZW1jdGw6IHVwZGF0ZXMgZm9yIG11bHRpIHdvcmtlciB0ZXN0aW5nLgo+Cj4gQ2hhbmdlZCBz
ZW1jdGwwMSwgd2hpY2ggcmVxdWlyZWQgdXBkYXRlcyB0bwo+IHJlZHVjZSBpbnRlcmZlcmVuY2Ug
YW5kIHByb3ZpZGUgYW4gYWxsb3dhbmNlCj4gZm9yIEVJTlZBTCBhbmQgRUlEUk0gZmFpbHVyZXMu
CgpUaGUgYm9keSBzaG91bGQgc2F5ICp3aHkqIG11bHRpLXdvcmtlciBzdXBwb3J0IGlzIG5lZWRl
ZCDigJQgd2hhdCBoYXJuZXNzCm9yIHJ1bm5lciBleGVyY2lzZXMgdGhpcyBpbiBwYXJhbGxlbCwg
b3Igd2hhdCBmYWlsdXJlIHByb21wdGVkIHRoZSBjaGFuZ2UuCgo+IC1zdGF0aWMgaW50IHNlbV9p
ZCA9IC0xOwo+IC1zdGF0aWMgaW50IHNlbV9pbmRleDsKPiArc3RhdGljIF9fdGhyZWFkIGludCBz
ZW1faWQgPSAtMTsKPiArc3RhdGljIF9fdGhyZWFkIGludCBzZW1faW5kZXg7Cj4gIHN0YXRpYyBz
dHJ1Y3Qgc2VtaWRfZHMgYnVmOwo+ICBzdGF0aWMgc3RydWN0IHNlbWluZm8gaXBjX2J1ZjsKPiAg
c3RhdGljIHVuc2lnbmVkIHNob3J0IGFycmF5W1BTRU1TXTsKPiAgc3RhdGljIHN0cnVjdCBzZW1i
dWYgc29wczsKPiAgc3RhdGljIGludCBwaWRfYXJyW05DSElMRF07CgpidWYsIGlwY19idWYsIGFy
cmF5LCBzb3BzLCBwaWRfYXJyIGFyZSBzdGlsbCBwbGFpbiBnbG9iYWxzLiBNYWtpbmcgb25seQpz
ZW1faWQvc2VtX2luZGV4IFRMUyBsZWF2ZXMgYWxsIHRoZSBoZWxwZXIgZnVuY3Rpb25zIHRoYXQg
cmVhZC93cml0ZQp0aGVzZSBnbG9iYWxzIHVuc2FmZSBmb3IgY29uY3VycmVudCB1c2UsIHNvIHRo
ZSBwYXJhbGxlbGlzYXRpb24gaXMKaW5jb21wbGV0ZS4KClsuLi5dCgo+ICsJCWlmIChzaWQgPT0g
LTEpCj4gKwkJCXNlbV9pZCA9IHNpZCA9IFNBRkVfU0VNR0VUKElQQ19QUklWQVRFLCBQU0VNUywK
PiArCQkJCQkJICAgSVBDX0NSRUFUIHwgSVBDX0VYQ0wgfCBTRU1fUkEpOwoKY2xlYW51cCgpIHJ1
bnMgaW4gdGhlIG1haW4gdGhyZWFkIGFuZCBvbmx5IHNlZXMgdGhlIG1haW4gdGhyZWFkJ3MgVExT
CnNlbV9pZC4gV29ya2VyIHRocmVhZHMgdGhhdCBoaXQgdGhpcyBwYXRoIHdpbGwgbGVhayB0aGVp
ciBzZW1hcGhvcmUgc2V0cy4KRWl0aGVyIHRyYWNrIGFsbCBhbGxvY2F0ZWQgSURzIGluIGEgc2hh
cmVkLCBtdXRleC1wcm90ZWN0ZWQgbGlzdCwgb3IgZHJvcApfX3RocmVhZCBhbmQga2VlcCB0aGUg
dGVzdCBzaW5nbGUtdGhyZWFkZWQuCgpBbHNvIG5vdGUgc3RydWN0IHRjYXNlczo6c2VtaWQgaXMg
bm93IGFsd2F5cyBOVUxMIGFuZCBuZXZlciByZWFkOyB0aGUKZmllbGQgY2FuIGJlIHJlbW92ZWQu
CgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2gu
IFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFi
cy5vcmcvcHJvamVjdC9sdHAvbGlzdC8/c2VyaWVzPTQ5OTg3NAoKVGhlIGFnZW50IGNhbiBzb21l
dGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdz
IGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UK
Y29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
