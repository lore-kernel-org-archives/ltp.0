Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95AFCD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FA373E5873
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:15:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528EE3E545A
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:14:50 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E72AD6001E3
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:14:49 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so10008145e9.1
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 07:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781792089; cv=none;
 d=google.com; s=arc-20240605;
 b=jVZPrWtt2EsrRmt7P9MdzaSy45VUfP5QN8yek0somkA6QQyLclY5Hj1J3HtZpWy2VZ
 yMdFzJxQX2bsaZk+DTbSAuVaXkhwWmbURG8qYtTR1v2yCXFAHJRcrBJJzIQG2pxzZHSr
 yHuXMoi6+IcxJgtGQPwYwfOhkMMVrDNvujxMjAswyemuLWbqswNGj25mC3XBWTjheWYJ
 ZSfu0Fj/gZXEcvbYMBOi7T4xylpQVTSZHZ6ckoVoFkI8WtCYLz4oTZ5UnauzhxU+wlGL
 BLTrLeR2WL8+6K7DTN3a2QwFkaKuTxc03ax+8G+3Wx2IVtR3i4e96OXZ4oNA080sfrlU
 8HKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Tbq7umb62rGcgjo5uWe+b9C6nu8QNLoiOssRSEdVrMk=;
 fh=pPGPq/PsCV5qCahfwH64Uh5LwRmv9e/jKq1T9IVUzAU=;
 b=NwkVlt31D0rrT69S23rB+UPaTcyslTrxZidLMB1sWEyv3+/m0NzVQQiN+B3R3f8b4x
 Y84fj2SfjZnZfsHS4qUnEh0ABFtbJy4I+TuDhyBrG1UPnKvm+xYcdVt8rloqPBjA175e
 XCo6hdumjGQGx+SNOze1YrIYeJQ9JAbS2Sb7tsYYbH1c4QSD3t8/3M0OyFaNAmayQdW5
 j5r9Tyr8px0RDGd51E/n707r+GawTqHj/9djm8qWprLFfB5MVgb4YKCFqQmH1JMJk9BE
 tAuXizK6q+9g0dwR0LF8fXeq4Rp19pyMwitiF+d4ieLnhlZ56tUFdzZHfB/dRBD7HUzT
 UA1A==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781792089; x=1782396889; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tbq7umb62rGcgjo5uWe+b9C6nu8QNLoiOssRSEdVrMk=;
 b=N763XFj1tzRjWlyMda8Pu8iDUbd/lPaQkLNV74MgpFzcM2U1gHb+lOImoRT7kv+EJG
 DJ/vY7/tjAHi7eUDx/FQV8r7khLGZY29Bgxl2iWa/PGg3LOC4uKXgTPfGZCwP1TMCxnC
 y5I/FkzFBMcOrxl+WG9tPw95MjfCiwE1uVLyAGWEAzmDGuNnBViF66KoTfV5+JIcFoIg
 CaRQIVII7+naUGAC3vBStv67/acCB4PvGiB/7Osph9uEqb+OM37UGM/lfPNmqoa1LTBP
 COtDjHGfeNpFKoIx2arZF5aJkrBnSjlAZsjhQ4P/Gv4Bbel/RdGPp8FIKc5Wkye4EbE+
 Amxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781792089; x=1782396889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tbq7umb62rGcgjo5uWe+b9C6nu8QNLoiOssRSEdVrMk=;
 b=im0zx44e06BPAS4+6wF3eHjqq544IHN33ZlHmnatQfP55udo5ctITDDb1MwMrYdlDv
 QzDCJnwvtcRInT4jID0nJLBx6JWHtxiycWbjSuvA5VY+Eg2ucKdAfc2F3SJ+9IHBWmsw
 ngw8YH/7JhY65hIEbfzvuApc7b2Pa9WlclazIJBmUfM8nisMFz1P5cxJBL6bxGuT50FQ
 8SgqdOh8bY7K/YGx9f9OakCqrh/1SQ7uoo0x7ps1ygl0lovfu1LbhTsnAWC7NtHfkq7N
 4hODl4bZUa5Vh/geiOCItzpyGFMUqv+9Zkk6hoirgHdGOVVof5fdPBGq7JlFdgXVKUIb
 Hh2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LSosc8U8IbNGKFV4IFIBvXb4mx5Wkv306JT5Hrg2gFnOC3yQDnd2tM8YSfdsn1rFOLt0=@lists.linux.it
X-Gm-Message-State: AOJu0Yy++FZuh7VIZFt7E6vLXE4P9Lx+J17iQAtVC2EAOolzCzNkxuKa
 nzHBI+CJo+qAbcGRFWygsruPIDSsNUThA9gUu433xln19MGE8zj22xXcYojAHydQg3qj7q+9JQR
 gyybBkBZh2Ze2ACncENmLTAOWgVwR0Zo=
X-Gm-Gg: AfdE7cm3c5Mlk5kHJ8B6MCBrM15756/jrEx2twjVvJ0Kw+SdZiJil9uHKsoAGmz3vrL
 rbA3XxH73CI8k2XtGwCiOMnYUrgZSiOGCAtpy9KesGscKmLOVBANnAR+3RvVYc2GN0thBcsGMFQ
 WMXS5zofOOQY2wHTC+ZHj2eTI+eryIZQiQzeI7V4ayQhuJVLc5fCqvpjeTfVBwYMIts/SaohVdn
 DJkUvp8gBkUAKpyGAb2jEGmWKlHzhpAbKHb+S86Kja2Lt/gpkorIkP3CvDPvw5rtjR1s1dSYwfl
 ALa+UWt8nsXqX+SjbrTV2oVvYIM=
X-Received: by 2002:a05:600c:8b25:b0:490:d32b:39c3 with SMTP id
 5b1f17b1804b1-492340ff803mr134812285e9.6.1781792088004; Thu, 18 Jun 2026
 07:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <f3181c24-f3b8-4083-ac42-fb2da6cfa8a1@linux.ibm.com>
 <6a33d80b.cf2df9a4.12392.26f4@mx.google.com>
In-Reply-To: <6a33d80b.cf2df9a4.12392.26f4@mx.google.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Thu, 18 Jun 2026 16:14:36 +0200
X-Gm-Features: AVVi8CdNxbx2RECROwdC6119n4RtXgv2DMPTqd-JfaRv6yg9IDGoyen3ky8s5Xg
Message-ID: <CAJCsO8d1yGFjnEvVed5_H_mJbcszqQ8kfjBrvwxBjKSFdcB0nw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] RFC: Proposed cgroup v2 and openat2 test case
 contributions for LTP
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

T24gVGh1LCAxOCBKdW4gMjAyNiBhdCAxMzozNSwgQW5kcmVhIENlcnZlc2F0byB2aWEgbHRwIDxs
dHBAbGlzdHMubGludXguaXQ+Cndyb3RlOgoKPiBIaSBQcml5YW1hLAo+Cj4gdGhlIGNncm91cCB0
ZXN0aW5nIHN1aXRlIGluIExUUCBjYW4gYmUgYSBiaXQgdW5zdGFibGUgZHVlIHRvIHRoZSBuYXR1
cmUKPiBvZiBjZ3JvdXAgdjEgLT4gdjIgbWlncmF0aW9uLiBUaGUgVjIgc2VlbXMgc3RhYmxlLCBi
dXQgc29tZXRpbWVzIHRlc3RzCj4gbWlnaHQgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMsIG1vc3Rs
eSByZWxhdGVkIHRvIHN5c3RlbSBjb25maWd1cmF0aW9ucwo+IG9yIHN5c3RlbSBvdmVybG9hZC4g
V2UgZGlnZ2VkIHF1aXRlIGEgbG90IGludG8gaXQgaW4gdGhlIHBhc3QgeWVhcnMgYW5kCj4gd2Ug
ZW5kZWQgdXAgd2l0aCBhIHNvbHV0aW9uIHdoaWNoICJnb29kIGVub3VnaCIgZm9yIHJlZ3Jlc3Np
b24gdGVzdGluZywKPiBzdXBwb3J0aW5nIGJvdGggdjEgYW5kIHYyLgo+Cj4gQWxzbywga3NlbGZ0
ZXN0cyBhbHJlYWR5IGNvdmVyIG1hbnkgY2dyb3VwIHRlc3Rpbmcgc2NlbmFyaW9zIGFuZCB3ZSBh
cmUKPiBub3QgYWN0aXZlbHkgaW52ZXN0aW5nIHRpbWUgb24gaXQuCgoKSeKAmW0gZnVsbHkgd2l0
aCBBbmRyZWEgaGVyZS4gVGhlcmUgaXMgYWxyZWFkeSBnb29kIGFuZCBleHRlbnNpdmUgY2dyb3Vw
IHRlc3QKY292ZXJhZ2UgaW4ga3NlbGZ0ZXN0cywgYW5kIHRoaXMgaXMgYWxzbyBjb21wbGVtZW50
ZWQgYnkgTFRQIHRlc3RzIHRoYXQKZXhlcmNpc2UgY2dyb3Vwcywgc28gd2UgYXJlIG5vdCBpbiBh
IGJhZCBwb3NpdGlvbi4KClRoZXJlIGFyZSBhbHNvIGdvb2QgcmVsYXRlZCB0ZXN0cyBpbiBibGt0
ZXN0cywgZm9yIGV4YW1wbGUgdGhlIGJsay10aHJvdHRsZQp0ZXN0czoKaHR0cHM6Ly9naXRodWIu
Y29tL2xpbnV4LWJsa3Rlc3RzL2Jsa3Rlc3RzL3RyZWUvbWFzdGVyL3Rlc3RzL3Rocm90bAoKQW55
d2F5LCBzaW5jZSB5b3Ugb3BlbmVkIHRoaXMgaXNzdWU6Cmh0dHBzOi8vZ2l0aHViLmNvbS9saW51
eC10ZXN0LXByb2plY3QvbHRwL2lzc3Vlcy8xMzI4CgpsZXTigJlzIGNvbnRpbnVlIHRoZSBjb252
ZXJzYXRpb24gdGhlcmUuIEnigJltIGdvaW5nIHRvIGNvbW1lbnQgdGhlcmUgc2hvcnRseS4KCgo+
IEJ1dCB5b3UgYW5kIG90aGVycyBhcmUgd2VsY29tZSB0byB0cnkKPiBpbXBsZW1lbnRpbmcgc29t
ZXRoaW5nLCBpZiB5b3UgdGhpbmsgdGhpcyBjYW4gYmUgaGVscGZ1bC4KPgo+IE15IGJpZ2dlc3Qg
Y29uY2VybiBpcyB0aGUgY29kZSBxdWFsaXR5LiBjZ3JvdXBzIGNhbiBiZSBhIGNvbXBsZXggYmVh
c3QKPiB0byBoYW5kbGUgd2l0aCBMVFAgQVBJLCB3aGljaCBhcmUgbWFkZSBzdXBwb3J0aW5nIHYx
IGFuZCB2Mi4KPgo+IElmIHlvdSBhcmUgd2lsbGluZyB0byBpbXBsZW1lbnQgbmV3IHRlc3RzLCBw
bGVhc2UgY29uc2lkZXIgdGVzdCBjYXNlcwo+IHNjZW5hcmlvcyB0aGF0IGFyZSBub3QgaW1wbGVt
ZW50ZWQgaW4gTFRQIGFuZCBrc2VsZnRlc3RzLiBUaG9zZSBhcmUgdGhlCj4gbW9zdCB2YWx1YWJs
ZSBhdCB0aGUgbW9tZW50Lgo+Cj4gUmVnYXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNhdG8KPiBT
VVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRvQHN1c2Uu
Y29tCj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
