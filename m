Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B916C48BC4
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 07:03:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B5BF3CF111
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 08:03:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 311183CC256
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 08:03:01 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9E3CE20EB54
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 08:03:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708671778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VSUn/ylyG93RlBECOBbWL6SxG0Nozf5wZ3Fe78j9wWM=;
 b=hi9DP/oqC8c3z5ZeUVIYaS7JSKP1TqYr73npeJhhOjS0JgX2SDUEIL+9u0OmkUhpwnTobM
 Y+rBRZrfo1mvqkeJ3lffHG2kYSySWhaUeVxw71lIwHjtU0gGs3MPRk7YwBokpM8z9fIuHe
 yxOXVKaNcO5LFgLuz4Z9z9Psph+qly8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-6pThtH6DMreqQLAdxmmLlQ-1; Fri, 23 Feb 2024 02:02:55 -0500
X-MC-Unique: 6pThtH6DMreqQLAdxmmLlQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299220f4cb7so382326a91.0
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 23:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708671773; x=1709276573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VSUn/ylyG93RlBECOBbWL6SxG0Nozf5wZ3Fe78j9wWM=;
 b=ht4EqmLooul+3+iwubfOICaQlDxrwEFVFDe4+SaqUKWMiR3hSmsBx6WOPrMqB+g4ed
 vkgd1bofNwbt1guS5Ufz0DFrGJ21w6Sr+FeghH/o0TML3Thy3EcHEjPqGK1syTusPfaP
 apMPhIEi25B2X+Az/IJANZAjJz2prDC7tcVrnkHEzYBczzvKVHcWl0XBd42ZfJQJ0Rou
 mjq0aWau7zpSqEHn6Ck3OZHcB7IG8OkGegNoWRCIGG3GS8ygflARfrFKpSAX/BQ4Kwca
 eG/1ALrkE7X0EDmFRNIqWdz1BFBtnkGXEmjBNUiwDBpo55qQc1fwTQ444ZSSZoZ5iQ18
 6fvQ==
X-Gm-Message-State: AOJu0Yxzq7YQKjW2ZfNwACJAsAGX+MgtfV9c1wTJF0/B1HdrvAIgV5Q4
 ExJ9qBQnMdQAAgjTCygAoMiiIafvaYOcE74UC3WjofHHsTIxcQWuxQv2H7tokuWw1cVnAPjlaP0
 k4W1wmli7fffmIc5H8eaasc1zGF6cU5LGGKz5YCGifgFZZ6KZqfjXzi/GdG3k3OawVC0gsx1zKu
 o3jjXYSCWWWjKgy+sdadLVeZM=
X-Received: by 2002:a17:90a:b103:b0:29a:3989:cb07 with SMTP id
 z3-20020a17090ab10300b0029a3989cb07mr930862pjq.26.1708671773601; 
 Thu, 22 Feb 2024 23:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6o78vk0eQVkwH1H/PA5w/xXFPbpPJQCjd2ytDpd1CxgmK+RubX6IEodBbwtjTSLqYHRfu2ereag6Ei2ry5lY=
X-Received: by 2002:a17:90a:b103:b0:29a:3989:cb07 with SMTP id
 z3-20020a17090ab10300b0029a3989cb07mr930848pjq.26.1708671773283; Thu, 22 Feb
 2024 23:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20240223000543.1135129-1-edliaw@google.com>
In-Reply-To: <20240223000543.1135129-1-edliaw@google.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 23 Feb 2024 15:02:41 +0800
Message-ID: <CAEemH2cLcpuagpy3EVJvuoLhMXPME1XXijLgjLSJYieVT+YiNw@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_fd: Use raw syscall for fanotify_init
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgODowNuKAr0FNIEVkd2FyZCBMaWF3IHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4Kd3JvdGU6Cgo+IFNvbWUgc3lzdGVtcyBkbyBub3QgcHJvdmlkZSBz
eXMvZmFub3RpZnkuaCwgc3VjaCBhcyBBbmRyb2lkLiAgV2UgY2FuIHVzZQo+IHRoZSByYXcgc3lz
Y2FsbCBmb3Igb3Blbl9mYW5vdGlmeSB0byBhdm9pZCBpbXBvcnRpbmcgdGhlIGhlYWRlciBmaWxl
Lgo+Cj4gU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiBTaWdu
ZWQtb2ZmLWJ5OiBFZHdhcmQgTGlhdyA8ZWRsaWF3QGdvb2dsZS5jb20+Cj4KClJldmlld2VkLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
