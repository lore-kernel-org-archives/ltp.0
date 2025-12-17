Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3489D65526
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 09:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765964657; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ixeo6kRjFpMybIux/toVhuaDhYGsbT6oCJJuUwNB+wc=;
 b=Bl2C3P0vZZdMY1+otJs3HJkrAAVmT7XN5fsg+V5R47Rq3ngaqB7vtj0AvXBNbeNIW6nAD
 re5u7VNOhFsQAb3gIwMShfNVjty292XxoPQDAvnoT3TM9kfSCEHpvq4lLWZB4+0Mj33gXj+
 hySrYva3DWjQel7Cf5MyIIFddyt2LgI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B06A3D03A5
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 10:44:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D02863CEB38
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 10:43:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E736C1A0090C
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 10:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765964630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gR4Q+aYYTDtrqtbY54WENMjnwQBqp8YEHaZGgPz2Ly0=;
 b=VY82cCwheGdq6p+Cl/XQiW4UXze/5AGo7KYJ+lgh1AHOneE1gPMBOdvYsXWgYQGsK2QNdk
 /qTtsKDtzqpmeiXLzs7lc9xuTWKADIRv9WDGil/krj1h4nf9P8YfLc5NxNsQ3gzDx2fZgS
 x0NwEfCJz1+L1qRI5UhZQs/hn9hC78E=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ZyMEutT2PWaWEfFf57mCEg-1; Wed, 17 Dec 2025 04:43:48 -0500
X-MC-Unique: ZyMEutT2PWaWEfFf57mCEg-1
X-Mimecast-MFC-AGG-ID: ZyMEutT2PWaWEfFf57mCEg_1765964627
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b98e6ff908aso14374134a12.2
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 01:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765964627; x=1766569427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gR4Q+aYYTDtrqtbY54WENMjnwQBqp8YEHaZGgPz2Ly0=;
 b=mf0AV+Z9nL5ppFJZ02vHLJYuhe4l2QWtYST80H2AKdaZ1XdZ3wg5IFPcn7Sv3q+oCn
 9l8+XGBsy2S9UObvZIDD+c0Xs1KOd9dUDM8Y/wFYC9YjZ/GfdBt8/8WU/sL6SOAFIsvG
 vwzZSvwffaucCBcmYdoSEP2WxK21PfYh/HGmVdqfRzo1wLFvUB6+ynWdrqpCQp44TlNw
 Ny3JiyvZvOUcOA/MLRmXnWsFXD1vPsyt76bDEjk1++/H2FftyJusHJFTDg+HCIw6GT54
 WFX0P+6eRPpLxUAIpr2Xxg1I/0ZAAwTa3CZITs2kfQ4VijkJLwdXq2K6dL2PVkNaoKY6
 m57w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJns1HoOZ6CMf8ot92z9txnzojJOd+AJ5QEYnHksqaA+wDfasomrtNTAqOhjj4qvveq0k=@lists.linux.it
X-Gm-Message-State: AOJu0YwPL5V8CgYHnSNIH4L1sDffNS/JtPyFGMgiM3lvFWoiCp6Hdqlu
 XEqQK9H+Jwo8XIvpSnJeAfWBMlWhSMvcketMoMR7Crl+yz62tGLGVnz0j4Y/+J/IYJ/KZoOfKRG
 GKunOSKlBO7m/owBZ3ve9T1X1HMGR0HmxPEGMipI9t60edCDxTfjG7O8WbWXZ66gpf4wj/RxTrq
 TgRMiV5WzfRWjFDO9NbpGB5JOIsb8=
X-Gm-Gg: AY/fxX41qY181hyG2IXW1FIt5hx+UP5hR8ScnfgtDnR4Wp635wON8nBkPi8KosJKALU
 DA+ZYU6Odv2Fsd+tpyw48AoNXCkCR2JwgCon/lK/D1srL+HMu2wyYFgK+kbwdsNlCrKqBuzpk+X
 WYNziIJ02SR+6Gfq51KNrqzpXWge0JGiq1mt6NQs0z1oqYcnDtpy9kLbyDUDCWNyq3Ggo=
X-Received: by 2002:a05:7300:c3a0:b0:2a4:3592:cf76 with SMTP id
 5a478bee46e88-2ac3025c6f5mr12205525eec.26.1765964627072; 
 Wed, 17 Dec 2025 01:43:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvSywWtlFIRHHqM1cx7ntSWQ0WPXlcxMtGpIpAxvWYCW7++aXl1pGI3no94ruZ2t7aL9fS5bjP4n0jmzgpies=
X-Received: by 2002:a05:7300:c3a0:b0:2a4:3592:cf76 with SMTP id
 5a478bee46e88-2ac3025c6f5mr12205512eec.26.1765964626425; Wed, 17 Dec 2025
 01:43:46 -0800 (PST)
MIME-Version: 1.0
References: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
 <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
 <CAKfqHeptLHymCgRyyUZ64UXoexoPEFsNHxSLa=aME9=U+dBywA@mail.gmail.com>
 <7d12c14f-4654-4248-b478-f57d721aba9a@suse.com>
In-Reply-To: <7d12c14f-4654-4248-b478-f57d721aba9a@suse.com>
Date: Wed, 17 Dec 2025 17:43:34 +0800
X-Gm-Features: AQt7F2pn23GikuKAhJ0TLYU4LH55T8jhpbpyVh6hyK_lvoGWZ_9D4--GjiJfzso
Message-ID: <CAEemH2fxanCLLMaMZRporvMXxdg0LKjO07_4suHgcFYxGQGCPQ@mail.gmail.com>
To: Anrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5NKdPWDpwGAZ8qBBoNBMMNAN2wfX58k5rORXiQ-OsTY_1765964627
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Update clone3 wrapper signature
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: chrubis@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBEZWMgMTcsIDIwMjUgYXQgMzo1OOKAr1BNIEFucmVhIENlcnZlc2F0byB2aWEgbHRw
IDxsdHBAbGlzdHMubGludXguaXQ+Cndyb3RlOgoKPiBIaSBDaHJpcywKPgo+IE9uIDEyLzE2LzI1
IDY6NTAgUE0sIENocmlzIFdhaWxlcyB3cm90ZToKPiA+IEFuZHJlYSwKPiA+Cj4gPiBUaGFua3Mg
Zm9yIHJldmlld2luZyB0aGUgY2hhbmdlLiAgV2UncmUgY3VycmVudGx5IGFkZGluZyBhIGBjbG9u
ZTNgCj4gPiB3cmFwcGVyIHRvIEFuZHJvaWQncyBCSU9OSUMgbGliYyBpbXBsZW1lbnRhdGlvbi4g
QWRkaXRpb25hbGx5LCB0aGlzIGlzCj4gPiB0aGUgc2lnbmF0dXJlIHVzZWQgZm9yIGBnbGliY2An
cyBgX19jbG9uZTNgCj4gPiA8Cj4gaHR0cHM6Ly9naXRodWIuY29tL2JtaW5vci9nbGliYy9ibG9i
L2RlZDljMWU1MjVmMmQ2OWE4MWU2MWMzNGMyOTA3N2ZlZDdkZjY1OGMvaW5jbHVkZS9jbG9uZV9p
bnRlcm5hbC5oCj4gPi4KPiA+Cj4gPiAtIENocmlzCj4KPiBBdCB0aGlzIHBvaW50LCBJIHRoaW5r
IHdlIHNob3VsZCBqdXN0IGFkb3B0IHRzdF9jbG9uZSgpIGluc3RlYWQgb2YKPiBjbG9uZTMoKSBm
YWxsYmFjay4KPgoKUGVyaGFwcyBhIHNpbXBsZSBhcHByb2FjaCBpcyB0byBkZWZpbmUgYSByYXcg
c3lzdGVtIGNhbGwgZm9yIGNsb25lMwphbmQgdXNlIGl0IGluIGFsbCBleGlzdGluZyB0ZXN0cywg
YW5kIHRoZW4gYWRkIG5ldyB0ZXN0cyBpZiB3ZSBwbGFuIHRvCnRlc3QgdGhlIGxpYmMtbGlrZSBj
bG9uZTMgd3JhcHBlciAod2l0aCBmb3VyIGFyZ3MpLgoKT3RoZXJ3aXNlIHRoZSBuZXcgYWRkZWQg
J05VTEwsIE5VTEwnIGFyZ3VtZW50cyBmb3IgY3VycmVudCBoYWNrZWQKY2xvbmUzIG1ha2VzIG5v
IHNlbnNlLgoKc3RhdGljIGlubGluZSBpbnQgbHRwX2Nsb25lM19yYXcoc3RydWN0IGNsb25lX2Fy
Z3MgKmFyZ3MsIHNpemVfdCBzaXplKQp7CiAgICByZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9jbG9u
ZTMsIGFyZ3MsIHNpemUpOwp9CgojaWZkZWYgSEFWRV9DTE9ORTNfV1JBUFBFUgppbnQgbHRwX2Ns
b25lMyhzdHJ1Y3QgY2xvbmVfYXJncyAqY2xfYXJncywgc2l6ZV90IHNpemUsCiAgICAgICAgICAg
ICAgIGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcpOwojZWxzZQpzdGF0aWMgaW5saW5lIGlu
dCBsdHBfY2xvbmUzKHN0cnVjdCBjbG9uZV9hcmdzICpjbF9hcmdzLCBzaXplX3Qgc2l6ZSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGludCAoKmZuKSh2b2lkICopLCB2b2lkICphcmcpCnsK
ICAgIHJldHVybiAtMTsKfQojZW5kaWYKCkJ0dywgdGhlIGFib3ZlIGNoYW5nZXMgc2hvdWxkIGJl
IHB1dCBpbiBsYXBpL3NjaGVkLmggaWYgd2UgZGVjaWRlIGdvIHRoaXMuCgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
