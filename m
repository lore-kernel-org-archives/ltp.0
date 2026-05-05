Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABAAFF8855
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 17:53:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C29F3E6ADB
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 19:53:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F366B3E24C9
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:53:38 +0200 (CEST)
Received: from mail-dy1-x1344.google.com (mail-dy1-x1344.google.com
 [IPv6:2607:f8b0:4864:20::1344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 982666009F7
 for <ltp@lists.linux.it>; Tue,  5 May 2026 19:53:38 +0200 (CEST)
Received: by mail-dy1-x1344.google.com with SMTP id
 5a478bee46e88-2ef2a1cc06dso26513eec.0
 for <ltp@lists.linux.it>; Tue, 05 May 2026 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778003617; x=1778608417; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPZYEFrX5+u4+ixuYkFiUaK/bNxOyrNNZIfgGgO7IW4=;
 b=PA1kWGgRWJYU1U6ayWi3aRbrLozJhNHAx/d5sYKTi9hYKb1AJSj8hTwnBe4VUIcnbQ
 jWj1ebuHAo50chogBoWI8cbecl0OfI/UZ046+xVJp+0V13NaKjKWjORUfZdrixaKqroT
 yACJPUE4D7GUfY2jhcfoYNbuRk0DqqBsmrhMRuRB6Pv8/PLJFUp3VgOS7/BdH2C0tGCy
 n5clE6GAxyLnpA6/2TcxA94ZJmk9z0X/lsfppUq/ouknUXjxzWqobuS9x4rsB5M0PUzh
 oFHk6qN86FeJ/s7vg3op+d7uNso/scr8BbbfaDPRWYR+PTsqkAiQD9BHLEKcRW9l5uBP
 GTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778003617; x=1778608417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tPZYEFrX5+u4+ixuYkFiUaK/bNxOyrNNZIfgGgO7IW4=;
 b=RRXwOVTOo/K6nAt27LIa9KA8wlxO+xb6RQT5hbvfkLG6ppLAiHV/7YFNeLNcnrNY4d
 8egR7xCm3oaLyp6g3Z+WQ20GI8YmtKzVgr1Rwjz+xGNI7BeEwaDzMpndx+aFlSKRcZfq
 TAA9dY6MeSV4DRKjwikj/y8XPg+AfNbkHflTX9znR+aBMmigzgRGNQqQYR8xXDp4oKYR
 XkeM14Up5z3ss3RJOBSMco0h0fnC2n42Ku9AMsRvk4sJC9zIq3NwlfRYe6Kp+wk8h47S
 J7q690b4XWpPBdAlhNVGzx7qIVlM8pQr35DSK9yqd2VzZQvwehNsxIiz9C5pRMa2qp6i
 cEEg==
X-Gm-Message-State: AOJu0Yz6j2+KRBlOcYIrF/VdTiOEaCUqhDnCWLcYlbYceu7aDIplJRHa
 RTG3zXUC3x+3r5M0XHAZekoNViteMOXLuAMe7mhA1lcGxAZnE+6Ua2CR
X-Gm-Gg: AeBDies2q4mq1NpaUj2qs8ZMcK6W+UCBGOWnVTt8OHiqGM5T7hFoREjl9/2j7tUVFfD
 uExxdDo2en1MjMh96TAC4o0Nt9CTjnAic0uymsxL0CKWeoDvBUEeR6Ts0nozIlgRa2fJ1Iv4cDl
 hVZh/MPiRy8oBgvop3tQLVJV0Q0o0jp1jPmwjv0sbLBsb/UZ9PHssGEvrAftBYQCNfRjZyQB3TN
 7/fXoyW6fIWSOxtjtLHxUT7YFhZMDUSM4F70wqXDbFq84nynj7Qau87XP7f3iEhAhKmmO7SlLHH
 kbz+JOL9lQ2MyDJEczCpimKbhxqlISZAOAop07bZ9z21i2Hv227dGMMKocivq9ztq6th7K5jJ8L
 Ps1iR2TjW0cpOdPCq+lv15GbpNxGnf2nu9j5cGG8kASy/ujPE+/koh6Mh6NuiUM2QVRGWRA11c5
 lcX9fGD0wxGnxd2s9P8AniHIvLiVT6kOLDe0wCSfftVfnE5AUnkcXDk/GilXuhXzUo33IN9fQNX
 J8PJrG6U94LzLXpXcVS+GtXwFPTg/ZFq6EvKll+eC/yG/kMwslKSPo=
X-Received: by 2002:a05:7300:a987:b0:2d8:7302:d21 with SMTP id
 5a478bee46e88-2f549e6b1d2mr165468eec.16.1778003616851; 
 Tue, 05 May 2026 10:53:36 -0700 (PDT)
Received: from
 runnervmeorf1.j4d2msqytdjuzezxjpe1iftl5h.phxx.internal.cloudapp.net
 ([172.182.226.214]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889cf53sm28233385eec.5.2026.05.05.10.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:53:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue,  5 May 2026 17:53:35 +0000
Message-ID: <20260505175335.4038-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505110208.32207-2-piotr.kubaj@intel.com>
References: <20260505110208.32207-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

SGkgUGlvdHIsCgpPbiBUdWUsIDUgTWF5IDIwMjYgMTM6MDI6MDkgKzAyMDAsIFBpb3RyIEt1YmFq
IHdyb3RlOgo+IGNwdWZyZXEuYzogYWRkIG5ldyB0ZXN0IGZvciBjcHVmcmVxIHN5c2ZzIGludGVy
ZmFjZSB2YWxpZGF0aW9uCgo+ICsvKlwKPiArICogUnVucyB2YXJpb3VzIHNhbml0eSBjaGVja3Mg
Zm9yIGludGVsX3BzdGF0ZSBjcHVmcmVxIHN5c2ZzIGludGVyZmFjZS4KPiArICogLi4uCj4gKyAq
LwoKVGhlIGRvYyBjb21tZW50IGRvZXMgbm90IHN0YXRlIHdoeSByb290IGlzIG5lZWRlZC4gUGVy
IGdyb3VuZC1ydWxlcyBydWxlIDQsCmRvY3VtZW50IHRoZSByZWFzb24gaW4gdGhlIGRvYyBibG9j
ayDigJQgZS5nLiAiUmVxdWlyZXMgcm9vdCB0byB3cml0ZSB0bwovc3lzL2RldmljZXMvc3lzdGVt
L2NwdS9pbnRlbF9wc3RhdGUvIGFuZCBwZXItQ1BVIGNwdWZyZXEgc3lzZnMgYXR0cmlidXRlcy4i
CgpbLi4uXQoKPiArCVNBRkVfRklMRV9TQ0FORigiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50
ZWxfcHN0YXRlL25vX3R1cmJvIiwgIiVkIiwgJm5vX3R1cmJvKTsKPiArCVNBRkVfRklMRV9TQ0FO
RigiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvaW50ZWxfcHN0YXRlL3N0YXR1cyIsICIlMTVzIiwg
aW50ZWxfcHN0YXRlX3N0YXR1cyk7CgpDT05GSUdfWDg2X0lOVEVMX1BTVEFURT15IGRvZXMgbm90
IGd1YXJhbnRlZSB0aGUgZHJpdmVyIGlzIGFjdGl2ZSBhdCBydW50aW1lCihhY3BpX2NwdWZyZXEg
bWF5IHRha2Ugb3Zlciwgb3IgdGhlIGRyaXZlciBtYXkgYmUgaW4gIm9mZiIgbW9kZSkuIElmIHRo
ZQpzeXNmcyBmaWxlcyBhcmUgYWJzZW50LCBTQUZFX0ZJTEVfU0NBTkYgY2FsbHMgdHN0X2JyayhU
QlJPSykuIEd1YXJkIHdpdGgKYW4gZXhpc3RlbmNlIGNoZWNrIGFuZCB1c2UgdHN0X2JyayhUQ09O
RiwgImludGVsX3BzdGF0ZSBkcml2ZXIgbm90IGFjdGl2ZSIpCmluc3RlYWQuCgotLS0KTm90ZToK
Ck91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBhZ2VudCBj
YW4gc29tZXRpbWVzIHByb2R1Y2UKZmFsc2UgcG9zaXRpdmVzIGFsdGhvdWdoIG9mdGVuIGl0cyBm
aW5kaW5ncyBhcmUgZ2VudWluZS4gSWYgeW91IGZpbmQgaXNzdWVzCndpdGggdGhlIHJldmlldywg
cGxlYXNlIGNvbW1lbnQgdGhpcyBlbWFpbCBvciBpZ25vcmUgdGhlIHN1Z2dlc3Rpb25zLgoKUmVn
YXJkcywKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
