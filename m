Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFA8C54E60
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 05:43:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37E1E3CE6A4
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 06:43:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11D383CB37F
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 06:43:37 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 31F53600486
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 06:43:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710827015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nv+QyQ+1zwwLtRfikDRVkCztWY6M7kQEWaMXiZdR2t4=;
 b=L8uKYQy005qBOOtMJCuOZRpO4AxkSJaQUeeTTcaePUdxsdMVU4tgjFBPoz0SQW7RJBCgDZ
 Wyi3Ow5bt+LkVEGQw4BILn+cN4nMurQua8UBx/+idOM1q+NDbv3wVYyk79b3gd5fUgJ6zg
 ZaOpe/jGok3/v+3137aMBgQHj0FSIVI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-CMQobV3eM2aJJxgNLJJQyA-1; Tue, 19 Mar 2024 01:43:30 -0400
X-MC-Unique: CMQobV3eM2aJJxgNLJJQyA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29de02b98caso4363048a91.0
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 22:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710827009; x=1711431809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nv+QyQ+1zwwLtRfikDRVkCztWY6M7kQEWaMXiZdR2t4=;
 b=oweKBYfyteRHkwKL5CPQ90HJMPsEdjJHMl5u7fYNEmggRglghS7Hx4FpXuQtcRJSDV
 +5INgTH4iKWcR5OeK09/Ve5tbzLEITsZ1LADGCDljVsxfkIfhtVn3nGceFQtWac+1cal
 635gTACbviNLEAGYciT9DKCmddsHhpeyrGtjnX3AuF1R9vbROjwwBp0ZNSI2d5v/6QhW
 +RyX+enKCztXKZMjcgOZLvnDKBYu5mmCgGrb6AngsdY9kAPp0gJb85oG8OSBFHcuNo09
 qMlcF0vFYiA3W3wLMZlL28RML/dEI5Ldb0ZqvTL4CJeOqeB6sdEDk+iASiZn56gvBCgz
 mKNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1SnfhsPGJRibKh54/hdancYEb+0sYrV8aL1U+K9cbftFogIv12/QQCtY/cNkkjY0IfM4Kvsi17bRvw1s5ACfh8SE=
X-Gm-Message-State: AOJu0YwJALqY7xWINzIH0VI8aMPBVpBYX/RDpGjmkUw3Jf09n9K/HB3d
 3IkGwoj57OIgK21zqPhBYH88/Ya/t/mBCNreOfT3ZgDtLw8NaVKiMOF+KyFg6kAcNhr2A5UTwLD
 2/RgtddKKVaei+2t5uPce9vtN46Uk1BsXz9mCcl9lp2CEcekun3M+xONvKYMbLTYPOXs3IowuYC
 7NIJeJTyYzknmFil4OPu1hKVU=
X-Received: by 2002:a17:90a:f298:b0:29e:d30:5b2c with SMTP id
 fs24-20020a17090af29800b0029e0d305b2cmr1727803pjb.18.1710827009662; 
 Mon, 18 Mar 2024 22:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr8Ofr8e1SkUZgzQkQ7oqsr87dHrD8DEC6unZ/Qk8jnotUW9KLWfgzIfYLP/tbWL1rhH/ZKfIhKwZ5PyJwHcU=
X-Received: by 2002:a17:90a:f298:b0:29e:d30:5b2c with SMTP id
 fs24-20020a17090af29800b0029e0d305b2cmr1727795pjb.18.1710827009422; Mon, 18
 Mar 2024 22:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
 <Zfg2E59Pa1uF84di@wegao.115.61.67>
 <CAEemH2c--aHRW5ZqvBZTP2AVuoiKcY4x6GAxcaMb1KgbXVUEDA@mail.gmail.com>
 <20240319050357.GA417761@pevik>
In-Reply-To: <20240319050357.GA417761@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2024 13:43:17 +0800
Message-ID: <CAEemH2eoeuvZB+=9iG0qJ6_2OSAN9S_7R+hq+i1pXFXmY4j_jQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

T24gVHVlLCBNYXIgMTksIDIwMjQgYXQgMTowNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBPbiBNb24sIE1hciAxOCwgMjAyNCBhdCA4OjQw4oCvUE0gV2VpIEdh
byA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4KPgo+Cj4gPiA+ID4gVGhhdCdzIGJlY2F1c2Ug
dGhlIGF2YWlsYWJsZSBzd2FwZmlsZSBvbiB5b3VyIFNVVCBpcyB0b28gc21hbGwsCj4gPiA+ID4g
eW91IGNhbiBhZGp1c3QgaXQgKHRoZW4gcmV0ZXN0IGl0KSBieSB5b3Vyc2VsZiB0byBmaW5kIGEg
cHJvcGVyIHNpemUuCj4KPiA+ID4gPiBUaGlzIGlzIGZpbmUgYXMgbG9uZyBhcyB0aGUgc3dhcGZp
bGUgc2l6ZSBpcyBsZXNzIHRoYW4gMzAwTUIsCj4gPiA+ID4gb3RoZXJ3aXNlIHdlIG5lZWQgdG8g
c2V0IC5kZXZfbWluX3NpemUgbGlrZSB3aGF0IHdlIGRpZAo+ID4gPiA+IGZvciBzd2Fwb2ZmMDEu
Yy4KPgo+ID4gPiA+IEFuZCwgb24gdGhlIG90aGVyIHNpZGUsIHdlIGNhbid0IGd1YXJhbnRlZSB0
aGUgc3lzdGVtIFN3YXBDYWNoZWQKPiA+ID4gPiBoYXBwZW5lZCBldmVyeSB0aW1lLCBpdCBkZXBl
bmRzIG9uIHRoZSBzeXN0ZW0ncyBjb25maWd1cmF0aW9uLgo+Cj4KPiA+ID4gMTAwTSBpcyBnb29k
IGVub3VnaCBmb3IgY3VycmVudCBzeXN0ZW0sIGNvdWxkIHlvdSBoZWxwIGNoZWNrIGZvbGxvd2lu
Zwo+ID4gPiBwYXRjaD8KPgo+Cj4gPiBDYW4gd2UgcmV3cml0ZSB0aGUgbWFrZV9zd2FwZmlsZSgp
IEFQSSB0byBzdXBwb3J0IHBhc3NpbmcgTUIgc2l6ZSBmb3IKPiA+IG1ha2luZyB0aGUgc3dhcGZp
bGU/Cj4KPiBJIGd1ZXNzIGl0IHdvdWxkIGJlIGRlc2lyYWJsZSAoYnV0IGtlZXAgYWxzbyBwb3Nz
aWJsZSB0byBwYXNzIHRoYXQgMTAKPiBibG9ja3MsCj4gdGhlcmVmb3JlIG1heWJlIHVzZSBmbGFn
IHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gTUIgYW5kIGJsb2Nrcz8pLgo+CgpUaGF0J3MgZmluZSBi
dXQgYSBiaXQgY29tcGxleCBmb3IgdXNlcnMgdG8gZGlzdGluZ3Vpc2ggZmxhZ3MuCgpPciwgd2hh
dCBhYm91dCBtYWtpbmcgdGhlIGZ1bmN0aW9uIHVzZSB0aGUgZmxhZyBhcyBzdGF0aWMsIGFuZApl
eHBvcnQgdHdvIGFkZGl0aW9uYWwgZnVuY3Rpb25zIHdpdGggTUIgYW5kIGJsb2Nrcz8KCmVudW0g
c3dhcGZpbGVfbWV0aG9kIHsKICAgIFNXQVBGSUxFX0JZX1NJWkUsCiAgICBTV0FQRklMRV9CWV9C
TE9DS1MKfTsKCnN0YXRpYyBpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmlsZSwg
dW5zaWduZWQgaW50IHBhcmEsIGludCBzYWZlLAplbnVtIHN3YXBmaWxlX21ldGhvZCBtZXRob2Qp
IHsKICAgIC8vIFRoZSBtYWluIGxvZ2ljIHRvIGFjaGlldmUgdGhlIHN3YXBmaWxlLW1ha2luZyBw
cm9jZXNzCiAgICAvLyAuLi4KfQoKaW50IG1ha2Vfc3dhcGZpbGVfc2l6ZShjb25zdCBjaGFyICpz
d2FwZmlsZSwgdW5zaWduZWQgaW50IHNpemUsIGludCBzYWZlKSB7CiAgICByZXR1cm4gbWFrZV9z
d2FwZmlsZShzd2FwZmlsZSwgc2l6ZSwgc2FmZSwgU1dBUEZJTEVfQllfU0laRSk7Cn0KCmludCBt
YWtlX3N3YXBmaWxlX2Jsa3MoY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVkIGludCBibG9j
a3MsIGludCBzYWZlKQp7CiAgICByZXR1cm4gbWFrZV9zd2FwZmlsZShzd2FwZmlsZSwgYmxvY2tz
LCBzYWZlLCBTV0FQRklMRV9CWV9CTE9DS1MpOwp9CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
