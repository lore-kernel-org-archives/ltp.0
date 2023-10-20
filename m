Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03DDCDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 16:06:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBEC13CFBF8
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 18:06:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 254B53C8927
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 18:05:49 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 057801000A20
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 18:05:49 +0200 (CEST)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-776f84c6cc7so56991285a.2
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697817948; x=1698422748; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3LCC97dlu+qUU8XgyzEcdmb6RY/D7cNLyMa88/TYD0=;
 b=cWR4FR282H2fu4ompvGs5ZuzOiVAEVYEF/a/eDNPJbNrazAgNcYbidHK599SMPL3Tr
 koEiwNaCeFw9aGLoNltDY+wENlv4OEQ1WV+ozMNuMPe7oeYMh8ieKyaqJSj+PMHmQWYU
 EDOBswO+msC2d6raM6vXq+DwTyB42jQGkr/VpPQaYjzlMKf3Hhfra/0+F5hC2AS75C0J
 RILQAJFmghhHcZ0EhrKe1goo5INOMX9V4jdxq+/6yO5gVUDcC9065H32Db/byQPwLAqr
 HBzxw67NgL88t7HLLNjQYuAtQrtkhs5Ji9d/XjRE83h4MSmJGk7L0xJMpdg+nQunDlGW
 3iHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697817948; x=1698422748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3LCC97dlu+qUU8XgyzEcdmb6RY/D7cNLyMa88/TYD0=;
 b=XDItvqG5GSmPxE79OO4KWhHLbkN8Dhn2WB08I1DtD5OB/7wCZjpa9j60tbx3ZmSJSM
 hWQclQlc7NtKF+GVWlMdGegR4BNVMU/QmcHyW0+o9mzKmIwVxNNb/ircKTx2MyzoI58y
 dPbnEkgg0W2oxI2jZkZTziNtGTx3zTNsPOxQY1mPAMEEqOUqa8OebDckgWtjJeaf2h0g
 JK5Qaimva00JX9K0nE9HIDQOe6Ucy1zkmLM1R27WdmG0w6g4t3CKKVxLcO68Cjx0FeWD
 6vifT/iBNZjpZA9Uun8PvYJoJY2+7YywqFqstk6tBNH5oTzp9iBqg4aRa2ggnBPNy9sw
 USGg==
X-Gm-Message-State: AOJu0Yyl34TZ7X7UImuYdVfHv9sWEd5Jk7By/f/9BQcTIQZ8O1P4QrfN
 nqGLIzuPQ/LpZH3raSwhcMUnZ9o6MYwzIdlrBKdx1kZMLzU=
X-Google-Smtp-Source: AGHT+IH+k08Ot/NfV68+d6cqASpTkjXg3iTcpITZY6mYnjqkT0OoRo6kRecNBGuMzaKG/UWQohCH3j1/8R/3bSysWRU=
X-Received: by 2002:a05:6214:519a:b0:66d:6266:40d3 with SMTP id
 kl26-20020a056214519a00b0066d626640d3mr2193766qvb.27.1697817947628; Fri, 20
 Oct 2023 09:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231020150749.21165-1-mdoucha@suse.cz>
 <20231020150749.21165-3-mdoucha@suse.cz>
In-Reply-To: <20231020150749.21165-3-mdoucha@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Oct 2023 19:05:36 +0300
Message-ID: <CAOQ4uxgV-PoXQ6Aeimn8T5tUbXX_8RRMwXtAqzUix7ro=BmV-g@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] fanotify14: Improve check for unsupported
 init flags
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBPY3QgMjAsIDIwMjMgYXQgNjowN+KAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBUZXN0IGNhc2UgOCBvZiBmYW5vdGlmeTE0IHVzZXMgaW5pdCBm
bGFncyBzdXBwb3J0ZWQgb25seSBvbiBrZXJuZWwgNS45Kwo+IGJ1dCBkb2VzIG5vdCBwcm9wZXJs
eSBjaGVjayBmb3IgdGhlaXIgc3VwcG9ydC4gUmV3cml0ZSBmYW5vdGlmeSBmZWF0dXJlCj4gY2hl
Y2tzIHVzaW5nIG5ldyBoZWxwZXIgZnVuY3Rpb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4g
RG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4gLS0tCj4KPiBDaGFuZ2VzIHNpbmNlIHYxOgo+IC0g
QWRkZWQgRkFOX0NMQVNTXyogY29uc3RhbnRzIHRvIHN1cHBvcnQgY2hlY2sgaW4gc2V0dXAoKQo+
IC0gQWRkZWQgbG9uZ2VyIHBhdGNoIGRlc2NyaXB0aW9uCj4KPiBDaGFuZ2VzIHNpbmNlIHYyOiBO
b25lCj4KPiBJJ2QgcmF0aGVyIG5vdCBzcXVhc2ggdGhpcyBwYXRjaCBzbyB0aGF0IGl0IGNhbiBi
ZSByZXZlcnRlZCB3aXRob3V0Cj4gcG90ZW50aWFsbHkgYnJlYWtpbmcgb3RoZXIgdGVzdHMuCj4K
PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMgfCAxNSAr
KysrKysrKystLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90
aWZ5L2Zhbm90aWZ5MTQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFu
b3RpZnkxNC5jCj4gaW5kZXggNDU5NjUxMWYwLi4wYmI3ODkxODggMTAwNjQ0Cj4gLS0tIGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTE0LmMKPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MTQuYwo+IEBAIC00NSw4ICs0
NSw4IEBACj4KPiAgc3RhdGljIGludCBwaXBlc1syXSA9IHstMSwgLTF9Owo+ICBzdGF0aWMgaW50
IGZhbm90aWZ5X2ZkOwo+IC1zdGF0aWMgaW50IGZhbl9yZXBvcnRfdGFyZ2V0X2ZpZF91bnN1cHBv
cnRlZDsKPiAgc3RhdGljIGludCBpZ25vcmVfbWFya191bnN1cHBvcnRlZDsKPiArc3RhdGljIHVu
c2lnbmVkIGludCBzdXBwb3J0ZWRfaW5pdF9mbGFnczsKPgo+ICBzdHJ1Y3QgdGVzdF9jYXNlX2Zs
YWdzX3Qgewo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBsb25nIGZsYWdzOwo+IEBAIC0yNDYsOSAr
MjQ2LDggQEAgc3RhdGljIHZvaWQgZG9fdGVzdCh1bnNpZ25lZCBpbnQgbnVtYmVyKQo+ICAgICAg
ICAgdHN0X3JlcyhUSU5GTywgIlRlc3QgY2FzZSAlZDogZmFub3RpZnlfaW5pdCglcywgT19SRE9O
TFkpIiwgbnVtYmVyLAo+ICAgICAgICAgICAgICAgICB0Yy0+aW5pdC5kZXNjKTsKPgo+IC0gICAg
ICAgaWYgKGZhbl9yZXBvcnRfdGFyZ2V0X2ZpZF91bnN1cHBvcnRlZCAmJiB0Yy0+aW5pdC5mbGFn
cyAmIEZBTl9SRVBPUlRfVEFSR0VUX0ZJRCkgewo+IC0gICAgICAgICAgICAgICBGQU5PVElGWV9J
TklUX0ZMQUdTX0VSUl9NU0coRkFOX1JFUE9SVF9UQVJHRVRfRklELAo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFuX3JlcG9ydF90YXJnZXRfZmlkX3Vuc3Vw
cG9ydGVkKTsKPiArICAgICAgIGlmICh0Yy0+aW5pdC5mbGFncyAmIH5zdXBwb3J0ZWRfaW5pdF9m
bGFncykgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAiVW5zdXBwb3J0ZWQgaW5p
dCBmbGFncyIKCnN1Z2dlc3QgdG8gcHJlc2VydmUgdGhlIGluZm9ybWF0aW9uIHByaW50ZWQgYnkK
RkFOT1RJRllfSU5JVF9GTEFHU19FUlJfTVNHLCB5b3UgY2FuIHVzZSB0Yy0+aW5pdC5kZXNjCnRo
ZSBmb3IgdGhlIGZsYWcgbmFtZSBzdHJpbmcuCgpPdGhlcndpc2UsIHlvdSBtYXkgYWRkOgoKUmV2
aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+CgoKCj4gICAgICAg
ICAgICAgICAgIHJldHVybjsKPiAgICAgICAgIH0KPgo+IEBAIC0zMTcsMTEgKzMxNiwxNSBAQCBv
dXQ6Cj4KPiAgc3RhdGljIHZvaWQgZG9fc2V0dXAodm9pZCkKPiAgewo+ICsgICAgICAgdW5zaWdu
ZWQgaW50IGFsbF9pbml0X2ZsYWdzID0gRkFOX1JFUE9SVF9ERklEX05BTUVfVEFSR0VUIHwKPiAr
ICAgICAgICAgICAgICAgRkFOX0NMQVNTX05PVElGIHwgRkFOX0NMQVNTX0NPTlRFTlQgfCBGQU5f
Q0xBU1NfUFJFX0NPTlRFTlQ7Cj4gKwo+ICAgICAgICAgLyogUmVxdWlyZSBGQU5fUkVQT1JUX0ZJ
RCBzdXBwb3J0IGZvciBhbGwgdGVzdHMgdG8gc2ltcGxpZnkgcGVyIHRlc3QgY2FzZSByZXF1aXJl
bWVudHMgKi8KPiAgICAgICAgIFJFUVVJUkVfRkFOT1RJRllfSU5JVF9GTEFHU19TVVBQT1JURURf
T05fRlMoRkFOX1JFUE9SVF9GSUQsIE1OVFBPSU5UKTsKPgo+IC0gICAgICAgZmFuX3JlcG9ydF90
YXJnZXRfZmlkX3Vuc3VwcG9ydGVkID0KPiAtICAgICAgICAgICAgICAgZmFub3RpZnlfaW5pdF9m
bGFnc19zdXBwb3J0ZWRfb25fZnMoRkFOX1JFUE9SVF9ERklEX05BTUVfVEFSR0VULCBNTlRQT0lO
VCk7Cj4gKyAgICAgICBzdXBwb3J0ZWRfaW5pdF9mbGFncyA9IGZhbm90aWZ5X2dldF9zdXBwb3J0
ZWRfaW5pdF9mbGFncyhhbGxfaW5pdF9mbGFncywKPiArICAgICAgICAgICAgICAgTU5UUE9JTlQp
Owo+ICsKPiAgICAgICAgIGlnbm9yZV9tYXJrX3Vuc3VwcG9ydGVkID0gZmFub3RpZnlfbWFya19z
dXBwb3J0ZWRfYnlfa2VybmVsKEZBTl9NQVJLX0lHTk9SRV9TVVJWKTsKPgo+ICAgICAgICAgLyog
Q3JlYXRlIHRlbXBvcmFyeSB0ZXN0IGZpbGUgdG8gcGxhY2UgbWFya3Mgb24gKi8KPiAtLQo+IDIu
NDIuMAo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
