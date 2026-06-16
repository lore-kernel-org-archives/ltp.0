Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240FCCD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:39:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DA63E5995
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 13:39:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D380B3C19F0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:39:14 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 564801000A45
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:39:14 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bebb72b845aso755462766b.3
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781609954; cv=none;
 d=google.com; s=arc-20240605;
 b=O+CORoffGTPm6ibxUoietHJzJdlufnUWTppoqp5t9fxFrvKOM2W5imOdvt/74BgOlz
 JALVAp3oxqPq8hgtMl7Dk8PQ4y25FWRXnHVRlzrJL0XtEk8qcykyTVG9PJ6FVRL27uMP
 Ewdm8V3A6dq5fRZ4iex87GqzfjzN2dVfJUwF8ve1tewr06mpi/FQdiuY3Dq5TOQ2cDod
 xN09d7aPFWEPvDBsTSpeKwd1EkV9CXYAuPJK9jvrhGawutB4/7Rkb4AS0Ghtk4ACjgSz
 nsV7AKfJM66yKxfR5s2MPsdr2GwfFMUF8YsyLBSN9c9qq9Adp98ZuO1NiEsn/tbnPWzy
 ZnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GuMTJNv2LKYSrGThDBL/srt41lSW/YIpfKQFOWf956o=;
 fh=XmhRV9Kg10EPs0EzmghYa+aEB4kOuHorngG7UAiQsCs=;
 b=PbBlrCMg0Mz251DEsv7u2P4SoJX1rFEniCXMuUMKMSbiCapld8oleaJ8s1frMtdGDe
 K+2VO1Wersr7ySpbGZWEj3IKumyW9nXFbryS3suI5ics7u8zpWUmkJZLY1Pil2mZ9h+a
 1UWONXJDaQFROxycWuBYJ17KZUI26HIZ7lG60/E84FdMBXfWfgyRqc4pdI3eLt12HrrX
 cQq13C+oWRiGZglkfBPesQApCBFGSzN/YuuWdtgepZ9aEvCUKOG5Fz0DaxT+Of0WEDTG
 N40kFFOaZjaOMBI3R20nwlEp68Aat6iW8cpGfIfG/CJYaG0TUPkyMbdYw3ESqRqnXQDC
 KjSw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781609954; x=1782214754; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuMTJNv2LKYSrGThDBL/srt41lSW/YIpfKQFOWf956o=;
 b=VKog9bTOv4ZvbR03LAISy8lHLA9z3OftudipUaHwuIucXJmH2UiIsUlAzENrf0hX0o
 R9Vt3HJNSZDHel/vUbsTe5tZulX3Fk+kp/ORV4L8FoNVRJLI9o3wK9wNZxbkBbS6cjpP
 rzdyc4uP1kwyvqQ/qIIwcRjtQUVOOVEBbaJdgCiPFIH6LghBM44QBW8CP0Mr6qnbaTsw
 PyjNYhCQOUN58yNSjugxvlMdm73TErkTLb7Py7vnFfvRpYz0Mv4Ain1iRyHdWYrWgNkP
 oV/hDe5iCHb/XHwtC7QWjb1ZbCW0PRQtgYQvw2ltG/V2AtH47df/SsIlpPKWPo8SkeDL
 pvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781609954; x=1782214754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GuMTJNv2LKYSrGThDBL/srt41lSW/YIpfKQFOWf956o=;
 b=CU+ejzptGmgKDhtfP+HEdALr+5FSsEkrV/qbOW8VZUaEKn3jFX9Kx7a0g8x8m6cggq
 2bhjWZdnyQbLWH6Uw9f41P5NsxVGDq4AGdCDAQX/pR028nFyUi5qpoBt5W6QmKeCjDmf
 eJppTxj42G70cFib6+NW/BYZ0f7yAgQwflGtj8SPG/EFgj6Zec/b/8Bo8EukPmkOwPfn
 4gX24lCnZwHC6cyxvamclq+Pcy/E6dmxun88zeQHGK4UPynfcx6yYzmaicGOzSbHuriJ
 e2d3gcOMhnpL10LPc2+KPGcfYXSSZt3MGj3lttvBL8SXeXryMGwY10t9ORMUItxsh44M
 HL0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ZYBn6u1SArBX7Q5jtS4HvT1jOvecHEd1aWiVN7X2vPTSx9VX3JKrMMGxKsI45u5kfPVA=@lists.linux.it
X-Gm-Message-State: AOJu0YzxksHV9tdfVtN7cUelhJXzrTuBQ3dMJM3glQxSy7v3prMthiFH
 bF/LKn2wW/CjgzHFG/z2usLQ7ieMBXk/Wll0u7zsnsxumnf3Ivxwot7ImUXv49air59b66LgUoX
 Xh7Tgg9et9R28QQ8j3fsOMicq9o1L3Lk=
X-Gm-Gg: Acq92OFYCFhxAG6KX3Esyxtq9MjlWUZ8fXeutQKEtg8CR8pCV7gFWQgqz5UgHdjZM5w
 lLsQSAaNzPP1ujb4d87YxO6dTYgHbDVOBU/gIP0FFNjkqZ7jlxg4gvtWaN68OxGlbX3IzwSTgRS
 7DB8Ncdlx1wJfiPrPaGVE2ri83j1VU4Nn7h7QoCfdHRreVV/WJ8VQqCY6KsdDqnU7wDWZwB/M/2
 qDOxNPbDoD5awBH5yUhTQX+SXmHne7qub7r/MqJhPvGI9hHuivBK7oS/ngvPMC5Ahq3Kgnq5qXU
 RhVsNwumRvM8ucyH0opznR96dp3BRlB4pV4T7ZEcq0kj2LUWfvZB
X-Received: by 2002:a17:907:75eb:b0:bdd:378:3f2a with SMTP id
 a640c23a62f3a-c043d7b4fe9mr119999566b.38.1781609953233; Tue, 16 Jun 2026
 04:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
In-Reply-To: <20260615180629.7148-1-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jun 2026 13:39:01 +0200
X-Gm-Features: AVVi8CcIW2NM7UMNpQleIyOPSVLP2nlMHoKUTLQ7U8MoklmwzMUnkaMkT5Q73cs
Message-ID: <CAOQ4uxj5bU7m11O4YUBKrph5Ok4XZe8YQ6WtxH4WQxXp1DvRxA@mail.gmail.com>
To: AnonymeMeow <anonymemeow@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] fanotify: update pidfd tests for
 FAN_REPORT_TID
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
Cc: jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTUsIDIwMjYgYXQgODowNuKAr1BNIEFub255bWVNZW93IDxhbm9ueW1lbWVv
d0BnbWFpbC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBzZXQgdXBkYXRlcyBmYW5vdGlmeSBw
aWRmZCB0ZXN0cyBmb3IgdGhlIGtlcm5lbCBjaGFuZ2UgdGhhdAo+IGFkZHMgRkFOX1JFUE9SVF9Q
SURGRCBzdXBwb3J0IHRvZ2V0aGVyIHdpdGggRkFOX1JFUE9SVF9USUQuCj4KPiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjYwNjA3MDAzMzQzLjQyNTkzOS0xLWFub255bWVt
ZW93QGdtYWlsLmNvbS8KPgo+IC0tLQo+Cj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBJIGFj
Y2lkZW50YWxseSBicm9rZSBteSBzeXN0ZW0gbGFzdCB3ZWVrLAo+IHNvIEkgd2FzIGJ1c3kgcmVw
YWlyaW5nIGl0LiBBbmQgSSBtYXkgbm90IGJlIGFibGUgdG8gcmVzcG9uZCBpbiB0aW1lCj4gZHVl
IHRvIGZpbmFsIGV4YW1zIHRoaXMgd2Vlaywgc29ycnkuCj4KCkdyZWF0IHNlcmllcy4gTmljZSBq
b2IhCgpJIGFtIGdsYWQgdGhhdCB5b3UgbWFuYWdlZCB0byBzYWx2YWdlIHRoZSB2YXJpYW50cyBp
ZGVhCmFuZCBtYWRlIHRoZSB0ZXN0IGJldHRlciBvbiB0aGUgd2F5LgoKRmVlbCBmcmVlIHRvIGFk
ZCB0byB0aGUgc2VyaWVzOgpSZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdt
YWlsLmNvbT4KCihubyBuZWVkIHRvIHJlcG9zdCBmb3IgYWRkaW5nIFJWQiBvbmx5IGlmIHJlcG9z
dGluZyBmb3IgYW5vdGhlciByZWFzb24pCgpUaGFua3MhCkFtaXIuCgo+IC0tLQo+Cj4gQW5vbnlt
ZU1lb3cgKDUpOgo+ICAgZmFub3RpZnkyMDogQWxsb3cgRkFOX1JFUE9SVF9QSURGRCB3aXRoIEZB
Tl9SRVBPUlRfVElEIG9uIHY3LjIrCj4gICBmYW5vdGlmeTIxOiBTdG9wIHJlbHlpbmcgb24gZXhp
dGVkIGNoaWxkIGZvciBwaWRmZCBlcnJvcgo+ICAgZmFub3RpZnkyMTogU2ltcGxpZnkgcmVhZF9w
aWRmZF9mZGluZm8oKQo+ICAgZmFub3RpZnkyMTogQWRkIHRlc3QgdmFyaWFudHMgZm9yIEZBTl9S
RVBPUlRfVElECj4gICBmYW5vdGlmeTIxOiBBZGQgRkFOX1JFUE9SVF9USUQgcGlkZmQgY292ZXJh
Z2UKPgo+ICBpbmNsdWRlL2xhcGkvcGlkZmQuaCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDQgKwo+ICAuLi4va2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjAuYyAgICAgfCAg
MTkgKy0KPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIxLmMgICAgIHwg
MTkxICsrKysrKysrKysrLS0tLS0tLQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEzNiBpbnNlcnRpb25z
KCspLCA3OCBkZWxldGlvbnMoLSkKPgo+IC0tCj4gMi41NC4wCj4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
