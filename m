Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC60DCCF2DB
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792391569; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pUK3zq7+mb4PbukaVznjk0ceH0mXCZmRHe8Wx+XsnoQ=;
 b=FeTR5iVUw0eha/I1ixX59YSGapJM2nIy9zEZD02WIXPifJ+S9KOLtpCSRULFCExeDT52r
 MYhxcPMfShRLor9iwHii7M51iDNBXL5+56FDXNJeKeVcK9vfqSEUGyxMccl3lfWX6jkvHim
 zrZJhTl+7/TGGlEaibjqw/SXjxjBMLE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 812873E283B
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 08:32:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDD5D3E283B
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 08:32:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58FA5600058
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 08:32:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792391546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5q/KF+kNDYBqeIY4gQ7F5WbCLGKxlUOBwUXMWnCRQAk=;
 b=b04c3eolVgwvUof6eTWMieEzJh82vMOoMFc8NOh743B3RxWYlNlwescs6jZRx55i46lx+d
 VfilhOrvfOQFFuWgz2byAZpmjKRB6/q62O99SmyqzK06ALQOtVtZVnkPysEJBkpiAZjUGU
 XyQW8J1W0CYA499Ofkx7t4KbkUn4Vf4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-9s3rDDZwMVyQck9tpbWW7w-1; Mon, 19 Oct 2026 06:32:24 +0000
X-MC-Unique: 9s3rDDZwMVyQck9tpbWW7w-1
X-Mimecast-MFC-AGG-ID: 9s3rDDZwMVyQck9tpbWW7w_1792391543
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48dff112136so1146260f8f.1
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 23:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792391543; x=1792996343;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5q/KF+kNDYBqeIY4gQ7F5WbCLGKxlUOBwUXMWnCRQAk=;
 b=UcOH+IdY/3+wELC23zT+xJoOyHRbzY7vI6sgWm0aJYmf4vS/Y/fsVKpCIM4ZyFRJKr
 I2g6cPjLInGXhOvg4Sw++u33LHYylkCgG4V34bxLsT/XeM+zVvbSmCFrOSakYJo2gCgJ
 tJqcBLMJMUB/8iH4WB8pCZX3M+vu/Phz11RLSpBaGxZJPx89FecIEHgzmVFJfxxn3Sm3
 wMOsuXHtma0vTB7XyO1EVjEuZKozWjtazUcTOEz/EFakCw+RBbE7zTsXa3L+fr3q3uNA
 +OZrz2z0IdjNQEOCSEhlTd58SO+Fa+Me/2SCeXZorQxY6O4KGwnFicG97unoLc0Qx2JQ
 BtmQ==
X-Gm-Message-State: AFq9FYIauXm0y4tOgljbwauFItjJGSOdfdq/l01ioh11xOVhlOdWRN39
 FW5f35e0vZ/QiOzilNhXcgJViXXhv6vAvrxwntxST82xyG/QjGst/uKlHk/YbJugoOWTIf4peIQ
 /a4vcpojYBZspJvJEKw0JkZIqDT899KHWANk095q8kCcqybpxUt059L5kue8kknk4tAGwkPsisH
 ZWlkGwfNWwHmKAm1Hw2W2bKxI6lag=
X-Gm-Gg: AYBFou3XNihpVrPy5tJNMQD3DflH8uMi+MetyAPJn9pG7ks3/T1S26prkBN2qx02nFi
 ricBSHMftyAxBu0/5lCojoVfkwfiC4yy/x5MR0KJydHvEYwecz3WgwQowW8WxaBy+5ACpTy53T2
 0Ol25O2XjSKeMeqMDYBrfAkI6LcaGGEUDgOnMFXKhforDhvG5V4tGg1bg=
X-Received: by 2002:a05:6000:2413:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-48e0932b129mr12271581f8f.26.1792391542971; 
 Sun, 18 Oct 2026 23:32:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2413:b0:48e:932:aefa with SMTP id
 ffacd0b85a97d-48e0932b129mr12271544f8f.26.1792391542464; Sun, 18 Oct 2026
 23:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <d462c7ccea7e45f489e9f8d5a04ec786de2014b6.1791780763.git.jstancek@redhat.com>
 <b6d98d03422ec30d0bf5284cd094d2ecf688efe3.1791792065.git.jstancek@redhat.com>
 <20261012093357.GA191096@pevik>
In-Reply-To: <20261012093357.GA191096@pevik>
Date: Mon, 19 Oct 2026 08:32:04 +0200
X-Gm-Features: AclHuK_pWBP0TpI5JGvoEA4qaOsGcEYA9BkZH9UCT1pRGOohSdpF1bJPv5ABaWs
Message-ID: <CAASaF6x7RgYB_Mua_L=yQfwc7aHVV2uPMd5e44uoRt9hLfpcFA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qQAiIZx--RH7Jqu5XxIZyFRk_zTwAY1NGA8XUQ0uVIk_1792391543
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] openposix: timers/twoevtimers: Wait for both
 timer signals
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBPY3QgMTIsIDIwMjYgYXQgMTE6MzTigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBKYW4sCj4KPiB0aGFua3MsIExHVE0uCj4gUmV2aWV3ZWQtYnk6
IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKUHVzaGVkIHdpdGggeW91ciBzdWdnZXN0aW9u
cy4KClRoYW5rcywKSmFuCgo+Cj4gPiAtI2RlZmluZSBFWFBJUkVERUxUQSAzCj4gPiAtI2RlZmlu
ZSBMT05HVElNRSA1Cj4gPiArI2RlZmluZSBFWFBJUkVERUxUQV9OUyA1MDAwMDAwMAo+Cj4gdmVy
eSBuaXQ6IGhhdmluZyBFWFBJUkVERUxUQV9NUyA1MCBhbmQgdGhlbiB1c2UgRVhQSVJFREVMVEFf
TVMgKiAxMDAwMDAwCj4gbWlnaHQgYmUgc2xpZ2h0bHkgbW9yZSByZWFkYWJsZS4KPgo+ID4gKyNk
ZWZpbmUgTE9OR1RJTUUgMwo+ID4gKwo+ID4gKyNkZWZpbmUgUE9MTF9NUyA1MAo+ID4gKyNkZWZp
bmUgUE9MTF9DT1VOVCAoTE9OR1RJTUUgKiAxMDAwIC8gUE9MTF9NUykKPgo+ID4gICNkZWZpbmUg
Q0hJTERQQVNTIDEKPgo+ID4gLXN0YXRpYyBpbnQgY2F1Z2h0YWJvcnQgPSAwOwo+ID4gLXN0YXRp
YyBpbnQgY2F1Z2h0YWxhcm0gPSAwOwo+ID4gK3N0YXRpYyB2b2xhdGlsZSBzaWdfYXRvbWljX3Qg
Y2F1Z2h0YWJvcnQgPSAwOwo+ID4gK3N0YXRpYyB2b2xhdGlsZSBzaWdfYXRvbWljX3QgY2F1Z2h0
YWxhcm0gPSAwOwo+IG5pdDogc3RhdGljIGlzIDAgYWxyZWFkeSAobWF5YmUgZHJvcCAiPSAwIj8p
Cj4KPiA+IC1zdGF0aWMgdm9pZCBoYW5kbGVyX2FicnQoaW50IHNpZ25vKQo+ID4gK3N0YXRpYyB2
b2lkIGhhbmRsZXJfYWJydChpbnQgc2lnbm8gUFRTX0FUVFJJQlVURV9VTlVTRUQpCj4gVGhhbmtz
IGZvciBzaWxlbmNlIHNvbWUgb2YgdGhlIHdhcm5pbmdzLgo+Cj4gPiAgewo+ID4gLSAgICAgcHJp
bnRmKCJDYXVnaHQgYWJvcnQgc2lnbmFsXG4iKTsKPiArMQo+Cj4gPiAgICAgICBjYXVnaHRhYm9y
dCsrOwo+ID4gIH0KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
