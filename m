Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748DDCDB474
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 14:18:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 033923CECD3
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:18:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 331363C8524
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 18:43:57 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A30D6008AC
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 18:43:56 +0200 (CEST)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-49e15724283so1031883e0c.1
 for <ltp@lists.linux.it>; Mon, 09 Oct 2023 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869835; x=1697474635; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h74o2AZcTC7GyQaZvo8+es5i4OkJLBnswUlj7gMbv2U=;
 b=JP7JGQsUX9frT7ph2G082bV9HoV8EKFJstVwtWyg/JT0j/ICd4tlj7yg4YgYCIDkbE
 o8UYkLHbG98z6rojlWUc57BouFrrQcpTWhN7Fs6XC+jzlXsTrRr18ayljhCcRJRQeNjq
 QuwH+g0scV+tHyfIDfozDzMfV+rDBZitQC8RW77CzHm2eY3JYahwnj1diR8kLKyp6X1O
 nUNLX1cgwOP/nxwiDxm38Js//GPJBpwTjb6kK5PASPWUt8iegOqHYpFstW41XMtqOa3A
 sZi4bWPHOtJbayYnO9VqxllkXV0mzVdXSon7jJlgZ/lq4jsX2p31oFkI0/iNElyd6MUL
 9nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869835; x=1697474635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h74o2AZcTC7GyQaZvo8+es5i4OkJLBnswUlj7gMbv2U=;
 b=GBpzbKpv5bdX3Ote9P+spa9dS8HrIaKq/i6jWpYuI5v7KjVWW23pvHDvu7C0q7ENxX
 d/+QChGEoPLs0HMvhye9UeyyMm6lRlZ2BTCkD+X2457mjGx48rBpTdmLI3rIMZf/6/oa
 ESEwe0/EN5CClNFPqwFZAx6wskreG7dilhXbJdfiqAtUQHBZr6lcREv6KAhBXmOKg6lw
 ybDIRlP3raDHOM218xjGJv/dD0XqPXW49s62ikkVvAMXAntRr7n9qDyYzfgEnMZyjyR/
 qObRpQx7SdgVoTaJFG78lCeZBJqLYs2zKTeB9f4jLEnPuLz692n7AGSOQdvNylx2gndc
 TChA==
X-Gm-Message-State: AOJu0YyWVruLF+u4jzKgDTMTAUlfk5RdwlYd55Sc4a9uSjEIm7OZ7guW
 GXfXQ91zXkBHrXdjH5PslZRax7D50DKP3G2nkNqLeQ==
X-Google-Smtp-Source: AGHT+IEkXqZBLHppN9aD1rPab7CXnRnbSPIio7BIWqrTQXvtR6190yK7ITH0FWBWUzGCmJoQh0UXep8/jjC65cWusQM=
X-Received: by 2002:a1f:d686:0:b0:49d:a52a:441f with SMTP id
 n128-20020a1fd686000000b0049da52a441fmr12470392vkg.7.1696869835132; Mon, 09
 Oct 2023 09:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org>
 <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <CAEUSe78O-Ho=22nTeioT4eqPRoDNfcWCpc=5O=B59eaMvOkzpg@mail.gmail.com>
 <2023100755-livestock-barcode-fe41@gregkh>
In-Reply-To: <2023100755-livestock-barcode-fe41@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 9 Oct 2023 22:13:42 +0530
Message-ID: <CA+G9fYvzV03=-LTmburzzwRpw0xuxoAXBKo0n1muYwOOiVG_bw@mail.gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Oct 2023 16:18:31 +0200
Subject: Re: [LTP] [PATCH 6.1 000/259] 6.1.56-rc1 review
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
Cc: lkft-triage@lists.linaro.org, patches@lists.linux.dev,
 Olga Kornievskaia <kolga@netapp.com>, stable@vger.kernel.org, shuah@kernel.org,
 f.fainelli@gmail.com, jonathanh@nvidia.com, patches@kernelci.org,
 linux@roeck-us.net, srw@sladewatkins.net,
 Richard Palethorpe <rpalethorpe@suse.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LTP List <ltp@lists.linux.it>, linux-nfs@vger.kernel.org,
 Eryu Guan <eguan@redhat.com>, rwarsow@gmx.de, pavel@denx.de,
 linux-kernel@vger.kernel.org, conor@kernel.org, sudipm.mukherjee@gmail.com,
 Benjamin Coddington <bcodding@redhat.com>, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCA3IE9jdCAyMDIzIGF0IDE0OjI4LCBHcmVnIEtyb2FoLUhhcnRtYW4KPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPgo+IE9uIEZyaSwgT2N0IDA2LCAyMDIzIGF0IDEy
OjQyOjA0UE0gLTA2MDAsIERhbmllbCBEw61heiB3cm90ZToKPiA+IEhlbGxvIQo+ID4KPiA+IE9u
IFRodSwgNSBPY3QgMjAyMyBhdCAxMDo0MCwgTmFyZXNoIEthbWJvanUgPG5hcmVzaC5rYW1ib2p1
QGxpbmFyby5vcmc+IHdyb3RlOgo+ID4gPiBPbiBXZWQsIDQgT2N0IDIwMjMgYXQgMjM6NDEsIEdy
ZWcgS3JvYWgtSGFydG1hbgo+ID4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3Rl
Ogo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBpcyB0aGUgc3RhcnQgb2YgdGhlIHN0YWJsZSByZXZpZXcg
Y3ljbGUgZm9yIHRoZSA2LjEuNTYgcmVsZWFzZS4KPiA+ID4gPiBUaGVyZSBhcmUgMjU5IHBhdGNo
ZXMgaW4gdGhpcyBzZXJpZXMsIGFsbCB3aWxsIGJlIHBvc3RlZCBhcyBhIHJlc3BvbnNlCj4gPiA+
ID4gdG8gdGhpcyBvbmUuICBJZiBhbnlvbmUgaGFzIGFueSBpc3N1ZXMgd2l0aCB0aGVzZSBiZWlu
ZyBhcHBsaWVkLCBwbGVhc2UKPiA+ID4gPiBsZXQgbWUga25vdy4KPiA+ID4gPgo+ID4gPiA+IFJl
c3BvbnNlcyBzaG91bGQgYmUgbWFkZSBieSBGcmksIDA2IE9jdCAyMDIzIDE3OjUxOjEyICswMDAw
Lgo+ID4gPiA+IEFueXRoaW5nIHJlY2VpdmVkIGFmdGVyIHRoYXQgdGltZSBtaWdodCBiZSB0b28g
bGF0ZS4KPiA+ID4gPgo+ID4gPiA+IFRoZSB3aG9sZSBwYXRjaCBzZXJpZXMgY2FuIGJlIGZvdW5k
IGluIG9uZSBwYXRjaCBhdDoKPiA+ID4gPiAgICAgICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
cHViL2xpbnV4L2tlcm5lbC92Ni54L3N0YWJsZS1yZXZpZXcvcGF0Y2gtNi4xLjU2LXJjMS5nego+
ID4gPiA+IG9yIGluIHRoZSBnaXQgdHJlZSBhbmQgYnJhbmNoIGF0Ogo+ID4gPiA+ICAgICAgICAg
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51
eC1zdGFibGUtcmMuZ2l0IGxpbnV4LTYuMS55Cj4gPiA+ID4gYW5kIHRoZSBkaWZmc3RhdCBjYW4g
YmUgZm91bmQgYmVsb3cuCj4gPiA+ID4KPiA+ID4gPiB0aGFua3MsCj4gPiA+ID4KPiA+ID4gPiBn
cmVnIGstaAo+ID4gPgo+ID4gPiBSZXN1bHRzIGZyb20gTGluYXJv4oCZcyB0ZXN0IGZhcm0uCj4g
PiA+IFJlZ3Jlc3Npb25zIG9uIGFybTY0IGJjbTI3MTEtcnBpLTQtYiBkZXZpY2UgcnVubmluZyBM
VFAgZGlvIHRlc3RzIG9uCj4gPiA+IE5GUyBtb3VudGVkIHJvb3Rmcy4KPiA+ID4gYW5kIExUUCBo
dWdldGxiIGh1Z2VtbWFwMTEgdGVzdCBjYXNlIGZhaWxlZCBvbiB4ODYgYW5kIGFybTY0IGJjbTI3
MTEtcnBpLTQtYi4KPiA+ID4KPiA+ID4gUmVwb3J0ZWQtYnk6IExpbnV4IEtlcm5lbCBGdW5jdGlv
bmFsIFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4KPiA+ID4KPiA+ID4gTFRQIGh1Z2V0bGIgdGVz
dHMgZmFpbGVkIGxvZwo+ID4gPiAgIHRzdF9odWdlcGFnZS5jOjgzOiBUSU5GTzogMSBodWdlcGFn
ZShzKSByZXNlcnZlZAo+ID4gPiAgIHRzdF90ZXN0LmM6MTU1ODogVElORk86IFRpbWVvdXQgcGVy
IHJ1biBpcyAwaCAwNW0gMDBzCj4gPiA+ICAgaHVnZW1tYXAxMS5jOjQ3OiBURkFJTDogTWVtb3J5
IG1pc21hdGNoIGFmdGVyIERpcmVjdC1JTyB3cml0ZQo+ID4gPgo+ID4gPiBMVFAgZGlvIHRlc3Rz
IGZhaWxlZCBsb2cKPiA+ID4gICBjb21wYXJlX2ZpbGU6IGNoYXIgbWlzbWF0Y2g6IGluZmlsZSBv
ZmZzZXQgNDA5NjogMHgwMSAuICAgb3V0ZmlsZQo+ID4gPiBvZmZzZXQgNDA5NjogMHgwMCAuCj4g
PiA+ICAgZGlvdGVzdDAxICAgIDEgIFRGQUlMICA6ICBkaW90ZXN0MS5jOjE1ODogZmlsZSBjb21w
YXJlIGZhaWxlZCBmb3IKPiA+ID4gaW5maWxlIGFuZCBvdXRmaWxlCj4gPgo+ID4gQmlzZWN0aW9u
IGxlZCB0byAiTkZTOiBGaXggT19ESVJFQ1QgbG9ja2luZyBpc3N1ZXMiICh1cHN0cmVhbSBjb21t
aXQKPiA+IDdjNjMzOTMyMmNlMGM2MTI4YWNiZTM2YWFjYzFlZWI5ODZkZDdiZjEpLiBSZXZlcnRp
bmcgdGhhdCBwYXRjaCBhbmQKPiA+ICJORlM6IEZpeCBlcnJvciBoYW5kbGluZyBmb3IgT19ESVJF
Q1Qgd3JpdGUgc2NoZWR1bGluZyIgKHVwc3RyZWFtCj4gPiBjb21taXQgOTU0OTk4YjYwY2FhOGYy
YTNiZjNhYmU0OTBkZTZmMDhkMjgzNjg3YSkgKG5vdCBhIGNsZWFuIHJldmVydAo+ID4gdGhpcyBv
bmUpIG1hZGUgbHRwLWRpbyBwYXNzIGFnYWluLgo+Cj4gU28gdGhpcyBpcyBhbHNvIGFuIGlzc3Vl
IGluIExpbnVzJ3MgdHJlZT8gIE9yIGlzIGl0IG9ubHkgb24gdGhlIDYuMS55CgogSXQgaXMgb25s
eSBvbiB0aGUgNi4xLnkgYnJhbmNoLgoKLSBOYXJlc2gKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
