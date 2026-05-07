Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A032ACD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:40:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F5103E2C3A
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:40:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A21213E2497
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:40:34 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F2641A009B1
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:40:34 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-1309f4ee973so766699c88.1
 for <ltp@lists.linux.it>; Thu, 07 May 2026 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778146832; x=1778751632; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcawnK629FlkKTcxRvS5DwRSG/wD88m8HQ9EKQaw/g8=;
 b=N5SuoHo/8731fI8S1UVHN82Whw3DaY08w/2Yoar8GZ9yA3nsSo6xFY44xhJNyK+7eT
 e4BMd0QqDl0ZH3jrifISVkS91P1h1kiX/inHI6bVlzEE8JkplnW8s4HYm9v9JcXaPjNl
 m15Z2j8bKH71J6NX07MduyyCVAEvUeIosd4RfOuWMg8iNGIgGfbnJUShbnmaitB9AAPn
 bXXOqWNUd8/dduB+0jDMOLWOUPY1j8lSJR7PPpbbwC4DFVLdz1/NTSH5jzuorQFNR4HJ
 Nt0/4t/H6jLIYDbQOszqosUoZ02G2kEYoreYfJASzOXrck2RndIYKZ4UVDAeIibdlc0a
 X0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146832; x=1778751632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YcawnK629FlkKTcxRvS5DwRSG/wD88m8HQ9EKQaw/g8=;
 b=SaCmV/ccX9VsgpB6CYF4rHscjG8wKzuOmEdKm29t4hLAks/c9NvWJPje9omm3/CK4b
 hUh+MFZcS0ip8ntYBX/tnD5eA5Gpj0djVkmdBYl1chl5JQhHZD4xawJPz+wQUdbRWg8q
 bFNd+bpTL4fMBgUabs7lPSvj3PAXbr21Rq4aGcAgo3WEemoPt6orZ6Uet9vR3yBbRInG
 veBjn1Buf11cZP3kSjqJKr1ekWsO3eM7UD8U57B08rL0RVATEzW1caaHBm4N6iC3uFVR
 ACOLASy8hd41zs1A7wdLLTGnyHpPf5tSc1jsYIwDtLcPE4uo5KFl5x49TTyadmAil84E
 zoyg==
X-Gm-Message-State: AOJu0YwLZiZIBsSarqaiTy9tm9IMOyBXJjA1sdNust6zegK653ZXMx59
 JCjgIFiD6YahYAhG3FlymhbInVWhwg0CnrZOE5KeJQFIUdwLWhv/hZB3is05Ou4S9g8=
X-Gm-Gg: AeBDiesWt9gwvTYbKNjiB/zN7/QpzoZVP4jmI+Mbc0jEKA6tq2yDNIiacOteZC+JksR
 kEvwTUKu8ZmS1YAZOjAMtgGVwb1qgtLG4Ev+RBRSseCMYjiYw1AsJ/Ds0E+SCldHgcG9Np/C+mW
 KCy40dTjDUeU+06nBXoPSzuJoe9W1BU3TpIAocfOq+oJOt5eOoLuYkgEUTKmQPQw5azSFr1eNLx
 BUdwDMEzj1V9ov9LKNk87rrpwkGAukmJKmwlGamEnUbj4N8UlCorqtOCCT6GDfn8svWcHWeiyhX
 XfS64TzuhQJ9ipWBNb2e/QKnaX5iQ3nW7sfbeOHMk9o2LOSQdkKdkd70rowCX+riiPrbYgKK8Yg
 yA9uwRndm+9lqkUFaZyEDvZhV++lS/KJk58rTf4mITZ0jl6swgIZSCGkasWt/3drnL0lamjQLjX
 lN9eVcLDCRUzF2j8UDOXA10vSmsoQm5MUrORkhmZ9cUSTI4VU2g91cquS2pKZz4S8eUuID+OZiU
 On8JDhALKUm8d1BIOvsHX59biR5G57vEsEHsH/TOLOI7BIbiXhwsuU11c/1
X-Received: by 2002:a05:693c:3015:b0:2ea:5057:a331 with SMTP id
 5a478bee46e88-2f54a77f732mr3557012eec.21.1778146832108; 
 Thu, 07 May 2026 02:40:32 -0700 (PDT)
Received: from
 runnervmeorf1.wpx3thj3tobuhgjrwdc2frxatd.yx.internal.cloudapp.net
 ([128.24.161.42]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56ff82f5bsm6609095eec.24.2026.05.07.02.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:40:31 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ricardo Branco <rbranco@suse.de>
Date: Thu,  7 May 2026 09:40:30 +0000
Message-ID: <20260507094030.4155-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507083131.28197-1-rbranco@suse.de>
References: <20260507083131.28197-1-rbranco@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] userfaultfd: Add helper for checking UFFD feature support
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

SGkgUmljYXJkbywKCi0tLSBbUEFUQ0ggMS8yXSAtLS0KCk9uIFRodSwgNyBNYXkgMjAyNiwgUmlj
YXJkbyBCcmFuY28gd3JvdGU6Cj4gdXNlcmZhdWx0ZmQ6IEFkZCBoZWxwZXIgZm9yIGNoZWNraW5n
IFVGRkQgZmVhdHVyZSBzdXBwb3J0Cj4KPiBBZGQgQ0hFQ0tfVUZGRF9GRUFUVVJFKCkgdG8gcGVy
Zm9ybSB0aGUgaW5pdGlhbCBVRkZESU9fQVBJIGhhbmRzaGFrZQo+IHdpdGhvdXQgcmVxdWVzdGlu
ZyBvcHRpb25hbCBmZWF0dXJlcyBhbmQgdmVyaWZ5IHRoYXQgdGhlIGtlcm5lbCByZXBvcnRzCj4g
dGhlIHJlcXVlc3RlZCBmZWF0dXJlIGJpdC4KClRoZSBib2R5IG9ubHkgZXhwbGFpbnMgdGhlIG1l
Y2hhbmlzbSwgbm90IHRoZSBtb3RpdmF0aW9uLiBBZGQgYSBzZW50ZW5jZQpleHBsYWluaW5nIHdo
eSB0aGlzIGhlbHBlciBpcyBuZWVkZWQg4oCUIGUuZy4gIldpdGhvdXQgdGhpcyB0d28tc3RlcCBw
cm9iZSwKcmVxdWVzdGluZyBhbiB1bnN1cHBvcnRlZCBmZWF0dXJlIGluIFVGRkRJT19BUEkgZmFp
bHMgd2l0aCBFSU5WQUwsCmNhdXNpbmcgdGVzdHMgdG8gVEJST0sgaW5zdGVhZCBvZiBUQ09ORi4i
CgotLS0gW1BBVENIIDIvMl0gLS0tCgpPbiBUaHUsIDcgTWF5IDIwMjYsIFJpY2FyZG8gQnJhbmNv
IHdyb3RlOgo+IEZpeGVzOiAxODQwZWUyM2QxNzJiNWFiMDRjY2E3YzJhY2ZhNDg3NTViMDQxOTEx
CgpQbGVhc2UgdmVyaWZ5IHRoaXMgU0hBIHJlc29sdmVzIGluIHRoZSBmdWxsIExUUCBoaXN0b3J5
OyBpdCBpcyBub3QKcmVhY2hhYmxlIGluIHRoaXMgY2xvbmUuCgpQcmUtZXhpc3RpbmcgaXNzdWVz
IG5vdGljZWQgaW4gdGhlIHN1cnJvdW5kaW5nIGNvZGUgKG5vdCBpbnRyb2R1Y2VkCmJ5IHRoaXMg
cGF0Y2gpOgoKLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3VzZXJmYXVsdGZkL3VzZXJmYXVs
dGZkMDUuYyDigJQgYHdwX2ZhdWx0X3NlZW5gCiAgaXMgbmV2ZXIgcmVzZXQgdG8gMCBhdCB0aGUg
dG9wIG9mIHJ1bigpOyBvbiBtdWx0aS1pdGVyYXRpb24gcnVucyAoLWkgTikKICB0aGUgc2Vjb25k
IGl0ZXJhdGlvbiBtYXkgZmFsc2VseSBwYXNzLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxl
dGVkIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoLgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJv
ZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51
aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0
aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2
aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
