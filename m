Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DEFFF885A
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:40:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 636F33E49F3
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:40:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A7413E1A46
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:39:57 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BFA59200242
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:39:56 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-506362ac5f7so94253281cf.1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777387195; x=1777991995; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQZEiRu73og84jRFnORA8kt8941aWJhuW+gD4QioBHs=;
 b=OppizRSBVdO/UF9MUKaVEjRy8iv4jcIiniOgqbLEu2ZaWSIz6/oMBTSVIJh81Oqg0W
 1R709+ollQryBX0KJRcHIg1naYttzweu68USx/55C8WbcVwRw99zpGs+jEUxoM1K9X7i
 jkDWZUZUG1KZQsIx/cEdgi4SojxMzG5FIoeQ4Bp8A+gIpfFP+m9YLOpHChbqaFFBj4S5
 2AWU5CjJ/+yraSi8BlrIbfxWGHecnyxEJSy33hRQedW+WjJ+pIQjVG4kfKjKAk8JFv61
 Mdm/nThqAbQiRpvvaK/GfIlaqrtGiB84DyBHwNSzapy1P4YNYo5ZzwnYvHHcJooacUm6
 oq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387195; x=1777991995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQZEiRu73og84jRFnORA8kt8941aWJhuW+gD4QioBHs=;
 b=TfrnhKivML3zBKCYkwlj8sbpDaeTMEqhaWgthJHWLDNpm0F3SS59SmIf3cm3hhl6FI
 VLyQt/knFECFwdxUTleYjcIrIrz+iEikgIAfvIVZ28b4AuD5Z20MtzMvN/RY/RFJSx06
 oiKk7ok+04z4x1ahK45s3wcvbtIKjE8HzTU8kMLunOtKYz6pfI8G5yTFuNYBS7/i+LL9
 sHO8M6i0TYFEn8Y5yfgiNQkFOSoAMDm5X4PoHWlZuObRc7XoNiyZy4YZPT/2Cqx/1vV/
 eEM0Z1ojbVGim3AgbgesOWREKFe2t3zogh/PdU+UL3eueXNk9Zme1LLigCdrw7IlExWg
 77Ag==
X-Gm-Message-State: AOJu0Yy+uRFSqozEY3QU3fMYbwwT+qx8N71QsuWsllebmD5rhlltDJDn
 I5iEixdxVSt8F4qt+9NXqExmzxF2EwmlovszPDtXI9A9Za52tHLX2RvJdKANZNKlqXU=
X-Gm-Gg: AeBDieurX2wZpW81ztuOlw+ZrbbxQlxyuT9KAstGqToBkbrVh29Lt1V521RM5AA4hEM
 zeg2UzoISqSx5uM5tkFC0vfKPnteyEKHX5WDNgvOiJmQAbcVQCPehetFpc3rYLiUrH4JIJnL1o/
 srQuwWguH231whFVnSXtcD8DRYY4UZE1OmK/EbO4an+MKrciISGxhaiG36eBUxnrw7ET2UEVzqx
 Jqk/WvEkMkaSeUkXit9Uox7c0aSdU0daUNkIYfOS8u1cYLHQB5SojfimrBwg/zZ0mvaejqZd1Xn
 19tQUubhtwZM7esDSXtd9BsIrwo9z/wmY+Qwr1Sj2cr7laPQeQ7zIQm76eiJlzLUBxuixBpbWdq
 wyc+pZ0uSw35aFcg3Hc1QUOkM8okjs5W7yKCBD0Zp0KZfW7c0IrwT1pRzxUpfVwOg6TT6EV3goP
 Ov9y1Zwhmshuaj23aJAGREN1LC4ruUKRhYbcAhOPqiKcwDdEorcDHI8Q9icPf95nVXy2In79x+2
 xlfqV6aytHcn6g/yZ1HtGnoGfVF4lzY3KyarcdHDvQKOOAUbw==
X-Received: by 2002:a05:622a:4587:b0:510:1543:31fd with SMTP id
 d75a77b69052e-5101543560bmr11208971cf.51.1777387195421; 
 Tue, 28 Apr 2026 07:39:55 -0700 (PDT)
Received: from
 runnervmeorf1.4zenpulcgpvenhjux0oihply3f.bx.internal.cloudapp.net
 ([74.235.70.231]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5100da4d29bsm20008421cf.3.2026.04.28.07.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:39:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sayali Patil <sayalip@linux.ibm.com>
Date: Tue, 28 Apr 2026 14:39:54 +0000
Message-ID: <20260428143954.4078-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <91e8e5a0259ba981e530d099eb053395d8991177.1777377311.git.sayalip@linux.ibm.com>
References: <91e8e5a0259ba981e530d099eb053395d8991177.1777377311.git.sayalip@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmat05: use size_t for hugepage allocation
 sizes
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

SGkgU2F5YWxpLAoKT24gVHVlLCAyOCBBcHIgMjAyNiAxNzoyNzoyOSArMDUzMCwgU2F5YWxpIFBh
dGlsIHdyb3RlOgo+IGh1Z2V0bGIvaHVnZXNobWF0MDU6IHVzZSBzaXplX3QgZm9yIGh1Z2VwYWdl
IGFsbG9jYXRpb24gc2l6ZXMKClJldmlld2VkLWJ5OiBMVFAgQUkgUmV2aWV3ZXIgPGx0cC1haUBu
b3JlcGx5LmdpdGh1Yi5jb20+CgpQcmUtZXhpc3RpbmcgaXNzdWVzIG5vdGljZWQgaW4gdGhlIHN1
cnJvdW5kaW5nIGNvZGUgKG5vdCBpbnRyb2R1Y2VkCmJ5IHRoaXMgcGF0Y2gpOgoKLSBodWdlc2ht
YXQwNS5jOjQ3IOKAlCBzaG1nZXQoKSBzaG91bGQgdXNlIFNBRkVfU0hNR0VUKCkKLSBodWdlc2ht
YXQwNS5jOjUxIOKAlCBzaG1hdCgpIHNob3VsZCB1c2UgU0FGRV9TSE1BVCgpCi0gaHVnZXNobWF0
MDUuYzo2MSDigJQgc2htZHQoKSBzaG91bGQgdXNlIFNBRkVfU0hNRFQoKQotIGh1Z2VzaG1hdDA1
LmM6NjIsNjYg4oCUIHNobWN0bCgpIHNob3VsZCB1c2UgU0FGRV9TSE1DVEwoKQoKLS0tCk5vdGU6
CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgYWdlbnQg
Y2FuIHNvbWV0aW1lcwpwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMg
ZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmCnlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcs
IHBsZWFzZSBjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlCnRoZSBzdWdnZXN0aW9ucy4KClJl
Z2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
