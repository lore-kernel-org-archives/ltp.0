Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB65CD6E4A
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 09:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F5C23E21D4
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 11:23:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D4973E2014
 for <ltp@lists.linux.it>; Sat, 30 May 2026 11:22:56 +0200 (CEST)
Received: from mail-dl1-x1243.google.com (mail-dl1-x1243.google.com
 [IPv6:2607:f8b0:4864:20::1243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DEF5210000EB
 for <ltp@lists.linux.it>; Sat, 30 May 2026 11:22:55 +0200 (CEST)
Received: by mail-dl1-x1243.google.com with SMTP id
 a92af1059eb24-137d452574cso1473292c88.0
 for <ltp@lists.linux.it>; Sat, 30 May 2026 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780132974; x=1780737774; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAaCn7PvHTqyXsIw/GOy0wV7i7L1eRsHHeSQXf+1ulo=;
 b=IxJvmJz+qRlNJj72BPwyZsvaamzFdZRxdggD+svHUMszIRMTV/BF3f8Xw5I5/ygQhz
 GE+2GCLxaQGIb95yd5p42JKGSJKOXL5ZciHt2sVLADhCGBkWMM9Bp3QDObMU1msT7SCi
 HsAUR7Azggj2DvwlymWxgjSfqJSBfYhRI2qno81Kvs56Iz0P7ScT9vy0g7I0ONJJ8oJe
 h8R5PSeh7zGcl9IkmdbMI9JPTwi64dYZmORkFNckD5zdHXQ0HjMXZhZh8dKK1w2ERpAV
 eC0uC+AcC09jFhtsDp+PNdo7Rw3lg+kEG2Rm7c8sd1jHJArqgM8k7DhtDr4rKun93W/q
 BKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780132974; x=1780737774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oAaCn7PvHTqyXsIw/GOy0wV7i7L1eRsHHeSQXf+1ulo=;
 b=FStaHord6Fb1RiDYdYkJc6Yn7Iqr99dJWPWuKrTCyVQBprBGfD24O7a/AA1s5K2DEc
 BhxTsPBCB5hdlffiSaBGp1XVfiuQOWZsw5Jhzg3QP4vkQXsvJWKeYPDw0n7yWTmpyrIo
 EbEf9fh5qrWqWsDBX37w2N+iFVivFsuq880z/w+tCjK1R2h8MFcUKbLet53lFlVJ8LbY
 zaECnlR/l2xTA/b1ZsRo90mM2bW7vzE8pIbtSWHA2FpmQLBDWa7RWKh4MpceVDELzwNt
 RWl8Nvcpis316HCzQPphTws6SW2GBOb5zVCKCraJvwZGNL22ZT++e/ZLrG47qo5F19To
 wSNQ==
X-Gm-Message-State: AOJu0YzeTfLAvi2eHSpKnju7U+1h31hyTLnTLZiDc2jgau5ygPByzWgg
 rja+JweT1tnq/Wnk1Y4HRiFnKBIR7+iNDFIXbYggigBPoPqdPs+SBuwY
X-Gm-Gg: Acq92OFTMtGGwddqAvIt/QILyFyDjLD5b2ifUsBQlw/2b/8jaD49/2oCtkabAV6zoxX
 Fq/2q0VcQwhzIsRH8UtwrvaAC0jVCn1t4HxQwCiJt+z1WfBdZRISLdwxMITfu2Qw+aL7F/bb46l
 aHGUqd35io8fLLDOpj2WI0jTnFrbSRSrsW9khweCRFN3qcYc+mONpwgEPKb2etU1msULz54c3So
 1UY4snAomXMxYffMtqgFWawv45Sz7TLN13l34AUNHSI3X0SyxQQvhzL73WD7OrIa+zc1gpbHePf
 F1jlc+rbleqhgoJfIIesM1++laN5ZTihfaaJoRsWE9uss+NYidU8wMR5ZmoNX9n9/h+GecXuco5
 vGc332HySB1DFTHJrskA5bqlYbMvCERkiUDMSC1tXNGTc3KeQkY7kn/QnyUMBo7UwHXmKYjqNeN
 yG1HwOqxjYOK28izhJDCgmcVEuWtBFSviPKESRNBOHUjDH23DhbuBwCaH4PDQj1wsjyZ3ganlJL
 4oHP0J4IeSZzLChlp6+mDy9q3sDjGs3mya8J8ctbdpfv7ecDgs=
X-Received: by 2002:a05:7022:f418:b0:12d:ff1b:92f5 with SMTP id
 a92af1059eb24-137d4283a00mr1247148c88.28.1780132974033; 
 Sat, 30 May 2026 02:22:54 -0700 (PDT)
Received: from
 runnervm3jyl0.mmi2fnf01etepo0d1tf1o4mopb.dx.internal.cloudapp.net
 ([52.190.182.114]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm2990228c88.11.2026.05.30.02.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:22:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat, 30 May 2026 09:22:49 +0000
Message-ID: <20260530092250.4062-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com>
References: <20260530-gitignore_ltp_agent-v1-1-e8812d8de8c5@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] gitignore: ignore ltp-agent setup files
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

SGkgQW5kcmVhLAoKVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guCgo+IGdpdGlnbm9yZTogaWdub3Jl
IGx0cC1hZ2VudCBzZXR1cCBmaWxlcwo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KClRoZSBjb21taXQgbWVzc2FnZSBpcyBtaXNz
aW5nIGEgYm9keS4gUGxlYXNlIGFkZCBhIGJyaWVmIGV4cGxhbmF0aW9uIG9mCndoYXQgdGhlc2Ug
ZW50cmllcyBhcmUgYW5kIHdoeSB0aGV5IG5lZWQgdG8gYmUgaWdub3JlZCDigJQgZS5nLiB0aGF0
IHRoZXkKYXJlIGZpbGVzIGFuZCBzeW1saW5rcyBpbmplY3RlZCBhdCBydW50aW1lIGJ5IHRoZSBs
dHAtYWdlbnQgdG9vbCBpbnRvCnRoZSBMVFAgd29ya2luZyBkaXJlY3RvcnksIGFuZCBtdXN0IG5v
dCBiZSB0cmFja2VkIG9yIGNvbW1pdHRlZC4KCj4gKyMgbHRwLWFnZW50IHNldHVwCj4gK0FHRU5U
Uy5tZAo+ICtHRU1JTkkubWQKPiArLmFnZW50cwo+ICsuY2xhdWRlCj4gK2FnZW50cwo+ICtsaW50
ZXIKPiArc2tpbGxzCgpUaGUgYGxpbnRlcmAgZW50cnkgaXMgcHJvYmxlbWF0aWMuIFRoZSB1cHN0
cmVhbSBMVFAgcmVwb3NpdG9yeSB0cmFja3MgYQpgbGludGVyL2AgZGlyZWN0b3J5IGNvbnRhaW5p
bmcgdGhlIGBsdHAtbGludGVyYCBzY3JpcHQuIEluIGEgbm9ybWFsIExUUApjaGVja291dCwgYWRk
aW5nIGBsaW50ZXJgICh3aXRob3V0IGEgbGVhZGluZyBgL2ApIHRvIGAuZ2l0aWdub3JlYCB3aWxs
CnNpbGVudGx5IHN1cHByZXNzIGFueSBuZXcsIHVudHJhY2tlZCBmaWxlcyBhIGRldmVsb3BlciBh
ZGRzIHRvIHRoYXQKZGlyZWN0b3J5IGZyb20gYXBwZWFyaW5nIGluIGBnaXQgc3RhdHVzYC4gVGhp
cyBjYW4gZWFzaWx5IGNhdXNlCndvcmstaW4tcHJvZ3Jlc3MgY2hhbmdlcyB0byB0aGUgbGludGVy
IHRvIGdvIHVubm90aWNlZC4KClVzZSBhbiBhbmNob3JlZCwgZGlyZWN0b3J5LXNwZWNpZmljIHBh
dHRlcm4gdG8gbGltaXQgdGhlIG1hdGNoIHRvIHRoZQpsdHAtYWdlbnQtaW5qZWN0ZWQgc3ltbGlu
ayBhdCB0aGUgcmVwb3NpdG9yeSByb290OgoKICAvbGludGVyLwoKVGhlIHNhbWUgbG9naWMgYXBw
bGllcyB0byBgYWdlbnRzYCBhbmQgYHNraWxsc2A6IHByZWZlciBhbmNob3JlZApwYXR0ZXJucyAo
YC9hZ2VudHMvYCwgYC9za2lsbHMvYCkgc28gdGhleSBvbmx5IG1hdGNoIGF0IHRoZSByb290IGFu
ZApjYW5ub3QgYWNjaWRlbnRhbGx5IHNoYWRvdyB0cmFja2VkIHN1YnRyZWVzIGluIHRoZSBmdXR1
cmUuCgpUaGUgcmVtYWluaW5nIGVudHJpZXMgKEFHRU5UUy5tZCwgR0VNSU5JLm1kLCAuYWdlbnRz
LCAuY2xhdWRlKSBhcmUKZmluZSBhcy1pcyBzaW5jZSB0aGV5IGFyZSBzcGVjaWZpYyBlbm91Z2gg
bm90IHRvIGNvbmZsaWN0IHdpdGggYW55dGhpbmcKY3VycmVudGx5IHRyYWNrZWQgaW4gTFRQLgoK
T3ZlcmFsbDogTmVlZHMgcmV2aXNpb24g4pyXCgotLS0KTFRQIEFJIFJldmlld2VyCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
