Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7460FF885A
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 10:53:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CD453E6173
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 12:53:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A5033E616A
 for <ltp@lists.linux.it>; Tue,  5 May 2026 12:53:12 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5355A1000935
 for <ltp@lists.linux.it>; Tue,  5 May 2026 12:53:09 +0200 (CEST)
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso2905886a34.1
 for <ltp@lists.linux.it>; Tue, 05 May 2026 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777978388; x=1778583188; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3TSHgcup5GoIpk9cvbCHpZn39n4+SSDEhk2aZIHVsU=;
 b=RPruWs5bxMt/6SApRcZv4s8AXeNJxUYMEpsJq43+6V3e4cY+UJawloa1gk04OgK2/6
 rzq8OG67LFxNvBA7ktK2tGjooda7lWgeF7gYn8QRM2/LJIW0bkfOmrNayubuG+rAVJwA
 yyib0i4BebKINGMK0O/1ZRHKgZuNnjWkdOo+3HUdSoWPI6RnND+Fmng9EDxypPFVB8f9
 WaojQUDLWPslD4+fiFizW55OEEnoBx8BQtbkXG1yd+F1FP8SkyxCCfJ26/WY87U6ZV3u
 5r0wf5s/v9s1BM05RB6GximtCKK1ITnTE9HCwg4qq2MT4xzTeotvxLPmVgMjeVyrTqFt
 /8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777978388; x=1778583188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K3TSHgcup5GoIpk9cvbCHpZn39n4+SSDEhk2aZIHVsU=;
 b=fJYV94drsC8q4I3qjrIsQ/hegmaVsWogvTzkdxD9t9BtVkLe50rA2rO1jXo88fVEO4
 j+LRooihZYrAjzpmt0dMKhBxFpBGm8VtJuWy9DtYz+7ww8i4SLfaH9A07mYVWMqNdCZR
 dWnaj40+jBrVBzX9i2vaYk+szUvjHoEVCes88ShoQYhC8IxqTlq4sVYfstS90H4RfmiQ
 /jU5ex8eKHNLdqxgcvnJm6NNzaiMe0faFwN7M4XTq0d5mexqDR6UHeNMrIm7AM2Xf4mO
 h6P6W89VKUrM+7XX+WywpzE/saYskQPk+EOHNlM9Th6fHEGaevcNxkqymqIjRg1jE9ca
 me2w==
X-Gm-Message-State: AOJu0YzuhcUXwQrZnEvNlz6NVPhz9XVnkbbLGv1jP+0Hdcn65STflhft
 ri2sAkOubybGLMzv+NRP6GGDQtA4qpVF77YxfJi84KonTJRoK4NrGB3Y
X-Gm-Gg: AeBDieuydgdJdso80E9uOTNXM80tAF2jz5QslHWpM0UG5b5PuivC6yOoEjPGiWTM4/B
 pEAgogQI0jD6//7KcVoOHpZMxlZUUaoltGd3iZHfyxy/dM1XUGxpdZupGcfRUkJn4frYMDnSkvZ
 shXjKxtsgnoCPj4U/Is5MO4DOGnSGXL4QCtChJ7V10cwwvwfPshvBTry9RHJsT3EdOZilpi1Q85
 ceNiwGLJ4shq6ZDjbCj48cSmjU3oeSGCNg1xwINHTEcomRuMR0h1k4nR63T32qIGX22WOLGXlIV
 jhdHAUkfDcSRgzNQglvUyf2rxD9fyfO1AMKt2kJ3yJlgQUZjjn57S72XFw1PmO2UDwuPoKuCA6x
 9LYRvWcbRkvXv1UKGqV0iqc6wlY/aMAVfHIpMq6rjh8Jcqs1+Hc/7FwkJL3EbBZ8eoZS+kIuX8I
 J99SYs9f8nXDYiSCkHHUNNXDWV7W3t7M3LfkHD4igO/F5K2w7Ocy0sDDx6SscDcsHW1jBapJrJy
 ZT/f/5Iwjxr2wLxfOhVCwcACOmS+ihozAKRz+9XXrvo+aPj
X-Received: by 2002:a05:6830:6d2f:b0:7de:4fc6:a588 with SMTP id
 46e09a7af769-7e188715e00mr1348493a34.23.1777978387993; 
 Tue, 05 May 2026 03:53:07 -0700 (PDT)
Received: from
 runnervmeorf1.to02svzrmkrudjrmfnnyhvzpob.gx.internal.cloudapp.net
 ([52.154.21.55]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac83717sm9791464a34.19.2026.05.05.03.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:53:07 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Tue,  5 May 2026 10:53:06 +0000
Message-ID: <20260505105306.3983-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505094853.25383-2-piotr.kubaj@intel.com>
References: <20260505094853.25383-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

SGkgUGlvdHIsCgpPbiBUdWUsIDA1IE1heSAyMDI2IDExOjQ4OjU0ICswMjAwLCBQaW90ciBLdWJh
aiB3cm90ZToKPiBjcHVmcmVxLmM6IGFkZCBuZXcgdGVzdCBmb3IgY3B1ZnJlcSBzeXNmcyBpbnRl
cmZhY2UgdmFsaWRhdGlvbgo+Cj4gUnVucyB2YXJpb3VzIHNhbml0eSBjaGVja3MgZm9yIGludGVs
X3BzdGF0ZSBjcHVmcmVxIHN5c2ZzIGludGVyZmFjZS4KPgo+IENoZWNrcyB3aGV0aGVyIGludGVs
X3BzdGF0ZSBkcml2ZXIgaXMgdXNlZCwgd2hldGhlciBpdCBpcyBwb3NzaWJsZQo+IHRvIHN3aXRj
aCBzY2FsaW5nX2dvdmVybm9yIHRvIHBvd2Vyc2F2ZSBhbmQgcGVyZm9ybWFuY2UsCj4gd2hldGhl
ciBpdCBpcyBwb3NzaWJsZSB0byBkaXNhYmxlIHR1cmJvIGZyZXF1ZW5jeSBhbmQKPiB3aGV0aGVy
IGl0IGlzIHBvc3NpYmxlIHRvIGNoYW5nZSBzY2FsaW5nX21pbl9mcmVxIGFuZCBzY2FsaW5nX21h
eF9mcmVxCj4gdG8gaXRzIG1pbmltYWwgdmFsaWQgYW5kIG1heGltYWwgdmFsaWQgdmFsdWVzLgoK
VGhlIGJvZHkgb25seSBkZXNjcmliZXMgd2hhdCB0aGUgdGVzdCBkb2VzLCBub3Qgd2h5IGl0IGlz
IG5lZWRlZC4gQWRkIGEKc2VudGVuY2Ugc3RhdGluZyB0aGUgbW90aXZhdGlvbiDigJQgZS5nLiBs
YWNrIG9mIHJlZ3Jlc3Npb24gY292ZXJhZ2UgZm9yIHRoZQppbnRlbF9wc3RhdGUgc3lzZnMgaW50
ZXJmYWNlLCBvciBhIHNwZWNpZmljIGlzc3VlIHRoYXQgcHJvbXB0ZWQgdGhpcyB0ZXN0LgoKUHJl
LWV4aXN0aW5nIGlzc3VlcyBub3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBjb2RlIChub3QgaW50
cm9kdWNlZApieSB0aGlzIHBhdGNoKToKCi0gY3B1ZnJlcS5jOjE5IOKAlCBgc3RhdGljIGNoYXIg
cGF0aFtQQVRIX01BWF1gIHVzZWQgYXMgYSBzaGFyZWQgc2NyYXRjaAogIGJ1ZmZlciBhY3Jvc3Mg
c2V0dXAvcnVuL2NsZWFudXA7IGEgZnVuY3Rpb24tbG9jYWwgYnVmZmVyIGluIHJ1bigpIHdvdWxk
CiAgYmUgY2xlYW5lci4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3
IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpmb3VuZCBhdDogaHR0cHM6Ly9n
aXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAtYWdlbnQvYWN0aW9ucy9ydW5zLzI1Mzcx
ODMwMjIxCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBh
bHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3Vl
cyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRo
ZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
