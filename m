Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16BC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 08:51:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20A993CE62A
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 09:51:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80BBD3C998A
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 09:51:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA50A1036E3C
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 09:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711097475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k28iBSokKbkEAOUjyZsCzahSF/x3TE1/JRcuXmh9meM=;
 b=VziXBSIKMLTq5035PZqfWuHS5PXRIaBkm4TCdp41bYyCxX+ZF0pXAKP3faIUnnb0RwtCUa
 115GO6auf1JkIs2W7aB0q5q5moQeyOkgOZpeX6+Jkvrq/UGMzTjMd4xEean1CS41DFZm2p
 JDgR4fdwwowPbk3GIuvVTOEuZimZsIs=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-4ylZRvxQOgOUbYak6BllaA-1; Fri, 22 Mar 2024 04:51:11 -0400
X-MC-Unique: 4ylZRvxQOgOUbYak6BllaA-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a20dba2133so1252534eaf.0
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 01:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711097471; x=1711702271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k28iBSokKbkEAOUjyZsCzahSF/x3TE1/JRcuXmh9meM=;
 b=VYk9x2BudEAW0uRJnJbQYc+FXcEODP+djxrhq2Y1di3RprLk8lmLaLk/SMrxOBF3lh
 siZd+IfG6FkFVlJf4X8ecfOl9iQL6Q7plkz+lF4pmqa0VkSK7omqcjODoVNsnbs6aDsx
 TK+IPu7jHY65TP5Kpv8sRXqbJS2D1j5z2bArtzx8aokRvCfkhBJL8aVpdm1VuFTKxruW
 japuO6Kyyv3kgzcRSar+LqbO0zFFLxf7C81vqNXzmjWtiQljc51mUWVmtjAdg952b5c4
 xqAjZivT4EPvbGdy9IDFP3WBO3V27x3LrHPrY1Zg1tAN8iuRtzrd2oPhr0B5rGbeM1D0
 Hu6g==
X-Gm-Message-State: AOJu0YyYC7r8s4nJCgiWXtZ4VYkQ26AgoqeOg7BMOmadyTjXy84aC3ly
 OBH/hiXsrVvNuYCi1/gWFt65wrEaA7MV1l1P4VY/P4LDUd63w4yOmX4tPNAifjBfovpqn8AmVAy
 UR9hfQXDI1Ua9JOjNvmbnPEmMr778C3nJhkbDdOzk3XRt0++52K/Dd+wP8l8+nZrrMkOqiZqybr
 lenpwTMKPA7KW8Xe3ADmdrKDg=
X-Received: by 2002:a05:6820:1f06:b0:5a5:dc:1875 with SMTP id
 dl6-20020a0568201f0600b005a500dc1875mr2170690oob.2.1711097471051; 
 Fri, 22 Mar 2024 01:51:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPYSGED+AQOw3zVRg55ytUugI+/woiaxXWTJktOKPDyOHrv7SNx7oU9wK19Etd/zJ788SjnbMHCpXCmJDiS/U=
X-Received: by 2002:a05:6820:1f06:b0:5a5:dc:1875 with SMTP id
 dl6-20020a0568201f0600b005a500dc1875mr2170672oob.2.1711097470594; Fri, 22 Mar
 2024 01:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <fae6ad10f98ab50a1a3e362706d65ea13fdda3ff.1711044800.git.jstancek@redhat.com>
 <cf3287a8009ab6104a4dec45b7b8160f35a358b0.1711045522.git.jstancek@redhat.com>
 <20240322051132.GB572447@pevik>
In-Reply-To: <20240322051132.GB572447@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Mar 2024 09:51:46 +0100
Message-ID: <CAASaF6wqF_avAiziA-OSEfoAi6n9xCPeEERNu=OswCa078_1YA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjIsIDIwMjQgYXQgNjoxMeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+IC4uLgo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy90aW1lcl9nZXRvdmVycnVuL3RpbWVyX2dldG92ZXJydW4wMS5jCj4gPiBAQCAt
MTksMTAgKzE5LDExIEBACj4gPiAgI2luY2x1ZGUgPHRpbWUuaD4KPiA+ICAjaW5jbHVkZSAidHN0
X3NhZmVfY2xvY2tzLmgiCj4gPiAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPiA+ICsjaW5j
bHVkZSAibGFwaS9jb21tb25fdGltZXJzLmgiCj4KPiA+ICBzdGF0aWMgdm9pZCBydW4odm9pZCkK
PiA+ICB7Cj4gPiAtICAgICB0aW1lcl90IHRpbWVyOwo+ID4gKyAgICAga2VybmVsX3RpbWVyX3Qg
dGltZXI7Cj4KPiBHb29kIGNhdGNoLgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KPgo+IEJUVyBpbiB2MSB5b3UgdXNlZCBtZW1zZXQoJnRpbWVyLCAwLCBzaXplb2Yo
dGltZXJfdCkpOwo+IENvdWxkIGhhdmUgd2UgdXNlZCB3aXRoIGN1cnJlbnQgY29tcGlsZXJzIGp1
c3QgdGltZXJfdCB0aW1lciA9IHt9IGluc3RlYWQgb2YKPiBtZW1zZXQoKT8gT3Igd2hhdCBpcyB0
aGUgcmVhc29uIHdlIGtlZXAgdXNpbmcgbWVtc2V0KCkgaW5zdGVhZCBvZiB7fT8KCkkgdHJlYXRl
ZCBpdCBhcyBvcGFxdWUgdHlwZS4gSWYgaXQgd2FzIGEgc2NhbGFyLCBwbGFpbiB7fSBkb2Vzbid0
IHdvcmsgd2l0aCBhbGwKY29tcGlsZXJzLiBGb3IgZXhhbXBsZSB0aGlzIGZhaWxzIHRvIGNvbXBp
bGUgZm9yIG1lIHdpdGggZ2NjIDExOgppbnQgbWFpbigpIHsgaW50IGkgPSB7fTsgcmV0dXJuIGk7
IH0KCiQgZ2NjICAtV3BlZGFudGljIGEuYwphLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6CmEu
YzoxOjIyOiB3YXJuaW5nOiBJU08gQyBmb3JiaWRzIGVtcHR5IGluaXRpYWxpemVyIGJyYWNlcyBb
LVdwZWRhbnRpY10KICAgIDEgfCBpbnQgbWFpbigpIHsgaW50IGkgPSB7fTsgcmV0dXJuIGk7IH0K
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICBeCmEuYzoxOjIyOiBlcnJvcjogZW1wdHkgc2Nh
bGFyIGluaXRpYWxpemVyCmEuYzoxOjIyOiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3Ig
4oCYaeKAmSkKCiJ7MH0iIHNob3VsZCB3b3JrIC0gSSBndWVzcyBJIHdhcyBqdXN0IGJlaW5nIHRv
byBjYXJlZnVsLgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
