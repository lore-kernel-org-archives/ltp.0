Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD97BC7EE32
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 11:21:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1B0B3CCB93
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 13:21:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 408963CB39B
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 13:20:48 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA2E21A00CD4
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 13:20:47 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0dd62f2adso69318266b.2
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750936847; x=1751541647; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YWGvZw6MV7GFdDBKi+dQLKYsveFoasqLGDzAcy79qPA=;
 b=dKJ1eB2k7qpEBP7LfJOUCdEqevnDE8E+BlVDOcT7M1lSzr5AScawcOiaKUZNjtEZYb
 sNCFh0cKBVKos7oUTAZzPXR6GpzfQFPKG2vf7fiTe5LLZMHEjQ83upBV08M9AkvRNOfR
 6IgTwY7CVfaXkw5G9neVRsuekixTLHdF78vh3vdwGzJLcFCo2myhY7a1Iq2IT688hi2k
 tHRTz0EfyPHnA/e4m/fGYEsr2yXHXv7IhXqlV0pCrnxlaDvzO+YarNWjCpnH+5pgbLRO
 lT3k1Jcdd+8SdKn/WoCYNJcNz9Uva03SbeKWVj+3BpSwSf9ISNDnhmJdlZxl3hcnGZC5
 xHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750936847; x=1751541647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YWGvZw6MV7GFdDBKi+dQLKYsveFoasqLGDzAcy79qPA=;
 b=MVxKKLSyFuBkyu0oUZK3LT+dLWb9n6GkUIr1UlRQ35/+Zd21GXSIZ2cDR1uQ3o9nGO
 KfqBAls0+AWL2idPAjPgWQGRLugQ7zDHKzPfX9UeGk4i/KHH2so2Ud8mq2NjI7wALbaE
 KOf7EYbVYT149YHt4S0ZR+jTQoM3vjOnIha9PlfjHuC6K/olm992qKAJSI+eqiuQJVsV
 uK5uE/+Huoiy198XLahVgIADqggCzYbDYI7T6SQKIHwhE2dDcCTrQ3VQ/7yOVQJJdHrE
 RCaztvgREcYSM0fdFJoC81gbPduhoKB3OizX1v4ApSvi/1KOWtRWfa34R1LYuzqw8+ri
 7frQ==
X-Gm-Message-State: AOJu0Yzz4fTF+j7UXfzSycttBJFs+6YEIwN7anjfa0sm8nsyfES/3GSy
 rB0e4p+xfHHAhsjesv6mitnUr1nsGQiWH3EMTP1POQ+U4AKsvcRTjJVACRSDNq+Km0TYY+wsodR
 nbBavVT7E7mLmTTYd6ZGjGroUl2nWf6/Ewxtt
X-Gm-Gg: ASbGncsLH9LdFiQ+Q2uWDicRGzjGVaw6tKYqw/xAiJF39iGKNd4FAt8W0F4itViEqM2
 Q7g6CeBrdtMsr1d1u1YG9DNcgFdqEDz8SEOW1k23mQ0htI33CvbSJX6DiOW7AfeVMl0yC4MVs1P
 unUnFgh5D7C7SkS8rzE699Ug2oKZglwf6dL+EX/uhRbq0=
X-Google-Smtp-Source: AGHT+IFGmfCKJbvnbGzZtBmpy8UpMv0Gaae1MPevBZvEmkYAT/3EHECmHFwUpqq1SojkVMOTp1DkNUFg1K1CE3Q+O6k=
X-Received: by 2002:a17:907:ba06:b0:ade:433c:6412 with SMTP id
 a640c23a62f3a-ae0be7fda14mr724079666b.3.1750936846702; Thu, 26 Jun 2025
 04:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com>
 <CAOQ4uxi9KjOx0JSakPYbsNaZj63nLiLzQE-_Hdq1H_MGrC8=6A@mail.gmail.com>
In-Reply-To: <CAOQ4uxi9KjOx0JSakPYbsNaZj63nLiLzQE-_Hdq1H_MGrC8=6A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Jun 2025 13:20:34 +0200
X-Gm-Features: Ac12FXxYyrb54qNUP16cQgT4q4pUUBMxVyyoX1vueeowLOsUWx2U9K5eznE3q9U
Message-ID: <CAOQ4uxhkZ989daUzNos3=7ucsOWx9bRd36gLppA7ttgbquWkeg@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] stable-rc: 5.4 and 5.10: fanotify01.c:339: TFAIL:
 fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100,
 ".") expected EXDEV: ENODEV (19)
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Jan Kara <jack@suse.cz>,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>,
 linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
 LTP List <ltp@lists.linux.it>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdW4gMjYsIDIwMjUgYXQgMTE6NTfigK9BTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIFRodSwgSnVuIDI2LCAyMDI1IGF0IDk6MDPigK9B
TSBOYXJlc2ggS2FtYm9qdQo+IDxuYXJlc2gua2FtYm9qdUBsaW5hcm8ub3JnPiB3cm90ZToKPiA+
Cj4gPiBSZWdyZXNzaW9uIGluIHRoZSBMVFAgc3lzY2FsbHMvZmFub3RpZnkwMSB0ZXN0IG9uIHRo
ZSBMaW51eCBzdGFibGUtcmMgNS40Cj4gPiBhbmQgNS4xMCBrZXJuZWwgYWZ0ZXIgdXBncmFkaW5n
IHRvIExUUCB2ZXJzaW9uIDIwMjUwNTMwLgo+ID4KPiA+ICAtIFRoZSB0ZXN0IHBhc3NlZCB3aXRo
IExUUCB2ZXJzaW9uIDIwMjUwMTMwCj4gPiAgLSBUaGUgdGVzdCBmYWlscyB3aXRoIExUUCB2ZXJz
aW9uIDIwMjUwNTMwCj4gPgo+ID4gUmVncmVzc2lvbnMgZm91bmQgb24gc3RhYmxlLXJjIDUuNCBh
bmQgNS4xMCBMVFAgc3lzY2FsbHMgZmFub3RpZnkwMS5jCj4gPiBmYW5vdGlmeV9tYXJrIGV4cGVj
dGVkIEVYREVWOiBFTk9ERVYgKDE5KQo+ID4KPiA+IFJlZ3Jlc3Npb24gQW5hbHlzaXM6Cj4gPiAg
LSBOZXcgcmVncmVzc2lvbj8gWWVzCj4gPiAgLSBSZXByb2R1Y2liaWxpdHk/IFllcwo+ID4KPiA+
IFRlc3QgcmVncmVzc2lvbjogc3RhYmxlLXJjIDUuNCBhbmQgNS4xMAo+ID4KPiA+IFJlcG9ydGVk
LWJ5OiBMaW51eCBLZXJuZWwgRnVuY3Rpb25hbCBUZXN0aW5nIDxsa2Z0QGxpbmFyby5vcmc+Cj4g
Pgo+ID4gZmFub3RpZnkwMS5jOjMzOTogVEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAw
eDAwMDAwMDAxLAo+ID4gMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFWERFVjogRU5P
REVWICgxOSkKPiA+Cj4gPiBUaGUgdGVzdCBleHBlY3RlZCBmYW5vdGlmeV9tYXJrKCkgdG8gZmFp
bCB3aXRoIEVYREVWLCBidXQgcmVjZWl2ZWQKPiA+IEVOT0RFViBpbnN0ZWFkLiBUaGlzIGluZGlj
YXRlcyBhIHBvdGVudGlhbCBtaXNtYXRjaCBiZXR3ZWVuIHVwZGF0ZWQKPiA+IExUUCB0ZXN0IGV4
cGVjdGF0aW9ucyBhbmQgdGhlIGJlaGF2aW9yIG9mIHRoZSA1LjQga2VybmVs4oCZcyBmYW5vdGlm
eQo+ID4gaW1wbGVtZW50YXRpb24uCj4gPgo+Cj4gWWFwLCB0aGF0J3MgdHJ1ZS4KPgo+IFRoZSBj
aGFuZ2UgdG8gZmFub3RpZnkwMToKPiAqIGRiMTk3YjdiNSAtIGZhbm90aWZ5MDE6IGZpeCB0ZXN0
IGZhaWx1cmUgd2hlbiBydW5uaW5nIHdpdGggbmZzIFRNUERJUgo+Cj4gRGVwZW5kcyBvbiB0aGlz
IGtlcm5lbCBjaGFuZ2UgZnJvbSB2Ni44Ogo+ICogMzBhZDE5MzgzMjZiIC0gZmFub3RpZnk6IGFs
bG93ICJ3ZWFrIiBmc2lkIHdoZW4gd2F0Y2hpbmcgYSBzaW5nbGUgZmlsZXN5c3RlbQo+Cj4gV2hp
Y2ggZnMgdHlwZSBpcyB5b3VyIExUUCBUTVBESVI/Cj4KPiBDYW4geW91IHBsZWFzZSB0ZXN0IHRo
aXMgZml4Ogo+Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5v
dGlmeTAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MDEuYwo+IEBAIC0zNzQsNyArMzc0LDIxIEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4g
ICAgICAgICB9Cj4KPiAgICAgICAgIGlmIChmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMo
RkFOX1JFUE9SVF9GSUQsCj4gRkFOX01BUktfTU9VTlQsIEZBTl9PUEVOLCAiLiIpKSB7Cj4gLSAg
ICAgICAgICAgICAgIGlub2RlX21hcmtfZmlkX3hkZXYgPSAoZXJybm8gPT0gRU5PREVWKSA/IEVY
REVWIDogZXJybm87Cj4gKyAgICAgICAgICAgICAgIGlub2RlX21hcmtfZmlkX3hkZXYgPSBlcnJu
bzsKPiArICAgICAgICAgICAgICAgaWYgKGlub2RlX21hcmtfZmlkX3hkZXYgPT0gRU5PREVWKSB7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgLyoKPiArICAgICAgICAgICAgICAgICAgICAgICAg
KiBUaGUgZnMgb24gVE1QRElSIGhhcyB6ZXJvIGZzaWQuCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICogT24ga2VybmVscyA8ICB2Ni44IGFuIGlub2RlIG1hcmsgZmFpbHMgd2l0aCBFTk9ERVYu
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogT24ga2VybmVscyA+PSB2Ni44IGFuIGlub2Rl
IG1hcmsgaXMgYWxsb3dlZCBidXQgbXVsdGkKPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBm
cyBpbm9kZSBtYXJrcyB3aWxsIGZhaWwgd2l0aCBFWERFVi4KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgKiBTZWUga2VybmVsIGNvbW1pdCAzMGFkMTkzODMyNmIKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgKiAoImZhbm90aWZ5OiBhbGxvdyAid2VhayIgZnNpZCB3aGVuIHdhdGNoaW5nCj4g
YSBzaW5nbGUgZmlsZXN5c3RlbSIpLgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqLwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmCj4gKGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9m
cyhGQU5fUkVQT1JUX0ZJRCwgRkFOX01BUktfSU5PREUsCj4gRkFOX09QRU4sICIuIikpCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbm9kZV9tYXJrX2ZpZF94ZGV2ID0gZXJybm87
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZWxzZQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5vZGVfbWFya19maWRfeGRldiA9IEVYREVWOwo+ICsgICAgICAgICAgICAgICB9
Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8gfCBURVJSTk8sICJUTVBESVIgZG9lcyBu
b3Qgc3VwcG9ydAo+IHJlcG9ydGluZyBldmVudHMgd2l0aCBmaWQgZnJvbSBtdWx0aSBmcyIpOwo+
ICAgICAgICAgfQo+ICB9Cj4KPgoKUGxlYXNlIHRlc3QgdGhlIGF0dGFjaGVkIHBhdGNoIGluc3Rl
YWQuCkl0IGlzIHNpbXBsZXIgYW5kIG1vcmUgY29ycmVjdCBpbiBzb21lIGNvbmZpZ3VyYXRpb25z
LgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
