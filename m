Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BECCD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:25:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7B2A3E56BC
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:24:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF76E3E722A
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:56 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C7F61A000A8
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:56 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-304f590dd91so3686628eec.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399435; x=1781004235; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qC3mnN6+ydOwfVa4UjfGorsrs1ULfxS6Y2muAC/C5k8=;
 b=lfyvEzw8bgxyCUnJPIL2KzTY6SUcbFxrhQYq+eF7wqM9uZs25wiuMibmkUiDrhcWsY
 ZKplqPjcxTDlafSQP7nZnSLFnoK8DVCrUyJy1ZKunbDUKJ/SmflI2q4pyqMF/0Z69U1y
 Aqx89wkQ1n7T+9gxI9/OqFaLPBPBxP9JjTA7RgdiT8eXK/cibEC+lM/q8saO1JY3H7uv
 4muDWcF3mOgDBSQlqDQqW1iBFtD9oWyCZG1rCk2w6e54Q+UU58XHzvvk4jxnpxSKre1L
 sWLUMsoZhGoPHkQMj+8mTsLNWLUgzIlozlViCt8iCVmWStpt5VQfop7BeigVFLRoPiBz
 51fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399435; x=1781004235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qC3mnN6+ydOwfVa4UjfGorsrs1ULfxS6Y2muAC/C5k8=;
 b=Ysr6Y+srLCCv0s7GmTTkFLgqxo5ZzV7BIhvm8pQT2qCIWFaSgiYGB9fHZZoKRKbhcs
 8HDdyw2DPqG/VgXGBBBaowmG3GBIREg7cvKEeuRlByM9H/yj23PV5/w2zgyFC740nhbf
 A1nXBiDbThCIWVBZPbcascf5+2XaOfYxfGgS01mO1kmR5JIWaBj8tlWchY1PJm976tSL
 RhSd9AAKcwLwizAeouLsut8tQ6fqbPpxg6XDSdpTVmI3S+rxtVHW+/wf9yp4ohIpNPWU
 E7TiKXVautzvOUJFWNO5An+dU9TyXdM68yTPnWR1aqq94ADNWTMPvBcVg7K+aS9ZPgpn
 Wweg==
X-Gm-Message-State: AOJu0YxVQwhViFOliHztpZ86WMFRuzP9ZyS2q43gSvyIJ+pWNeO832MB
 T6FMKx+aON+30akKx1CS0VG+IvaJylrsWx0OWjKqPc3X0xeEHoKltUzM
X-Gm-Gg: Acq92OFtTwLNN11AhaUA30MWFNvbkqC1OKHWHxBYCW0hCUATV+dUiDghCF9QVkkNGqO
 t+/8OWGgX6/C/fjlVAWmDmgjhz/C8swomAszzOBUpOTN8XGbqJzTpZOKSn9BgcP6E9HXuj1JZoq
 A/Bh4ngyM/Kna9HiE8uA1ZgHuKHLKL03eccYUaKDqd3K4TPQ3WPTPzLaDzZ5fm12XI9cDD4ayL8
 IBQ6+QtUWrR3CcfiFrNDN16kngSXcLQa61fT8+vK9XuFXZObLf04fMxAisldBfSuS6huvO7oPsH
 8UHSqrlyEEhZnsFOxCay6XPBhyFQzKr2l4FA9BdI1pvqU/gNGkPMDRZw8EsJZrFk+Sacnu+s96P
 ZGxhLFiCxWqDGyJ8oLFuBdLhWMkNLNhnLBHwZd88s/YU8vlal0UYUwnsZv03wtp1dY4a/QXrXa8
 +dXvLO0+Lug7OJ1JdJGpq1TQsAxVFlMchuOn1CdeHTrv9w7rJ4IT7mVXI1xsM2J6zfdSQ+ijq3s
 q+z1tSIVytHh29lwHEBPpY2l1rQolPqleWYY6iFDlMIV8nhN0bzMSrx9ZcQUZE=
X-Received: by 2002:a05:7300:a54b:b0:2e1:e3e6:2909 with SMTP id
 5a478bee46e88-304fa54bfccmr5983626eec.9.1780399434586; 
 Tue, 02 Jun 2026 04:23:54 -0700 (PDT)
Received: from
 runnervm3jyl0.euvoypmqv01u5lz5obefzjxsjg.phxx.internal.cloudapp.net
 ([20.163.83.240]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2bdda4sm10408606eec.2.2026.06.02.04.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:23:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: XiaoLei Wu <wxl18715129466@gmail.com>
Date: Tue,  2 Jun 2026 11:23:53 +0000
Message-ID: <20260602112353.4005-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602064115.718468-1-wxl18715129466@gmail.com>
References: <20260602064115.718468-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/fcntl.h: fix O_PATH fallback on alpha
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

SGkgWGlhb0xlaSBXdSwKClRoZSBmaXggaXMgY29ycmVjdCDigJQgYXJjaC9hbHBoYS9pbmNsdWRl
L3VhcGkvYXNtL2ZjbnRsLmggY29uZmlybXMgdGhhdAphbHBoYSBkZWZpbmVzIE9fUEFUSCBhcyAw
NDAwMDAwMDAsIHdoaWxlIHRoZSBhc20tZ2VuZXJpYyBmYWxsYmFjawowMTAwMDAwMDAgY29sbGlk
ZXMgd2l0aCBhbHBoYSdzIE9fQ0xPRVhFQyB2YWx1ZSwgc28gdGhlIGJ1ZyBpcyByZWFsIGFuZAp0
aGUgY2hvc2VuIHZhbHVlIGlzIHJpZ2h0LgoKT25lIHN0eWxlIGlzc3VlIGJlbG93LgoKLS0tCgo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvZmNudGwuaCBiL2luY2x1ZGUvbGFwaS9mY250bC5o
Cj4gQEAgLTEzNyw2ICsxMzcsOCBAQAo+ICAjaWZuZGVmIE9fUEFUSAo+ICAjIGlmZGVmIF9fc3Bh
cmNfXwo+ICAjICBkZWZpbmUgT19QQVRIIDB4MTAwMDAwMAo+ICsjIGVsaWYgZGVmaW5lZChfX2Fs
cGhhX18pCj4gKyMgIGRlZmluZSBPX1BBVEggMDQwMDAwMDAwCj4gICMgZWxzZQoKVGhlIGV4aXN0
aW5nIGFybSB1c2VzIGAjIGlmZGVmIF9fc3BhcmNfX2AsIGJ1dCB0aGUgbmV3IGFybSB1c2VzCmAj
IGVsaWYgZGVmaW5lZChfX2FscGhhX18pYC4gIFdpdGhpbiB0aGUgc2FtZSAjaWYvI2VsaWYgY2hh
aW4gdGhlCnN0eWxlIHNob3VsZCBiZSBjb25zaXN0ZW50LiAgUGxlYXNlIHVzZSBgIyBlbGlmIF9f
YWxwaGFfX2AgdG8gbWF0Y2gKdGhlIHN1cnJvdW5kaW5nIGNvZGU6CgogICMgaWZkZWYgX19zcGFy
Y19fCiAgIyAgZGVmaW5lIE9fUEFUSCAweDEwMDAwMDAKICAjIGVsaWYgX19hbHBoYV9fCiAgIyAg
ZGVmaW5lIE9fUEFUSCAwNDAwMDAwMDAKICAjIGVsc2UKICAjICBkZWZpbmUgT19QQVRIIDAxMDAw
MDAwMAogICMgZW5kaWYKCi0tLQoKQ29tbWl0IG1lc3NhZ2UgbG9va3MgZ29vZDogYWNjdXJhdGUg
c3ViamVjdCwgY2xlYXIgcmF0aW9uYWxlLCBwcm9wZXIKU2lnbmVkLW9mZi1ieS4KCkl0IHdvdWxk
IGJlIGhlbHBmdWwgKGJ1dCBub3QgcmVxdWlyZWQpIHRvIG5vdGUgaW4gdGhlIGNvbW1pdCBib2R5
IHRoYXQKdGhlIGdlbmVyaWMgdmFsdWUgMDEwMDAwMDAwIG1hcHMgdG8gT19DTE9FWEVDIG9uIGFs
cGhhLCBleHBsYWluaW5nIHdoeQp0aGUgbWlzbWF0Y2ggY2F1c2VzIGEgc2lsZW50IHNlbWFudGlj
IGZhaWx1cmUgcmF0aGVyIHRoYW4gYW4gb2J2aW91cwplcnJvci4KClZlcmRpY3Q6IE5lZWRzIHJl
dmlzaW9uIChzdHlsZSBmaXggYWJvdmUpCgpMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
