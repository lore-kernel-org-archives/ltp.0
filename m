Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3720C4167B
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 17:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C1F23CFA98
	for <ltp@archiver.kernel.org>; Mon, 27 Nov 2023 18:40:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 105B23C86A8
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 18:40:27 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 620FE6096BF
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 18:40:27 +0100 (CET)
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67a47104064so6346046d6.0
 for <ltp@lists.linux.it>; Mon, 27 Nov 2023 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701106826; x=1701711626; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M8tcNG7o+AdD9BgwdikDOy+HQr9yweBJc7o03Q69HWE=;
 b=NBj0YVnQYRk4Y+BQYFchhHOtjNsurAnwomT9hcsp5rh+Iau+jE88UagPe4Cj3737XN
 vHfRMwas+YuiC0v0wdg9Ddd+mzY2K2TPT5h62fgDq96ZkuntKUCxdNF9hQvpIT9e3Gys
 jqWoYRuGzypXsZR5rh86OwFZ0VdeGqvHRluNnwv46xy9wEWTm9d+LbFDtxqI5DPxUY5Z
 IPsZ6JiLwG1oZhy5zzWH6iSdSmK5l/W6ar6Yan7blMjdtXOmXAd+SyssMNoneSQYWPxB
 unHC7AluJKeJMAglKszsR0VrN+4hNfwqKkZ4cG6m+3vHO2V54lX528+NIqIvBQBnMJEj
 Cd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701106826; x=1701711626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8tcNG7o+AdD9BgwdikDOy+HQr9yweBJc7o03Q69HWE=;
 b=iKdadFxvxnIsF7j5fiQi2KU1q5TkgGZkX2oQBdemy2H/fCnc36fm6TSFyYl6Qv1kqB
 zJpvwWcN8pJNo+59N7fhI9vqdxQTGau+cbBaGXyiY0yFkYJvOQhZ7XxniuQkecJCdl7B
 5sIER4daDglkbOFbtevc/v6+vk+Fd3bMpIDSTbwjtNRK4xJsn78U2ER5CLnW8YK/HC3E
 wmj9lqLQeEd6DeuvOnv4A/rI3bNKOQZBlfWHmzsyUQvFZPBMdO3ZKUYaAvtMwMbbmrJ4
 /AEatDI2r2POgplonYIJTYrIXz2YBpqf3Vi76ti5UM0J0Sim71OACqJXhF4OYPsJUvA1
 Wscw==
X-Gm-Message-State: AOJu0YxFB7Vr2oJ9Ec9PzWoCTj2R6ZZ+A2LWTpEqCkv7DBj7DGV28Q1Y
 Cyr9IRXrg/0hw43hUxgjTzYDw7lsqlRXpwlK9XE=
X-Google-Smtp-Source: AGHT+IFQVHlDTdol9upITcnRbeormTk8oRzdacyNQZGG0TIMkvGs2AV3qGnHuWAb9Zlfd/C12oD30T9DCxftFX4Vizc=
X-Received: by 2002:a05:6214:1051:b0:67a:36ab:d4d0 with SMTP id
 l17-20020a056214105100b0067a36abd4d0mr6342065qvr.39.1701106826180; Mon, 27
 Nov 2023 09:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20231127154013.2625-1-jack@suse.cz>
In-Reply-To: <20231127154013.2625-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 27 Nov 2023 19:40:14 +0200
Message-ID: <CAOQ4uxhtz2rCn70roeof0Bt8CbAi0vK4CMNiuoFq9M85FUpgGQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify: Fix broken tests due to
 fanotify_events_supported_by_kernel()
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
Cc: pvorel@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgNTo0MOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gV2hlbiBMVFAgdGVzdCBpcyBydW4gd2l0aCBDV0QgaW4gYnRyZnMgc3Vidm9s
dW1lLCB0ZXN0cyBsaWtlIGZhbm90aWZ5MTYKPiBmYWlsIHdpdGg6Cj4KPiBmYW5vdGlmeS5oOjE2
OTogVEJST0s6IGZhbm90aWZ5X21hcmsgKDMsIEZBTl9NQVJLX0FERCwgLi4uLCBBVF9GRENXRCwg
Ii4iKSBmYWlsZWQ6IEVYREVWICgxOCkKPgo+IFRoaXMgaXMgYmVjYXVzZSBmYW5vdGlmeV9ldmVu
dHNfc3VwcG9ydGVkX2J5X2tlcm5lbCgpIHRyeSB0byBwbGFjZSBhCj4gbWFyayBvbnRvIENXRCBh
bmQgdGhhdCBpcyBmb3JiaWRkZW4gZm9yIGJ0cmZzIHN1YnZvbHVtZXMuIENoYW5nZQo+IGZhbm90
aWZ5X2V2ZW50c19zdXBwb3J0ZWRfYnlfa2VybmVsKCkgdG8gdXNlICIvIiBpbnN0ZWFkIG9mICIu
IiB3aGljaAo+IGhhcyBoaWdoZXIgY2hhbmNlcyBvZiB3b3JraW5nIGZvciBidHJmcy4KPgoKRldJ
VywgIi4iIGluIHNldHVwKCkgaXMgdXN1YWxseSBhIHRlbXBkaXIgKHVuZGVyIExUUCB0ZW1wIHJv
b3QpClNvIEknbSBub3Qgc3VyZSB0aGF0ICIvIiBpcyBhIGJldHRlciBjaG9pY2UgdGhhbiAiLiIu
CkF0IGxlYXN0IHRoZSBMVFAgdGVtcCBkaXIgaXMgY29uZmlndXJhYmxlLgphbmQgbm8gcmVhc29u
IHRoYXQgIi8iIGlzIG5vdCBhIGJ0cmZzIHN1YnZvbCBpbnNpZGUgYSBjb250YWluZXIuLi4KCkZZ
SSwgaW4gdGhpcyBicmFuY2g6Cmh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC9sdHAvY29tbWl0
cy9mYW5vdGlmeV9mc2lkCgpJIGhhdmUgYWxyZWFkeSBpbXBsZW1lbnRlZCBmYW5vdGlmeV9mbGFn
c19zdXBwb3J0ZWRfb25fZnMoKQp3aGljaCBjYW4gYmUgdXNlZCB0byB0ZXN0IHN1cHBvcnQgZm9y
IGFuIGV2ZW50L21hcmsgb24gYSBzcGVjaWZpYyBwYXRoLgoKSSBkaWQgbm90IG1ha2UgdGhlIGNo
YW5nZSBpbiBmYW5vdGlmeTE2LmMgdG8gdXNlCmZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9m
cygpIGluc3RlYWQgb2YKZmFub3RpZnlfe21hcmssZXZlbnRzfV9zdXBwb3J0ZWRfYnlfa2VybmVs
KCkgYnV0IGl0IHdvdWxkIGJlIHRyaXZpYWwgdG8gZG8uCgpUaGFua3MsCkFtaXIuCgoKCj4gQWxz
byB1cGRhdGUgdGhlIGVycm9yIG1lc3NhZ2UgdG8gcHJvdmlkZSBhIGJpdCBtb3JlIGluZm8uCj4K
PiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+IC0tLQo+ICB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggfCA1ICsrKy0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gaW5kZXggMzJiNTEwY2Rj
MTc4Li5mMmZlMGMwNWI0NDkgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeS5oCj4gQEAgLTE2MSwxMiArMTYxLDEzIEBAIHN0YXRpYyBpbmxpbmUg
aW50IGZhbm90aWZ5X2V2ZW50c19zdXBwb3J0ZWRfYnlfa2VybmVsKHVpbnQ2NF90IG1hc2ssCj4K
PiAgICAgICAgIGZkID0gU0FGRV9GQU5PVElGWV9JTklUKGluaXRfZmxhZ3MsIE9fUkRPTkxZKTsK
Pgo+IC0gICAgICAgaWYgKGZhbm90aWZ5X21hcmsoZmQsIEZBTl9NQVJLX0FERCB8IG1hcmtfZmxh
Z3MsIG1hc2ssIEFUX0ZEQ1dELCAiLiIpIDwgMCkgewo+ICsgICAgICAgaWYgKGZhbm90aWZ5X21h
cmsoZmQsIEZBTl9NQVJLX0FERCB8IG1hcmtfZmxhZ3MsIG1hc2ssIEFUX0ZEQ1dELCAiLyIpIDwg
MCkgewo+ICAgICAgICAgICAgICAgICBpZiAoZXJybm8gPT0gRUlOVkFMKSB7Cj4gICAgICAgICAg
ICAgICAgICAgICAgICAgcnZhbCA9IC0xOwo+ICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiZmFub3RpZnlfbWFyayAoJWQsIEZBTl9NQVJLX0FERCwg
Li4uLCBBVF9GRENXRCwgXCIuXCIpIGZhaWxlZCIsIGZkKTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJmYW5vdGlmeV9tYXJrICglZCwgRkFOX01BUktfQUREIHwgJXgsICVsbHgs
IEFUX0ZEQ1dELCBcIi5cIikgZmFpbGVkIiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGZkLCBtYXJrX2ZsYWdzLCAodW5zaWduZWQgbG9uZyBsb25nKW1hc2spOwo+ICAgICAgICAg
ICAgICAgICB9Cj4gICAgICAgICB9Cj4KPiAtLQo+IDIuMzUuMwo+CgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
