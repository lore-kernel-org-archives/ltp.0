Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57915CD5BDE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 05:31:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E4C83C7404
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:31:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 133373C311C
 for <ltp@lists.linux.it>; Wed, 27 May 2026 07:31:04 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B38A14004F2
 for <ltp@lists.linux.it>; Wed, 27 May 2026 07:31:04 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-914a90b69a3so611089085a.3
 for <ltp@lists.linux.it>; Tue, 26 May 2026 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779859863; x=1780464663; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=li8JVRXj4iSRLU7hqUsj03tigK3kORqZXN61mr48974=;
 b=XILnFMA7psDB+Tzf4CrNCUI9h6kQCFZS2oeIo+EhUurfPPfn7wW8+XFVpNehbP5vh3
 93cq66juab6ZpBvuABHI/hz1vayGgIbZQ7CFV3jvuNE5LivBNpkQjHTYnlRjMpkpvDVZ
 nJRJLhIKfcfuz//0XjdzJf8agZVi4PtsG2XgHvLzei0U6rgV4TDxy02gDqvAmqnXkBN6
 eQd39Rtxz+7ZYjQVEQfMDCqbRNLnXNKDi/FkP9oIjMxDj1vVtdFY5EKkFUx4dyofvN9g
 DaCtde7+aOYuE39KkvIXuyiXEedrCUwE1CdGQKsDKqb+l/RMB2AQYE/J6YZzaobaseiC
 H7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779859863; x=1780464663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=li8JVRXj4iSRLU7hqUsj03tigK3kORqZXN61mr48974=;
 b=k7tncNt4yLeF0gi1MYilGm5H3kHRRBAO9MTO713uDx/fEk3PRn5pOVX9lK4PYa8XhG
 ECGQLZhIub4XW6B/dLKf2JYyoaiyeDOsgQzGN+h7BmwIUS0WnGI7J7NCm7j0VFEL5mMH
 ba3YJz3XBfffLxD1Qn8gXgMJsLi7ZtnuQAe+AXejHqwKE3TSpqR/duIeQfQyKaVpmH/f
 CjXJoWfJcvhKLjfn+RvzpF2t+JzRkbtg0ZO82mXFaCviNE3iECnsFjeDVCcQlivmIhvn
 A+sgEc4ql1d75g7j8uedDzu72vL0/ktAi4Vca7qR5zEj2dTwx8BFCT7DTzIWkmg7NxLm
 u7nQ==
X-Gm-Message-State: AOJu0Yxphc+FY0I2X9WBzgGb0xKr/MGo8Z1KKI94/35aNDXJOvYzxBj0
 NXVD38ImVDARcuvN+WOfRQPm9xH2duRbNm9ggOYeWG/slD5tX1QUen7K
X-Gm-Gg: Acq92OHFq5YUUGnMM+NrLSFu+glTjk93+HKqUKXKHG1+YUz9W/9gIb7D6SiWiFHRrMd
 dhToi0VXmjoC3pk14xVUyKRP2bYJ0i5ACXm09JGbLgNuAZA6PuKPAHYZZql/PXMY1AcRSMtcFQJ
 LzjjDqpUCDJxV2nkx6TMnpwd8rtiSDlT+3Q9Xg2uVPk2sHOCzHR6u3CJoXz0mZVZNnajaC8mM6b
 W0hjQ3xzOzCwViIAq3HpAiz7AFDDS2DEs5zgj7Q/H+/lpYk4BVdunPnCLgpuwJZDjk11MPTYhtO
 sFvtQzC+zpvpClGc/Xx5ntbeR9eGqjw6ri8ZXwPLR9/l5vZ+Heg2IiVIM0mioKeC0fMFMKMzykY
 ryxjtsOG/1wrv13MntwzrZyPpV1KYJnKQmDrWrzZDkQs7BfyAYuLtsiS43CYuFfsJEpEGOY0U+4
 ycF7dzYr1loyysJReG8ntaHwtXwDktb+1qBNWUTEkbvRpQe+i5RpsFDjsdlc0FlGlI50QlSDjTv
 7F0tGTtb4a9g+FuF/4LCUoPvxK0D5te4kEHNA0=
X-Received: by 2002:a05:620a:4806:b0:913:e5bb:3dac with SMTP id
 af79cd13be357-914b494e800mr3224532185a.37.1779859862098; 
 Tue, 26 May 2026 22:31:02 -0700 (PDT)
Received: from
 runnervm3jyl0.gjdbbupuwjlu1o3x5tnkqk5h4e.cx.internal.cloudapp.net
 ([9.234.149.178]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86e9ba7sm387957485a.6.2026.05.26.22.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 22:31:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 27 May 2026 05:31:00 +0000
Message-ID: <20260527053100.4072-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527050843.14963-1-wegao@suse.com>
References: <20260527050843.14963-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mem/min_free_kbytes: Add grace period for memory reclaim
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

SGkgV2VpLAoKT24gV2VkLCBNYXkgMjcgMjAyNiwgV2VpIEdhbyB3cm90ZToKPiBtZW0vbWluX2Zy
ZWVfa2J5dGVzOiBBZGQgZ3JhY2UgcGVyaW9kIGZvciBtZW1vcnkgcmVjbGFpbQoKPiArZm9yIChp
ID0gMTsgaSA8IDEwMjQ7IGkgKj0gMikgewo+ICt1c2xlZXAoaSAqIDEwMDApOwo+ICttZW1mcmVl
ID0gU0FGRV9SRUFEX01FTUlORk8oIk1lbUZyZWU6Iik7Cj4gK2lmIChtZW1mcmVlID49IHR1bmUp
Cj4gK2JyZWFrOwo+ICt9CgpUaGUgZXhwb25lbnRpYWwtYmFja29mZiBwb2xsaW5nIGlzIHRoZSBy
aWdodCBhcHByb2FjaCBoZXJlIOKAlCBhc3luYyBrZXJuZWwKcmVjbGFpbSBpcyBleGFjdGx5IHRo
ZSBjYXNlIEdyb3VuZCBSdWxlIDIgY2FsbHMgb3V0IGZvciB0aGlzIHBhdHRlcm4uCgo+IC1zbGVl
cCgyKTsKPiArdXNsZWVwKDEwMDAwMCk7CgpSZWR1Y2luZyB0aGUgcG9sbGluZyBpbnRlcnZhbCBm
cm9tIDJzIHRvIDEwMG1zIGlzIGZpbmUuCgpbLi4uXQoKQWxsIGdvb2QuIEFwcHJvdmVkLgoKLS0t
Ck5vdGU6CgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBh
bHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3Vl
cyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRo
ZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
