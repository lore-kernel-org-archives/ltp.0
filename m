Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA5AC282DE
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 02:25:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAA163CA52E
	for <ltp@archiver.kernel.org>; Fri, 14 Mar 2025 03:25:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1513CA4E5
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 03:25:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 882C71A0099D
 for <ltp@lists.linux.it>; Fri, 14 Mar 2025 03:25:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741919109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rtoYWs+KB7Ys5kzxHuQ/Ln8UkOzdUkd/jLeMMkTqtzo=;
 b=JsdpW12KOKByNnyCwULv5QROWlfsfd4Bzi58n9H3X9F+igjMD7CzBq7mjXblZ+gFs5vKNc
 wUesPnj2mMrw1GaOqol8BmXzgGHXYzPF8zJr+ZTDVpINWjOq+599SMQwhAO7RlOftZiZKl
 48JIu8ZexVRU1u3zEMIOG71Ra9rCLRk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-bZas_MYuMTikTj7sMPUC8g-1; Thu, 13 Mar 2025 22:25:07 -0400
X-MC-Unique: bZas_MYuMTikTj7sMPUC8g-1
X-Mimecast-MFC-AGG-ID: bZas_MYuMTikTj7sMPUC8g_1741919106
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff68033070so2485703a91.2
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 19:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741919106; x=1742523906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rtoYWs+KB7Ys5kzxHuQ/Ln8UkOzdUkd/jLeMMkTqtzo=;
 b=EGOaITOT5wUINcGQTNEpJ5l7IsFuoYdWc/3tiSgQKzWVuLNR2D54Z+AMa996dWrkZD
 2Utjb7q/fcdGtUHUuxIc9J6uHbXt7yL8JuKiiDtq/UmtfS2DrvzhY8cxsf+fDMTH1Svw
 cAp6rMK5ECkU0Z/3pDXW8eqHnliAQLeSl7jBiUtGA+xhyUqBnhqM3a3R77Af+MSyNpIk
 1LzF6dFOzlmU8MyI02lx6z6N+agXTzOgjqgxSdhTZa4ffk0mxqwngkkZDMlZL0hWV4Jj
 0GoS4lmFcGLJJnNG/kcKjfMxtJrNRanaPWdcD6QbhuU5hfM6rzKWxDjH06UHQSel71/U
 hRDw==
X-Gm-Message-State: AOJu0Yx5sBnoEtMrcZptVillO30x9loTx0UsxUbC1c0zMVYEQZGVtrjh
 zop1UljnGwNuJWC9yLPBLhKq20GJaIAxKAgctRy1eo01Pruh+BWYn3iFO4kOuNGZEoEs4uMXNkD
 dn6Fwjmu6R4VZ6hDg8/xIaAn1InT6RlM3guJgz36lPwJwJJh7EEWEM1cdWvTeKhR2PlmCLg340r
 1m3f9nhF9BzVPMFI38mHmz784=
X-Gm-Gg: ASbGncuBM1O82zB42rrDqNYecNN1olmdIRvOJHMeOKedhUP/rmjxHnWqtHLXvGDKdsZ
 Ly1g892v1+GYw2Hej46cCX+blQvANprcP84X94nnIsQEtkb1O0t4In/KKTPlrNdtO8MIgDEsPqg
 ==
X-Received: by 2002:a17:90a:d888:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-30151d00252mr922786a91.21.1741919105893; 
 Thu, 13 Mar 2025 19:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuJPx6l3RsciuErGsVsB+zAuCXtJN3znwv10axXFRe+N05ohIn73MqX298cgNLHCZptDCQMJMYQpcTs99Ddp8=
X-Received: by 2002:a17:90a:d888:b0:2f8:34df:5652 with SMTP id
 98e67ed59e1d1-30151d00252mr922756a91.21.1741919105380; Thu, 13 Mar 2025
 19:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250313092445.164616-1-liwang@redhat.com>
 <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
In-Reply-To: <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
From: Li Wang <liwang@redhat.com>
Date: Fri, 14 Mar 2025 10:24:52 +0800
X-Gm-Features: AQ5f1JooECBCZO1D7aH0Gca4YH4NFGlmOarXyQ6RqFpF_oSQM7hWpPpsekgIor0
Message-ID: <CAEemH2cTkjGzYgvL3vw3+9MRPtxYfVTCmgexFWAVh5Q00J0oKg@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D6wF4kbwcRkjL7Q70tZCbiDRlijKn9wl_v1pakKuL1s_1741919106
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] ioctl_loop06: update loopback block size
 validation
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
Cc: Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTHVpcywKCk9uIEZyaSwgTWFyIDE0LCAyMDI1IGF0IDY6NTnigK9BTSBMdWlzIENoYW1iZXJs
YWluIDxtY2dyb2ZAa2VybmVsLm9yZz4gd3JvdGU6Cgo+IE9uIFRodSwgTWFyIDEzLCAyMDI1IGF0
IDA1OjI0OjQ1UE0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPiBUaGUga2VybmVsIGNvbW1pdCA0
N2RkNjc1MyAoImJsb2NrL2JkZXY6IGxpZnQgYmxvY2sgc2l6ZSByZXN0cmljdGlvbnMgdG8KPiA2
NGsiKQo+ID4gbm93IHN1cHBvcnRzIGJsb2NrIHNpemVzIGxhcmdlciB0aGFuIFBBR0VfU0laRSwg
d2l0aCBhIG5ldyB1cHBlciBsaW1pdCBvZgo+ID4gQkxLX01BWF9CTE9DS19TSVpFICg2NEspLiBC
dXQgaW9jdGxfbG9vcDA2IHN0aWxsIGFzc3VtZXMgdGhhdCBQQUdFX1NJWkUKPiBpcyB0aGUKPiA+
IG1heGltdW0gYWxsb3dlZCBibG9jayBzaXplLCBjYXVzaW5nIGZhaWx1cmVzIG9uIG5ld2VyIGtl
cm5lbHMoPj0gNi4xNCk6Cj4KCldlbGwsIHRoaXMgc291bmRzIGxpa2Ugd2UgbmVlZCB0byBnbyBi
YWNrIHRvIHBhdGNoIHYxOgogIGh0dHBzOi8vbGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8y
MDI1LU1hcmNoLzA0MjU5OS5odG1sCgpOb3RlOiBMVFAgaGFzIGEgZnVuY3Rpb24gdHN0X2t2ZXJj
bXAoKSBmb3IgY29tcGFyaW5nIGtlcm5lbCB2ZXJzaW9ucy4KCgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
