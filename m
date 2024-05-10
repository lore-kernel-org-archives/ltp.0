Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58AC10F1A
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 02:37:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2703A3CE2EC
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 04:37:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA6213CC524
 for <ltp@lists.linux.it>; Fri, 10 May 2024 04:37:07 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0BE1F605655
 for <ltp@lists.linux.it>; Fri, 10 May 2024 04:37:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715308625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SEbxaWISBgHaxK3BMoTGs2OcEaoekzeSeBFLF+OhhRE=;
 b=MyBx0xHPZmaNASbX3jjnM7dadpn3wPsnfQ4JWTQX7UYFWqwluP7hoVshnanxGaU1LYvUXo
 m2gPfWt5P6IGYsDA6LD6YKwUh3lqlAq7SuKQiYGmGX7FKuWbqx8sGR0DeKzwkc9UqihrAS
 HHFcPxJWUYyyAWONwgqYVwHIYPYcD0Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-9qH7LfijOJmyXM5AuY_nxQ-1; Thu, 09 May 2024 22:37:03 -0400
X-MC-Unique: 9qH7LfijOJmyXM5AuY_nxQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-61dc66c4989so1504606a12.0
 for <ltp@lists.linux.it>; Thu, 09 May 2024 19:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715308622; x=1715913422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEbxaWISBgHaxK3BMoTGs2OcEaoekzeSeBFLF+OhhRE=;
 b=JE/G9dS40vFVJPqZFIbBIKYxMXBdJBvEGzW0Qs+4ULL+ggRfgqFWxF48op+hNEmSNy
 oQrKUPUfTCxqnbyLPzWB9KIevfAmWGwFAKZ/oEuy5EGcd5aB+h8auCiHcYil71gpYgOC
 vWOCVFjC8c9fv25PeOOMdVKrqTdBTkGpoX6iK8s4DJzZOZpcPb0Y26DFlZqNKJaBMglk
 izOcTJiYm1y7424CvnBD4bDHsYzxLEY9Ej9+yNjgK0wLwZM8PmPgq2kiZmywdSTDZrWM
 uwFwEp3rRn03/BrZTUEdSvlBvdh1RwR1NeYcF1lqncwKS4dRyffGWeTR9Qf6bK06SmoJ
 RfvQ==
X-Gm-Message-State: AOJu0YxIcKO5TI9bGmrR/z2MIB1mrW+chijThRLD1Xl/QjBt1FlgiWmV
 GWDgTcSWOuRV42ZgpxIgnmMwbhEZ/eYItbBAKLpK5J50gbfep6z1lxoNIxGGmbk51gJ7d6XVtL/
 2wH1xDTIR10ATiaE1dSV251j5eqD2Dt3Z4Kal0GS7b3Us2bIobeyehJygau9H5otVb444Yi6fsg
 acNAp6G/FcB19PONptDzSt6cYTxpcUHMINFw==
X-Received: by 2002:a05:6a20:9c89:b0:1af:ad0e:c917 with SMTP id
 adf61e73a8af0-1afde2008a4mr1841646637.46.1715308621903; 
 Thu, 09 May 2024 19:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPtOKKtgAuc6IOC7T8YtCKRV7d5ELi5V1rVVYmlut1wqkn8z0UoMpdFMRSrtE97yHiNtHkCeN4ktZmsblSNBI=
X-Received: by 2002:a05:6a20:9c89:b0:1af:ad0e:c917 with SMTP id
 adf61e73a8af0-1afde2008a4mr1841636637.46.1715308621594; Thu, 09 May 2024
 19:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240509102802.20091-1-liwang@redhat.com>
 <20240509134029.GA300682@pevik>
In-Reply-To: <20240509134029.GA300682@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 May 2024 10:36:49 +0800
Message-ID: <CAEemH2ezk6Q5UEW8vq-461D6Q-1uU=zgManic6Gf4o3qHvs_rg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] madvise11: ignore EBUSY for MADV_SOFT_OFFLINE
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
Cc: Luis Goncalves <lgoncalv@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGF0Y2ggbWVyZ2VkLCB0aGFuayB5b3UuCgpPbiBUaHUsIE1heSA5LCAyMDI0IGF0IDk6NDDigK9Q
TSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gLi4uCj4g
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21hZHZpc2UvbWFkdmlzZTExLmMKPiA+
IEBAIC0xMjgsNiArMTI4LDggQEAgc3RhdGljIGludCBhbGxvY2F0ZV9vZmZsaW5lKGludCB0bnVt
KQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOwo+Cj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKG1hZHZpc2UocHRyc1tudW1fYWxsb2NdLCBwYWdlc2l6ZSwK
PiBNQURWX1NPRlRfT0ZGTElORSkgPT0gLTEpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIChlcnJubyA9PSBFQlVTWSkKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7Cj4KPiBMR1RNCj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6Pgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmIChlcnJubyAhPSBFSU5WQUwpCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBURVJSTk8sICJtYWR2aXNl
Cj4gZmFpbGVkIik7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoZXJybm8g
PT0gRUlOVkFMKQo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
