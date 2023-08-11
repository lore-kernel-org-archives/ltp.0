Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C256C001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 12:02:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EEF33CDA4B
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 14:02:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF2EC3C4BC7
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 14:02:31 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F213E600F8F
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 14:02:30 +0200 (CEST)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc8a2f71eeso13889935ad.0
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 05:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691755349; x=1692360149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbNKsJXe+0EHrwCAXBg8RBUkazGRuNh5pObksrF05vY=;
 b=U3O91nJxl6ptUt+Tl8DVonpQCqUPf04NA+57ZhF8CMaFt5G0+TTraAeXYd8UkA8DZO
 BOsaiWa1mwwhvRqnRekUATPQy43R4S0XiOP6uTjuBo/TTw4hjVIgpY4SljFDcJu1qy2P
 w7OqiSzfer+O37c4pJb4JZShYYypkw20Hp6DhGvClEFBxC9z+eqyZ2q/8fWjUYQIm/1J
 XgSp8ZezTe4HanyzD126yh/o7dhao/kE/kvdXHnoPhHACeq3p3NtENmkUj/T3/Ev7LpI
 ZmGpB9toZUmadprQp14FivC8DK24+GGjOCr2xd6Tfaugq6RSY0eGl6u0p1fP6T1uw0Lv
 UoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691755349; x=1692360149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbNKsJXe+0EHrwCAXBg8RBUkazGRuNh5pObksrF05vY=;
 b=Dv0QBCpGQ6LJ5m6LWgAH6W/O1Igf3rb/EcuieSt6uH3gwXgK8u/t0gkfxu0BfwqYMr
 mNSkThyDOO9CEihvx1d94c0rlSUUjIhwjb0UuQXyWss8lOJHvUFqfdAq+SOKtnpq1Yi7
 9RszLoMbwWMsmf08gnQIh1coAO5lZxrDfg55Al+1IP0jVa+rqbMsHzFbXCClCmm9nn7N
 qomfmsIEeekxWN9GWgmye4M8Q3OTYwFfqRSA17MQUVHalQITOcSo+gJmXnuArow5KIfd
 bSuUqTJlsQZHg5SJpLQ9WlD3e8ONEKR1Gyx0fUFhf+whn1/N/I5ZbEXFV9XhlTPTahuC
 hi3Q==
X-Gm-Message-State: AOJu0YyC4UVp385yJwGLF2Gzx75UU0SQsuKHku7EcHeSFglRyZuqjxpF
 7INvcMUy1/dbVMSR3V6g38F1W07gxcrjSec6Lbar8V9LuBg=
X-Google-Smtp-Source: AGHT+IEhBA5jvKd9qb8UPRVVD0y3mqEJNc/7q4PHP8/CHyFmO7dWzzQ53E+TIDwgWtiBTYmlYKkOqiP9YIUF2i6Z6EU=
X-Received: by 2002:a05:6358:2904:b0:123:5664:e493 with SMTP id
 y4-20020a056358290400b001235664e493mr2323887rwb.27.1691755328619; Fri, 11 Aug
 2023 05:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230810175926.6205-1-jack@suse.cz>
In-Reply-To: <20230810175926.6205-1-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Aug 2023 15:01:57 +0300
Message-ID: <CAOQ4uxjpsqLgOgUPccQKfqpNV899eVa8PvCHc6LDLcMQB6bZkA@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fanotify23: Make evictable marks tests more
 reliable
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
Cc: ltp@lists.linux.it, petr.vorel@suse.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgODo1OeKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gSXQgaGFzIGJlZW4gb2JzZXJ2ZWQgdGhhdCB3aGVuIGZhbm90aWZ5MjMgdGVz
dCBpcyBydW4gaW4gYSBsb29wLCBpdAo+IGV2ZW50dWFsbHkgZmFpbHMgYXM6Cj4KPiBmYW5vdGlm
eTIzLmM6MTEyOiBUUEFTUzogRkFOX01BUktfQUREIGZhaWxlZCB3aXRoIEVFWElTVCBhcyBleHBl
Y3RlZCB3aGVuIHRyeWluZyB0byBkb3duZ3JhZGUgdG8gZXZpY3RhYmxlIG1hcmsKPiBmYW5vdGlm
eTIzLmM6NzU6IFRQQVNTOiBGQU5fTUFSS19SRU1PVkUgZmFpbGVkIHdpdGggRU5PRU5UIGFzIGV4
cGVjdGVkIGFmdGVyIGVtcHR5IG1hc2sKPiBmYW5vdGlmeTIzLmM6MTU2OiBUUEFTUzogR290IG5v
IGV2ZW50cyBhcyBleHBlY3RlZAo+IGZhbm90aWZ5MjMuYzo4MTogVEZBSUw6IEZBTl9NQVJLX1JF
TU9WRSBkaWQgbm90IGZhaWwgd2l0aCBFTk9FTlQgYXMgZXhwZWN0ZWQgYWZ0ZXIgZHJvcF9jYWNo
ZXM6IFNVQ0NFU1MgKDApCj4KPiBUaGlzIGlzIGJlY2F1c2UgcmVwZWF0ZWQgZXZpY3Rpb25zIG9m
IGNhY2hlcyBkb25lIGJ5IHRoZSB0ZXN0IHJlY2xhaW0KPiBhbGwgZnJlZWFibGUgc2xhYiBvYmpl
Y3RzIGluIHRoZSBzeXN0ZW0uIFNvIHdoZW4gdGhlIHRlc3QgY2FsbHMgZHJvcAo+IGNhY2hlcywg
b25seSB0aGUgZGVudHJ5IGFuZCBpbm9kZSBvZiB0aGUgdGVzdCBmaWxlIGFyZSB0aGVyZSB0byBy
ZWNsYWltLgo+IEJ1dCBmb3IgaW5vZGUgdG8gYmUgcmVjbGFpbWVkLCBkZW50cnkgKHdoaWNoIGhv
bGRzIGlub2RlIHJlZmVyZW5jZSkgaGFzCj4gdG8gYmUgZnJlZWQgZmlyc3QgYW5kIGZvciBkZW50
cnkgdG8gYmUgZnJlZWQgaXQgaGFzIHRvIGZpcnN0IGN5Y2xlCj4gdGhyb3VnaCB0aGUgTFJVIHdo
aWNoIHRha2VzIHR3byBzbGFiIHJlY2xhaW0gY2FsbHMuCj4KPiBDYWxsIGRyb3AgY2FjaGVzIHR3
aWNlIHRvIG1ha2Ugc3VyZSBkZW50cnkgaGFzIGNoYW5jZSB0byBwYXNzIHRocm91Z2gKPiB0aGUg
TFJVIGFuZCBiZSByZWNsYWltZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gS2FyYSA8amFja0Bz
dXNlLmN6PgoKUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+
Cgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMu
YyB8IDggKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkyMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5v
dGlmeTIzLmMKPiBpbmRleCA4OWZkNGYzNmEwOWIuLmZiODEyYzUxZTM0ZSAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjMuYwo+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkyMy5jCj4gQEAgLTE2
MCwxMCArMTYwLDE2IEBAIHN0YXRpYyB2b2lkIHRlc3RfZmFub3RpZnkodm9pZCkKPiAgICAgICAg
IH0KPgo+ICAgICAgICAgLyoKPiAtICAgICAgICAqIGRyb3BfY2FjaGVzIHNob3VsZCBldmljdCBp
bm9kZSBmcm9tIGNhY2hlIGFuZCByZW1vdmUgZXZpY3RhYmxlIG1hcmsKPiArICAgICAgICAqIGRy
b3BfY2FjaGVzIHNob3VsZCBldmljdCBpbm9kZSBmcm9tIGNhY2hlIGFuZCByZW1vdmUgZXZpY3Rh
YmxlIG1hcmsuCj4gKyAgICAgICAgKiBXZSBjYWxsIGRyb3BfY2FjaGVzIHR3aWNlIGFzIG9uY2Ug
dGhlIGRlbnRyaWVzIHdpbGwganVzdCBjeWNsZQo+ICsgICAgICAgICogdGhyb3VnaCB0aGUgTFJV
IHdpdGhvdXQgYmVpbmcgcmVjbGFpbWVkIGFuZCBpZiB0aGVyZSBhcmUgbm8gb3RoZXIKPiArICAg
ICAgICAqIG9iamVjdHMgdG8gcmVjbGFpbSwgdGhlIHNsYWIgcmVjbGFpbSB3aWxsIGp1c3Qgc3Rv
cCBpbnN0ZWFkIG9mCj4gKyAgICAgICAgKiByZXRyeWluZy4gTm90ZSB0aGF0IHRoaXMgcmVsaWVz
IG9uIGhvdyByZWNsYWltIG9mIGZzIG9iamVjdHMgd29yawo+ICsgICAgICAgICogZm9yIHRoZSBm
aWxlc3lzdGVtIGJ1dCB0aGlzIHRlc3QgaXMgcmVzdHJpY3RlZCB0byBleHQyLi4uCj4gICAgICAg
ICAgKi8KPiAgICAgICAgIGZzeW5jX2ZpbGUoVEVTVF9GSUxFKTsKPiAgICAgICAgIFNBRkVfRklM
RV9QUklOVEYoRFJPUF9DQUNIRVNfRklMRSwgIjMiKTsKPiArICAgICAgIFNBRkVfRklMRV9QUklO
VEYoRFJPUF9DQUNIRVNfRklMRSwgIjMiKTsKPgo+ICAgICAgICAgdmVyaWZ5X21hcmtfcmVtb3Zl
ZChURVNUX0ZJTEUsICJhZnRlciBkcm9wX2NhY2hlcyIpOwo+Cj4gLS0KPiAyLjM1LjMKPgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
