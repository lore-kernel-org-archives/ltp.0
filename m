Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9721FF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:55:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AE4A3E52F8
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 18:55:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDC793E2D7C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:55:40 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46EDC1000377
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 18:55:40 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8f231f3b130so388439685a.3
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777395339; x=1778000139; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lr9mgA0I0f4CfuV/MMNLwwe/C3z1zrbMKUw3eL1JNIg=;
 b=ENht9sdmWS0yWOF38zYq3FldVpbO11QrtQsdFJQH/cfKULCf+t03Dpj1NPL2fDPD7X
 rX3XTk8n5N3r4064FJWcH4zGF1Y0Od4nzrUQpqL5V8+JkCG1xI4jc5QvVRdmwoadJDJ4
 0o6EId5QSkbV+xpRm0QxtQTiItaa7zzO4GNo7mTza8x24nJjsz2KbSLF/dSqY4jJDuCl
 DgHZ0qfTGyoZEji82zOhYlQR184IhW/QWed88rkxMLnbI68t50uxZE5lFN+Z2Lx6znMx
 V76fNAmuN6stvBefuECTJLwORb7twwpw/zvbMviYsRalcEK7t6QUYdMujEvqtHa/RoHK
 JWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777395339; x=1778000139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lr9mgA0I0f4CfuV/MMNLwwe/C3z1zrbMKUw3eL1JNIg=;
 b=Nd1FuHy6GqdNQd00FCJPrMu3AO/l2+xOWEw8wwxpBlCOAkWAmD+/aA6hmHHs9Oe6/7
 JCX7SocMozxAZ7+DIR3Tqgt/CiDi42eW10974Bzm5nt0UUTJpREH03NaTxQ33FrtHdW8
 YJU8kjOHhnMhabtXmGkihd7PqhaPRfnbGtkAMZtnqidDlPoucMk3uvDPjV067WfjD8o7
 iJrKwRL+8n+Bc6rBxhBEEGeNcB2kCWkSy3VBVxIyzfjcSaKZVRUcXiBCKvbwkSzVC1KL
 n9G+GquTk9SZ/hjb0TE2Fy7j25yfS3bSMt8uoOhIgtS73eUwfSoKf/pQbqvYda/G2DtU
 A4rQ==
X-Gm-Message-State: AOJu0Yy8YHg2B8KsteqXdgdjLR1C5ToQtvLEq2de0iq5cDbHJHQhIfCD
 4Ycnbohy/MKaEPG5ebtSxmbhaUc9cNKCbosn86X+RsmpOWin9uvDOis69fVFSLT8u1I=
X-Gm-Gg: AeBDiesQPbhlQiTrPphA3KOBqH1Qd/YOS5D3r9dDZmGIx5t3W1O4LPIhrUHlStqI5M0
 P0SO2DTbODMkGSYCsNXdY109nie1GtaHQ06h9W5cJhyK9q/onX9pbEP6wWPTcnc3KTBP7V5sil+
 A8cYWKT3nUpr4nU8E6M5u//ULooRQkf4MfBl/xqBEb1S8yA4P0tIn55uaQ53v0fttRLwP2IdQoy
 cTrc8FwjmcX6kyaimzCjj13RrDyD4n3No8poWx/M3dtiHKc5nwyT6j5XNnVPUhnRai6PlNXs6WE
 wCVpb9JkWGQaoJY5QCKoRXmVQuaHkflCVo5CiPoLIB+4iwyZBuPzAUqymCdwekU+MqtmwFeLjH5
 QSHyVpBz+uPTPVSx7EXAQUJb39dbK6xVKgCam6weLM93TDDO0noO+X7sQn45aLg79WHVGwOurwC
 pwX53JySLedRK9O9sTSDuFwv6vcMmQo4BiIsqS140z6sDg3s8yqPqABxT/DwOin8Q1CQ5eW88dz
 psPg0cggG0xhrJA0KlE6KSNL8YiwO1iIOfmmebIlbZqnlChOJ0=
X-Received: by 2002:a05:620a:3910:b0:8c6:d309:f9c0 with SMTP id
 af79cd13be357-8f8f353413bmr55928285a.8.1777395338895; 
 Tue, 28 Apr 2026 09:55:38 -0700 (PDT)
Received: from
 runnervmhkfpo.a2dweqjxmhye1fk1eeuafcafsa.ex.internal.cloudapp.net
 ([130.131.55.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3e2843a52sm23980446d6.14.2026.04.28.09.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 09:55:38 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Tue, 28 Apr 2026 16:55:37 +0000
Message-ID: <20260428165537.3839-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428143614.69724-1-sachinp@linux.ibm.com>
References: <20260428143614.69724-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: generate CVE catalog documentation
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU2FjaGluLAoKT24gVHVlLCAyOCBBcHIgMjAyNiAyMDowNjoxMyArMDUzMCwgU2FjaGluIFNh
bnQgd3JvdGU6Cj4gZG9jOiBnZW5lcmF0ZSBDVkUgY2F0YWxvZyBkb2N1bWVudGF0aW9uCj4gZG9j
OiBSZW5hbWUgc3RhdGlzdGljcyBwYWdlIHRvICdTdXBwb3J0ZWQgc3lzY2FsbHMnCgpCb3RoIHBh
dGNoZXMgbG9vayBnb29kLiBUaGUgQ1ZFIGNhdGFsb2cgZ2VuZXJhdG9yIGNvcnJlY3RseSBoYW5k
bGVzIG1pc3NpbmcKcnVudGVzdC9jdmUgYW5kIG1ldGFkYXRhIGZpbGVzIHdpdGggd2FybmluZ3Mg
cmF0aGVyIHRoYW4gaGFyZCBmYWlsdXJlcy4gVGhlCnJlbmFtZSBpcyBjb25zaXN0ZW50IOKAlCBz
cGVsbGluZyBleGNsdXNpb24sIGZ1bmN0aW9uIG5hbWUsIGFwcC5jb25uZWN0KCkgY2FsbCwKYW5k
IGluZGV4IHJlZmVyZW5jZXMgYXJlIGFsbCB1cGRhdGVkIGluIGxvY2tzdGVwLgoKUmV2aWV3ZWQt
Ynk6IExUUCBBSSBSZXZpZXdlciA8bHRwLWFpQG5vcmVwbHkuZ2l0aHViLmNvbT4KCi0tLQpOb3Rl
OgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwg
cmV2aWV3IGNhbiBiZQpmb3VuZCBhdDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJv
amVjdC9sdHAtYWdlbnQvYWN0aW9ucy9ydW5zLzI1MDY2MTMxNjUwCgpUaGUgYWdlbnQgY2FuIHNv
bWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGlu
Z3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFz
ZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMs
CkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
