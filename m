Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF4CD6E5D
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDF463E1DBC
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:40:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60A2A3E1DBC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:40:23 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C932D1400055
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:40:22 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8ccf6a63a45so38377016d6.3
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780400421; x=1781005221; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnBYg5hnE4WCOHvBTB+HKnapNFbx4EtQJ/nPrD+tB7I=;
 b=gxBNj6dfmJQQ4c4kMPdklO0XwoaKcFLCReLOmfhbL0rgOyPG/k45HPcEaIn7MR8m2t
 c30Ge+qjwFJiGceyk6OltJxtSSo2DAE2Xs4hfTmBttpm8fGSOo+Ms3nR2JakFfVwWXaz
 q61B+X5QjrvvIRAqD82uDtWwXy9o9kVX1a/G/2RxRBBoSZGcr70I/mlzKgzaaMXWmlp6
 GRz/A5aSQ4LBqK6zzeHDYeo9CBGRt29Bl6f2AjIaqbfaKMLffQXpfsg6ZQIT/DqPbkYR
 moKlObiKxuIjHfFbeYgCS0tkeunuz0vI2Hj7SfSlmF4ASRNYGX68k3/mhg4xB96TEK/z
 DKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780400421; x=1781005221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnBYg5hnE4WCOHvBTB+HKnapNFbx4EtQJ/nPrD+tB7I=;
 b=Z/GsR8/b/9PHS2/jHCVm42sx1HyOkRyof5Jne2dK+mwqX+YmY61Ci4S2O7A45cxy2W
 KXbTx2AMa+k6L/9OfRcxGd7AH2daK7ENJ0AkCEKcesOxMaxQiTayfQ+QyjpxUj1j+keg
 Y7vQjQyHGeB4NX7zmYdrdcQl7LS4Xc2vJ1Tehy8G937hAbtOblTEhKWbSPI6WLm7dxeT
 iTFc2dSN8f8Iad3Fd8+KZaDbtsO6fdjv5QU0x9S72//gVnhs5MyuLCcMD+TS+TqPOCO0
 r7iqbdbGea9RvUFjVf9knGHCBs+QyXDbniga9xOtNu1pvNAqJ5IU5eGpPXIiftKrR9Uu
 lJuA==
X-Gm-Message-State: AOJu0YzLnCm3JzSqtm+fvo3usZMDucm6zaw6fsKWazehqohE8NAtJnpj
 HKvOk3IHuADXmUsRIOOaV6HWzavQeHvck1Z3SiJP+3J9PXJGOtL8XOJM
X-Gm-Gg: Acq92OEl4gtekIGwIukFRoXrfNR8sc9acKP1++/sfob0SMk6QajIXWBKl52MSPt1I40
 uaUVFEpDFgt3dWMue8kxXsNPvSr0jF3ApkuqpRm+HsHAst+A57FUutxf7E6eU+dnIS3PDMdtDUH
 18wwt4jO86WnibiA3497GRl+0+gFgbcaIeWILlY00Nn4C9+zaFsMXqx93yrj8LHAhQavzdfZxtH
 IXzo2oe21TarpSg7Utf5WI5KW+xx68Sebt8EDjO+DiuJU9Hr9FsxVuWA9kK/DZGnGNh4Ei1DBCX
 CXrhJYHuM799BUcFyNEyoRbAvmkvN10Og7LU4y1ltITPwKU95qsgBsT9faNaOfu8uKzya87AKeu
 RIo5SzArQ7DUj0rcZO9Jr5iKw6RmNZkhcv9ze2vxd5hjNaZsD4Q9ATJJa/lDl9N+HLCNofSIZzi
 6EPZPeO97Io0u5TBmuXdKkTO6W1IMX5Xyk5igpNqL5JrO9bj3r0mtCZKpUd2dNdOLIjBcKc42BS
 t+nScZLXfPFHgZgtEa71pwz2Ksm8YC5A6xhZHjv1hc/qRIddTwOAOT6ewI=
X-Received: by 2002:a05:6214:8002:b0:8ce:aafb:452b with SMTP id
 6a1803df08f44-8ceaafb4723mr138924376d6.40.1780400421481; 
 Tue, 02 Jun 2026 04:40:21 -0700 (PDT)
Received: from
 runnervm3jyl0.y3u3p3xfq4cuvcwo3255dnwsqe.bx.internal.cloudapp.net
 ([40.76.239.38]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea08d945sm116468126d6.20.2026.06.02.04.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:40:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue,  2 Jun 2026 11:40:20 +0000
Message-ID: <20260602114020.4465-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602-doc_add_missing_headers-v2-1-9ccd988c093d@suse.com>
References: <20260602-doc_add_missing_headers-v2-1-9ccd988c093d@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

SGkgQW5kcmVhLAoKdGhhbmsgeW91IGZvciB0aGUgZG9jdW1lbnRhdGlvbiBzZXJpZXMuIEEgZmV3
IGlzc3VlcyBiZWxvdy4KCi0tLQoKW1BBVENIIDEvM10gZG9jOiBBZGQgU0FGRV8qIG1hY3JvcyBy
ZWZlcmVuY2UgcGFnZQoKQ2xhaW06ICJsaXN0aW5nIGFsbCAyNDUgU0FGRV8qIHdyYXBwZXIgbWFj
cm9zIgpWZXJpZmllZDogMjUyIHVuaXF1ZSBTQUZFXyogbWFjcm8gbmFtZXMgaW4gaW5jbHVkZS87
IHRoZSA3IG5vdCBsaXN0ZWQKYXJlIGhlYWRlciBndWFyZHMgKFNBRkVfTUFDUk9TX0ZOX0hfXywg
U0FGRV9ORVRfRk5fSF9fLApTQUZFX1NURElPX0ZOX0hfXywgU0FGRV9SVF9TSUdOQUxfSF9fKSBh
bmQgaW50ZXJuYWwgaGVscGVycwooU0FGRV9GSUxFX09QUywgU0FGRV9GSUxFX09QU19GTiwgU0FG
RV9JT0NUTF8pLiAgQ291bnQgMjQ1IGlzIGNvcnJlY3QuCgpObyBvdGhlciBpc3N1ZXMgZm91bmQg
aW4gdGhpcyBjb21taXQuCgotLS0KCltQQVRDSCAyLzNdIGRvYzogQ29tcGxldGUgc3RydWN0IHRz
dF90ZXN0IHRhYmxlIGFuZCBzaGVsbCBBUEkgZG9jcwoKQ2xhaW06ICJBZGQgOCBtaXNzaW5nIHN0
cnVjdCB0c3RfdGVzdCBmaWVsZHMiClZlcmlmaWVkOiAuZmlsZXN5c3RlbXMsIC5mb3Jrc19jaGls
ZCwgLm1pbl9ydW50aW1lLCAubmVlZHNfYWJpX2JpdHMsCi5uZWVkc19jZ3JvdXBfbnNkZWxlZ2F0
ZSwgLm5lZWRzX2Nncm91cF92ZXIsIC5uZWVkc19odWdldGxiZnMsCi5ydW5zX3NjcmlwdCDigJQg
YWxsIHByZXNlbnQgaW4gaW5jbHVkZS90c3RfdGVzdC5oLiAgQ291bnQgOCBpcyBjb3JyZWN0LgoK
QWxwaGFiZXRpY2FsIGZpeHVwICgubW50X2ZsYWdzIOKGlCAubWluX3N3YXBfYXZhaWwpOiB2ZXJp
ZmllZCBjb3JyZWN0LgoKU2hlbGwgQVBJIHZhcmlhYmxlczogc3BvdC1jaGVja2VkIFRTVF9ORUVE
U19LQ09ORklHU19JRlMsIFRTVF9GU19UWVBFCihkZWZhdWx0IGV4dDIpLCBUU1RfVEVTVF9EQVRB
X0lGUyAoZGVmYXVsdCBzcGFjZSksIGNoZWNrcG9pbnQgZnVuY3Rpb25zCmFuZCByZXRyeSBoZWxw
ZXJzIOKAlCBhbGwgYWNjdXJhdGUuCgpObyBpc3N1ZXMgZm91bmQgaW4gdGhpcyBjb21taXQuCgot
LS0KCltQQVRDSCAzLzNdIGRvYzogQWRkIG1pc3NpbmcgQVBJIHJlZmVyZW5jZXMgdG8gYXBpX2Nf
dGVzdHMucnN0CgpDbGFpbTogIjEwIGhlYWRlcnMiIGFkZGVkLgpWZXJpZmllZCBpbiB0aGUgYXBp
X2NfdGVzdHMucnN0IGRpZmY6CiAgdHNlX3VpbnB1dC5oLCB0c3RfY2xvbmUuaCwgdHN0X2Rldmlj
ZS5oLCB0c3RfZnMuaCwKICB0c3RfZnV6enlfc3luYy5oLCB0c3RfaHVnZXBhZ2UuaCwgdHN0X2tj
b25maWcuaCwgdHN0X21lbXV0aWxzLmgsCiAgdHN0X3NhZmVfZmlsZV9vcHMuaCwgdHN0X3RhaW50
Lmgg4oCUIGNvdW50IDEwIGlzIGNvcnJlY3QuCgpDbGFpbTogcmVtb3ZpbmcgQHBhcmFtLCBAcmV0
dXJuLCBAcmVsYXRlcywgQHNhIERveHlnZW4gZGlyZWN0aXZlcy4KVmVyaWZpZWQ6IEBwYXJhbSBp
biB0c3Rfa2NvbmZpZy5oLCBAcmV0dXJuIGluIHRzdF9kZXZpY2UuaCwKQHNhIGFuZCBAcmVsYXRl
cyBpbiB0c3RfZnV6enlfc3luYy5oIOKAlCBhbGwgcmVtb3ZlZC4gQ29ycmVjdC4KCkJVRyAxIOKA
lCBpbmNsdWRlL3RzdF9kZXZpY2UuaDogbWlzc2luZyBibGFuayBsaW5lCgpBZnRlciB0aGUgcGF0
Y2gsIHRzdF9tb3VudF9oYXNfb3B0KCkncyBkZWNsYXJhdGlvbiBpcyBpbW1lZGlhdGVseQpmb2xs
b3dlZCBieSB0aGUga2VybmVsLWRvYyBjb21tZW50IGZvciB0c3RfaXNfbW91bnRlZCgpIHdpdGgg
bm8KYmxhbmsgbGluZSBiZXR3ZWVuIHRoZW0uICBFdmVyeSBvdGhlciBjb25zZWN1dGl2ZSBmdW5j
dGlvbiBwYWlyIGluCnRoZSBmaWxlICh0c3RfaXNfbW91bnRlZCAvIHRzdF9pc19tb3VudGVkX3Jv
LCB0c3RfaXNfbW91bnRlZF9ybyAvCnRzdF9pc19tb3VudGVkX3J3LCBldGMuKSBoYXMgYSBibGFu
ayBsaW5lIHNlcGFyYXRpbmcgdGhlIGRlY2xhcmF0aW9uCmZyb20gdGhlIG5leHQgLyoqIGJsb2Nr
LiAgUGxlYXNlIGFkZCB0aGUgbWlzc2luZyBibGFuayBsaW5lOgoKPiBpbnQgdHN0X21vdW50X2hh
c19vcHQoY29uc3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqb3B0KTsKPiAvKioKPiAgKiB0c3Rf
aXNfbW91bnRlZCgpIC0gQ2hlY2sgaWYgYSBwYXRoIGlzIGEgbW91bnQgcG9pbnQuCgpTaG91bGQg
YmU6CgogIGludCB0c3RfbW91bnRfaGFzX29wdChjb25zdCBjaGFyICpwYXRoLCBjb25zdCBjaGFy
ICpvcHQpOwoKICAvKioKICAgKiB0c3RfaXNfbW91bnRlZCgpIC0gQ2hlY2sgaWYgYSBwYXRoIGlz
IGEgbW91bnQgcG9pbnQuCgpCVUcgMiDigJQgaW5jbHVkZS90c3Rfa2NvbmZpZy5oOiBUU1RfS0NP
TkZJR19JTklUKCkgZHJvcHMgc3RyaW5nLmggbm90ZQoKVGhlIG9yaWdpbmFsIGNvbW1lbnQgcmVh
ZDoKICAiSW5pdGlhbGl6YXRpb24gaGVscGVyIG1hY3JvIGZvciBzdHJ1Y3QgdHN0X2tjb25maWdf
dmFyLgogICBSZXF1aXJlcyA8c3RyaW5nLmg+IgoKVGhlIG5ldyBrZXJuZWwtZG9jIGNvbW1lbnQg
b21pdHMgdGhlIDxzdHJpbmcuaD4gcmVxdWlyZW1lbnQ6CiAgIlRTVF9LQ09ORklHX0lOSVQoKSAt
IEluaXRpYWxpemF0aW9uIGhlbHBlciBtYWNybyBmb3Igc3RydWN0CiAgIHRzdF9rY29uZmlnX3Zh
ci4iCgpUaGUgbWFjcm8gZXhwYW5kcyB0byB7IC5pZF9sZW4gPSBzdHJsZW4oY29uZm5hbWUpIH0s
IHdoaWNoIHJlcXVpcmVzCnN0cmxlbigpLiAgdHN0X2tjb25maWcuaCBpbmNsdWRlcyBvbmx5IDxz
dGRib29sLmg+IGFuZCA8c3RkZGVmLmg+LApub3QgPHN0cmluZy5oPi4gIFRoZSBvcmlnaW5hbCAi
UmVxdWlyZXMgPHN0cmluZy5oPiIgbm90ZSB3YXMgdGhlcmUgZm9yCmEgcmVhc29uLiAgUGxlYXNl
IHByZXNlcnZlIGl0LCBlLmcuOgoKICAvKioKICAgKiBUU1RfS0NPTkZJR19JTklUKCkgLSBJbml0
aWFsaXphdGlvbiBoZWxwZXIgbWFjcm8gZm9yIHN0cnVjdAogICAqICAgICB0c3Rfa2NvbmZpZ192
YXIuIFJlcXVpcmVzIDxzdHJpbmcuaD4gZm9yIHN0cmxlbigpLgogICAqIEBjb25mbmFtZTogQ29u
ZmlnIHZhcmlhYmxlIG5hbWUgc3RyaW5nLgogICAqLwoKTUlOT1Ig4oCUIGluY2x1ZGUvdHN0X2Rl
dmljZS5oOiB0c3RfZGV2aWNlIGdsb2JhbCB1c2VzIC8qIG5vdCAvKioKClRoZSB0c3RfZGV2aWNl
IGV4dGVybiBwb2ludGVyOgoKICAvKgogICAqIHRzdF9kZXZpY2UgLSBQb2ludGVyIHRvIHRoZSB0
ZXN0IGJsb2NrIGRldmljZS4KICAgKiAuLi4KICAgKi8KICBleHRlcm4gc3RydWN0IHRzdF9kZXZp
Y2UgKnRzdF9kZXZpY2U7Cgp1c2VzIGEgcGxhaW4gLyogY29tbWVudCwgc28gdGhlIGtlcm5lbC1k
b2MgZXh0cmFjdG9yIHdpbGwgbm90IGVtaXQgYW4KZW50cnkgZm9yIGl0IGV2ZW4gdGhvdWdoIGFw
aV9jX3Rlc3RzLnJzdCBub3cgaW5jbHVkZXMKYC4uIGtlcm5lbC1kb2M6OiAuLi8uLi9pbmNsdWRl
L3RzdF9kZXZpY2UuaGAuICBUaGUgc3RydWN0IHRzdF9kZXZpY2UKZG9jIGJsb2NrIGFib3ZlIGFs
cmVhZHkgY2FycmllcyB0aGUgIkF1dG9tYXRpY2FsbHkgaW5pdGlhbGl6ZWQgaWYKdHN0X3Rlc3Qu
bmVlZHNfZGV2aWNlIGlzIHNldC4iIG5vdGUsIHNvIHRoaXMgbWF5IGJlIGludGVudGlvbmFsLgpJ
ZiB0aGUgaW50ZW50IGlzIHRvIGhhdmUgdGhlIHZhcmlhYmxlIGFwcGVhciBpbiB0aGUgQVBJIGRv
Y3MsIGNoYW5nZQovKiB0byAvKiouCgotLS0KClZlcmRpY3Q6IE5lZWRzIHJldmlzaW9uIChCVUcg
MSBhbmQgQlVHIDIgYWJvdmUpLgoKTFRQIEFJIFJldmlld2VyCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
