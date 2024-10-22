Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA0DD2C54D
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 13:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 521E43C6FBA
	for <ltp@archiver.kernel.org>; Tue, 22 Oct 2024 15:05:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B48603C6F7F
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:05:15 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6F38C1BB8753
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 15:05:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729602312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dS6VpWWGA/8Bd2Dezv+B4+NuLL8vnF6rYOUG/zmsCm8=;
 b=IlOfrkTfiw4bimOUUc+6BrrvFgGilQ7PIiUliaKBUfPr0mNcR7PJoFa9kV84REqaRZC+vd
 cjsmhXnttEaOnQOurQHhN22JEtVDgwYfrei5JJNyqa5nY6L2L1XGwLouL7EZWYAb9gQ5pG
 iXX6V7FJHzg6xj9APCyFMAj69vKQzyY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-F00eSPrfM_CyR1_YS8sFuA-1; Tue, 22 Oct 2024 09:05:10 -0400
X-MC-Unique: F00eSPrfM_CyR1_YS8sFuA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-20c94c1f692so56081615ad.1
 for <ltp@lists.linux.it>; Tue, 22 Oct 2024 06:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729602309; x=1730207109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dS6VpWWGA/8Bd2Dezv+B4+NuLL8vnF6rYOUG/zmsCm8=;
 b=pC8YUcyome22msK7m3u/BafqrRmBkJEZRIti3l0tfTysDmm2EijmVhKrhZNHXo3aUO
 1RtxsP8IlbB7A3R6oXrZh3kOYFc6Nn+gO9waudRLkaPJN/P1O/ZTEMUvFbxA59T5NB5a
 OuWK9BJNpkQOnf5JxVy4va81OLAeBARBPYtneLZ3mJ9b4n2Km/cxOo/ly+i3kDkLNKGk
 ol6ut1Oj2NvMzFUEDDpZs5vWLL0hKd4i2NKUVMb+nWis3eXpSt/J5qZ5VrAO1cNAWP1P
 gBuBNDMJKuuVjr13r6FmPzNg2yKwUdMPWX6C0agVUYb98WdZHZwaiQWkrvHiJVhierHE
 udCg==
X-Gm-Message-State: AOJu0Yyp2lFVdFpclTg3h5IEw2lSm+Z9W/umSYvZbwoTZ1AhMPc8ltul
 qq/jK5DkpTlWHE8KrX1wfbiqixJSHDX3fC3x5NJqPLXWJahwlobJF71S3kwV9QbZbEJMiYAan4d
 Fo46uvnHEOhYwf12eziqAg1SFrAp/HRrUA7bERB9HsxNzWVt6qolIw6ybfL6J3wToVAMOgvfnZH
 jiNeyc7obxuEaTIXpBSEWtKjC5KsA3TX/dIUYy
X-Received: by 2002:a17:90a:304a:b0:2e0:f035:8027 with SMTP id
 98e67ed59e1d1-2e5db91a7bbmr5086634a91.2.1729602308714; 
 Tue, 22 Oct 2024 06:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9/0wkMpdEUATRB8aHvv++fPv4ud+3G4uphaDzrnDYXRH+tCm+FSqeB44x2xR34pUMMD2/C2LlEvS7o2Tngcc=
X-Received: by 2002:a17:90a:304a:b0:2e0:f035:8027 with SMTP id
 98e67ed59e1d1-2e5db91a7bbmr5086594a91.2.1729602308375; Tue, 22 Oct 2024
 06:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <36c63ee52ce1e7ab1f6ce90bc6a4c58272130bee.1729590080.git.jstancek@redhat.com>
In-Reply-To: <36c63ee52ce1e7ab1f6ce90bc6a4c58272130bee.1729590080.git.jstancek@redhat.com>
From: Li Wang <liwan@redhat.com>
Date: Tue, 22 Oct 2024 21:04:56 +0800
Message-ID: <CAEemH2f3zaf+3jq8346WQNP9QgsvjBUA9GqCb8c8OYuVh2Q+dg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] read_all: limit sysfs tpm entries to single worker
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

T24gVHVlLCBPY3QgMjIsIDIwMjQgYXQgNTo0NeKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gUmVwZWF0ZWQgcmVhZHMgZnJvbSBUUE0gZW50cmllcyAodGNn
X29wZXJhdGlvbnMsIHZzX29wZXJhdGlvbnMsCj4gY2FwcywuLikgYXJlIGNhdXNpbmcgYmlnIGRl
bGF5cyB3aXRoIDMgb3IgbW9yZSByZXBldGl0aW9ucywKPiB3aGljaCBoYXMgc2lnbnMgb2Ygc29t
ZSBraW5kIG9mIHJhdGUtbGltaXR0aW5nIG9uIGZpcm13YXJlIHNpZGUuCj4KPiBUaGlzIHBhdGNo
IGludHJvZHVjZXMgYSBuZXcga2luZCBvZiBibGFja2xpc3QsIHdoaWNoIGRvZXNuJ3QKPiBjb21w
bGV0ZWx5IHNraXBzIHRoZSBlbnRyeSwgYnV0IGFzc2lnbnMgaXQgdG8gb25seSBzaW5nbGUKPiB3
b3JrZXIuCj4KCkRpZCB5b3UgdGVzdCB0aGF0IGEgc2luZ2xlIHdvcmtlciBpcyBmYXN0ZXIgZW5v
dWdoIHdpdGggdGhlCmRlZmF1bHQgJy5tYXhfcnVudGltZSA9IDEwMCcgb24gdGhvc2Uga2luZCBv
ZiBzeXN0ZW1zPwoKSWYgdGhhdCdzIHN0aWxsIHRpbWVvdXQgb24gdGhlIHJhdGUtbGltaXRlZCBm
aWxlcywgd2hhdCBzaG91bGQgd2UgZG8gKG1vdmUKdG8gYmxhY2tsaXN0KT8KCkFueXdheSwgdGhl
IHBhdGNoIGl0c2VsZiBsb29rcyBnb29kIHRvIG1lLgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
