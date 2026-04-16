Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57D6F8D755
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 18:36:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 230E83E7618
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 20:36:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 380FC3E74F1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:36:25 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 400C91000459
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:36:24 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso815429eec.0
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776364582; x=1776969382; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHsvki27CCyD70beoEOb+eB+E0M3zI6Rjl3S+zBjg3U=;
 b=lr9RKr+/pDaMIUW0yBdWM1Fs5h0Yw29HYal3OxIyZbPY22zuz4qpy9AA9TXPMXKK7n
 EbahGfoBO8MGjrIzisDfYSo4E6eZ6hxw1zZ5IBalxF33JmCD4tCOfANxb5R8Zpo2T1RS
 VbCPEeO8vA0icjakWwShSH7qJt3TgIq7WSpDSbzor6qX0Cs+MxQFuY5jaMjlUV6q1m8Q
 wOkc6myLebgORWHa3Z8vdX9rngQKT9DF+9ggFuu4FIGMGNkUAccnqXWKKWNNGA5Kf05O
 UN6MHPPiijS08STvRuErNl/xwVy0tHmrk5VIdsNQGK+ZkJIVk2rXGeU2EUHeqVHYye1f
 RRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776364582; x=1776969382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zHsvki27CCyD70beoEOb+eB+E0M3zI6Rjl3S+zBjg3U=;
 b=sKjbXlZbcNMJvlbSSTO/G5LIQQ0Q8xslr5AJo8AXcfSf5OibhSyOpjBXzBIJkfq3qE
 DpKVYY3xrQJbX5i0NG4npU00VL9jCn91UaPei96EmbAB/H+LVTapEiEjXoXIBTnEcggo
 pQ+OgXSCE9HbexsIbQghr3Y2oWoHP0HIYoQTpJzut+W4s6rD90DWr3ArdgLirtCROceq
 XkV29Sj2RQ7/9G9P3ffpIWG7acK5tcEWw6aFER9maoPGwtN2gUDfvlcYdh73BL+4ZgJp
 oj0pOzbTfVS1pLrMnuZKIoRP9oMKJ908qIwuooEdAxsH8nEsl1Oo1YSnY0RCQE0HgKY5
 khgg==
X-Gm-Message-State: AOJu0YwF39M87gu6qA0fo63Yw4rxNW/VZXy3/32wSA3/5NB/xR45edk+
 8gV2Ak+K7yGLB/EuHZUaQ3MxpddmCIavRl5WTuM7hPP7SdQ+7qY5CL2U
X-Gm-Gg: AeBDieteUWmH8KTyvdwYDMkGgdbUtvfBV1zO82vvikMJ9SOzKLMDlfbM+WuGzGPfAJS
 uECDgVogWQoScy4L8m8wjr3LLFi7AMHocyTWtp0T3daywgkhVDkjywwCxX01TxaGa9svYx5ALaz
 wy9N73uv8EqCGuQCVNOh6aZ5opYkAKjlVd712fDH+9WvJYIGkm6u/x1lms9dgteyaq1BsObrmP1
 iyiJYIshJCiu5lYSocMSw2vs327Jd1UAZ0jjD8jxe6Eu3PxK/jgAmlMhd6zR92skYztaoJahDWB
 5QUsibgo4u3Q1lYfGtK6L1PKok3HvsgBhzxR2XuO6MiUa6jcLF93TPRAPE1+jnlkU4dp69XYgJD
 5aOXCSDU66B33GRtmpQJ6QRdyb5N8B/sewiMJGW8IiVdUEHg2htiUjuf8sBo05r4RgUO+QX2pfP
 KOCUPmJOp9gebHLml/j8EVVfHCTrvbewJjowEry68eK/jJz0RWzmH5O0hmbRv/ao9ah8jpUjhZ9
 IQwdBaHex7DlJCrFEfL0Ld7c7zvAoEeLmOjEP1yaIJePryh
X-Received: by 2002:a05:7300:8c88:b0:2c1:7480:ff9b with SMTP id
 5a478bee46e88-2e2e5028983mr172990eec.18.1776364582430; 
 Thu, 16 Apr 2026 11:36:22 -0700 (PDT)
Received: from
 runnervmeorf1.mdwwigey15hubdk4xsiuhudezb.dx.internal.cloudapp.net
 ([52.157.2.240]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a9a3sm9935141eec.2.2026.04.16.11.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:36:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 16 Apr 2026 18:36:20 +0000
Message-ID: <20260416183620.4076-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416144213.27221-1-mdoucha@suse.cz>
References: <20260416144213.27221-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Add common entry point function for all tests
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

SGkgTWFydGluLAoKT24gVGh1LCAxNiBBcHIgMjAyNiwgTWFydGluIERvdWNoYSB3cm90ZToKPiBP
cGVuUE9TSVg6IEFkZCBjb21tb24gZW50cnkgcG9pbnQgZnVuY3Rpb24gZm9yIGFsbCB0ZXN0cwo+
Cj4gQWRkIGEgbmV3IHNoYXJlZCBzb3VyY2UgZmlsZSBpbXBsZW1lbnRpbmcgdGhlIG1haW4oKSBm
dW5jdGlvbiBhbmQgcmVuYW1lCj4gdGhlIGV4aXN0aW5nIG1haW4oKSBmdW5jdGlvbnMgaW4gdGVz
dCBjYXNlIHNvdXJjZXMgdG8gdGVzdF9tYWluKCkuIFRoaXMKPiBhbGxvd3MgYWRkaW5nIGN1c3Rv
bSBkZWJ1ZyBjb2RlIHRvIGFsbCB0ZXN0IGNhc2VzIGF0IG9uY2UuCgpbLi4uXQoKPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFj
ZXMvcHRocmVhZF9jcmVhdGUvYXNzZXJ0aW9ucy54bWwgYi8uLi4KPiAtICBOT1RFOiB0aGF0IHRo
ZSB0aHJlYWQgaW4gd2hpY2ggbWFpbigpIHdhcyBvcmlnaW5hbGx5IGludm9rZWQgaXMgZGlmZmVy
ZW50Cj4gKyAgTk9URTogdGhhdCB0aGUgdGhyZWFkIGluIHdoaWNoIHRlc3RfbWFpbigpIHdhcyBv
cmlnaW5hbGx5IGludm9rZWQgaXMgZGlmZmVyZW50CgpUaGlzIGNoYW5nZXMgdmVyYmF0aW0gUE9T
SVggc3BlY2lmaWNhdGlvbiB0ZXh0LiBUaGUgYXNzZXJ0aW9ucy54bWwgZmlsZXMKcXVvdGUgdGhl
IFBPU0lYIHN0YW5kYXJkLCB3aGljaCBkZWZpbmVzIGJlaGF2aW91ciByZWxhdGl2ZSB0byBtYWlu
KCkg4oCUIHRoZSBDCmVudHJ5IHBvaW50LCBub3QgYW4gTFRQLWludGVybmFsIGZ1bmN0aW9uIG5h
bWUuIFJldmVydCB0aGVzZSBodW5rcyBpbiBib3RoCnB0aHJlYWRfY3JlYXRlL2Fzc2VydGlvbnMu
eG1sIGFuZCBwdGhyZWFkX2V4aXQvYXNzZXJ0aW9ucy54bWwuCgo+IGRpZmYgLS1naXQgYS8uLi4v
YWlvX3dyaXRlLzktMi5jIGIvLi4uL2Fpb193cml0ZS85LTIuYwo+ICtpbnQgdGVzdF9tYWluKGlu
dCBhcmdjLCBjaGFyKiogYXJndikKCnMvY2hhcioqIGFyZ3YvY2hhciAqKmFyZ3YvIHRvIG1hdGNo
IHRoZSBzdHlsZSB1c2VkIGV2ZXJ5d2hlcmUgZWxzZS4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNv
bXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpm
b3VuZCBhdDogaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0Lz9z
ZXJpZXM9NTAwMTczCgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0
aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5k
IGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdu
b3JlIHRoZSBzdWdnZXN0aW9ucy4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
