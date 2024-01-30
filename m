Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919BDC47DDB
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 14:59:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E8CA3CF970
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 15:58:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 327A33C71C6
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 15:58:41 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 726746002C8
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 15:58:41 +0100 (CET)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-68c438fde8eso25950376d6.1
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 06:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706626720; x=1707231520; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWtRWwcmyih03Ag9nPi5dRm9AkE50nrgZ0tkN/exEXk=;
 b=HEMHzXjudDrH79uMprMnOnehfLi7QXgUTVcIL5HRYSSA9Kqr6TXHKa3ahEjVTbl77M
 Dh9dicREVYaYjrqrxlZMIrDWw4HSw/GWALQ6xP4zZq3mQhYoXWQLD7eRt3BJWyRZH3yg
 E1lhvAyJTKhrjtU+TQSR/xE8yAdFZ0/OzdoEtTWGM8KaWQIGnDHhpjoSkHp0KF1x5Nlp
 Qf8Tu9UsWCmIyjhTLOmRsqKJKKD7ucbxorFGtqoAqA4jDzzbEBKbk9hQM7sfk3Yp1ZFs
 GEXMXBsDwC7TWvh3zNaL+IJmlE+fO0KE4xfTJhnCN/IisSWALoLKyDx3M7zM2FEf6Va2
 M9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626720; x=1707231520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWtRWwcmyih03Ag9nPi5dRm9AkE50nrgZ0tkN/exEXk=;
 b=cfGgX2rcmjSZh8FPAc0xkG91+ZvPHp743FrxNq6Xx/0VsoioG1+HHIo3tae1DOW78o
 dbqwABqU9i/DAR52ZUqJMpn+bhG6kNy1QxS3W+3B18DAvEhCyzaqO5l2laf/UkHNzO+r
 FgqDgS1EOjCBf8i3EE2+Hv4dWlokvu0BMcdrXPjVijnPBQQdUKKs4+w6VxXnqlsWWKbH
 AmnqV0w5Fm2zi5LhiSlEHcqElbFvHaB5QXyEyZSWWAiY4pFOvSv8oAni3qP7czAD+/Hq
 DCOasJXLOGRSkC4IXsC1DxTbCKBVKa0Kuiz+iMcqZ6vPOQYwm7lYXZ7rRwSZlyO6xHTY
 NieA==
X-Gm-Message-State: AOJu0YyrCWdOFOtizHUoZcmrcBizS7vdv3ttQUzyA3uS5fphA3GFEzfw
 k5jxVVaF4C6a/sKsuQTc0oRwqrJqGOcRuiFkvDYfiJx20mhE0wuNzU+e8r4O+99yeic4Ye/c/oO
 0k5uHUg4bPFDNWUTl/Je/Ft/qixQ=
X-Google-Smtp-Source: AGHT+IGZES3U5dUHVZ4CIgWVwRFyd/zm0/K462/dOqTMZzCXeAIC6ReGJiBKwcrAz0lrHTVG41UPz+GzHJ2HOjqYxsI=
X-Received: by 2002:ad4:5ec7:0:b0:681:172f:a989 with SMTP id
 jm7-20020ad45ec7000000b00681172fa989mr8323687qvb.107.1706626720213; Tue, 30
 Jan 2024 06:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20240125110510.751445-1-amir73il@gmail.com>
 <20240130130712.GB778733@pevik>
In-Reply-To: <20240130130712.GB778733@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 30 Jan 2024 16:58:28 +0200
Message-ID: <CAOQ4uxi+0us5cq5BhoLoPDCbZgeqhtWiK4UCDV5HaZ+aZQwCLw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify01: Test setting two marks on different
 filesystems
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

T24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMzowN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEFtaXIsIEphbiwKPgo+IEkgd2FzIGdvaW5nIHRvIG1lcmdlLCBi
dXQgSSBzdXNwZWN0IHRoaXMgZG9lcyBub3Qgd29yayBvbiBUTVBESVIgb24gYnRyZnMuCj4KClRo
aXMgaXMgYSBwcm9ibGVtIGJlY2F1c2UgdGhlIHRlc3QgcmVzdWx0IGRlcGVuZHMgb24gdGhlIHR5
cGUgb2YgVE1QRElSLgpUaGUgZmFpbHVyZSBpbiB5b3VyIGNhc2UgaXMgYmVjYXVzZSBUTVBESVIg
aXMgbm90IG9ubHkgYnRyZnMsIGJ1dCBhCmJ0cmZzIHN1YnZvbC4KSmFuIGhhcyBkZWFsdCB3aXRo
IHNldmVyYWwgcmVsYXRlZCBmYW5vdGlmeSB0ZXN0cyBmYWlsdXJlcyBsYXRlbHkuCgo+IFRlc3Rl
ZCBvbiBTTEUgMTUtU1A2IChrZXJuZWwgNi40KSwgb24gMTUtU1A0IChrZXJuZWwgNS4xNCksIFR1
bWJsZXdlZWQgKGtlcm5lbAo+IDYuOC4wLXJjMSksIEFscGluZSBMaW51eCAoa2VybmVsIDYuNCkg
SSBnZXQ6Cj4KPiBmYW5vdGlmeTAxLmM6MzQxOiBURkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3Rp
ZnksIDB4MDAwMDAwMDEsIDB4MDAwMDAwMDgsIC0xMDAsICIuIikgZmFpbGVkOiBFWERFViAoMTgp
Cj4KPiBmb3IgdGVzdHMgIzMsICM0IGFuZCAjNSBvbiBhbGwgZmlsZXN5c3RlbXMuCj4KPiBUZXN0
aW5nIG9uIG90aGVyIG9uIG90aGVyIGZpbGVzeXN0ZW0gaXQgd29ya3M6IERlYmlhbiBrZXJuZWwg
NS4xMCwgNi4xIG9uIGV4dDQsCj4gQWxwaW5lIExpbnV4IGtlcm5lbCA2LjQgb24gdG1wZnMsIFR1
bWJsZXdlZWQga2VybmVsIDYuOC4wLXJjMSBvbiB0bXBmcy4KPgo+IFNob3VsZCBiZSBidHJmcyBo
YW5kbGVkIGRpZmZlcmVudGx5IG9yIHNraXBwZWQ/IChiZWxvdykKPiBPciB0ZXN0IEVYREVWIGZv
ciAjMywgIzQgYW5kICM1PyAobm90IHN1cmUgaG93IGhhbmRsZSBqdXN0IGhhbGYgb2YgdGhlIHRl
c3RzIG9uCj4gYnRyZnMgZGlmZmVyZW50bHkpLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+
IGRpZmYgLS1naXQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAx
LmMgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiBpbmRl
eCBiYTA5ZjMwOWQuLjk3YWRlMTgyOSAxMDA2NDQKPiAtLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiArKysgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKPiBAQCAtMzM1LDggKzMzNSwxNSBAQCBwYXNzOgo+ICAg
ICAgICAgICogZGlmZmVyZW50IGZpbGVzeXN0ZW1zIGFyZSBzdXBwb3J0ZWQuCj4gICAgICAgICAg
KiBXaGVuIHRlc3RlZCBmcyBoYXMgemVybyBmc2lkIChlLmcuIGZ1c2UpIGFuZCBldmVudHMgYXJl
IHJlcG9ydGVkCj4gICAgICAgICAgKiB3aXRoIGZzaWQrZmlkLCB3YXRjaGluZyBkaWZmZXJlbnQg
ZmlsZXN5c3RlbXMgaXMgbm90IHN1cHBvcnRlZC4KPiArICAgICAgICAqIE5vdCBzdXBwb3J0ZWQg
b24gQnRyZnMuCj4gICAgICAgICAgKi8KPiArICAgICAgIGlmICh0c3RfZnNfdHlwZSgiLiIpID09
IFRTVF9CVFJGU19NQUdJQykgewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAic2tp
cHBlZCBvbiBCdHJmcyIpOwo+ICsgICAgICAgICAgICAgICByZXR1cm47Cj4gKyAgICAgICB9Cj4g
KwoKTm90ZSB0aGF0IGJ0cmZzIGlzIG5vdCB0aGUgRlMgdW5kZXIgdGVzdC4gSXQgaXMgdGhlIEZT
IG9mIFRNUEZTLApzbyBldmVuIGlmIHlvdSBkaWQgc2tpcCwgdGhpcyBtZXNzYWdlIHdvdWxkIGhh
dmUgYmVlbiB3cm9uZy4KClBsZWFzZSB0cnkgdGhlIHBhdGNoIGJlbG93LgoKVGhhbmtzLApBbWly
LgoKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMK
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAxLmMKQEAg
LTM2NCwxMiArMzY0LDE5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAgICAgICAgbW91bnRf
bWFya19maWRfdW5zdXBwb3J0ZWQgPQpmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoRkFO
X1JFUE9SVF9GSUQsCgpGQU5fTUFSS19NT1VOVCwKCkZBTl9PUEVOLCBmbmFtZSk7Ci0gICAgICAg
LyogV2hlbiBtb3VudCBtYXJrIGlzIG5vdCBzdXBwb3J0ZWQgZHVlIHRvIHplcm8gZnNpZCwgbXVs
dGkgZnMKaW5vZGUgbWFya3MgYXJlIG5vdCBzdXBwb3J0ZWQgKi8KKyAgICAgICAvKgorICAgICAg
ICAqIFdoZW4gbW91bnQgbWFyayBpcyBub3Qgc3VwcG9ydGVkIGR1ZSB0byB6ZXJvIGZzaWQgKGUu
Zy4KZnVzZSkgb3IgaWYgVE1QRElSIGhhcyBub24tdW5pZm9ybQorICAgICAgICAqIGZzaWQgKGUu
Zy4gYnRyZnMgc3Vidm9sKSwgbXVsdGkgZnMgaW5vZGUgbWFya3MgYXJlIG5vdCBzdXBwb3J0ZWQu
CisgICAgICAgICovCiAgICAgICAgaWYgKG1vdW50X21hcmtfZmlkX3Vuc3VwcG9ydGVkICYmIGVy
cm5vID09IEVOT0RFVikgewogICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgImZpbGVzeXN0
ZW0gJXMgZG9lcyBub3Qgc3VwcG9ydApyZXBvcnRpbmcgZXZlbnRzIHdpdGggZmlkIGZyb20gbXVs
dGkgZnMiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9kZXZpY2UtPmZzX3R5
cGUpOwogICAgICAgICAgICAgICAgaW5vZGVfbWFya19maWRfeGRldiA9IEVYREVWOwogICAgICAg
IH0KKyAgICAgICBpZiAoZmFub3RpZnlfZmxhZ3Nfc3VwcG9ydGVkX29uX2ZzKEZBTl9SRVBPUlRf
RklELApGQU5fTUFSS19NT1VOVCwgRkFOX09QRU4sICIuIikpIHsKKyAgICAgICAgICAgICAgIGlu
b2RlX21hcmtfZmlkX3hkZXYgPSBlcnJubzsKKyAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8s
ICJUTVBESVIgZG9lcyBub3Qgc3VwcG9ydCByZXBvcnRpbmcKZXZlbnRzIHdpdGggZmlkIGZyb20g
bXVsdGkgZnMiKTsKKyAgICAgICB9CiB9CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
