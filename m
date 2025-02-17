Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D9DC021A1
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 10:01:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBA843C9BCC
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 11:01:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72AAC3C9B88
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 11:01:15 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9F44F142AA56
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 11:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739786472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvJbP5AVs7DGAnPJRaRlpvLjWwytr1vs+g8GvkVMqf0=;
 b=Rn6ES6kEOYsbYEaBysVYfcjZ4SC+cAsdUti3TEyQeFhJWtf/mNwkBaszv/vW41FwtjfgBS
 mt6i+DTxQ569T9jEYjZXkpIute2X2VUuw8odHkW/0Hmv7KlcJK0AUufau7JcQoGosimy5h
 K8HO50b3AFg2T6ybtgIxQXYJ++QzxSs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-k_c-EpKKORG5q7K_x8wjWw-1; Mon, 17 Feb 2025 05:01:09 -0500
X-MC-Unique: k_c-EpKKORG5q7K_x8wjWw-1
X-Mimecast-MFC-AGG-ID: k_c-EpKKORG5q7K_x8wjWw_1739786469
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f46b7851fcso13913317a91.1
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 02:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739786469; x=1740391269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QvJbP5AVs7DGAnPJRaRlpvLjWwytr1vs+g8GvkVMqf0=;
 b=ZOyphXFTnw+kNQ3WcohBx0sexE4Wjsmh0sbIk8nl63SzqIViLlIVsQtk7TnwcTga/2
 E4uuMJcnT0ERz81DRCZKbRcs/HO9LCmDlWffhh0upwyOnyJcGf+V9Mr4T8Yu1L5p5CCP
 6Z+/6PekEg7MD49VcA6nWG9Cbl0/9U1H1Qe71YSYO+IGm4BI9mnYvyLemNd9vMgqaNQe
 KgDwLzKutZiSw0uYE/wGLVylGBxcHU7IQvlkfEb3iZkHutYFClDWKO8hf6akd+YkeNc7
 KR1Z+QV8Y74pwm/ijdgF0xAKAGiFe3iKuV2C8a1Wf6ARobItuTQ4tmjyVC0bVvW1PjH7
 8o3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4pXZ0bZ1mlJoC1rgzeY4O6WMZqDG42enpBaopatJAupWoHRxTxl/+Zid4vn+jMJYWNTM=@lists.linux.it
X-Gm-Message-State: AOJu0YywZa8Y4zbg7rBRA7aSjxfiqG1agkRH3iVESzbkYwoHL2FGAfgy
 3mHidwwRl4DnYbSsSD8v1+FZTuqHBlURw7DNwf9xBjvNtZNo2wC41NzwDC/tqkaVGJY+gXGeJpo
 KMlJZps29qArgOmsnEk9m5Ldo+Pww7VYUmbK6PmIWq/fc0NWafwPvJgsR+NCaz3Od1tsn/U5zwa
 4JuYH30BcSCgJ/PHvZyXhXEH8=
X-Gm-Gg: ASbGncuQlCs4AmAM0yeamTMZ200uQKE+8SlsTfGCNn2S1W2x02YN0eAH9EJ7EclmGHA
 QGS1G4VIAtsncbmTKYmYgiCW79Nv4I0xWTDvsnNdljgp2aRA788gpeynCY/QOtRM=
X-Received: by 2002:a17:90b:2d83:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2fc40f0e646mr14730555a91.10.1739786468767; 
 Mon, 17 Feb 2025 02:01:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqQ7u6pFtv6Zj9L1GzN0HpwsqprOnBn1cZXfCp1/CTPyTA8+botpZykgQXu1RAGM6gccRdK8R6kF/+dE00WsY=
X-Received: by 2002:a17:90b:2d83:b0:2f9:c56b:6ec8 with SMTP id
 98e67ed59e1d1-2fc40f0e646mr14730526a91.10.1739786468488; Mon, 17 Feb 2025
 02:01:08 -0800 (PST)
MIME-Version: 1.0
References: <6b486134-632b-42d7-bc01-b8f6905ee7ca.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQd1_URO66whTCnVd7Kd7EwNPvBrnE-eQQEvTqTLXGYTg@mail.gmail.com>
 <CAEemH2eroaD4es23EdOWNmaD+NL-2HKffPieMgJg06R3NENbAg@mail.gmail.com>
 <5feb6b6b-3f69-46a6-a7ae-b02a81df2953@oracle.com>
In-Reply-To: <5feb6b6b-3f69-46a6-a7ae-b02a81df2953@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2025 18:00:55 +0800
X-Gm-Features: AWEUYZl4YpciXmlaLzAAKX1Q_fqDBUuW3XIAhbjDjX0u_0XLeSYuPoiQhCLwBEY
Message-ID: <CAEemH2fW+01WZnhQO8m3pfP-YM_=a3OKgSMr5TBMuetqshRKFQ@mail.gmail.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HtYNzHbCBE3Gd_5n7GPnPtFFIIV_aSeBiazU5i1gh10_1739786469
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBGZWIgMTcsIDIwMjUgYXQgNTo1MOKAr1BNIEhhcnNodmFyZGhhbiBKaGEgPApoYXJz
aHZhcmRoYW4uai5qaGFAb3JhY2xlLmNvbT4gd3JvdGU6Cgo+Cj4gT24gMTcvMDIvMjUgMTA6MjEg
QU0sIExpIFdhbmcgd3JvdGU6Cj4gPiBIaSBHdW9qaWUsCj4gPgo+ID4gSSBoZWxwZWQgcmViYXNl
IHRoZSBwYXRjaCB0byB0aGUgbGF0ZXN0IGFuZCBwdXNoZWQgaXQgd2l0aCBhbiBpbXByb3ZlZAo+
ID4gZGVzY3JpcHRpb24sIHRoYW5rcyBmb3IgeW91IHdvcmshCj4KPgo+IEhpIExpLAo+IFVzaW5n
IHRoZSBsYXRlc3QgTFRQIHZlcnNpb24gbWFrZXMgdGhlIHByZXZpb3VzIHRlc3QgZmFpbHVyZXMg
ZGlzYXBwZWFyCj4gb24gNi4xNCBrZXJuZWwuCj4KCkdyZWF0LCBnb29kIHRvIGtub3cgdGhpcy4K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
