Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2332C7EE33
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 09:57:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E1033CCB9F
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 11:57:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 131DF3CBB96
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 11:57:26 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0747A1400BCE
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 11:57:26 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ae0dffaa8b2so27504466b.0
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750931845; x=1751536645; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7jBCr5MZqaLmLDdD69Fv01V6uu7m4dupO4xr56uExw=;
 b=dUiVf/UoXSYcz6oWDdIUs+SMfFm5VuD9MZ9bwONHxhoJbd6SLz7t+cGsGc95BEy5Iz
 swg+caTVlv+7KTGKXuaMelpMxuVDfh88i9skSqqSMvURtkT3VIYrB0CHtOkrlqCLgs0Z
 2s54TgiIKoOYbjsq1T0S9P+6aqBT+3M9GSji7yxoihYA6Tc6/70CGe96qa+mr7eeuMAs
 DuiVvsjIeoZq/9FJHqYLS3oXEQxaryVm0VLBr7om02luuSp85re0YJwwEfGM4mzmeoxC
 No2uuuoQAGcvHKNWv6iXh5vS37B5fpNyWnXKwQ3o0K4pjM5sKotPkCLT/QNVvIpfIgX4
 s0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750931845; x=1751536645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/7jBCr5MZqaLmLDdD69Fv01V6uu7m4dupO4xr56uExw=;
 b=NxEOf9fs9DSPS7mxuLfeep/4W20heeyr47MRJH+Z6UtnVghRC3odxGWzNy5mJpHz/6
 d43DAOCLwm2ugigIgDm3pVqeNeczs5RX6nLDUe9t+19TIUPIMoL1E7dJuLNoOEh9zLXP
 OOJ1C8QDwnSdWSBdgTxshDsrWLq4Da0+xMx7Ou9i5b2vWWEVHiUDI+09Gt+QGHaZ/ve4
 eDrqaLPPOnE0yFtSbEH8Wt6//P7siF4idu60mG3hsZUdAtpnhz4Qs111TzfKDQJY9WWy
 8aqdaFsjYxnHfC8ehW0Zbe2AFaZplYAiuuMEKt5WEpT/KEf/V2ur8yA2NkEB7KRZ8LRR
 ZnbQ==
X-Gm-Message-State: AOJu0YwnxFpEfn9eDcV/LPLb5bzOUYUoUpXCXKMUrHv/jesmrf2Gxlt3
 NWkCSU2pYt2KHZJQ3rd0+Wzao7wlRRBxMIsQaELkgCfSAfx7pIfaLsn+6OX8CQK4TVChSnFv/mm
 Te+K2j4+Y5DAqhu09XIc6qoNqE4KbQ5I=
X-Gm-Gg: ASbGncsID9XAfTmDzvFXJxON06syyWNxqVdrUhZnbbnvuByYgTaJmK4N/NnPqknxjCQ
 RbGE5xHdKLgG411PxHxYNxYoXZmfn28KdIahNjU8UOdbKnPH54wObZzn2ux2z23WLJoh78GL8PD
 mVZH9x36mH+bIB+HN+yZY8Zz79/uakIK+xrv929Fkd6q7pdzCrYHevtA==
X-Google-Smtp-Source: AGHT+IHqVNAzo/SYvg+5aWaqbDFWj5obVs7H8dkhv8IDg3aaiUl9SM61Zk9afMLbdhzCa/5DF2NxXVMpCufIfEI54K8=
X-Received: by 2002:a17:906:a44b:b0:ad5:55db:e413 with SMTP id
 a640c23a62f3a-ae0be894206mr510831666b.26.1750931844899; Thu, 26 Jun 2025
 02:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com>
In-Reply-To: <CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Jun 2025 11:57:12 +0200
X-Gm-Features: Ac12FXy8P5m6Uq6DYd39S5vG5de_lMDYUsNQB3uoNHk8hKKBSM8JOIak9cK9zIM
Message-ID: <CAOQ4uxi9KjOx0JSakPYbsNaZj63nLiLzQE-_Hdq1H_MGrC8=6A@mail.gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>, Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
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

T24gVGh1LCBKdW4gMjYsIDIwMjUgYXQgOTowM+KAr0FNIE5hcmVzaCBLYW1ib2p1CjxuYXJlc2gu
a2FtYm9qdUBsaW5hcm8ub3JnPiB3cm90ZToKPgo+IFJlZ3Jlc3Npb24gaW4gdGhlIExUUCBzeXNj
YWxscy9mYW5vdGlmeTAxIHRlc3Qgb24gdGhlIExpbnV4IHN0YWJsZS1yYyA1LjQKPiBhbmQgNS4x
MCBrZXJuZWwgYWZ0ZXIgdXBncmFkaW5nIHRvIExUUCB2ZXJzaW9uIDIwMjUwNTMwLgo+Cj4gIC0g
VGhlIHRlc3QgcGFzc2VkIHdpdGggTFRQIHZlcnNpb24gMjAyNTAxMzAKPiAgLSBUaGUgdGVzdCBm
YWlscyB3aXRoIExUUCB2ZXJzaW9uIDIwMjUwNTMwCj4KPiBSZWdyZXNzaW9ucyBmb3VuZCBvbiBz
dGFibGUtcmMgNS40IGFuZCA1LjEwIExUUCBzeXNjYWxscyBmYW5vdGlmeTAxLmMKPiBmYW5vdGlm
eV9tYXJrIGV4cGVjdGVkIEVYREVWOiBFTk9ERVYgKDE5KQo+Cj4gUmVncmVzc2lvbiBBbmFseXNp
czoKPiAgLSBOZXcgcmVncmVzc2lvbj8gWWVzCj4gIC0gUmVwcm9kdWNpYmlsaXR5PyBZZXMKPgo+
IFRlc3QgcmVncmVzc2lvbjogc3RhYmxlLXJjIDUuNCBhbmQgNS4xMAo+Cj4gUmVwb3J0ZWQtYnk6
IExpbnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4KPgo+IGZh
bm90aWZ5MDEuYzozMzk6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAw
MSwKPiAweDAwMDAwMDA4LCAtMTAwLCAiLiIpIGV4cGVjdGVkIEVYREVWOiBFTk9ERVYgKDE5KQo+
Cj4gVGhlIHRlc3QgZXhwZWN0ZWQgZmFub3RpZnlfbWFyaygpIHRvIGZhaWwgd2l0aCBFWERFViwg
YnV0IHJlY2VpdmVkCj4gRU5PREVWIGluc3RlYWQuIFRoaXMgaW5kaWNhdGVzIGEgcG90ZW50aWFs
IG1pc21hdGNoIGJldHdlZW4gdXBkYXRlZAo+IExUUCB0ZXN0IGV4cGVjdGF0aW9ucyBhbmQgdGhl
IGJlaGF2aW9yIG9mIHRoZSA1LjQga2VybmVs4oCZcyBmYW5vdGlmeQo+IGltcGxlbWVudGF0aW9u
Lgo+CgpZYXAsIHRoYXQncyB0cnVlLgoKVGhlIGNoYW5nZSB0byBmYW5vdGlmeTAxOgoqIGRiMTk3
YjdiNSAtIGZhbm90aWZ5MDE6IGZpeCB0ZXN0IGZhaWx1cmUgd2hlbiBydW5uaW5nIHdpdGggbmZz
IFRNUERJUgoKRGVwZW5kcyBvbiB0aGlzIGtlcm5lbCBjaGFuZ2UgZnJvbSB2Ni44OgoqIDMwYWQx
OTM4MzI2YiAtIGZhbm90aWZ5OiBhbGxvdyAid2VhayIgZnNpZCB3aGVuIHdhdGNoaW5nIGEgc2lu
Z2xlIGZpbGVzeXN0ZW0KCldoaWNoIGZzIHR5cGUgaXMgeW91ciBMVFAgVE1QRElSPwoKQ2FuIHlv
dSBwbGVhc2UgdGVzdCB0aGlzIGZpeDoKCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkwMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFu
b3RpZnkvZmFub3RpZnkwMS5jCkBAIC0zNzQsNyArMzc0LDIxIEBAIHN0YXRpYyB2b2lkIHNldHVw
KHZvaWQpCiAgICAgICAgfQoKICAgICAgICBpZiAoZmFub3RpZnlfZmxhZ3Nfc3VwcG9ydGVkX29u
X2ZzKEZBTl9SRVBPUlRfRklELApGQU5fTUFSS19NT1VOVCwgRkFOX09QRU4sICIuIikpIHsKLSAg
ICAgICAgICAgICAgIGlub2RlX21hcmtfZmlkX3hkZXYgPSAoZXJybm8gPT0gRU5PREVWKSA/IEVY
REVWIDogZXJybm87CisgICAgICAgICAgICAgICBpbm9kZV9tYXJrX2ZpZF94ZGV2ID0gZXJybm87
CisgICAgICAgICAgICAgICBpZiAoaW5vZGVfbWFya19maWRfeGRldiA9PSBFTk9ERVYpIHsKKyAg
ICAgICAgICAgICAgICAgICAgICAgLyoKKyAgICAgICAgICAgICAgICAgICAgICAgICogVGhlIGZz
IG9uIFRNUERJUiBoYXMgemVybyBmc2lkLgorICAgICAgICAgICAgICAgICAgICAgICAgKiBPbiBr
ZXJuZWxzIDwgIHY2LjggYW4gaW5vZGUgbWFyayBmYWlscyB3aXRoIEVOT0RFVi4KKyAgICAgICAg
ICAgICAgICAgICAgICAgICogT24ga2VybmVscyA+PSB2Ni44IGFuIGlub2RlIG1hcmsgaXMgYWxs
b3dlZCBidXQgbXVsdGkKKyAgICAgICAgICAgICAgICAgICAgICAgICogZnMgaW5vZGUgbWFya3Mg
d2lsbCBmYWlsIHdpdGggRVhERVYuCisgICAgICAgICAgICAgICAgICAgICAgICAqIFNlZSBrZXJu
ZWwgY29tbWl0IDMwYWQxOTM4MzI2YgorICAgICAgICAgICAgICAgICAgICAgICAgKiAoImZhbm90
aWZ5OiBhbGxvdyAid2VhayIgZnNpZCB3aGVuIHdhdGNoaW5nCmEgc2luZ2xlIGZpbGVzeXN0ZW0i
KS4KKyAgICAgICAgICAgICAgICAgICAgICAgICovCisgICAgICAgICAgICAgICAgICAgICAgIGlm
CihmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoRkFOX1JFUE9SVF9GSUQsIEZBTl9NQVJL
X0lOT0RFLApGQU5fT1BFTiwgIi4iKSkKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bm9kZV9tYXJrX2ZpZF94ZGV2ID0gZXJybm87CisgICAgICAgICAgICAgICAgICAgICAgIGVsc2UK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbm9kZV9tYXJrX2ZpZF94ZGV2ID0gRVhE
RVY7CisgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPIHwgVEVS
Uk5PLCAiVE1QRElSIGRvZXMgbm90IHN1cHBvcnQKcmVwb3J0aW5nIGV2ZW50cyB3aXRoIGZpZCBm
cm9tIG11bHRpIGZzIik7CiAgICAgICAgfQogfQoKClRoYW5rcywKQW1pci4KCj4gVGVzdCBsb2cs
Cj4gLS0KPgo+IGZhbm90aWZ5MDEuYzo5NDogVElORk86IFRlc3QgIzM6IGlub2RlIG1hcmsgZXZl
bnRzIChGQU5fUkVQT1JUX0ZJRCkKPiBmYW5vdGlmeTAxLmM6MzAxOiBUUEFTUzogZ290IGV2ZW50
OiBtYXNrPTMxIHBpZD0yMzY0IGZkPS0xCj4gLi4uCj4gZmFub3RpZnkwMS5jOjMwMTogVFBBU1M6
IGdvdCBldmVudDogbWFzaz04IHBpZD0yMzY0IGZkPS0xCj4gZmFub3RpZnkwMS5jOjMzOTogVEZB
SUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLAo+IDB4MDAwMDAwMDgsIC0x
MDAsICIuIikgZXhwZWN0ZWQgRVhERVY6IEVOT0RFViAoMTkpCj4gZmFub3RpZnkwMS5jOjk0OiBU
SU5GTzogVGVzdCAjNDogbW91bnQgbWFyayBldmVudHMgKEZBTl9SRVBPUlRfRklEKQo+IGZhbm90
aWZ5MDEuYzozMDE6IFRQQVNTOiBnb3QgZXZlbnQ6IG1hc2s9MzEgcGlkPTIzNjQgZmQ9LTEKPiAu
Li4KPiBmYW5vdGlmeTAxLmM6MzAxOiBUUEFTUzogZ290IGV2ZW50OiBtYXNrPTggcGlkPTIzNjQg
ZmQ9LTEKPiBmYW5vdGlmeTAxLmM6MzM5OiBURkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnks
IDB4MDAwMDAwMDEsCj4gMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFWERFVjogRU5P
REVWICgxOSkKPiBmYW5vdGlmeTAxLmM6OTQ6IFRJTkZPOiBUZXN0ICM1OiBmaWxlc3lzdGVtIG1h
cmsgZXZlbnRzIChGQU5fUkVQT1JUX0ZJRCkKPiBmYW5vdGlmeTAxLmM6MzAxOiBUUEFTUzogZ290
IGV2ZW50OiBtYXNrPTMxIHBpZD0yMzY0IGZkPS0xCj4gLi4uCj4gZmFub3RpZnkwMS5jOjMwMTog
VFBBU1M6IGdvdCBldmVudDogbWFzaz04IHBpZD0yMzY0IGZkPS0xCj4gZmFub3RpZnkwMS5jOjMz
OTogVEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLAo+IDB4MDAwMDAw
MDgsIC0xMDAsICIuIikgZXhwZWN0ZWQgRVhERVY6IEVOT0RFViAoMTkpCj4KPgo+ICMjIFRlc3Qg
bG9ncwo+ICogQnVpbGQgZGV0YWlsczoKPiBodHRwczovL3JlZ3Jlc3Npb25zLmxpbmFyby5vcmcv
bGtmdC9saW51eC1zdGFibGUtcmMtbGludXgtNS40LnkvdjUuNC4yOTQtMjIzLWc3ZmYyZDMyMzYy
ZTQvbHRwLXN5c2NhbGxzL2Zhbm90aWZ5MDEvCj4gKiBCdWlsZCBkZXRhaWwgMjoKPiBodHRwczov
L3JlZ3Jlc3Npb25zLmxpbmFyby5vcmcvbGtmdC9saW51eC1zdGFibGUtcmMtbGludXgtNS4xMC55
L3Y1LjEwLjIzOC0zNTMtZzlkYzg0M2M2NmY2Zi9sdHAtc3lzY2FsbHMvZmFub3RpZnkwMS8KPiAq
IFRlc3QgbG9nOiBodHRwczovL3FhLXJlcG9ydHMubGluYXJvLm9yZy9hcGkvdGVzdHJ1bnMvMjg4
NTkzMTIvbG9nX2ZpbGUvCj4gKiBJc3N1ZTogaHR0cHM6Ly9yZWdyZXNzaW9ucy5saW5hcm8ub3Jn
Ly0va25vd24taXNzdWVzLzY2MDkvCj4gKiBUZXN0IExBVkEgam9iIDE6Cj4gaHR0cHM6Ly9sa2Z0
LnZhbGlkYXRpb24ubGluYXJvLm9yZy9zY2hlZHVsZXIvam9iLzgzMjkyNzgjTDI4NTcyCj4gKiBU
ZXN0IExBVkEgam9iIDI6Cj4gaHR0cHM6Ly9sa2Z0LnZhbGlkYXRpb24ubGluYXJvLm9yZy9zY2hl
ZHVsZXIvam9iLzgzMjY1MTgjTDI4NDkxCj4gKiBCdWlsZCBsaW5rOiBodHRwczovL3N0b3JhZ2Uu
dHV4c3VpdGUuY29tL3B1YmxpYy9saW5hcm8vbGtmdC9idWlsZHMvMnl4SEd2VmtWcGNiS3FQYWhT
S1JubElUblZTLwo+ICogQnVpbGQgY29uZmlnOgo+IGh0dHBzOi8vc3RvcmFnZS50dXhzdWl0ZS5j
b20vcHVibGljL2xpbmFyby9sa2Z0L2J1aWxkcy8yeXhIR3ZWa1ZwY2JLcVBhaFNLUm5sSVRuVlMv
YnpJbWFnZQo+Cj4KPiAtLQo+IExpbmFybyBMS0ZUCj4gaHR0cHM6Ly9sa2Z0LmxpbmFyby5vcmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
