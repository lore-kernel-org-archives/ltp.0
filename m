Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA04C106F309
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774515562; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=OgDpazxXycdyxhPrZzd+aCkUzvTvhgXIPRpbbSy7Bqo=;
 b=pHEz7WLkgf4gCO8457YOyKaxFZPnDTC8HSJG1Ei08HgdJCZJk3Qldxm7kopIa92DASTu6
 /zUj1mlmDKk7Rp3JLnR/CjnjiqEHyuOGC97ausGbTu/rd6Z3xbXUYqaQ9aT9DuyGR5b1yo8
 4O6ardsBYc1z0cNs10JUp/Lxqnc9/JI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F05D3E2ABA
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 09:59:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 576AE3DCACD
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:58:58 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A89EE600756
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 09:58:57 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso7140875e9.2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774515537; x=1775120337; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hnUPwnMFz9XXh2pY6WRjfIrD4qW0CLenumnCRicFldA=;
 b=OxPGKl/LlfPNoDH/wAoHixgk/Sa4TSry+v8KvBJU7qgOvlQ2dMY5/MRisaWOQWcx41
 CKaMSaj8jH9GChFQu7NklTTMvG7h7idmzSrq69WhEDZyNIaDMMe6BdwESS9pJrVwsOrX
 tGy9ECmJNLkv6KTYQhaP8tKHxWG2JOSJzWQNg6zI86+YdnPCQ74uToMO9OUY7nrN3tME
 N6uJwKxsj9RT0iLbvEWbcmkCnh6Qmm6bws6vBtOkWfoKJepCe2ZENt/qpnOtPaK/HAJO
 4V/heay5XQYT2N2Q4UYRb5krIjfnZu/WFXlTwjn+f3F0q6UNqfXJhBXWU6GcTBIR4l9x
 0JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515537; x=1775120337;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnUPwnMFz9XXh2pY6WRjfIrD4qW0CLenumnCRicFldA=;
 b=UuefEsVJB+RouqmP9QolhObM9W+v/8cLn0iRS3YPnmCweeeJPFwKJQPuCKsMuoyiYu
 1PzhFZGgyzyD4nVQOutAebYePifz17i2D6IrYgX0Dxt7l8nf3veHaUbJfDVEymK44OBq
 96Ief0xIIYX1yUWc2wVznBCCh8kIkeBV4c1sbg4fvezW9JYLhXMeqTyrI2djIy1fCeQh
 WhdyB5BRF63ROlAx45NHVXkRvqE6ogkEmJeFMRLdRn8M1MGefXINZgyaudGYc6CbXz9M
 Dh2Yd8jzseCA9XsPpjUxAcXvSVlQwjQF7njGgLQ/q+VjCDhW0ND1BO7vesf6vzQQQGbC
 uA/g==
X-Gm-Message-State: AOJu0Yydf+/AseeUAYctUzilc/tVPE9g3UFgUjIQxJPJwaebyxmvCYGJ
 VSJbRQ3quLZu1gMY0Mr43fWS4b82/y54DC77uXYEG2jUmfGm/urV25UWCgd8W6kHPQ4=
X-Gm-Gg: ATEYQzwDEcDcG1Rkp55CO01HB+SI1wlgyw7ZviO1TGStapM/T1bi54ce5NodDQh4EJd
 YhAFrQAgcz/uCR0Em2gt3pkNvTabm26zk4dBU+fuW01YE+kzDXuzwlB6EmjX0fbo/h7Abz8t2CR
 5zXL3Hb07fuUNweYWTk7Bpfe/+/cfmFXsezCcynYt4D6muD3SVdAZIpPfYBPduSCcTgDqECvIvE
 tYLaj9DFmAMMVU52SIwWvEAacZ9ebrYo5ix5wJX/r5UNNM30Ekq0+K9kNmXHbDzxM47ZZ+8WPBs
 Zz4G6OdSkyiiFrSR1I1YVPmqwHR9BCGXu2hp6bBHK7ovuLdWviPkCif1AZ7cYnCVSiO4wzkJXEH
 5dGfb55o9Zp7ARUPKARfzCVwXuzytFAkhFcid0iv8q9S45CNgcQsTm8kKadkLMzeylQT6TuhpRi
 1jkZP9BepuZOGPBokPmct/DNkp/LBBxgvlx7DWgVh3N/kp4D+iivC1AJLoqafRo5xwHN+Pf2k0e
 eOaFrSRVqkZK30qHzVc/heWGIehkdxit20=
X-Received: by 2002:a05:600c:4685:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-48715fc3994mr95486485e9.5.1774515536886; 
 Thu, 26 Mar 2026 01:58:56 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872092883bsm10884605e9.27.2026.03.26.01.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 01:58:56 -0700 (PDT)
Message-ID: <69c4f550.050a0220.1d2cf9.0560@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260325105533.259287-2-piotr.kubaj@intel.com>
Date: Thu, 26 Mar 2026 08:58:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14] thermal: add new test group
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGlvdHIsCgo+ICtzdGF0aWMgaW50IG5wcm9jLCB0ZW1wX2hpZ2gsIHRlbXAsIHRyaXAsIHR6
X2NvdW50ZXI7CgpgdHJpcGAgaXMgYSBzaW5nbGUgaW50LCBidXQgY2xlYW51cCgpIHVzZXMgaXQg
dG8gcmVzdG9yZSB0cmlwX3BvaW50XzFfdGVtcApmb3IgQUxMIHg4Nl9wa2dfdGVtcCB6b25lcy4g
SWYgdGhlcmUgYXJlIG11bHRpcGxlIHN1Y2ggem9uZXMsIGVhY2gKdGVzdF96b25lKCkgY2FsbCBv
dmVyd3JpdGVzIGB0cmlwYCBhdCB0aGUgU0FGRV9GSUxFX1NDQU5GLCBzbyBvbmx5IHRoZQpsYXN0
IHpvbmUncyBvcmlnaW5hbCB2YWx1ZSBzdXJ2aXZlcy4gVGhlIGVhcmxpZXIgem9uZXMgZ2V0IHRo
ZSB3cm9uZwp2YWx1ZSByZXN0b3JlZC4KClRoaXMgbmVlZHMgdG8gYmUgYSBwZXItem9uZSBhcnJh
eSwgZS5nLiBgc3RhdGljIGludCAqdHJpcF9vcmlnO2AKYWxsb2NhdGVkIGFsb25nc2lkZSB4ODZf
cGtnX3RlbXBfdHogaW4gc2V0dXAoKSwgd2l0aCBlYWNoIHpvbmUncwpvcmlnaW5hbCB0cmlwIHZh
bHVlIHNhdmVkIGluZGl2aWR1YWxseS4KCj4gKwlpbnRlcnJ1cHRfaW5pdCA9IGNhbGxvYyhucHJv
Yywgc2l6ZW9mKHVpbnQ2NF90KSk7Cj4gKwlpbnRlcnJ1cHRfbGF0ZXIgPSBjYWxsb2MobnByb2Ms
IHNpemVvZih1aW50NjRfdCkpOwoKWy4uLl0KCj4gKwl4ODZfcGtnX3RlbXBfdHogPSBjYWxsb2Mo
dHpfY291bnRlciwgc2l6ZW9mKGJvb2wpKTsKCkxUUCBoYXMgU0FGRV9DQUxMT0MoKSBpbiB0c3Rf
c2FmZV9tYWNyb3MuaC4gUGxlYXNlIHVzZSBpdCBpbnN0ZWFkIG9mCnJhdyBjYWxsb2MoKSDigJQg
aXQgaGFuZGxlcyB0aGUgTlVMTCBjaGVjayBhbmQgY2FsbHMgdHN0X2JyayhUQlJPSykgb24KZmFp
bHVyZS4KCj4gKwkJCXRzdF9yZXMoVERFQlVHLCAiaW50ZXJydXB0c1slZF06ICVsZCIsIGksIGlu
dGVycnVwdHNbaV0pOwoKaW50ZXJydXB0c1tpXSBpcyB1aW50NjRfdCBidXQgcHJpbnRlZCB3aXRo
ICVsZC4gVXNlIFBSSXU2NDoKCiAgICB0c3RfcmVzKFRERUJVRywgImludGVycnVwdHNbJWRdOiAl
IiBQUkl1NjQsIGksIGludGVycnVwdHNbaV0pOwoKU2FtZSBpc3N1ZSBiZWxvdyBpbiBydW4oKToK
Cj4gKwkJCQl0c3RfcmVzKFRGQUlMLCAiQ1BVICVkIGludGVycnVwdCBjb3VudGVyOiAlbGQgKHBy
ZXZpb3VzOiAlbGQpIiwKPiArCQkJCQlpLCBpbnRlcnJ1cHRfbGF0ZXJbaV0sIGludGVycnVwdF9p
bml0W2ldKTsKCj4gKwkJU0FGRV9GSUxFX1NDQU5GKHBhdGgsICIlcyIsIGxpbmUpOwoKJXMgd2l0
aG91dCBhIHdpZHRoIGxpbWl0IGNhbiBvdmVyZmxvdyBsaW5lWzgxOTJdLiBVc2UgIiU4MTkxcyIu
Cgo+ICtzdGF0aWMgdm9pZCAqY3B1X3dvcmtsb2FkKGRvdWJsZSBydW5fdGltZSkKPiArewoKWy4u
Ll0KCj4gKwlyZXR1cm4gTlVMTDsKPiArfQoKY3B1X3dvcmtsb2FkKCkgcmV0dXJucyB2b2lkICog
YXMgaWYgaXQgd2VyZSBhIHB0aHJlYWQgc3RhcnQgcm91dGluZSwgYnV0Cml0IGlzIG9ubHkgY2Fs
bGVkIGRpcmVjdGx5IGZyb20gdGhlIGNoaWxkIHByb2Nlc3MuIEl0IHNob3VsZCByZXR1cm4gdm9p
ZC4KCj4gKwlmb3IgKGludCBpID0gMDsgaSA8IHR6X2NvdW50ZXI7IGkrKykgewo+ICsJCWlmICh4
ODZfcGtnX3RlbXBfdHpbaV0pIHsKPiArCQkJcmVhZF9pbnRlcnJ1cHRzKGludGVycnVwdF9pbml0
LCBucHJvYyk7Cj4gKwkJCXRlc3Rfem9uZShpKTsKPiArCQkJcmVhZF9pbnRlcnJ1cHRzKGludGVy
cnVwdF9sYXRlciwgbnByb2MpOwo+ICsJCQlmb3IgKGludCBpID0gMDsgaSA8IG5wcm9jOyBpKysp
IHsKCklubmVyIGBpYCBzaGFkb3dzIHRoZSBvdXRlciBsb29wIHZhcmlhYmxlIGBpYC4gUGxlYXNl
IHJlbmFtZSB0byBgamAgb3IKYGNwdWAgdG8gYXZvaWQgY29uZnVzaW9uLgoKUmVnYXJkcywKLS0K
QW5kcmVhIENlcnZlc2F0bwpTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKYW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmNvbQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
