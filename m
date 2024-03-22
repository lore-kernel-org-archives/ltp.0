Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213C8C47DD9
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 01:33:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29FF3CFBC0
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 02:33:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35AA33C997B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 02:33:08 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF1F62009E8
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 02:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711071186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gNJYWyHHwir6Y5aMfCtgFJsw4iye76FRG/K9oN/6R4=;
 b=YaqCb5qTcoDC2l57J4huA7wY7dQAO2roWDZFdNUGtU9Emf1WA+1ecV9/ZBMzUP13Fsf+Cs
 1KvKlrE9Gsb3UNSn+HMY3TLTPC/uN4a8TbGDKF9/vgKMc7wBYfbkKFweYmAP/6L9A+y0pX
 OG16TAtbQj0rl+loA/3NZhMUUfZKyuk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-wbu9tAjDMR67bZc-RP8JpA-1; Thu, 21 Mar 2024 21:33:03 -0400
X-MC-Unique: wbu9tAjDMR67bZc-RP8JpA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29c7932c5f5so1070463a91.1
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 18:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711071182; x=1711675982;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3gNJYWyHHwir6Y5aMfCtgFJsw4iye76FRG/K9oN/6R4=;
 b=jiB0AWPwGmtzmq7PqL+l2jYI60nze+tkNXiwQSlQbtD/jDRR6pzCRTPS0kGiTGl2/k
 pzF15nf2+f8XfPSKFt6DDJY1PbkZFv+37zcRdPnU1Xk7tQomeFaEhcnseeTFNzuYbSrb
 5hyGQESlRzDIpTu+0R1y2ga7shn1UzXud6eOip2ogD0pwSvq1ysbOO8IKABl+6ro88EG
 0fmXb7Cudhj7j2wD1p7FBn80m2US0wgydRCDSIkWJXEx17AZ08KZAEkXUwV+E9DwYOEw
 e2SDXn72GqFofrxLu9wPczvprp4igNfWql44KUgzAQp+TRzGwhw+2MNFWXzk/C0t2uwg
 NSxQ==
X-Gm-Message-State: AOJu0YxlO3VkMB+4Wz1JaSc2x0hyxpu64V8aSlCOZUVKUA0CaXp1fzAB
 sjbFE7+PR+Qzqrm5L4gMypnEPpbqxsJAnZ5U7LgxKP/jfRSwQo5Ng+BqKC3DSUh/2qzAavFN2Y0
 jfDLrhxZy4/7qMAg8KYKWhgHN6jj6zUCYUNbfTLLsFJPHBksOdP54XPTAjd7FA5eKd1I56B9mrk
 GLiF6F2OLdX+4z2UZUsozZ7ys=
X-Received: by 2002:a17:90b:4d8b:b0:2a0:1dd8:ee with SMTP id
 oj11-20020a17090b4d8b00b002a01dd800eemr957205pjb.11.1711071182039; 
 Thu, 21 Mar 2024 18:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+SCJ3AtBxT0RMctK5Os7Z8qH9zs1jzOEWbKzkgCeWwPg8y3h61/o51IBGhx1OIAY6wu+b1J/4B8AdPcss9pw=
X-Received: by 2002:a17:90b:4d8b:b0:2a0:1dd8:ee with SMTP id
 oj11-20020a17090b4d8b00b002a01dd800eemr957188pjb.11.1711071181665; Thu, 21
 Mar 2024 18:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
 <cf3287a8009ab6104a4dec45b7b8160f35a358b0.1711045522.git.jstancek@redhat.com>
In-Reply-To: <cf3287a8009ab6104a4dec45b7b8160f35a358b0.1711045522.git.jstancek@redhat.com>
From: Li Wang <liwan@redhat.com>
Date: Fri, 22 Mar 2024 09:32:50 +0800
Message-ID: <CAEemH2fg98s2JPAAJDo=V72eXxBi9pbNq_CeJSbW+cyb4PeBkA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] syscalls/timer_getoverrun01: use
 kernel_timer_t type
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

T24gRnJpLCBNYXIgMjIsIDIwMjQgYXQgMjoyNuKAr0FNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gVGVzdGNhc2UgaXMgZmFpbGluZyBvbiBzMzkweCwgd2l0aCBn
bGliYy0yLjM5IGFuZCA2LjktcmMwIChnaXQgY29tbWl0Cj4gYTQxNDVjZTFlN2JjKS4gVXNlcnNw
YWNlIGRlZmluZXMgdGltZXJfdCBhcyB2b2lkICogKDggYnl0ZXMpLCB3aGlsZQo+IF9fa2VybmVs
X3RpbWVyX3QgaXMgZGVmaW5lZCBhcyBpbnQgKDQgYnl0ZXMpLiAgVGhpcyBtZWFucyB0aGF0IGtl
cm5lbAo+IG9ubHkgcG9wdWxhdGVzIDQgYnl0ZXMsIGFuZCBvdGhlciA0IGNhbiByZW1haW4gdW5p
bml0aWFsaXplZCwgcG9zc2libHkKPiBjb250YWluaW5nIHNvbWUgbm9uLXplcm8gZ2FyYmFnZSwg
ZS5nLjoKPgo+ICAgdGltZXJfY3JlYXRlKENMT0NLX1JFQUxUSU1FLCB7c2lnZXZfc2lnbm89U0lH
QUxSTSwKPiBzaWdldl9ub3RpZnk9U0lHRVZfU0lHTkFMfSwgIDx1bmZpbmlzaGVkIC4uLj4KPiAg
IDwuLi4gdGltZXJfY3JlYXRlIHJlc3VtZWQ+WzBdKSA9IDAKPiAgIHRpbWVyX2dldG92ZXJydW4o
MSA8dW5maW5pc2hlZCAuLi4+Cj4gICB0aW1lcl9nZXRvdmVycnVuIHJlc3VtZWQ+KSA9IC0xIEVJ
TlZBTCAoSW52YWxpZCBhcmd1bWVudCkKPiAgIHRpbWVyX2RlbGV0ZSgxKSAgICA9IC0xIEVJTlZB
TCAoSW52YWxpZCBhcmd1bWVudCkKPgo+IFNpbmNlIHdlIGFyZSBkZWFsaW5nIHdpdGggc3lzY2Fs
bHMgZGlyZWN0bHksIHVzZSBrZXJuZWxfdGltZXJfdC4KPgo+IFNpZ25lZC1vZmYtYnk6IEphbiBT
dGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgLi4uL2tlcm5lbC9zeXNjYWxscy90aW1lcl9nZXRvdmVy
cnVuL3RpbWVyX2dldG92ZXJydW4wMS5jICAgICAgfCAzICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0Cj4gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3RpbWVyX2dldG92ZXJydW4vdGltZXJfZ2V0b3ZlcnJ1bjAxLmMK
PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdGltZXJfZ2V0b3ZlcnJ1bi90aW1lcl9nZXRv
dmVycnVuMDEuYwo+IGluZGV4IDVjNDQ0ODU3YWFhNy4uNTdjMjE0N2JmNDdmIDEwMDY0NAo+IC0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdGltZXJfZ2V0b3ZlcnJ1bi90aW1lcl9nZXRv
dmVycnVuMDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdGltZXJfZ2V0b3Zl
cnJ1bi90aW1lcl9nZXRvdmVycnVuMDEuYwo+IEBAIC0xOSwxMCArMTksMTEgQEAKPiAgI2luY2x1
ZGUgPHRpbWUuaD4KPiAgI2luY2x1ZGUgInRzdF9zYWZlX2Nsb2Nrcy5oIgo+ICAjaW5jbHVkZSAi
bGFwaS9zeXNjYWxscy5oIgo+ICsjaW5jbHVkZSAibGFwaS9jb21tb25fdGltZXJzLmgiCj4KPiAg
c3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gIHsKPiAtICAgICAgIHRpbWVyX3QgdGltZXI7Cj4gKyAg
ICAgICBrZXJuZWxfdGltZXJfdCB0aW1lcjsKPiAgICAgICAgIHN0cnVjdCBzaWdldmVudCBldjsK
Pgo+ICAgICAgICAgZXYuc2lnZXZfdmFsdWUgPSAodW5pb24gc2lndmFsKSAwOwo+IC0tCj4gMi4z
OS4zCj4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
