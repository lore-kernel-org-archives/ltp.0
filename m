Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E508CA0EE4
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755249891; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9uFGAuAW5ytQWSPb0Jx60nw7Ox+scThY8C+DVJpUW3k=;
 b=nyFqCFreBPVPrGu33A19ngBN7ul2uk/uSBpFFkq/tq+YK9roQRzjlTkIDKrzZe2/xPfR/
 eXXp2vLTMqywMcdbIKWsZmpoef8PtNbWXyH7Xby4RM2JCZDVCiEaDUCNkO1++Q1NQCKvLKF
 acki04TVG0FPA/v1E8HEWvsOeQ2zvtA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C45D3CC0A7
	for <ltp@archiver.kernel.org>; Fri, 15 Aug 2025 11:24:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3937C3CA02F
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 11:24:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B7D62009BF
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 11:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755249867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJ1aZCLXKeasqsxQmTpIrtRyi6xHlEyz05eJLIY0gMQ=;
 b=ER1oI9OLpGvgptppElW+PAtUac0YVakaWexA/PLyML+6iWYJ2E6dP1R1+fm1tFIyQswhJB
 kgrW2WK4awzk4Po7hedTA9R6TH5eXz+qMxr/VUgCC4zt9kySH/OpEAoy+CbHNKWXpZ3LFV
 ojk/DiVRt5PLyFjLeklSCyYAQuxdO5E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-EOzRkyiENCK7SGGH-0Tuig-1; Fri, 15 Aug 2025 05:24:25 -0400
X-MC-Unique: EOzRkyiENCK7SGGH-0Tuig-1
X-Mimecast-MFC-AGG-ID: EOzRkyiENCK7SGGH-0Tuig_1755249865
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24458264c5aso17625105ad.3
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 02:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755249864; x=1755854664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJ1aZCLXKeasqsxQmTpIrtRyi6xHlEyz05eJLIY0gMQ=;
 b=jVyBMG42u4iymaok9ev/mRFrzKW3r6l7K4p8GWPE9vqgb3LyPOyeSm2lMOh43yB0r6
 eii77w2fWqn3jPw+pBLvZoqr8tseehCZ+YlfmkVEPQ24ak6SycJh9tmX6v3Rltw4gqjg
 Ivj5L6DFZ4wOTeFlIJnb0DRqR2yfwnUkUofd/boZ1TEHMIOcajW5MUNOVIIWcU1J3F38
 8HuTlzW5VgjbZyk6WHaPT0v3ULJYmjqTRc5UvMR6RzH0gGwzpHsbLnBxyxmP5jGoHaUE
 aPaTwA+IcA3Eooul/jtc0uT0Vl6+u2H/lpKeasA5zZxy26PNBVUXjh6Veim0Xqlalfoa
 ZLuA==
X-Gm-Message-State: AOJu0Yw5pwWEa5ekyVvWTeY0J44EreBDrK6qFNeAgYrwcai1IEj5GLf/
 cVhRAqCNmlS/i+xGM4dHrRw3VHKJCdoYl5JEFlcrrb374JbKOVMUY0L4laS+1jYK1tsfwXTfBJA
 mtWGqT7QgBwCdQR6NTpLpRyVOTR8cidvOjSRJPxqs82d9981s1JxWgJHz5wq8XYA/5JQruyvOPP
 p87id2EJc3ssbspl9ICMRaYj+DAq56P/dCVw0aHQ==
X-Gm-Gg: ASbGncvEf1+M7cleEYGvcWpROL0hd61PyDty9pgd6IziU0pq5xX3EsoliGgcEaJFuRg
 S7Yt21o9bzWieXfOkH/yT0IldLW3WpdiFPG6jk58SqOu9bS8Bb21V4XNbEPFOULQWsEUw0jssgz
 5UCPGwnPze0IJKwM0vJQwINw==
X-Received: by 2002:a17:902:ebc2:b0:243:a5:f1f2 with SMTP id
 d9443c01a7336-2446d9c47e8mr23190695ad.56.1755249863816; 
 Fri, 15 Aug 2025 02:24:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgYPVkW+8xUwI25yY2dMTWqirvlX5B/fiwS94+dqBsIZvU9G16zSncXCOXc0ZEvI070bHOVT0POoBxvr+PYqo=
X-Received: by 2002:a17:902:ebc2:b0:243:a5:f1f2 with SMTP id
 d9443c01a7336-2446d9c47e8mr23190405ad.56.1755249863426; Fri, 15 Aug 2025
 02:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250815081942.584153-1-pvorel@suse.cz>
 <20250815081942.584153-3-pvorel@suse.cz>
In-Reply-To: <20250815081942.584153-3-pvorel@suse.cz>
Date: Fri, 15 Aug 2025 17:24:10 +0800
X-Gm-Features: Ac12FXwiXNPSnMEw2Y79yObja38H2HZ-R36rb9EHJph0R3-1OWkF_K7NX3GQPss
Message-ID: <CAEemH2cgzAKVT6-LfsSdvtCM5Fb44nMJddhftdkdXgiPzzFFdw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9yu0o8MbStmVx6pICHXAajUfjjyLz8Ph1hpAv2XXYQ0_1755249865
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgNDoyMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEtlcm5lbCBtb2R1bGVzIGRlbGliZXJhdGVseSBub3QgZmFpbCBvbiBl
cnJvciBkdWUga0FCSQo+IChMaW51eCBLZXJuZWwgRHJpdmVyIEludGVyZmFjZSkgbm90IGJlaW5n
IHN0YWJsZSBbMV0uCj4KPiBCdXQgdGhhdCBhbHNvIHNpbGVudGx5IGhpZGVzIG1vZHVsZXMgbm90
IGJlaW5nIGJ1aWxkIGR1ZSBjaGFuZ2UKPiAoTFRQIG1vZHVsZSBuZWVkcyB0byBiZSB1cGRhdGVk
KSBvciBkaXN0cm8gYnVnLgo+Cj4gSW50cm9kdWNlIEZPUkNFX01PRFVMRVM9MSB2YXJpYWJsZSBm
b3IgbWFrZSB0byBmb3JjZSBmYWlsIG9uIGVycm9yLgo+IFRoaXMgY2FuIGhhcHBlbiBpZgo+ICog
cGFja2FnZSBmb3IgYnVpbGRpbmcga2VybmVsIG1vZHVsZXMgaXMgbm90IGluc3RhbGxlZAo+ICog
TFRQIGtlcm5lbCBtb2R1bGUgZXJyb3IgbWVudGlvbmVkIGFib3ZlCj4KPiAkIG1ha2UgbW9kdWxl
cyBGT1JDRV9NT0RVTEVTPTEKPiBCdWlsZCB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zpbml0
X21vZHVsZQo+ICBDaGVjayB0aGF0IHBhY2thZ2UgZm9yIGJ1aWxkaW5nIGtlcm5lbCBtb2R1bGVz
IGZvciA2LjYuMTUtYW1kNjQgaXMgaW5zdGFsbGVkIGFuZCB0cnkgYWdhaW4uCj4gICogb3BlblNV
U0UvU0xFUzoga2VybmVsLWRlZmF1bHQtZGV2ZWwKPiAgKiBGZWRvcmEvUkhFTDoga2VybmVsLWRl
dmVsL2tlcm5lbC1oZWFkZXJzCj4gICogRGViaWFuL1VidW50dTogbGludXgta2J1aWxkCj4gIFlv
dSBjYW4gYnVpbGQgYW55d2F5IGJ5IG9taXR0aW5nIEZPUkNFX01PRFVMRVM9MS4gIFN0b3AuCj4g
Li4uCj4KPiBOT1RFOiBwcmV2aW91c2x5IGFkZGVkICdtb2R1bGVzJyBtYWtlIHRhcmdldCBrZWVw
cyB0cnlpbmcgdG8gYnVpbGQgYWxsCj4gbW9kdWxlcyAoZG9uJ3Qgc3RvcCBvbiBmaXJzdCBlcnJv
cikuCj4KPiBbMV0gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdGFibGUtYXBpLW5v
bnNlbnNlLmh0bWwKPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tIApSZWdhcmRz
LApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
