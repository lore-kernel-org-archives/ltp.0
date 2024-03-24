Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E5BC54E67
	for <ltp@archiver.kernel.org>; Sun, 24 Mar 2024 02:24:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69AD03CFF1A
	for <ltp@archiver.kernel.org>; Sun, 24 Mar 2024 03:24:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07AB63C81C7
 for <ltp@lists.linux.it>; Sun, 24 Mar 2024 03:24:21 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8502100078E
 for <ltp@lists.linux.it>; Sun, 24 Mar 2024 03:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711247058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d92mEvUHetVRH69MKwptAY3VAMY2Q6M/iSmK0T5cqNI=;
 b=M9GGXRAN6XhCy6GPtPTVaL0xTeCt6sLCne6yVg1waBJh4G7x6T/qjidZTbRsoWDcPC81qL
 1TozirHO4osFKKE1r3iQMeNgJDXe96/aWIE1a3K9xocluQ3F5qamEFCLhGBCyBcexSc0Wt
 NsB6MnOIs0yh/kVu8RMevIwFFbV20Is=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ycpy2ILCMZa_mge35kQxUQ-1; Sat, 23 Mar 2024 22:24:16 -0400
X-MC-Unique: ycpy2ILCMZa_mge35kQxUQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2a039b47c5fso1212979a91.0
 for <ltp@lists.linux.it>; Sat, 23 Mar 2024 19:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711247055; x=1711851855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d92mEvUHetVRH69MKwptAY3VAMY2Q6M/iSmK0T5cqNI=;
 b=utiQsSpW4L1v2XxVyB9IHBwjLhiWoiU+RTLvJXTksOSnGOOoZA0gVln9lKx8H6tmNT
 7WwEtuI41VCACQkoMXp7KLEAWxPyVOs6yi6AWqBxuooXPI4OXzbUoukPJb20VaHiY4LM
 WWqdBPtHJtj05XHBq/FqiGceiFKj94Ob3x1ee6+DAR79pJyaHzF8hqzPxZVplKCmYYCP
 uGZfz+ViQoayDn/TblgTZ/NW2mZHW65zvoi2GZeL8dZ/slHNGSRJRqrSWugLKQV6Uzbn
 OEV8ywf/ERXUs362FL7fozTPHh5IbFvc0IhgHvPo1rldMkDyezgPLY5PSX0NQwJ5WXRc
 JLUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmhIR37w+4ZZvJNvJ41iOtR3JWy4DACUT8IxUf/4RTRURPdTAU2IXRlqtQi27+6lYRgbwooXpyY+phi1jQ7z1F1MM=
X-Gm-Message-State: AOJu0YxNvyBkFij9byMEiVrv+2voi5GJXn3TEAXaF4LQPl2Ihodjm1Pt
 5uJ114ekDL5/QFx9O46zCwtbFR9CQlHOlBynVUNNkUrVpghr7d8xsnvEOxbWVkBXJiVVGs9fh2+
 KBI0AF/hvEbPVpY334cl1SK9MT3CvDuwRk74jQ5VB1XOnwtuhGWokSwsg0U7E8nx8oXHASRfSDs
 JDAYddxe6HR29x9OCxIly3n1xLGywiEv4=
X-Received: by 2002:a17:90a:428b:b0:29b:46f0:6f8e with SMTP id
 p11-20020a17090a428b00b0029b46f06f8emr4216188pjg.8.1711247054814; 
 Sat, 23 Mar 2024 19:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCTKGFk338UyF07cxUMXzAaPPg8MPoReAdQwRlH5vGEA6QHLk607beBVm+zGIvqCjh8t2LMgj4pDRIchPPpC4=
X-Received: by 2002:a17:90a:428b:b0:29b:46f0:6f8e with SMTP id
 p11-20020a17090a428b00b0029b46f06f8emr4216178pjg.8.1711247054486; Sat, 23 Mar
 2024 19:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <75b59f47-5e94-4293-8f9d-746aab4ef7d5@suse.com>
 <Zf18fSP0uQoFOpl6@yuki>
In-Reply-To: <Zf18fSP0uQoFOpl6@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sun, 24 Mar 2024 10:24:02 +0800
Message-ID: <CAEemH2e+zo-A2=rtZ2ibHA-K4uOqBU=qdT_AM+oLUjTK12P5YQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Next open monthly meeting request
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjIsIDIwMjQgYXQgODo0MuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gVW5mb3J0dW5hdGVsbHkgVGh1cnNkYXlzIGRvZXMgbm90
IHdvcmsgZm9yIG1lIGF0IGFsbC4gQ2FuIHdlIHJhdGhlciB0aGFuCj4gdGhhdCBtb3ZlIHRoZSBt
ZWV0aW5nIHRvIHNlY29uZCB3ZWVrIG9mIEFwcmlsPwo+CgorMSBtb3ZpbmcgdG8gdGhlIHNlY29u
ZCB3ZWVrIG9mIEFwcmlsLgoKU29ycnksIEkgaGF2ZSBhIHZhY2F0aW9uIGluIHRoZSBmaXJzdCB3
ZWVrIGFzIHdlbGwuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
