Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81E8CD5BB1
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 11:20:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DC143D9D19
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 13:20:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218033CB8CB
 for <ltp@lists.linux.it>; Sat, 23 May 2026 13:19:52 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC8FC14004E1
 for <ltp@lists.linux.it>; Sat, 23 May 2026 13:19:51 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-30455f77e0eso1565403eec.0
 for <ltp@lists.linux.it>; Sat, 23 May 2026 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779535190; x=1780139990; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWdQa/S+A5LLhJP3+aaZZzlCqzW7DEZYqXe8dZpxXew=;
 b=blZw8sMUZWS0rMdZQuSEmmb9XN08IIuqBzWrhZx/AHH4MwwURLS9WoQOXaZw9pEzMA
 xzXMUmT+BrPEnCqrbVe7VR673aplF7NRW7slR0U83uFvIzW796fnJyHyt/OtLIdWzKuk
 ZjuiMxuo0RZ+5/bplRBkX/e01uThd6kZUk251YdWFDs6teeDFPnxpLOr0/n4aFB5VCNZ
 6GujllTniUM/SUa19ZOdnAA2DJPOj4pE/QFQQJc8zTpuTMca/8s3GXKCac+D8xMlemSn
 5pvDVqV3rtXO5uFxR+km91T5lnW/Mji6QsYWIMQXpQ/bVmcHsvYkN/xl3ROAS/01KxRk
 J8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779535190; x=1780139990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oWdQa/S+A5LLhJP3+aaZZzlCqzW7DEZYqXe8dZpxXew=;
 b=OlyoxFzrbEc5vWufI8yqX2JKgaFN68df411I8nbLfkOXE1r2LO9goVAPgTuNe2LACQ
 vbT5RxsH6Y+4TY7cTg+N0A7zEVwhKkmNfIvvkxB4WWsewup1PN7wkoTRAosaqPFm1BSq
 sGJqwQJ0nCSxvDqpGG3XiCFD2wAUlS5o/145/GaB5C0CHpzqTfZSioqmGaHnTivDwIUS
 8TUNa0q/ad50U2ekD9AYaHDuksDhVoF57vtWZGO5imZ8XHKYaeCw2uO1goyUSJarE6zI
 NGse7sNCnsbVlbe5+8WUq68lKNcSCSVdLmZX+rLt2HjgyB4H/Oz3DgGVswa8woLWnbOM
 U86w==
X-Gm-Message-State: AOJu0YzS+EqrKzAcvkJcDqZHW0QdQ7HxoU8tcV/s9CgSrL0YWkStT93Z
 bCGieH/RFxNA3ShNWluKCOh1vFmd5sY1ANjLgAFgaggGXjVWPYAXellf
X-Gm-Gg: Acq92OGfj4kaH/6+ITZjeEv4nxNu1dartZ9WstxCQCtgB/0N96MOR81W6+TsKeG4WOk
 ke1e+hsLIcIsM4E0JJDuCCzyrFStoTdPnQ+okaz3ojXAwAeJSwVZbJ1v3uxVYMiO4ALXdiZ2nvq
 UGAbpXW7TT7j59yMm8eoW4a5O5W9jaShdn4alp8fDxjEd/8QfA0iHg2H5EjE2qUyGL5m4GYhihK
 XI9x0Wn01izUk7LkEeta3cSwANjKXr9/AMjGyTbTZDF17dFnwNDFpUNAMceWCPx4sybiFP/DqK9
 TTlC2Bb96xsIoYoSMHqLgLcttznWxxCV3eq8N+F5mPCnh206FlA9LrdFceaauv3iH8Lze4vV3CU
 4aBRGX0PcCteuPIvlTQL8FlEhDIEZKwQL6mgzeJwZ12De5Lstm5ZAThbz0VPOZJmQAnyHZBppjq
 RfS+z1BKVpJgoaV/SjZr0ektqn144RZ00W7+Q3k0/Ddr9RbYfYq5bFhkYkCZVxhYeZRP1+/WuTJ
 cvChU0gNILPJoByGHIIFhRGa6UNGjuJDR5VgJxy
X-Received: by 2002:a05:7300:ad06:b0:2c8:6361:ab2e with SMTP id
 5a478bee46e88-3044905b650mr3558544eec.8.1779535189920; 
 Sat, 23 May 2026 04:19:49 -0700 (PDT)
Received: from
 runnervmg397c.fs5dalhgbbmu5furubqachm4gc.yx.internal.cloudapp.net
 ([57.151.136.167]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452461cb5sm4292585eec.31.2026.05.23.04.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 04:19:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Sat, 23 May 2026 11:19:48 +0000
Message-ID: <20260523111948.4053-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523101749.27657-1-sebastian.chlad@suse.com>
References: <20260523101749.27657-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring/pintheft: Add CVE-2026-43494 regression test
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

SGkgU2ViYXN0aWFuLAoKT24gU2F0LCAyMyBNYXkgMjAyNiwgU2ViYXN0aWFuIENobGFkIHdyb3Rl
Ogo+IGlvX3VyaW5nL3BpbnRoZWZ0OiBBZGQgQ1ZFLTIwMjYtNDM0OTQgcmVncmVzc2lvbiB0ZXN0
CgpUaGUgY29tbWl0IGF1dGhvciBhZGRyZXNzIChzZWJhc3RpYW5jaGxhZEBnbWFpbC5jb20pIGRv
ZXMgbm90IG1hdGNoIHRoZQpTaWduZWQtb2ZmLWJ5IGFkZHJlc3MgKHNlYmFzdGlhbi5jaGxhZEBz
dXNlLmNvbSkuICBFaXRoZXIgYWRkIGEgLm1haWxtYXAKZW50cnkgb3IgcmUtc2VuZCB3aXRoIGEg
Y29uc2lzdGVudCBpZGVudGl0eS4KCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9pb191cmlu
Zy5oIGIvaW5jbHVkZS9sYXBpL2lvX3VyaW5nLmgKPiBbLi4uXQo+ICsjaWZuZGVmIElPUklOR19S
RUdJU1RFUl9DTE9ORV9CVUZGRVJTCj4gKyMgZGVmaW5lIElPUklOR19SRUdJU1RFUl9DTE9ORV9C
VUZGRVJTIDMwCj4gKyNlbmRpZgoKVXNlIGAjZGVmaW5lYCB3aXRob3V0IHRoZSBleHRyYSBzcGFj
ZSBhZnRlciBgI2AuICBBbGwgb3RoZXIgZmFsbGJhY2sKZGVmaW5lcyBpbiB0aGlzIGZpbGUgdXNl
IGAjZGVmaW5lYCwgbm90IGAjIGRlZmluZWAuCgo+IGRpZmYgLS1naXQgYS9ydW50ZXN0L2N2ZSBi
L3J1bnRlc3QvY3ZlCj4gWy4uLl0KPiArY3ZlLTIwMjYtNDM0OTQgcGludGhlZnQKCldyb25nIHBs
YWNlbWVudC4gIFRoZSBuZXcgZW50cnkgbGFuZHMgYmV0d2VlbiBgY3ZlLTIwMjItMjU5MGAgYW5k
CmBjdmUtMjAyMi0yMzIyMmAsIGluIHRoZSBtaWRkbGUgb2YgdGhlIDIwMjIgYmxvY2suCgpUaGUg
cGludGhlZnQgdGVzdCBjYW4gY3Jhc2gsIHRhaW50LCBvciBwYW5pYyBhIHZ1bG5lcmFibGUga2Vy
bmVsCigiVnVsbmVyYWJsZSBrZXJuZWxzIG1heSBjcmFzaCwgdGFpbnQsIHBhbmljLCBvciBoYW5n
IGR1cmluZyBzZW5kbXNnKCkKb3Igc3Vic2VxdWVudCBjbGVhbnVwLiIpLiAgSXQgYmVsb25ncyBp
biB0aGUgc2VjdGlvbiBiZWxvdyB0aGUKIlRlc3RzIGJlbG93IG1heSBjYXVzZSBrZXJuZWwgbWVt
b3J5IGxlYWsiIGNvbW1lbnQsIGluIENWRS1udW1iZXIgb3JkZXI6CgpgYGAKIGN2ZS0yMDI2LTQz
Mjg0IHhmcm0wMQorY3ZlLTIwMjYtNDM0OTQgcGludGhlZnQKIGN2ZS0yMDI2LTQ2MzAwIHhmcm0w
MgpgYGAKClsuLi5dCgpUaGUgdGVzdCBsb2dpYyBpdHNlbGYgbG9va3MgY29ycmVjdDogdGhlIGNo
aWxkIHRyaWdnZXJzIHRoZSBkb3VibGUtZHJvcAp2aWEgdGhlIElPUklOR19VTlJFR0lTVEVSX0JV
RkZFUlMgcGF0aCwgdGhlIHBhcmVudCBtb25pdG9ycyBmb3IgdGFpbnQKYWNyb3NzIHRoZSBSU1Mg
YWNjb3VudGluZyBzd2VlcCBhbmQgdGhlIDMwLXNlY29uZCBhc3luYyBjbGVhbnVwIHdpbmRvdywK
YW5kIGFsbCByZXNvdXJjZXMgYXJlIHByb3Blcmx5IGd1YXJkZWQgaW4gY2xlYW51cCgpLiAgS2Vy
bmVsIHZlcnNpb24KY2hlY2tzIChpb191cmluZyDiiaUgNS4xLCBSRFMvVENQIFRDT05GIGhhbmRs
aW5nLCBpb191cmluZ19kaXNhYmxlZApzYXZlL3Jlc3RvcmUpIGFyZSBpbiBvcmRlci4gIEJhc2Vk
IG9uIGtlcm5lbCA3LjEgYXMgdGhlIGN1cnJlbnQgc3RhYmxlCnJlZmVyZW5jZSwgbm8gc3RhZ2lu
ZyBmbGFnIGlzIHJlcXVpcmVkLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSBy
ZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiAoUkVW
SUVXX1VSTCBub3Qgc2V0KQoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBw
b3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3Ug
ZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9y
IGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
