Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9038FC3064D
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 09:24:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92113D123A
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:24:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA0143D0D73
 for <ltp@lists.linux.it>; Sun, 23 Jun 2024 19:10:44 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=guoren@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EC93A6014FA
 for <ltp@lists.linux.it>; Sun, 23 Jun 2024 19:10:43 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B6CE462557
 for <ltp@lists.linux.it>; Sun, 23 Jun 2024 17:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031BFC4AF14
 for <ltp@lists.linux.it>; Sun, 23 Jun 2024 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719162640;
 bh=aosSO/S+etUamgM4SS3mlQ3heoMUr6FZbeXpiXEovy0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SHcWkbRTRysffowmKeNtbvp9bhDl+zoDvjEJ2fFDHg7LSDrwqFsJdD9YYXV4Vr+sp
 2E8pAnecGBkfcW3fYWlLjSsfPlPKcXnQ8nJbcMvEmYSYZS0YcgH+rt/qDOrTB8Gvu+
 agZuIo6AmTpr2D4xK4pBnUswovpS9ueZT7VqTzkz0VoNehsJKjKIbT7Hxbmzrk7px2
 nKkeeohgJbLaTj1UD/4bc2iBlfTD7iIkm5ON/CNdK03bV+FGcWIvguDXvdHM+5cgLf
 OB8EHfsL2MFz6vrCmyH5CregCIOmWkoz7MbvmFg/cF39yMwxMHUAlyiXqW1imSaGS0
 Nv1EJ4Jnnv/6A==
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2ebeefb9a6eso38130831fa.1
 for <ltp@lists.linux.it>; Sun, 23 Jun 2024 10:10:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXE5PJIHcS3qGl3okhOqeaFsQd83jiZVUYyu10rSPv2mQ+ZMPOOIV+NmnSHoL2WJkZqlmaiUQLLHhASSBuRPOSsaZU=
X-Gm-Message-State: AOJu0YxPXS2s4nOOVvptpD8jNpyrKCcy7/uZvbfgu8x7zXe7f6tQ5Puh
 Clov6P+ci3DAs/YGStv2LTjdaVSAJTTmaJbz8LA+NJyLEgNvvAvR0Bgj6de3ofEDlx6yulM82H9
 z/Oi0NhLss5jCmg17+FWLKyFI+KE=
X-Google-Smtp-Source: AGHT+IHxMABTsjE/bTBoMOuJE1ctF+u0ZebsEtw1bh3nJ1bb3woGpWj5W/Pz1qQmYslYoKzzGRd0eu1pNlr+yN6Ofzo=
X-Received: by 2002:a2e:3101:0:b0:2ec:1cf1:b74c with SMTP id
 38308e7fff4ca-2ec594cfe8fmr16740431fa.32.1719162638077; Sun, 23 Jun 2024
 10:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-11-arnd@kernel.org>
In-Reply-To: <20240620162316.3674955-11-arnd@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 24 Jun 2024 01:10:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS9xKLSbSN2Scs016Boxzr6TdNxVLr2TYEfbJ0KqSgppw@mail.gmail.com>
Message-ID: <CAJF2gTS9xKLSbSN2Scs016Boxzr6TdNxVLr2TYEfbJ0KqSgppw@mail.gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 27 Jun 2024 11:23:38 +0200
Subject: Re: [LTP] [PATCH 10/15] csky,
 hexagon: fix broken sys_sync_file_range
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
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>,
 linux-mips@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-sh@vger.kernel.org,
 linux-csky@vger.kernel.org, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, musl@lists.openwall.com,
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, ltp@lists.linux.it,
 Brian Cain <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMjEsIDIwMjQgYXQgMTI6MjTigK9BTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4K
Pgo+IEJvdGggb2YgdGhlc2UgYXJjaGl0ZWN0dXJlcyByZXF1aXJlIHU2NCBmdW5jdGlvbiBhcmd1
bWVudHMgdG8gYmUKPiBwYXNzZWQgaW4gZXZlbi9vZGQgcGFpcnMgb2YgcmVnaXN0ZXJzIG9yIHN0
YWNrIHNsb3RzLCB3aGljaCBpbiBjYXNlIG9mCj4gc3luY19maWxlX3JhbmdlIHdvdWxkIHJlc3Vs
dCBpbiBhIHNldmVuLWFyZ3VtZW50IHN5c3RlbSBjYWxsIHRoYXQgaXMKPiBub3QgY3VycmVudGx5
IHBvc3NpYmxlLiBUaGUgc3lzdGVtIGNhbGwgaXMgdGhlcmVmb3JlIGluY29tcGF0aWJsZSB3aXRo
Cj4gYWxsIGV4aXN0aW5nIGJpbmFyaWVzLgo+Cj4gV2hpbGUgaXQgd291bGQgYmUgcG9zc2libGUg
dG8gaW1wbGVtZW50IHN1cHBvcnQgZm9yIHNldmVuIGFyZ3VtZW50cwo+IGxpa2Ugb24gbWlwcywg
aXQgc2VlbXMgYmV0dGVyIHRvIHVzZSBhIHNpeC1hcmd1bWVudCB2ZXJzaW9uLCBlaXRoZXIKPiB3
aXRoIHRoZSBub3JtYWwgYXJndW1lbnQgb3JkZXIgYnV0IG1pc2FsaWduZWQgYXMgb24gbW9zdCBh
cmNoaXRlY3R1cmVzCj4gb3Igd2l0aCB0aGUgcmVvcmRlcmVkIHN5bmNfZmlsZV9yYW5nZTIoKSBj
YWxsaW5nIGNvbnZlbnRpb25zIGFzIG9uCj4gYXJtIGFuZCBwb3dlcnBjLgo+Cj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPgo+IC0tLQo+ICBhcmNoL2Nza3kvaW5jbHVkZS91YXBpL2FzbS91bmlzdGQuaCAgICB8
IDEgKwo+ICBhcmNoL2hleGFnb24vaW5jbHVkZS91YXBpL2FzbS91bmlzdGQuaCB8IDEgKwo+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gvY3Nr
eS9pbmNsdWRlL3VhcGkvYXNtL3VuaXN0ZC5oIGIvYXJjaC9jc2t5L2luY2x1ZGUvdWFwaS9hc20v
dW5pc3RkLmgKPiBpbmRleCA3ZmY2YTI0NjZhZjEuLmUwNTk0YjYzNzBhNiAxMDA2NDQKPiAtLS0g
YS9hcmNoL2Nza3kvaW5jbHVkZS91YXBpL2FzbS91bmlzdGQuaAo+ICsrKyBiL2FyY2gvY3NreS9p
bmNsdWRlL3VhcGkvYXNtL3VuaXN0ZC5oCj4gQEAgLTYsNiArNiw3IEBACj4gICNkZWZpbmUgX19B
UkNIX1dBTlRfU1lTX0NMT05FMwo+ICAjZGVmaW5lIF9fQVJDSF9XQU5UX1NFVF9HRVRfUkxJTUlU
Cj4gICNkZWZpbmUgX19BUkNIX1dBTlRfVElNRTMyX1NZU0NBTExTCj4gKyNkZWZpbmUgX19BUkNI
X1dBTlRfU1lOQ19GSUxFX1JBTkdFMgpGb3IgY3NreSBwYXJ0LgpBY2tlZC1ieTogR3VvIFJlbiA8
Z3VvcmVuQGtlcm5lbC5vcmc+Cgo+ICAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvdW5pc3RkLmg+Cj4K
PiAgI2RlZmluZSBfX05SX3NldF90aHJlYWRfYXJlYSAgIChfX05SX2FyY2hfc3BlY2lmaWNfc3lz
Y2FsbCArIDApCj4gZGlmZiAtLWdpdCBhL2FyY2gvaGV4YWdvbi9pbmNsdWRlL3VhcGkvYXNtL3Vu
aXN0ZC5oIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvdWFwaS9hc20vdW5pc3RkLmgKPiBpbmRleCA0
MzJjNGRiMWI2MjMuLjIxYWUyMjMwNmI1ZCAxMDA2NDQKPiAtLS0gYS9hcmNoL2hleGFnb24vaW5j
bHVkZS91YXBpL2FzbS91bmlzdGQuaAo+ICsrKyBiL2FyY2gvaGV4YWdvbi9pbmNsdWRlL3VhcGkv
YXNtL3VuaXN0ZC5oCj4gQEAgLTM2LDUgKzM2LDYgQEAKPiAgI2RlZmluZSBfX0FSQ0hfV0FOVF9T
WVNfVkZPUksKPiAgI2RlZmluZSBfX0FSQ0hfV0FOVF9TWVNfRk9SSwo+ICAjZGVmaW5lIF9fQVJD
SF9XQU5UX1RJTUUzMl9TWVNDQUxMUwo+ICsjZGVmaW5lIF9fQVJDSF9XQU5UX1NZTkNfRklMRV9S
QU5HRTIKPgo+ICAjaW5jbHVkZSA8YXNtLWdlbmVyaWMvdW5pc3RkLmg+Cj4gLS0KPiAyLjM5LjIK
PgoKCi0tIApCZXN0IFJlZ2FyZHMKIEd1byBSZW4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
