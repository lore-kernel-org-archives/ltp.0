Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10A2C3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:32:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB1573D3EBB
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:32:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AC163D3EA4
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:32:37 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E90311401237
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719905555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SFluZ0LfjneULvzCXSEU2FosA5o0GC6pYW/BcZ6v69Q=;
 b=ZTSHwtYvFKBwDGTGBMcTdYr2dMFQSF0SjxmN6imTfwYLFMijL/ZfBC3a4oqvOsZhcPJBG7
 RlT6m5Ju55v6uY7vUkaaWAqJgx/ladDi/cssectqjXp3uPycJ/5c25MGTuegnzRsGe87bj
 te3qRoa+OoP7NrpkgJrjeJUGyaHh+4Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-8muumhruMNmqyoIHQ7eJww-1; Tue, 02 Jul 2024 03:32:32 -0400
X-MC-Unique: 8muumhruMNmqyoIHQ7eJww-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c961f68638so201893a91.2
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 00:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719905550; x=1720510350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SFluZ0LfjneULvzCXSEU2FosA5o0GC6pYW/BcZ6v69Q=;
 b=NLpE/25CXgA8B6GRp1fqnWeyjt5bd3dOsBBlwTTKB75VlfX8TIcdpy2Cj3NCSfXFQr
 rAlyxYc00RYjwU4LcJi2L6AQjE2Pn+pbKR3iz5DugJPlDOm4VOw7hkO5b2+75Cv/EY6T
 MwlEjoyHWiwPdmuPwl1Lpd9siXQEpLjRGkArQPnj8riT3b1Yb7kxDe4xUZhgsSX9hE3D
 zlTrqj0rUFhBfDKBPKC5NP7S2mNQednEkoGToO072dFvIj47GPh6Ow0k53AE8Q+OLqhz
 DlHu0qSRnq7qrFxmDuf/1wN8vUt3AlqmDmo6eBPmf34Vc7dAUs1e8zLe3D0c4YBNtWmm
 JGdA==
X-Gm-Message-State: AOJu0YxJlgJk1U1GtKMzpmpmakGkwID1syBW1+KMIBS2DjU5P7GS0the
 GQkfJDnmD01bzB+YSknNTHUxngTR73ivHQoeViSC9UQRrMyeBYC+MdxNAgXPVKyvo+0HPn2QpZO
 yZpXqF+C4J0tBoiHV+mfsSrN508dEpLoKrNPbzjUTiH1RK90pivSQOmO5f38UuLBZ4tkZAcLQvy
 U+a0SBgGeXyK1MFNWrSyypQuyBVHRhImmhpMNr
X-Received: by 2002:a17:90a:6d62:b0:2bf:de8b:bef5 with SMTP id
 98e67ed59e1d1-2c93d7042d4mr6104304a91.12.1719905549847; 
 Tue, 02 Jul 2024 00:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6Exeotp1i6AD2lSUV+90rHO3eOWy5HeJzCNtTMk2KcAO1RKMYDcFWnRbTn0RZOUIwIBnikZgDmRzrnyE3AU=
X-Received: by 2002:a17:90a:6d62:b0:2bf:de8b:bef5 with SMTP id
 98e67ed59e1d1-2c93d7042d4mr6104291a91.12.1719905549432; Tue, 02 Jul 2024
 00:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-2-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-2-58e9af649a72@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 15:32:17 +0800
Message-ID: <CAEemH2dUH+SM9_EALFtuNOq1v=1dSXOvsvxSk2pgOJknZ3VcgQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 02/10] Add lapi/landlock.h fallback
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

T24gTW9uLCBKdWwgMSwgMjAyNCBhdCAxMTo0M+KAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVz
YXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICBjb25maWd1cmUuYWMgICAg
ICAgICAgICB8ICAgNSArKwo+ICBpbmNsdWRlL2xhcGkvbGFuZGxvY2suaCB8IDEyMAo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAyIGZpbGVzIGNo
YW5nZWQsIDEyNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlLmFjIGIv
Y29uZmlndXJlLmFjCj4gaW5kZXggODI5NjliOGQzLi5lNWYwYzlmNzcgMTAwNjQ0Cj4gLS0tIGEv
Y29uZmlndXJlLmFjCj4gKysrIGIvY29uZmlndXJlLmFjCj4gQEAgLTE1Nyw2ICsxNTcsNyBAQCBB
Q19DSEVDS19GVU5DU19PTkNFKFsgXAo+ICBBQ19DSEVDS19GVU5DUyhta2R0ZW1wLFtdLEFDX01T
R19FUlJPUihta2R0ZW1wKCkgbm90IGZvdW5kISkpCj4KPiAgQUNfQ0hFQ0tfTUVNQkVSUyhbc3Ry
dWN0IGZhbm90aWZ5X2V2ZW50X2luZm9fZmlkLmZzaWQuX192YWxdLCwsWyNpbmNsdWRlCj4gPHN5
cy9mYW5vdGlmeS5oPl0pCj4gK0FDX0NIRUNLX01FTUJFUlMoW3N0cnVjdAo+IGxhbmRsb2NrX3J1
bGVzZXRfYXR0ci5oYW5kbGVkX2FjY2Vzc19uZXRdLCwsWyNpbmNsdWRlIDxsaW51eC9sYW5kbG9j
ay5oPl0pCj4gIEFDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCBwZXJmX2V2ZW50X21tYXBfcGFnZS5h
dXhfaGVhZF0sLCxbI2luY2x1ZGUKPiA8bGludXgvcGVyZl9ldmVudC5oPl0pCj4gIEFDX0NIRUNL
X01FTUJFUlMoW3N0cnVjdCBzaWdhY3Rpb24uc2Ffc2lnYWN0aW9uXSxbXSxbXSxbI2luY2x1ZGUK
PiA8c2lnbmFsLmg+XSkKPiAgQUNfQ0hFQ0tfTUVNQkVSUyhbc3RydWN0IHN0YXR4LnN0eF9tbnRf
aWQsIHN0cnVjdAo+IHN0YXR4LnN0eF9kaW9fbWVtX2FsaWduXSwsLFsKPiBAQCAtMTcwLDYgKzE3
MSw3IEBAIEFDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCB1dHNuYW1lLmRvbWFpbm5hbWVdLCwsWwo+
ICBdKQo+Cj4gIEFDX0NIRUNLX1RZUEVTKFtlbnVtIGtjbXBfdHlwZV0sLCxbI2luY2x1ZGUgPGxp
bnV4L2tjbXAuaD5dKQo+ICtBQ19DSEVDS19UWVBFUyhbZW51bSBsYW5kbG9ja19ydWxlX3R5cGVd
LCwsWyNpbmNsdWRlIDxsaW51eC9sYW5kbG9jay5oPl0pCj4gIEFDX0NIRUNLX1RZUEVTKFtzdHJ1
Y3QgYWNjdF92M10sLCxbI2luY2x1ZGUgPHN5cy9hY2N0Lmg+XSkKPiAgQUNfQ0hFQ0tfVFlQRVMo
W3N0cnVjdCBhZl9hbGdfaXYsIHN0cnVjdCBzb2NrYWRkcl9hbGddLCwsWyMgaW5jbHVkZQo+IDxs
aW51eC9pZl9hbGcuaD5dKQo+ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IGZhbm90aWZ5X2V2ZW50
X2luZm9fZmlkLCBzdHJ1Y3QKPiBmYW5vdGlmeV9ldmVudF9pbmZvX2Vycm9yLAo+IEBAIC0xOTAs
NiArMTkyLDkgQEAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBpZl9uZXh0ZHFibGtdLCwsWyNpbmNs
dWRlCj4gPGxpbnV4L3F1b3RhLmg+XSkKPiAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBpb3ZlY10s
LCxbI2luY2x1ZGUgPHN5cy91aW8uaD5dKQo+ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IGlwYzY0
X3Blcm1dLCwsWyNpbmNsdWRlIDxzeXMvaXBjYnVmLmg+XSkKPiAgQUNfQ0hFQ0tfVFlQRVMoW3N0
cnVjdCBsb29wX2NvbmZpZ10sLCxbI2luY2x1ZGUgPGxpbnV4L2xvb3AuaD5dKQo+ICtBQ19DSEVD
S19UWVBFUyhbc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0cl0sLCxbI2luY2x1ZGUKPiA8bGlu
dXgvbGFuZGxvY2suaD5dKQo+ICtBQ19DSEVDS19UWVBFUyhbc3RydWN0IGxhbmRsb2NrX3BhdGhf
YmVuZWF0aF9hdHRyXSwsLFsjaW5jbHVkZQo+IDxsaW51eC9sYW5kbG9jay5oPl0pCj4gK0FDX0NI
RUNLX1RZUEVTKFtzdHJ1Y3QgbGFuZGxvY2tfbmV0X3BvcnRfYXR0cl0sLCxbI2luY2x1ZGUKPiA8
bGludXgvbGFuZGxvY2suaF0pCj4KClRoaXMgbGluZSBtaXNzZXMgdGhlICksIGl0IHNob3VsZCBi
ZToKCi1BQ19DSEVDS19UWVBFUyhbc3RydWN0IGxhbmRsb2NrX25ldF9wb3J0X2F0dHJdLCwsWyNp
bmNsdWRlCjxsaW51eC9sYW5kbG9jay5oXSkKK0FDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgbGFuZGxv
Y2tfbmV0X3BvcnRfYXR0cl0sLCxbI2luY2x1ZGUKPGxpbnV4L2xhbmRsb2NrLmg+XSkKCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
