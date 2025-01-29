Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31960C0218D
	for <ltp@archiver.kernel.org>; Wed, 29 Jan 2025 21:42:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 241293C6F9F
	for <ltp@archiver.kernel.org>; Wed, 29 Jan 2025 22:42:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B36A3C2A49
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 22:42:24 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3CA4617D1E
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 22:42:22 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so87133f8f.1
 for <ltp@lists.linux.it>; Wed, 29 Jan 2025 13:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738186942; x=1738791742; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rr8sxsKiF/lU9vsbhVl5SmziNEiI8NAifs0lNyPeKH4=;
 b=fwY+rPMK/uqBww+js1/uZSGyKoqQIDDzXiwIi08JZOQOMCJB0mH88+zF9NRFZqxChE
 n0oDcCphz+LJHsOeDtSQxUCvdo8WuUSRXeYhjGrnR5IDow3FgVYXD4DuAWlpM2tjd9kP
 mMGJXCnwNHlWTJDir4wzIK/ox/bLQhwT7YKQVTxK71NLUr1oJnqGrHGxvnJfR5FX6m23
 lFM1njZ+WOoOdGngc5BwHOxm3Q7MOwrEfQo1xzt1wHVhcnAGKqBSyli6M9kQM8JVzulq
 BUukrcJcY+D4g0OgIoV13W3ZFrxn5U6IC4vlA22Gs1+7mZ59EAtoz0jOpV9uWg89AiVh
 KOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738186942; x=1738791742;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rr8sxsKiF/lU9vsbhVl5SmziNEiI8NAifs0lNyPeKH4=;
 b=kPBF4cH+VFTseiTENVnZCgAgyWoirXP1CuEope0mwW6lnNRbbAAOV0Mx+dDh47Yyc0
 2spvUwr+4J5tlqG7f0GXzzEnhB/SFJFccXZWV/384o3dS9va6mbKr+Ycdcbg1KZVrluh
 ZN0YFQU6fN1oWJ63Ny+i5m+yJ5qurHa/rpE3zvsWO4NmTECpE4WCAH5KKcH7Pwaj235c
 I2cv1u+v4C3yuQRU2qHSialx0qUXh0m1KCkN7fY6+47suqLzKzkYV9hUdw0JMxuzMUcN
 L48u/sCdRVlYOxS6YO3IISVW7JBNVNvwHk77FxISjP4I/xe0jp/Kpq/8u/kvJ2dtU3La
 s4PA==
X-Gm-Message-State: AOJu0YxoRCMBU1FUCF5GCh1MTTNVfJF/fp+NnSZLfcBVJe16Gfu7/1Eo
 oEqNIAGryoeWSSrefidq9tGawfb742EnSTXLTIZW3sTtZtRwYuNx
X-Gm-Gg: ASbGnct6e1zXRBSxPkX2Yftic7aYiOfi4CIrfp24iCQLXP2mIc1p89qBySdbzpH4sph
 4//OyLRYa1SjWXedF3QV936yHAtsFbX/z8gM2LBKW8+I2ytjWXvE07takHPiFf7XvF9/sdvyCLz
 ANOOBATR1YgwZGCM0qsQCkERmz84e2PlHKBG2LpLriSoWFPnSffwFBcL6cCdD4nSjkCyDEttF55
 Noz/MYDPpcw6z0dGXFEDfip1dpBG0l3ZZuA/FQaH3/5ReYUu+sL2fX11Obm8I7+3RfZNEwk3aoY
 OBGkEO4Hr5CgYCFnSHFg
X-Google-Smtp-Source: AGHT+IFoSi4pQyWa540ZMOoVaZElt7UULsPNO8T5++ktbSr6E6fWptQOWZVXTTTpG3iQKBnwCrQDqw==
X-Received: by 2002:a5d:6489:0:b0:38c:246f:b0b3 with SMTP id
 ffacd0b85a97d-38c52097871mr4094679f8f.51.1738186941922; 
 Wed, 29 Jan 2025 13:42:21 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0eccc3sm3189f8f.18.2025.01.29.13.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 13:42:21 -0800 (PST)
Date: Wed, 29 Jan 2025 22:42:19 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: buildroot@buildroot.org
Message-ID: <20250129214219.GA447474@pevik>
References: <20240226155137.25523-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240226155137.25523-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl02: Use correct termios structure
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
 James Hilliard <james.hilliard1@gmail.com>, Mike Gilbert <floppym@gentoo.org>,
 ltp@lists.linux.it, sparclinux@vger.kernel.org,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKRllJIHRoaXMgTFRQIGNvbW1pdCBtZXJnZWQgYXMgNjk3YTA2YTgyNyBbMV0gd2hp
Y2ggaXMgbmVlZGVkIHRvIGZpeCBpb2N0bDAyLmMKdGVzdCBvbiBwcGM2NGxlIG9uIGFsbCBrZXJu
ZWwgdmVyc2lvbnMgYnJlYWtzIGNvbXBpbGF0aW9uIG9uIEJ1aWxkcm9vdApib290bGluLXNwYXJj
NjQtZ2xpYmMgdG9vbGNoYWluIChnY2M6IDEzLjMuMCwga2VybmVsIGhlYWRlcnM6IDQuMTkuMjU1
LCBnbGliYzogMi4zOSk6CgoJSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGJyLXRlc3QtcGtnL2Jvb3Rs
aW4tc3BhcmM2NC1nbGliYy9ob3N0L3NwYXJjNjQtYnVpbGRyb290LWxpbnV4LWdudS9zeXNyb290
L3Vzci9pbmNsdWRlL3N5cy9pb2N0bC5oOjI5LAoJCQkJCSBmcm9tIC4uLy4uLy4uLy4uL2luY2x1
ZGUvbGFwaS9pb2N0bC5oOjExLAoJCQkJCSBmcm9tIGlvY3RsMDIuYzozMToKCWJyLXRlc3QtcGtn
L2Jvb3RsaW4tc3BhcmM2NC1nbGliYy9ob3N0L3NwYXJjNjQtYnVpbGRyb290LWxpbnV4LWdudS9z
eXNyb290L3Vzci9pbmNsdWRlL2JpdHMvaW9jdGwtdHlwZXMuaDozNjo4OiBlcnJvcjogcmVkZWZp
bml0aW9uIG9mIOKAmHN0cnVjdCB0ZXJtaW/igJkKCSAgIDM2IHwgc3RydWN0IHRlcm1pbwoJCSAg
fCAgICAgICAgXn5+fn5+CglJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW9jdGwwMi5jOjI5OgoJYnIt
dGVzdC1wa2cvYm9vdGxpbi1zcGFyYzY0LWdsaWJjL2hvc3Qvc3BhcmM2NC1idWlsZHJvb3QtbGlu
dXgtZ251L3N5c3Jvb3QvdXNyL2luY2x1ZGUvYXNtL3Rlcm1iaXRzLmg6MTc6ODogbm90ZTogb3Jp
Z2luYWxseSBkZWZpbmVkIGhlcmUKCSAgIDE3IHwgc3RydWN0IHRlcm1pbyB7CgpUaGUgcHJvYmxl
bSBpcyB3aXRoIGtlcm5lbCA8YXNtL3Rlcm1iaXRzLmg+IGluY29tcGF0aWJpbGl0eSB3aXRoIGds
aWJjCjxiaXRzL2lvY3RsLXR5cGVzLmg+IGluY2x1ZGVkIHZpYSA8c3lzL2lvY3RsLmg+IHdoaWNo
IGlzIG5lZWRlZCBieSBpb2N0bDAyLmMKYW5kIGFsc28gYnkgTFRQIGxpYnJhcnkgaW5jbHVkZS9z
YWZlX21hY3Jvc19mbi5oLgoKVGhpcyBwcm9ibGVtIHdhcyBmaXhlZCBhIHllYXIgYWdvIGluIGtl
cm5lbCB2Ni4xMC1yYzEgaW4gY29tbWl0IGMzMmQxOGU3OTQyZAooInNwYXJjOiBtb3ZlIHN0cnVj
dCB0ZXJtaW8gdG8gYXNtL3Rlcm1pb3MuaCIpIFsyXS4KCkJlY2F1c2Ugbm9ib2R5IG5vdGljZWQg
dGhpcyBjaGFuZ2UgSSBzdXBwb3NlIG5vYm9keSB1c2VzIExUUCBvbiBzcGFyYzY0Cm9yIHBlb3Bs
ZSBjb21waWxlIExUUCBvbiBzcGFyYzY0IHdpdGggbmV3IGtlcm5lbCBoZWFkZXJzLgoKQEN5cmls
IEBNYXJ0aW4gRllJIGFub3RoZXIgZXhhbXBsZSBvZiBjb25mbGljdGluZyBnbGliYyBhbmQga2Vy
bmVsIGhlYWRlcnMgKG5vdApsaXN0ZWQgaW4gWzNdKS4gSU1ITyBub3RoaW5nIHRvIGJlIGRvbmUg
b24gTFRQIHNpZGUgdW5sZXNzIHdlIGNhbiBtYWdpY2FsbHkgcHV0CmJhY2sgPHRlcm1pb3MuaD4g
YW5kIGhhdmUgcHBjNjRsZSB3b3JraW5nIHdpdGggaXQuCgpAQnVpbGRyb290IEFzIEkgd3JvdGUs
IGJlY2F1c2UgTFRQIG5lZWRzIHRoaXMgZml4IGZvciBwcGM2NGxlIChhcmNoIGFjdHVhbGx5CnRl
c3RlZCBieSBMVFAgZGV2ZWxvcGVycyksIHRoZSBvbmx5IHNvbHV0aW9uIGZvciBCdWlsZHJvb3Qg
aXMgdG8gcmVxdWlyZQp0b29sY2hhaW4gYmFzZWQgb24gdjYuMTAga2VybmVsIGhlYWRlcnMgZm9y
IHNwYXJjNjQgKHF1aXRlIGEgYmlnIGxpbWl0YXRpb24gZm9yCnNldmVyYWwgY3Jvc3MgY29tcGls
YXRpb24gdG9vbGNoYWluLCBzb21lIGFyZSBiYXNlZCBvbiA0LjE5IGtlcm5lbCBoZWFkZXJzLAo1
LjExIHJlcXVpcmVtZW50IGZvciBtdXNsIGVmZmVjdGl2ZWx5IGRpc2FibGVzIExUUCBvbiBCdWls
ZHJvb3Qgb24gbXVzbCkuCgpLaW5kIHJlZ2FyZHMsClBldHIKClsxXSBodHRwczovL2dpdGh1Yi5j
b20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9jb21taXQvNjk3YTA2YTgyNzk3ODg4N2U0Yzg4NzEw
ZGM3ZDMxZDZmM2VlODE2YQpbMl0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9YzMyZDE4ZTc5NDJkNzU4
OWI2MmUzMDFlYjQyNmIzMjYyMzM2NjU2NQpbM10gaHR0cHM6Ly9zb3VyY2V3YXJlLm9yZy9nbGli
Yy93aWtpL1N5bmNocm9uaXppbmdfSGVhZGVycwoKPiBUaGUgdGVybWlvcyBzdHJ1Y3R1cmUgZGVm
aW5pdGlvbiBpbiA8dGVybWlvcy5oPiBpcyBpbmNvbXBhdGlibGUKPiB3aXRoIGRpcmVjdCBpb2N0
bCgpIGNhbGxzLiBUaGUgY29ycmVjdCBkZWZpbml0aW9uIGlzIGluIDxhc20vdGVybWJpdHMuaD4K
Cj4gU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+IC0tLQo+
ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsMDIuYyB8IDIgKy0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsMDIuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGwwMi5jCj4gaW5kZXggYWFiODBiMjUxLi5mM2JmYjIz
OWEgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bDAy
LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsMDIuYwo+IEBA
IC0yNiw3ICsyNiw3IEBACgo+ICAjaW5jbHVkZSA8c3RkaW8uaD4KPiAgI2luY2x1ZGUgPHN0ZGxp
Yi5oPgo+IC0jaW5jbHVkZSA8dGVybWlvcy5oPgo+ICsjaW5jbHVkZSA8YXNtL3Rlcm1iaXRzLmg+
Cgo+ICAjaW5jbHVkZSAibGFwaS9pb2N0bC5oIgo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
