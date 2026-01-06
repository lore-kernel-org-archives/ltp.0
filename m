Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372D2CDC167
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 11:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767700677; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1GsCsdMnZ5lRZdyoTHQlhdIr30APnzwpY3FD09Arejw=;
 b=eeA0A2JTPwE9i29k3MseSNYMjg6OLyscXQ7tVWYWCdd54BAmQ7/NayupHe51qPl50bLq1
 hUtFQAIJjijGEg/pdV7O9RbF8As6r8kEe/2KokymuaDvjH8paJKFfqQ0kcfbGHFgY20uA+9
 WcdNspdHFtufnWhWgsK0ztFHZcBSRIw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0C273C2204
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 12:57:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A71803C1B25
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 12:57:34 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 175501000490
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 12:57:34 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so9310335e9.2
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 03:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767700653; x=1768305453; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cr4WP9L+9lcxSHzujUTMiqbzJMDCi1rbk0+nqXfGGA=;
 b=VMQgvDIQi7Qm2gb+Uv//XjuSbK1bQzOoyZ7A0mw7X2w1hAfG7rRH4ko138me/6MFpn
 m20Mis/uhTZwf8INprzKUuZHiPvelIKJd4oFl2lu9hK8jSVH8MxKQ7Eu6enObox2z0uQ
 mkUHmnyXdNGeAwsRc2SVrQgc51+rIA0yCr2Z2ToP/LUlKDIEiKAV5qvCh8iOCpZgUaP5
 KB6ioxIWBtmWtJoUszHCHUBmFuOFeodJ5nEKBzr6FCktEaUh8+iL8GGjYc5uwB99XJgT
 ept7kzP3jkCrrfsPmfng1WowWJ4+el4D7upR18R9WLYNgilo7gZv55OgZ485qebAn8ZB
 azSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767700653; x=1768305453;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Cr4WP9L+9lcxSHzujUTMiqbzJMDCi1rbk0+nqXfGGA=;
 b=YefEncGIdXVxjR6UTmTVwxZObLpjSnWID3Eboh0B0WYoh30ZjS5zRWmCf+Sz78v2p0
 yOcZXwEKV64Tu71MjX1AF/xAboLzZnGozl2gQsMLSwIeEWVtuTfYW2iebnYArFtDLNO2
 GaLf3BHx4tcBSMgwLSZv3F/e7f1q5H2V2fVtmZtmgfKEGZt+fEY6CQGDIeG0qlT9WYUz
 zNf6CFhbzEEQyfy6cyYkRnyvHynSWdkKT9yk5zQP+2YWf2e9h+lsSoo1b0Llbi0sav0E
 WGiADSgtXK2FvERSoye5ZfJw2qlI1jw0cHKmiQaMdi17mHEXOIYjijJfdh2AisjVh4ff
 RsXg==
X-Gm-Message-State: AOJu0YwCbjOxpUqsHETO0YA41tWqlS/LWYSVPEVZzjoDsw26QVo1qF3T
 idoco0G6dU1M2zfpwB7wX3LxL//ZhhdUBbNZkS5l2mHEcDnDAH7hyxzna9QyUkkpBMwt+8jmJxf
 CD3mILaw=
X-Gm-Gg: AY/fxX7isKl8YEYh4EDriDO95evNRm4z+akJ84ZaHHSGOb1+54gxCBwRQrdBJq2F8sA
 BS56jUrYZiXRoCQceRKzJty0arfOA3v/DUPNJv09tC0vGOtmI2wtfzMTrEL1LgOBnnDlOduHfzj
 Klvnd9b6Drnby+hPrXWZW6MlK0wXgEl6KyW8AcLNS7Vs0CvIZKgVbHMa/KfWwrciDojnCtAdNxC
 crxpPpmhgsCEbvA2Nlfu+itCXKk76p1xxccMxyB+8hPG+xZOv5eThN3nH7vhgxv9bnbv0jXB0Jx
 uRvPWGs5d87AcrqymJxLw0hD5zc50X8IC5ZsMp4VRXkLrR9eROW4bbc4hIoPwMcPUjD3SFNxFoT
 oNCB4rzy8s3dimgTFNvVI89QktqTrC4D28rxDZilrskU7WZdAYnI7zQTAptTORGIkw0fxsxBEa4
 uERruHrC00vHVyYoBZLR5GtRU=
X-Google-Smtp-Source: AGHT+IEgjX2K+JJHoPvLEUhL7smbcOKhAaFFgGucrB8D71qOL6TJl8wiDqdnCeuGDOSAtDCu9jGffw==
X-Received: by 2002:a05:600c:c170:b0:47d:3ffa:5c75 with SMTP id
 5b1f17b1804b1-47d7f09897amr27079285e9.20.1767700653412; 
 Tue, 06 Jan 2026 03:57:33 -0800 (PST)
Received: from localhost ([88.128.90.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7fae670esm15756345e9.2.2026.01.06.03.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 03:57:33 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 06 Jan 2026 12:57:32 +0100
Message-Id: <DFHHL0ST0J9B.VIZCKRYAK2TN@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251222094428.87910-1-pvorel@suse.cz>
 <DFGGXHDQ8OSM.36FM2U880AQKZ@suse.com> <20260105074908.GA589722@pevik>
In-Reply-To: <20260105074908.GA589722@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] swapon03: Try to swapon() as many files until
 it fails
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiBNb24gSmFuIDUsIDIwMjYgYXQgODo0OSBBTSBDRVQsIFBldHIgVm9yZWwgd3JvdGU6
Cj4gPiBIaSEKPgo+ID4gPiAtCWNoYXIgY21kX2J1ZmZlclsyNTZdOwo+ID4gPiArCWNoYXIgY21k
X2J1ZmZlcltGSUxFTkFNRV9NQVgrMjhdOwo+Cj4gPiBJJ20gbm90IHN1cmUgaWYgKzI4IGlzIG5l
ZWRlZC4KPgo+IEkgZGVzY3JpYmVkIHRoZSByZWFzb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlOgo+
Cj4gCUl0IHdhcyByZXF1aXJlZCB0byBpbmNyZWFzZSBjbWRfYnVmZmVyIHNpemUgdG8gYXZvaWQg
ZGlyZWN0aXZlIG91dHB1dAo+ICAgICBtYXkgYmUgdHJ1bmNhdGVkIHdhcm5pbmcuCj4KPiBJIGdl
dCB3YXJuaW5nIG9uIHNtYWxsZXIgc2l6ZToKPgo+IHN3YXBvbjAzLmM6NzQ6NjA6IHdhcm5pbmc6
IOKAmCVz4oCZIGRpcmVjdGl2ZSBvdXRwdXQgbWF5IGJlIHRydW5jYXRlZCB3cml0aW5nIHVwIHRv
IDQwOTUgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIDQwODcgWy1XZm9ybWF0LXRydW5jYXRp
b249XQo+ICAgIDc0IHwgICAgICAgICBzbnByaW50ZihjbWRfYnVmZmVyLCBzaXplb2YoY21kX2J1
ZmZlciksICJncmVwIC1xICclcy4qZmlsZScgL3Byb2Mvc3dhcHMiLCBmaWxlbmFtZSk7Cj4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+Cj4gLi4uLi4uCj4gICAgOTQgfCAgICAgICAgICAgICAgICAgY2hlY2tfYW5kX3N3
YXBvZmYoZmlsZW5hbWUpOwo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH5+fn5+fn5+Cj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS9zdGRpby5o
Ojk3MCwKPiAgICAgICAgICAgICAgICAgIGZyb20gc3dhcG9uMDMuYzoxNzoKPiBJbiBmdW5jdGlv
biDigJhzbnByaW50ZuKAmSwKPiAgICAgaW5saW5lZCBmcm9tIOKAmGNoZWNrX2FuZF9zd2Fwb2Zm
4oCZIGF0IHN3YXBvbjAzLmM6NzQ6MiwKPiAgICAgaW5saW5lZCBmcm9tIOKAmGNsZWFuX3N3YXDi
gJkgYXQgc3dhcG9uMDMuYzo5NDozOgo+IC91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251L2Jp
dHMvc3RkaW8yLmg6Njg6MTA6IG5vdGU6IOKAmF9fYnVpbHRpbl9fX3NucHJpbnRmX2Noa+KAmSBv
dXRwdXQgYmV0d2VlbiAyOSBhbmQgNDEyNCBieXRlcyBpbnRvIGEgZGVzdGluYXRpb24gb2Ygc2l6
ZSA0MDk2Cj4gICAgNjggfCAgIHJldHVybiBfX2J1aWx0aW5fX19zbnByaW50Zl9jaGsgKF9fcywg
X19uLCBfX1VTRV9GT1JUSUZZX0xFVkVMIC0gMSwKPiAgICAgICB8ICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+ICAg
IDY5IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2dsaWJjX29ianNpemUg
KF9fcyksIF9fZm10LAo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+ICAgIDcwIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBfX3ZhX2FyZ19wYWNrICgpKTsKPgo+IEtpbmQgcmVnYXJkcywK
PiBQZXRyCgpTb3JyeSwgSSBtaXNzZWQgdGhlIGdpdCBjb21tZW50LiBDYW4geW91IGFsc28gY29t
bWVudCB0aGUgc291cmNlIGNvZGUKcGxlYXNlPyBTbyB3ZSBkb24ndCBndWVzcyB3aGF0J3MgZ29p
bmcgb24gaW4gdGhlIGJ1ZmZlciwgYmFzZWQgb24KZ2l0IG1lc3NhZ2UuCgpCZXNpZGVzIHRoYXQs
CgpSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNv
bT4KCi0tIApBbmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51
eAphbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
