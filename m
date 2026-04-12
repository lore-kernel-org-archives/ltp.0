Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB77AE937E1
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775999706; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nOnNsIRKGrzM/Mmo8eAr9FZobY5mhnbS/LRn6J+lEdE=;
 b=MrIMbEOKvtPBF1NIQwdfYc6OeHeRSS197JtWS1e+vcbjVvNYLDz3Io5S4/h+5ic/YqdUl
 bHLPMG7TyR9geE2t/JhxGtuZT4hdrdrIP444ZT/HAMQNI9EcuKMhR53cxS7CESX8jMv5Ig6
 V45tSoph1CQA+eZ22gH0lZ51KejdjLs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AFF93E2681
	for <ltp@archiver.kernel.org>; Sun, 12 Apr 2026 15:15:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0FB663E213C
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 15:14:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EA16310001C4
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 15:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775999679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lhj3ZDQdPdhVcjvVXuIm27yS5c85wUHGCqQLOVLYw3E=;
 b=h8hojbMefqoyiUME0SoSvroXhg+W/ZiRCPUetE2esj5ZW1n1m/KUHQUu2x84LBf7ttk678
 tDPE3Pu6zIb274nbjmsEjIFKhx/Unf+KW1GMRRjWIeLkpew7G5EMGYslve/7xXI9/B8LQ/
 qbaVNS2tQgpUvPc5vH4IG3EKu8pf76w=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-_1A0qiykP5uMROv30eQOvw-1; Sun, 12 Apr 2026 09:14:37 -0400
X-MC-Unique: _1A0qiykP5uMROv30eQOvw-1
X-Mimecast-MFC-AGG-ID: _1A0qiykP5uMROv30eQOvw_1775999676
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a1055f8ebdso2906603e87.2
 for <ltp@lists.linux.it>; Sun, 12 Apr 2026 06:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775999675; x=1776604475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lhj3ZDQdPdhVcjvVXuIm27yS5c85wUHGCqQLOVLYw3E=;
 b=Sid/NwLUs5UHpQpgc5jeajIg5WWicAS4lzNxCjp1HktqOPkkgKTT9uTByy9Vgs0Jt+
 QIWjLk/umdKtWS8K51jM0WC0wriUGgdx5tYxpV8jLXJIBoN9E4Y1zJ+DHUYyZoDH68dU
 xnZwv5W+c3uWKuu3EOqeNbYR+Pv+2rtZHi5cO4FdWw3of0BqshnYgWDm8AEmqQQRzBR7
 KXcCR/yYvLrbtNxSNbga1dZ1PNVDjVWhmjnZUTKV2RxZzatn19pPwiAHW37+e+XKgeI3
 oWkbaKIZ5UtMDlLsTxQ3uSL5C4NhBNgr3uebJSSvnbcXieGqnqh2THz6P2JusCmyVs1i
 SU3w==
X-Gm-Message-State: AOJu0YwHnThaODcGe/6ZmjYzlnLmI+zu7EumoxU04KyYwHnftGQPE6Fm
 GAdjqAbJ28BwlZ0M/zLLwUOSW25zqHb64XrayuxumO1mvov9ebspHnEAmnjLa5WCxQ23M0acp48
 KwKpS8UU2xjMQYXj6hmU7r46WodF4V3bMtMyTxphRDkMTFvAccImhpMAmLX6ZjwNYtMGNv7JMGU
 3c1h84zu2l1u3hf96MQDBqUL/jPlk=
X-Gm-Gg: AeBDievEnWmy2BFtJZGJwSrZ7fxgwUkSNLL3xtJduBO6Mi/Sa4KfApKOx0CQeZK2pua
 2Q9BGxIb1GlJEZ7XBzNagnVnI5p80Iq3FtVuLE/n0hmJ8t4ae8LFajwuFYoweDenaB09Mk0zZYj
 /DddY5Si8rbsbqLz2E9qHFwqdrgepMrkznA9oxUigF251NHdGGE4A8smp78vWEpHMxGszSE54C1
 u0sk3E=
X-Received: by 2002:a05:6512:10cb:b0:5a2:843f:5800 with SMTP id
 2adb3069b0e04-5a3efd7a64cmr3534590e87.23.1775999675369; 
 Sun, 12 Apr 2026 06:14:35 -0700 (PDT)
X-Received: by 2002:a05:6512:10cb:b0:5a2:843f:5800 with SMTP id
 2adb3069b0e04-5a3efd7a64cmr3534574e87.23.1775999674742; Sun, 12 Apr 2026
 06:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHGiOXfj60hbfgVPBUYwTicuD9HMkdpjDwx9CLRLKHQ+BYO58A@mail.gmail.com>
 <ac0Jz9RnHrOlf93j@yuki.lan>
In-Reply-To: <ac0Jz9RnHrOlf93j@yuki.lan>
Date: Sun, 12 Apr 2026 16:14:17 +0300
X-Gm-Features: AQROBzCqtFjaKRfaoMGG9if68nu85a3yQfQ3Dxbgyj0SHFjl-0kZtemZw7ZJhAE
Message-ID: <CAHGiOXf1-pi7Gc=UoC_Ban0a=er_JmLDROQDAtP82F53JOD-jQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j4un1o4R3BPF-oN9KWRnye6pFw9zYoq8PwWwyg01gt4_1775999676
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] PATCH] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSB3aWxsIHNlbmQgZ2l0LXNlbmQtZW1haWwgYXMgcmVxdWVzdGVkLgoKCk9uIFdlZCwgQXByIDEs
IDIwMjYgYXQgMzoxMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToK
Cj4gSGkhCj4gPiBUaGUgdGVzdCdzIGNvdmVyIGFyZSBhcyBmb2xsb3dzLgo+ID4gZnV0ZXhfd2Fp
dDA2OiBFRkFVTFQgZm9yIGJhZCB1YWRkciBhbmQgdGltZW91dCBwb2ludGVycwo+ID4gZnV0ZXhf
d2FpdDA3OiBFSU5UUiB3aGVuIGludGVycnVwdGVkIGJ5IGEgc2lnbmFsCj4gPiBmdXRleF93YWtl
MDU6IEVGQVVMVCBmb3IgdW5tYXBwZWQgYW5kIFBST1RfTk9ORSBhZGRyZXNzZXMKPiA+IGZ1dGV4
X2NtcF9yZXF1ZXVlMDM6IEVGQVVMVCBmb3IgYmFkIHVhZGRyL3VhZGRyMiwgYW5kIEVBQ0NFUwo+
ID4KPiA+IFRoaXMgaXMgbXkgZmlyc3QgcGF0Y2ggY29udHJpYnV0aW9uIHRvIExUUCwgYW55IGZl
ZWRiYWNrIGFuZCBzdWdnZXN0aW9ucwo+ID4gd2lsbCBiZSB3ZWxjb21lZC4KPgo+IEkgc3VwcG9z
ZSB0aGF0IHRoaXMgcHVsbCByZXF1ZXN0IGlzIGNyZWF0ZWQgYnkgeW91Ogo+Cj4gaHR0cHM6Ly9n
aXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvcHVsbC8xMzAxCj4KPiBXZSBjYW4gZWl0
aGVyIHJldmlldyB0aGUgcHVsbCBvciB5b3UgY2FuIHNlbmQgdGhlIHBhdGNoZXMgdG8gdGhpcwo+
IG1haWxpbmcgbGlzdCB3aXRoIGdpdC1zZW5kLWVtYWlsLiBJZiB5b3Ugd2FudCB0byBjb250aW51
ZSBvbiB0aGUgZ2l0aHViLAo+IHNvbWVvbmUgd2lsbCBwaWNrIHVwIHRoZSBwYXRjaGVzIGFuZCBy
ZXZpZXcgdGhlbSBvbmNlIHdlIGdldCB0byBpdCBpbgo+IHRoZSBwYXRjaCBxdWV1ZS4KPgo+IC0t
Cj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gCgpNaWNoYWVsIE1lbmFz
aGVyb3YKClNvZnR3YXJlIFF1YWxpdHkgRW5naW5lZXIgLSBBdXRvbW90aXZlIEtlcm5lbAoKUmVk
IEhhdCA8aHR0cHM6Ly93d3cucmVkaGF0LmNvbS8+CjxodHRwczovL3d3dy5yZWRoYXQuY29tLz4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
