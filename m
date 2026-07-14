Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB4BC43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 11:06:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44B4A3E574B
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 13:06:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67FBF3E262B
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 13:05:50 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E523A600568
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 13:05:49 +0200 (CEST)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4a43c2a126fso1287090b6e.3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 04:05:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784027148; cv=none;
 d=google.com; s=arc-20260327;
 b=SfEucNS2j1V4YHxNbc/xF4uTiz81B2se2PI1s9+9SkjzLo/jjbZJdZYLW2Q3uOcdBL
 t5z0tqh/YKR18UOD5LYiNHaRnoziqoUaXJSsOeZx4307nbmU/d+QOaNoDLTmh38VZri7
 5UdWcXddgsZyYX8GiEDS9GIOrh/KluwVNcagYg0t+c936VAoZz1ph1Oz4CQm3sMr18Kw
 WZDnkWt/yLqgYicwFmmFzm7ggZ85wNjKYr8oST8w9ZOR+xgofO7BY+HHebMNk7Mor2s5
 vVGY2s/1pRjXXAzhG2dztHALpypGVc/zPzFMnH7MdchKGEDaskm1ALVMZE/2K4POOIM4
 wN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CKEhSe1+sPtp2UX14aHhhkigLyM9iH8eNqIovJScleg=;
 fh=NLAhOHOaMQLyvuylBs6X/1NdiVHo4S38uzUH4XEKHXw=;
 b=W9KwJbQ3Pdy9h4brKjSq+Z65A5x6UtUHalbaOmZSpWw2uQcK59SOCJGZdkxiGAvFlP
 /O8R5wkv2rKiJzefpHmIF4j8PyCbFv7Fb0alxe/KkTrXbBIOt2n14eDwCUSivbo5Qgng
 Dujs0PsJHC+K7NiEzL83ioyvpcxDQHTxxYCOOIPCmSkdXcjUNX5yxhTr0XSRXVq5z69j
 kOfP0WCujpr4K4NGYGcVmap6IF4Cbj5lrBWZSjjqiOcPGyWUXm2LJrp4VUUceExGZFn7
 ivqX8NBCwlmPYQazBn2fCdaVMU2KkJi48pkSIsF4EEvnftNvCNZUgqJ5TVeWLYiI8CRV
 BKvg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784027148; x=1784631948; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CKEhSe1+sPtp2UX14aHhhkigLyM9iH8eNqIovJScleg=;
 b=k21wIX7IOtwBNTFZGHM/NZeXIFDhzVjZWxk8YnlRwY0WP5QrhKND2QMkdFH7NoI9Ey
 8zQbr/0GSB0HFTtNKllhvkmfw2NNQcrC6iwwj4WnsvHO9SVfZ7XvIFjA6Tf0WXQPbxDQ
 YT4DvSZ3GqmBTeL4RBxUbPOaOLK+GaBJCVz/V2dZunz9o1B5b2KrAQ7tOEhz0xtgXsOg
 71CZp5AES7+bLjmHzC1m2xbL1d0+5oA1sr+UR5Nr686Q7AkZOetuClLGRp7Beaq6NXVm
 cS3mf6QYr+6IYA/wqGS/oc9p12APrtMY0aiRRph6BklHEMBiDqDtb/Mchy2kDwYmA+aT
 YR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784027148; x=1784631948;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CKEhSe1+sPtp2UX14aHhhkigLyM9iH8eNqIovJScleg=;
 b=l+Dipj1ES85lpGXdN2zjHFexMGbQfBYFUM5ZQdIG/cTHppxfYqzr9rGc09iqYBoKD5
 tylzPciKK/NNLWjDeSE1Sdt3KgbRCVXOUUMB/qSM9ASf0DXRR+Y2DVm617qCk/5hSNDu
 dsOyboaOFU20ix17NeLOwZ1cjPVmLWPzM168/9WVu/WHMi5Rf1n4B1Dy0hhEooQNDR8x
 mlTC0v6MpQ9uAbVhVVgOKSdk+QinhBUkJfy0kmsrX7tHSoTmmyndTGU7QecCmpL/NXiE
 Uw239Je0CnYS3pvbAyCdflW6KQv9AVs9gubmtjx0qTgwGU6qvmepDcLMSGQb7E2ZJlvb
 Jq+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SnPcT0RL7s2XSXKuwgQpyQSG7WYncGNn78hh+aqoGfmYT4iZipyfuNNpK+yFsbMogSx4=@lists.linux.it
X-Gm-Message-State: AOJu0YycsZvZtYchGiMqdPJjq4p9qxIAtGVaQYyCZ3E43L/+nB3dIg6g
 6LlxCJMO+2OrmMbIIySwFh8LpNhFaGpqFVyY/fhmO9mL5+jNYS2wnUklaqxemjxShpq2GUsw0tU
 51sBcReIKrxDTwvWkKyKB5pQFcqTiRkEVkLpU
X-Gm-Gg: AfdE7cm5oUHyT5+1msHO8C8dAPFIxmxpfVCLWA/w2KE/VpIFxAEK94Nc8zbSR+rCnL/
 2qiaIlittoVZDIDYJplP2Xn5nzu/TzLUiqOS18Fbk9ZM5WjAlk1EfSNXME3vbpxzap85WDoXv3c
 prUuytsp4nzzqThzXLgxeItwlFXsJGgQYSv6apS61OlpqqbvfPkhYszfQF8wg3AbZySykAzPnc4
 G1pkvnymz94SyjbPZtSO0Sd+KdMPzn2/KwukkI942O0Zbu3VS1ypYGRjc0sf0eiyMi4jzuEGJ8=
X-Received: by 2002:a05:6808:6f8c:b0:495:f10d:c440 with SMTP id
 5614622812f47-4a42af0a338mr8610249b6e.22.1784027148593; Tue, 14 Jul 2026
 04:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260714090632.2910506-1-zhanghongtao35@huawei.com>
 <20260714104959.4018-1-linuxtestproject.agent@gmail.com>
In-Reply-To: <20260714104959.4018-1-linuxtestproject.agent@gmail.com>
From: Yizhou Tang <tangyeechou@gmail.com>
Date: Tue, 14 Jul 2026 19:05:37 +0800
X-Gm-Features: AUfX_mwAK3Qob9sxs94wkarqEuUB-fRaXjsgCpC8YeObH-c7Al8mcPSLti0n4pk
Message-ID: <CAOB9oOZaAan2bKWzu2XLeGkZVV1RO39YWuucmQK0tvvgVE4rUA@mail.gmail.com>
To: linuxtestproject.agent@gmail.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: ltp@lists.linux.it, Hongtao Zhang <zhanghongtao35@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdWwgMTQsIDIwMjYgYXQgNjo1MOKAr1BNIDxsaW51eHRlc3Rwcm9qZWN0LmFnZW50
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBIb25ndGFvLAo+Cj4gT24gVHVlLCAxNCBKdWwgMjAy
NiAxNzowNjozMiArMDgwMCwgSG9uZ3RhbyBaaGFuZyB3cm90ZToKPiA+IFJldmVydCAidHBjaTog
dW5iaW5kIGRyaXZlciBpbiB0ZXN0X2Fzc2lnbl9yZXNvdXJjZXMoKSIKPgo+IFR3byBzbWFsbCBj
b21taXQtbWVzc2FnZSBpc3N1ZXMgYmVsb3c7IHRoZSBjb2RlIGl0c2VsZiBsb29rcyBmaW5lLgo+
Cj4gPiBXaGlsZSB0aGUgcGF0Y2ggZml4ZXMgYSB1c2UtYWZ0ZXItZnJlZSBpbiAvcHJvYy9pb21l
bSBieSB1bmJpbmRpbmcgYW5kCj4gPiByZWJpbmRpbmcgdGhlIGRyaXZlciBhcm91bmQgUENJIHJl
c291cmNlIHJlYXNzaWdubWVudCwgdGhpcyBhcHByb2FjaCBpcwo+ID4gdG9vIGRhbmdlcm91cyBm
b3IgYSBnZW5lcmFsIHRlc3QuIFVuYmluZGluZyBhIGRyaXZlciBmcm9tIGEgY3JpdGljYWwgZGV2
aWNlCj4gPiAoZS5nLiBhIG5ldHdvcmsgb3IgYmxvY2sgY29udHJvbGxlcikgY2FuIGluc3RhbnRs
eSBicmVhayBTU0ggY29ubmVjdGl2aXR5IG9yCj4gPiBjYXVzZSBmaWxlc3lzdGVtIGNvcnJ1cHRp
b24uIFN1Y2ggc2lkZSBlZmZlY3RzIGFyZSB1bmFjY2VwdGFibGUgY29tcGFyZWQgdG8KPiA+IHRo
ZSBvcmlnaW5hbCBpc3N1ZS4KPiA+IFNvIG5lZWQgdG8gcmV2ZXJ0IHRoYXQgcGF0Y2guCj4KPiAi
U28gbmVlZCB0byByZXZlcnQgdGhhdCBwYXRjaC4iIHJlYWRzIGluZm9ybWFsbHkgYW5kIGlzIGdy
YW1tYXRpY2FsbHkKPiBpbmNvbXBsZXRlLiBUaGUgbW90aXZhdGlvbiB3YXMgYWxyZWFkeSBzdGF0
ZWQgaW4gdGhlIHByZWNlZGluZyBzZW50ZW5jZXM7Cj4gdGhpcyBjbG9zaW5nIGxpbmUgY2FuIGJl
IGRyb3BwZWQgZW50aXJlbHksIG9yIHJld3JpdHRlbiBhcyAiUmV2ZXJ0IHRoZQo+IHBhdGNoLiIK
Pgo+IEFsc28sIHRoZSBib2R5IGlzIG1pc3NpbmcgdGhlIHN0YW5kYXJkIHRyYWNlYWJpbGl0eSBs
aW5lIHRoYXQgZ2l0IHJldmVydAo+IGFkZHM6ICJUaGlzIHJldmVydHMgY29tbWl0IDxmdWxsLVNI
QT4uIiBXaXRob3V0IGl0LCBiaXNlY3QgYW5kIGdpdC1sb2cKPiBzZWFyY2hlcyBjYW5ub3QgbWVj
aGFuaWNhbGx5IGxpbmsgdGhpcyByZXZlcnQgdG8gdGhlIGNvbW1pdCBpdCB1bmRvZXMuCj4gVGhl
IHN1YmplY3QgcXVvdGVzIHRoZSBvcmlnaW5hbCBtZXNzYWdlLCBidXQgdGhlIFNIQSBtYWtlcyB0
aGUgbGluawo+IHVuYW1iaWd1b3VzLiBQbGVhc2UgYWRkIGl0Lgo+Cj4gVmVyZGljdCAtIE5lZWRz
IHJldmlzaW9uCgpIaSwKCldlIHJlY2VudGx5IGNvbmZpcm1lZCB0aGlzIGNvbW1pdCBkb2VzIGNh
dXNlIGEgZmxvb2Qgb2YgSS9PIGVycm9ycyBvbgp0aGUgcm9vdCBmaWxlc3lzdGVtIGluIG91ciB0
ZXN0aW5nLCBsZWF2aW5nIHRoZSBtYWNoaW5lIHVudXNhYmxlIHVudGlsCnJlYm9vdC4KCkdpdmVu
IHRoYXQsIHdlJ2QgYXBwcmVjaWF0ZSB0aGUgY29tbXVuaXR5IGhlbHBpbmcgdG8gZGVjaWRlIHNv
b24Kd2hldGhlciB0aGUgcmV2ZXJ0IGlzIHdhcnJhbnRlZC4KCkJlc3QgcmVnYXJkcywKWWkKCj4K
Pgo+IC0tLQo+IE5vdGU6Cj4KPiBUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNl
IHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKPiBmaW5kaW5ncyBhcmUgZ2VudWluZS4gSWYg
eW91IGZpbmQgaXNzdWVzIHdpdGggdGhlIHJldmlldywgcGxlYXNlCj4gY29tbWVudCB0aGlzIGVt
YWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCj4KPiBSZWdhcmRzLAo+IExUUCBBSSBSZXZp
ZXdlcgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
