Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E35C021A0
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 03:07:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ADA03C9ADE
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 04:07:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62CF53C8F76
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 04:07:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 22CA81BCC62F
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 04:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739502437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LSjDDkYY4bBucPJTIFD8MfG8eitvlkLoG9862M9N2zI=;
 b=SWbsGb/g68ptxnMH+WW+ByT2/4gKx6MwveoWPtu2VAxwZ8TmPNAkVuSnJIawln0Zm360p4
 IJ0idoLi8VAvnWtzlATu4MT9ziagRpH8hv4G/tgveRdq8bMRjJQNBu/PYl0T1lTaieB5Fd
 7E7PKoAnvVcPjbNlTRLqOhoMCllRAPg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-YxKxzWtzN_-P31W_oLP-mw-1; Thu, 13 Feb 2025 22:07:11 -0500
X-MC-Unique: YxKxzWtzN_-P31W_oLP-mw-1
X-Mimecast-MFC-AGG-ID: YxKxzWtzN_-P31W_oLP-mw
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fc0bc05bb5so3452783a91.2
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 19:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739502430; x=1740107230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LSjDDkYY4bBucPJTIFD8MfG8eitvlkLoG9862M9N2zI=;
 b=lRE4QBdMfN6/Uqq1Yss6ZIe3vOOalCGXwCtHq4kPzv8DfOYhl/VpiryjYyxR4aYih/
 I3IkBaxW2vXiJuiZgijBoewzRqEZGuWSK+6tcKLb0lcRFfpLQvzxtBz7GBkql7Aj/JcS
 SdPfKPq66dNW7TxRrxnDGfRO894/VuadDmPojc3eGfhkmSS3XJg8fRwRCc6sbnVsT0ub
 mFtP7yRjBGYhBFBlxLLgNq05jqItWZ4XIimrZwHuuY441eFXRGqVGFZ8UMqGncIZ4gLa
 Cj0q2IUU41EMvqCPLvXG4+OsRLhNdZvkW9+joakY9Qm/b1PQuQfHS7ORlQFz/viuCK8H
 uLOA==
X-Gm-Message-State: AOJu0YxlRkWAAEo4yF2pC9F/5pREYoa11AlBi4J8t2ko/0g4Cr2vo+x3
 0nSn5AO0/owr8l8HJmMbJhXvfzRLwdJg+/F1EdZvOHvgU77uhBaAb404LgKuFYV2jZoQE817SPf
 7a0boYfAI9rMx/BdVYW++OpOgkg4OJqgrAnq+iqf/TRbSzPJiwjHXsZpuhz3T2R9r4+oYvDtekM
 zW/AiqIwhSSaE5YL6NxTR04Dc=
X-Gm-Gg: ASbGncuDDhzR/e2EeVcLXJr20kZFBaZBds201XbOSa4zEfigHdoooCkwRu4qQTsLhmU
 MzW+F/Sn8CPSGS6MYw+Ufvjwp7LwcQK83hEyOPlxFDUccX/6TAWr1AswW0q/gSAM=
X-Received: by 2002:a17:90b:2686:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2fc0f09f3afmr8108159a91.27.1739502430485; 
 Thu, 13 Feb 2025 19:07:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF/AeWgkt4BXfsa4e+yxrCoFJ+IJJR4CW3zDF87iY5WaQ+aC0+sAV2RTfHblY8hips5KumE6JeeZtfgGspgYo=
X-Received: by 2002:a17:90b:2686:b0:2ee:db8a:29f0 with SMTP id
 98e67ed59e1d1-2fc0f09f3afmr8108129a91.27.1739502430117; Thu, 13 Feb 2025
 19:07:10 -0800 (PST)
MIME-Version: 1.0
References: <cf44d644-bfce-4c88-8011-7fa5c15a8d9d@oracle.com>
 <CAEemH2fxMxbApmaszJGLvRSG9e0T7ZAYUD=hxBSw9JFZgqan7A@mail.gmail.com>
 <CAEemH2cmPbDp15DOmOy3dmoLjRYHPcAD9Q_fts==EF8YDUJMGQ@mail.gmail.com>
 <7baba4f6-3560-4965-b62d-43efc09555fd@oracle.com>
In-Reply-To: <7baba4f6-3560-4965-b62d-43efc09555fd@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Feb 2025 11:06:58 +0800
X-Gm-Features: AWEUYZnnhwG15Vd9W64u5OtbbnNJc8ABT241KA9bdl86Dh5uJ7_KzLgSAx7wNro
Message-ID: <CAEemH2cRUUQfbG0Mkj0kCgmheoE2AmFhYOXd-FHOsBZCmVqTiQ@mail.gmail.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pWmU2DSY70sgz9ArTOnflI5D-ex0aEg5fNgc_TTPNmI_1739502430
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Test failures obtained on 6.14 kernel in memcontrol04 test
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
Cc: cgroups@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgOToxNeKAr1BNIEhhcnNodmFyZGhhbiBKaGEgPApoYXJz
aHZhcmRoYW4uai5qaGFAb3JhY2xlLmNvbT4gd3JvdGU6Cgo+Cj4gT24gMTMvMDIvMjUgNTo0NyBQ
TSwgTGkgV2FuZyB3cm90ZToKPiA+Cj4gPgo+ID4gT24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgODox
NuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiAgICAgV2hh
dCBraW5kIG9mIGZhaWx1cmVzIGRpZCB5b3UgaGl0Pwo+ID4gICAgIENhbiB5b3UgdHJ5IHRoaXMg
c29sdXRpb24gdG8gc2VlIGlmIGl0IHByb3Blcmx5IHdvcmtzICh3aXRoIENncm91cAo+ID4gICAg
IHYyKT8KPiA+Cj4gPgo+ID4gSSBtZWFuIHRoaXM6Cj4gPiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L3BpcGVybWFpbC9sdHAvMjAyNS1KYW51YXJ5LzA0MTY1My5odG1sCj4gPiA8Cj4gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8y
MDI1LUphbnVhcnkvMDQxNjUzLmh0bWxfXzshIUFDV1Y1TjlNMlJWOTloUSFNTkJGaE9yZlRVWGJk
akc4SGFnZm1JdHFxRDFJMU5fZG41UWpsV3Y5aS1LQWVFSkhTME5xNjdmRTFzcEhFUVJEMmlhNEcw
UGRuWlFYMWJNclA4cUNQUSQKPiA+Cj4gPgo+Cj4gSSdtIG5vdCBhYmxlIHRvIGFwcGx5IGl0Ogo+
CgpZZXMsIHRoZSBwYXRjaCBsYWdzIGJlaGluZCB0aGUgbGF0ZXN0IGJyYW5jaCwgeW91IG1heSBu
ZWVkIHRvIG1vZGlmeSBpdAptYW51YWxseS4KCkkgaGF2ZSBhc2tlZCB0aGUgYXV0aG9yIHRvIHNl
bmQgcGF0Y2gtdjQuIFlvdSBjYW4gd2FpdCBpZiBubyBodXJyeSB0bwpyZXNvbHZlIHRoaXMuCgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
