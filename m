Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F2ACD13D3
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 06:35:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B96F3E2895
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:35:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DEB73E255B
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:35:03 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D98A96008C0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:35:02 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8eab809593cso58140885a.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777530902; x=1778135702; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CouMg6Rwh8LRPN0uu7sBlus20fuovY5UkE6tBvmXJc=;
 b=leTaybieA9swltWyrUjd0iIb4XVnkvj0j/JXNgvEAjl1buR95YPbVotKC0MYeG/fCE
 rj2H+vi65973IMAUTxNjvLUuytZy8xYtHOSkTgrBMLtPhRE1vlQSvZjMlInGCioDOPRh
 wuT9sCMY9a9Qr+Sw9tV2Klr8EctYjL183mIrBRBoohQ0oelpo5Vb/qZQQv0246MktZDk
 JItIx0seswEBateVu3NTfdJrEM0cTxINeKl0iN74voDXmmmaAvVPZP515ykNctK1q1h+
 J4a6AbXUBoMfiPmFVD/ZSoOvsN1MedFe0ro6S9QiJj0hlCJxmpuFrcjrzqBaU0EIwdAo
 4+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777530902; x=1778135702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/CouMg6Rwh8LRPN0uu7sBlus20fuovY5UkE6tBvmXJc=;
 b=kya9vHedQMjY4kPBubp2bGy87a2LgOePM1bV9HqCqnxvXGL7DEUIrIN/7gVyTSSsRS
 VyqDSeqf0qYrZ5G/4A+Dm2SPpJewQ7jug20dX/MMCBGOihdV+Ifa96bLSvTrlUICUvL3
 /vtLZcHU3YCoYq9+NSkDSzGoe/GT7RlSDjqwVe7DcxEqizFMvXvYzcIxUfqVJtz72mtf
 qcZQJ3LvedJBy+tu7sBTcAwXuRL6OerPFHWUdE9PS1ZZZNIeGkmculITuBI5z4QUA1KJ
 mPJVXkefM4H8GrBDsIqQowMWBne0lVKGUU7EUanm7Ljs259FZ0QOHIJxxR8kWzctcb1E
 HdCQ==
X-Gm-Message-State: AOJu0YxPyQ3omWxRygbx5nrWxv325jDUVnXhVivTPSbp3qCkpMEIO6oA
 B2Bl3DPBo7FTHv4zcmjeM1tu0F92GlGMSup2seHYcX+ZnFuU8nryVdRT
X-Gm-Gg: AeBDieu2nIytG7n9oryiPQ8hKJT4gmljcYi6sH25Mzt1MZg9o3krPzxDkxLdhTlXp3J
 niH+3ky9sPLL3YyIgrUpnM60bBEbgQTQ3KDLlC30K4/PblrHBm+u4s1NTbY9LsneSE2YHO4cbfk
 h3ZIbBziyX5xDpMR9jZk0ylte0nU6r2aPdzeIHySWmeza8Faekmv9ZfNNFyMkbHdhbaMQoJ0+3F
 BPsgPXbbI3/pPAZPKnUKP8rbXoukZqW5rZNy4eYFdWkTpGbqC3IxaYwlvLkG8rkkpXisNmAZ3or
 /XdHtnLSH4iM4qzfZNmYkXtx0nAUoAwzhJJEC7wwfbqvHDlXCWCKzhhkALE7W3KNvgsuV37NkWR
 Ty0x8s3uHZKLf3dzSk4bRS7GuSGy2gHhewRkG3fyVCG6GII6yqbWHWyHVngEcq7wY5vL3NN18eU
 Y5ozW1CVQoWBlumMvEICQZ2SWuiY0HZ70quPp3pEVYQho3B1Byi6vkEyXl4jgNhQOCJFe45BrgU
 Sn1y7rYC+rLhWWdR6zjDUNpJ168iCwN6JeGqvTn7nFaWQzWIw==
X-Received: by 2002:a05:620a:280c:b0:8cf:d62a:c81d with SMTP id
 af79cd13be357-8fa88942bb7mr267249185a.29.1777530901456; 
 Wed, 29 Apr 2026 23:35:01 -0700 (PDT)
Received: from
 runnervmeorf1.25nck5mkgfoenofczkdl0zm0ze.cx.internal.cloudapp.net
 ([20.55.223.181]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff335ccdsm10555386d6.20.2026.04.29.23.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 23:35:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 30 Apr 2026 06:35:00 +0000
Message-ID: <20260430063500.4035-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430034724.1628-1-wegao@suse.com>
References: <20260430034724.1628-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

SGkgV2VpLAoKT24gVGh1LCAzMCBBcHIgMjAyNiwgV2VpIEdhbyB3cm90ZToKPiBzaG1jdGwwMzog
Rml4IDMyLWJpdCBjb21wYXQgbW9kZSBmYWlsdXJlIGJ5IGFkanVzdGluZyBjb21wYXJpc29ucyBm
b3IKPiBjb21wYXQgbW9kZSB0cnVuY2F0aW9uCgo+ICsjZGVmaW5lIFRTVF9BU1NFUlRfU0FUVVJB
VEVEX0lOVCAgIDB4MDEKWy4uLl0KPiArCWlmIChmbGFncyAmIFRTVF9BU1NFUlRfU0FUVVJBVEVE
X0lOVCkgewo+ICsJCWlmIChzeXNfdmFsXzY0ID4gKHVuc2lnbmVkIGxvbmcgbG9uZylJTlRfTUFY
KQo+ICsJCQlleHBlY3RlZF92YWwgPSAodW5zaWduZWQgbG9uZylJTlRfTUFYOwoKRm9yIHNobW1h
eCBpbiBjb21wYXQgbW9kZSwgY2FuIHlvdSBjb25maXJtIHRoZSBzYXR1cmF0aW9uIGlzIHRvIElO
VF9NQVgKKDJeMzEtMSkgcmF0aGVyIHRoYW4gVUlOVF9NQVggKDJeMzItMSk/ICBUaGUgY29tcGF0
X3NobWluZm82NC5zaG1tYXgKZmllbGQgaXMgX19jb21wYXRfdWxvbmdfdCAodW5zaWduZWQgMzIt
Yml0KSwgc28gdHJ1bmNhdGlvbiB0byBVSU5UX01BWAp3b3VsZCBiZSB0aGUgbmF0dXJhbCBleHBl
Y3RhdGlvbi4gIEEgcmVmZXJlbmNlIHRvIHRoZSByZWxldmFudCBrZXJuZWwKY29tcGF0IGNvZGUg
cGF0aCBpbiBpcGMvc2htLmMgd291bGQgaGVscCBjbGFyaWZ5LgoKUHJlLWV4aXN0aW5nIGlzc3Vl
cyBub3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBjb2RlIChub3QgaW50cm9kdWNlZApieSB0aGlz
IHBhdGNoKToKCi0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htY3RsL3NobWN0bDAz
LmM6MTMg4oCUICNpbmNsdWRlCiAgInRzZV9uZXdpcGMuaCIgYXBwZWFycyB1bnVzZWQ7IG5vIHN5
bWJvbHMgZnJvbSBpdCBhcmUgcmVmZXJlbmNlZC4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBs
ZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpmb3Vu
ZCBhdDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAtYWdlbnQvYWN0
aW9ucy9ydW5zLzI1MTUwODU4ODgxCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZh
bHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElm
IHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1h
aWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
