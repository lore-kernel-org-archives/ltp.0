Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AA6C10DC1
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:13:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C11053CD6C1
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 11:13:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F7A13CC93A
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 11:13:09 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5D6E1002896
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 11:13:08 +0100 (CET)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67a44638adfso3915466d6.2
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 02:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701339187; x=1701943987; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91QQtYE5LUA2EknSndesP/0Ri8R/xRvhm+B6skBUCCs=;
 b=RIgB7A2LqNDvm2K8fwRFg7ukbaIwJUJ9RM+TMOJF0PXX59hBWwwL0a0WGo1jA/TVqC
 4Qy4bOf2SUcTlhQCKtGfZv23jxui8pmWiYVpHzz5CmzpK9mni316G23QBzsNL5C3kSeg
 lXFm4/61ueREwfuAdmI8Tge7VbCDIcpCpDB3ADvwydMaMFdtrWnDjqGhDWsGGydl1R9N
 8ZxNORVsY5UY/QFJvBh4jY+X3HwiOQirDjwZiUPg4W/x/y4mRdTHGxA5YGlNRznRFf53
 qZQ+3Y1neY1MbqQxW7MrhJudJqgjh4uyt3M4NKwzeUnp0vH9Bc672S1kxPJbSH59v0AT
 7dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701339187; x=1701943987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91QQtYE5LUA2EknSndesP/0Ri8R/xRvhm+B6skBUCCs=;
 b=ckxIoO/dfUsUdInE+4t5gV23xZIFGxoBFo1QomWJkaOXq2AXGJVnWJjJVukigL0LH5
 0vXJ5+KLxQssr5cG492Xl0ez6O4QAhm5MmUaTj/a7o/73BjL4j7TTearCqENJhK3mFyz
 CcxBbZtQ8fyiWbEXRlZI0mHt2HGCIcHlUIPZ+MvaiEKl+vrrC9ACR48T05G+nCOKs1HT
 iTEMMs/8wQEXLk1l++OlgKwh7+TCAOyH4FPgvMOuf/JvLz/eyvCaz7mqCr6rYFR0e2Xi
 gmx0TJgSZfQ8UY/c7gEm5/k5ZxiRRbJ/ChDnYYSqfPMa81iXhk4cINBZlGzNlG4x48Pv
 9e2w==
X-Gm-Message-State: AOJu0Yzcl9DR7P6s3motX6wWWHxGf7Gxpm4typqCnMoEg6UYtYM73s2L
 xYm5KtiwKibj6YEfQq+AppRWpqIm1OlLgM89SlQ=
X-Google-Smtp-Source: AGHT+IHaD4YVCUdkUnRJokb8WBGMEc4ZI+hmGQGCfdxS56+4pvglqzzjXfCDQFKb28RHRir/u7HaeE1Ya6JHw5pnJ+s=
X-Received: by 2002:a05:6214:f0c:b0:67a:212e:2ff with SMTP id
 gw12-20020a0562140f0c00b0067a212e02ffmr26093202qvb.11.1701339187456; Thu, 30
 Nov 2023 02:13:07 -0800 (PST)
MIME-Version: 1.0
References: <20231130093533.10036-1-jack@suse.cz>
 <20231130093711.20171-3-jack@suse.cz>
In-Reply-To: <20231130093711.20171-3-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 12:12:56 +0200
Message-ID: <CAOQ4uxjo29Ec1aDYPmht3R4kUd3bap0QxAiEDUU7yB3-HCm9Yw@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/7] fanotify: Provide
 fanotify_mark_supported_on_fs()
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

T24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgMTE6MzfigK9BTSBKYW4gS2FyYSA8amFja0BzdXNlLmN6
PiB3cm90ZToKPgo+IFByb3ZpZGUgaGVscGVyIGNoZWNraW5nIHdoZXRoZXIgYSBtYXJrIGlzIHN1
cHBvcnRlZCBvbiBhIGZpbGVzeXN0ZW0KPiBzaW5jZSBzb21lIG1hcmtzIG5lZWQgbm90IGJlIGF2
YWlsYWJsZSBvbiBhbGwgZmlsZXN5c3RlbXMgKGUuZy4gYnRyZnMKPiBzdWJ2b2x1bWVzKS4gQWxz
byBjb252ZXJ0IFJFUVVJUkVfTUFSS19UWVBFX1NVUFBPUlRFRF9CWV9LRVJORUwoKSBhbmQKPiBp
dHMgb25seSB1c2VyIHRvIHVzZSB0aGlzIG5ldyBmdW5jdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6
IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+ClJldmlld2VkLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1p
cjczaWxAZ21haWwuY29tPgoKPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5v
dGlmeS9mYW5vdGlmeS5oICAgfCAxMSArKysrKysrKy0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYyB8ICAyICstCj4gIDIgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaCBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+IGluZGV4IDNiODgzOGU4ZGQ2OC4uNTk3ZWQ5
NmUwMzEzIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkv
ZmFub3RpZnkuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFu
b3RpZnkuaAo+IEBAIC0yMjksNiArMjI5LDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IGZhbm90aWZ5
X2luaXRfZmxhZ3Nfc3VwcG9ydGVkX2J5X2tlcm5lbCh1bnNpZ25lZCBpbnQgZmxhZ3MpCj4gICAg
ICAgICByZXR1cm4gZmFub3RpZnlfaW5pdF9mbGFnc19zdXBwb3J0ZWRfb25fZnMoZmxhZ3MsIE5V
TEwpOwo+ICB9Cj4KPiArc3RhdGljIGlubGluZSBpbnQgZmFub3RpZnlfbWFya19zdXBwb3J0ZWRf
b25fZnModWludDY0X3QgZmxhZywgY29uc3QgY2hhciAqZm5hbWUpCj4gK3sKPiArICAgICAgIHJl
dHVybiBmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoRkFOX0NMQVNTX05PVElGLCBmbGFn
LCBGQU5fQUNDRVNTLCBmbmFtZSk7Cj4gK30KPiArCj4gICNkZWZpbmUgVFNUX0ZBTk9USUZZX0lO
SVRfS05PV05fRkxBR1MgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiAg
ICAgICAgIChGQU5fUkVQT1JUX0RGSURfTkFNRV9UQVJHRVQgfCBGQU5fUkVQT1JUX1RJRCB8IEZB
Tl9SRVBPUlRfUElERkQgfCBcCj4gICAgICAgICBGQU5fQ0xBU1NfTk9USUYgfCBGQU5fQ0xBU1Nf
Q09OVEVOVCB8IEZBTl9DTEFTU19QUkVfQ09OVEVOVCkKPiBAQCAtMzM2LDkgKzM0MSw5IEBAIHN0
YXRpYyBpbmxpbmUgaW50IGZhbm90aWZ5X2hhbmRsZV9zdXBwb3J0ZWRfYnlfa2VybmVsKGludCBm
bGFnKQo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+IC0jZGVmaW5lIFJFUVVJUkVfTUFSS19U
WVBFX1NVUFBPUlRFRF9CWV9LRVJORUwobWFya190eXBlKSBcCj4gKyNkZWZpbmUgUkVRVUlSRV9N
QVJLX1RZUEVfU1VQUE9SVEVEX09OX0ZTKG1hcmtfdHlwZSwgZm5hbWUpIFwKPiAgICAgICAgIGZh
bm90aWZ5X2ZsYWdzX2Vycl9tc2coI21hcmtfdHlwZSwgX19GSUxFX18sIF9fTElORV9fLCB0c3Rf
YnJrXywgXAo+IC0gICAgICAgICAgICAgICBmYW5vdGlmeV9tYXJrX3N1cHBvcnRlZF9ieV9rZXJu
ZWwobWFya190eXBlKSkKPiArICAgICAgICAgICAgICAgZmFub3RpZnlfbWFya19zdXBwb3J0ZWRf
b25fZnMobWFya190eXBlLCBmbmFtZSkpCj4KPiAgI2RlZmluZSBSRVFVSVJFX0hBTkRMRV9UWVBF
X1NVUFBPUlRFRF9CWV9LRVJORUwoaGFuZGxlX3R5cGUpIFwKPiAgICAgICAgIGZhbm90aWZ5X2Zs
YWdzX2Vycl9tc2coI2hhbmRsZV90eXBlLCBfX0ZJTEVfXywgX19MSU5FX18sIHRzdF9icmtfLCBc
Cj4gQEAgLTM0Niw3ICszNTEsNyBAQCBzdGF0aWMgaW5saW5lIGludCBmYW5vdGlmeV9oYW5kbGVf
c3VwcG9ydGVkX2J5X2tlcm5lbChpbnQgZmxhZykKPgo+ICAjZGVmaW5lIFJFUVVJUkVfRkFOT1RJ
RllfRVZFTlRTX1NVUFBPUlRFRF9PTl9GUyhpbml0X2ZsYWdzLCBtYXJrX3R5cGUsIG1hc2ssIGZu
YW1lKSBkbyB7IFwKPiAgICAgICAgIGlmIChtYXJrX3R5cGUpICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gLSAgICAgICAgICAgICAgIFJFUVVJUkVf
TUFSS19UWVBFX1NVUFBPUlRFRF9CWV9LRVJORUwobWFya190eXBlKTsgICAgICAgXAo+ICsgICAg
ICAgICAgICAgICBSRVFVSVJFX01BUktfVFlQRV9TVVBQT1JURURfT05fRlMobWFya190eXBlLCBm
bmFtZSk7ICAgIFwKPiAgICAgICAgIGlmIChpbml0X2ZsYWdzKSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gICAgICAgICAgICAgICAgIFJFUVVJUkVf
RkFOT1RJRllfSU5JVF9GTEFHU19TVVBQT1JURURfT05fRlMoaW5pdF9mbGFncywgZm5hbWUpOyBc
Cj4gICAgICAgICBmYW5vdGlmeV9mbGFnc19lcnJfbXNnKCNtYXNrLCBfX0ZJTEVfXywgX19MSU5F
X18sIHRzdF9icmtfLCBcCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkyMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTIzLmMKPiBpbmRleCBmYjgxMmM1MWUzNGUuLjVhMDM1MDNlOTUyYSAxMDA2NDQK
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4g
QEAgLTIzMCw3ICsyMzAsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICB7Cj4gICAgICAg
ICBTQUZFX1RPVUNIKFRFU1RfRklMRSwgMDY2NiwgTlVMTCk7Cj4KPiAtICAgICAgIFJFUVVJUkVf
TUFSS19UWVBFX1NVUFBPUlRFRF9CWV9LRVJORUwoRkFOX01BUktfRVZJQ1RBQkxFKTsKPiArICAg
ICAgIFJFUVVJUkVfTUFSS19UWVBFX1NVUFBPUlRFRF9PTl9GUyhGQU5fTUFSS19FVklDVEFCTEUs
ICIuIik7Cj4gICAgICAgICBSRVFVSVJFX0ZBTk9USUZZX0VWRU5UU19TVVBQT1JURURfT05fRlMo
RkFOX0NMQVNTX05PVElGfEZBTl9SRVBPUlRfRklELAo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEZBTl9NQVJLX0ZJTEVTWVNURU0sCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRkFOX0FUVFJJQiwgIi4iKTsK
PiAtLQo+IDIuMzUuMwo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
