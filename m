Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A89F9D0DA
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 17:00:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F34743E5E00
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 19:00:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998AF3CDC78
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 18:59:59 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DFB7600702
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 18:59:59 +0200 (CEST)
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-470145d7df5so3538749b6e.0
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776185998; x=1776790798; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RqwFWXA1r9C/qrxiI4Z6Cloe1c/7fkWOtsHTQZlJQA=;
 b=H2s6N/knr3tpJjRbdIVQ8Wp1vvLXhA/DTe62zD55jPELnSMV1aEgCKFvAiK6PCSkU7
 9gGUPMvsHkCxHzMTN19MMgNu/zVnWhNyaEcyRTeJ6Se6L+QNTrjgR5pvw/TDWZZ7q9FK
 iUSczqQXH3qPv59jhuPaMYy6ngP2tal4cTZVFuHK8fpbXKrJaMxAIrNhBhtwRAQ/G6+R
 8YEARrLmfFSntwhgfD2QC7gvBJPo4RfcxjuLI97HRq3Ag1CWK3qx+H6ak0QBaDxDhc/k
 9DHDUUkxpz0ilajtu+ZfhxUgSgLGbcQNzzp/wcvssT+SvEIUFltOiSP5ZObaLLs1mkdH
 XGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776185998; x=1776790798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0RqwFWXA1r9C/qrxiI4Z6Cloe1c/7fkWOtsHTQZlJQA=;
 b=jJapk59rbDRZR444VorLTRyvEbYKUZEwmwrZcgDRCl8QSeMzIA525L7M6ODkuQayzf
 0XIAFSDBy+fpmLargZGlFEHl2f1mzFB5bdYEvTRJzDZ3er4qEwqQs2GdnQhEuKCbSTOh
 nw6gPzb+QmgLS3CC+4SJXdY/8hYTtDT3arExsIqHFxMCASFxQEFPSEVhbphXGqIhwIdd
 AAH7V3Rkv/14Fstkwy5uQqXUUH+pW6uOMRm8UdBMFNyRo/1J6wN9TnAkfvqbbuNexFLL
 8k3UNNeXn9pgUYl0sR8KuIg63cTuPwX7hH7VN2p7VcdJ0Akc9dBtYqUkGp+W7M/Uphk/
 KJ8w==
X-Gm-Message-State: AOJu0YxZydHWLa44inqrcMOgHHwX0zd9UPWuvHgo4q0xoVBiyGqc5/qS
 v0dfAY5oQfEDCQXqL6m5IPoCWRCI7I+lInSi3D5e8FA2rOSie0aFoWrN
X-Gm-Gg: AeBDiesNRAEudXItPvWd25JkCesKxMf9oSlj8zDlpBce9rZUOYTBgW2bBdR5D9kURNJ
 IGs+bA1CHHzCntgzVj9DAoPJLfXAXkBGuzcvSCrpRvsfHh+o2aYzOh+ceM69QYsb6LBX6Fr7GJN
 qnwJC49XAN/b2/r3boUng2pP4o8zwrUYFr69rSmmrgP2mLXA3GX1p3tJdS81qGN0ARIAmerVERu
 sh+zUiYIsrDx3/1zT6gcq134aiNTdksZVmEI3iiOcEkWaEjEmnHfr6yFnXbG2lBol6tKlQznV6A
 D1mbNo8cxAlNmZSa3ILN8+FU/CzWzoPIg5151eIIiuFUgdxdC14SSY2YvAtFQjkQQ2sPJRA1mzK
 vP5BeExJP25fW0aOo813wiSN/aZjf87Rbm5lwbd2kwdEB7kfEMv+dKGWiEFuJL6coJFvMup4QnB
 sRFMFmZGunVILASSjd40H6aOvb/yjBQoHBNwSg/+3RcmAKxRGxq6IM8CoqV7t/wB3NnDOxhkLh1
 vF6ubU2SrVVDbRiYloo8//MAA==
X-Received: by 2002:a05:6808:1a25:b0:46a:e0cd:2723 with SMTP id
 5614622812f47-4789d73d0b5mr8644031b6e.21.1776185997654; 
 Tue, 14 Apr 2026 09:59:57 -0700 (PDT)
Received: from
 runnervm35a4x.kkizw1q41lvuhazfqxg01mu2mg.gx.internal.cloudapp.net
 ([172.212.163.19]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a0f1e841sm7879375b6e.5.2026.04.14.09.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:59:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Soma Das <somadas1@linux.ibm.com>
Date: Tue, 14 Apr 2026 16:59:56 +0000
Message-ID: <20260414165956.4038-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_football: fix false failures on many-CPU systems
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

SGkgU29tYSwKCk9uIFN1biwgMTIgQXByIDIwMjYgMTM6MTM6MDggKzAwMDAsIFNvbWEgRGFzIHdy
b3RlOgo+IHNjaGVkX2Zvb3RiYWxsOiBmaXggZmFsc2UgZmFpbHVyZXMgb24gbWFueS1DUFUgc3lz
dGVtcwo+Cj4gT24gbGFyZ2UgU01QIHN5c3RlbXMgd2l0aCBDT05GSUdfUlRfR1JPVVBfU0NIRUQ9
biwgZm91ciBpbmRlcGVuZGVudAo+IGlzc3VlcyBjYXVzZSBmYWxzZSBmYWlsdXJlcy4KPgo+IDEu
IFJUIHRocm90dGxpbmcuLi4KPiAyLiBPZmZlbnNlIGFuZCBkZWZlbnNlIHRocmVhZHMgd2VyZSB1
bnBpbm5lZC4uLgo+IDMuIGdhbWVfb3ZlciB3YXMgbmV2ZXIgcmVzZXQgYmV0d2VlbiBpdGVyYXRp
b25zLi4uCj4gNC4gc2NoZWRfc2V0c2NoZWR1bGVyKCkgZmFpbHVyZSBmb3IgdGhlIHJlZmVyZWUg
d2FzIHNpbGVudGx5IGlnbm9yZWQuCgpUaGUgY29tbWl0IG1lc3NhZ2UgaXRzZWxmIGRlc2NyaWJl
cyB0aGVzZSBhcyBmb3VyIGluZGVwZW5kZW50IGlzc3Vlcy4KUGxlYXNlIHNwbGl0IGludG8gZm91
ciBzZXBhcmF0ZSBjb21taXRzIHNvIGJpc2VjdGlvbiBhbmQgYmFja3BvcnRpbmcKd29yayBjb3Jy
ZWN0bHkuIEF0IG1pbmltdW0sIGZpeGVzIDMgKGdhbWVfb3ZlciByZXNldCBiZXR3ZWVuIC1pCml0
ZXJhdGlvbnMpIGFuZCA0IChzY2hlZF9zZXRzY2hlZHVsZXIgZXJyb3IgY2hlY2spIGFyZSBmdWxs
eSBvcnRob2dvbmFsCnRvIHRoZSBSVC10aHJvdHRsaW5nIGFuZCBDUFUtYWZmaW5pdHkgY2hhbmdl
cyBhbmQgbXVzdCBiZSBzZXBhcmF0ZQpwYXRjaGVzLgoKWy4uLl0KCj4gKwlTQUZFX0ZJTEVfU0NB
TkYoIi9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfcnRfcnVudGltZV91cyIsICIlbGQiLAo+ICsJCQkm
c2F2ZWRfcnRfcnVudGltZV91cyk7Cj4gLi4uCj4gKwlTQUZFX0ZJTEVfUFJJTlRGKCIvcHJvYy9z
eXMva2VybmVsL3NjaGVkX3J0X3J1bnRpbWVfdXMiLCAiJWxkIiwgLTFMKTsKCkNvbnNpZGVyIHVz
aW5nIC5zYXZlX3Jlc3RvcmUgaW4gc3RydWN0IHRzdF90ZXN0IGluc3RlYWQgb2YgbWFudWFsCnNh
dmUvcmVzdG9yZSBpbiBzZXR1cC9jbGVhbnVwIOKAlCBpdCBpcyB0aGUgaWRpb21hdGljIExUUCBh
cHByb2FjaCBmb3IKL3Byb2Mvc3lzIGtub2JzLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxl
dGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcwpwcm9k
dWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMgZmluZGluZ3MgYXJlIGdlbnVp
bmUuIElmIHlvdQpmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZSBjb21tZW50IHRo
aXMgZW1haWwgb3IgaWdub3JlIHRoZQpzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZp
ZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
