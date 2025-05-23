Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7360DC3DA6D
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747980162; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UR1torSil0NBZF0OjjOVYlItzYsjlTXj167ODAzZts4=;
 b=X9Dj9UOjcVr4K++QNK1Ycd6OvQn49o1ugP/jWBtOXM9UklipeK3gsoJEvThLGBAiJJs3Y
 gLTdK5C5P5EJL1pZ5NVWRDJlRfLZe3F9wo7wYd+D7vCaAS6n9AVixFn5vdTaW277IM7ylTQ
 1egp9CaOo9xbP2UlJyB/32DS68u4nmg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75B8D3CC8CC
	for <ltp@archiver.kernel.org>; Fri, 23 May 2025 08:02:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5C033CC363
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:02:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61B836007A1
 for <ltp@lists.linux.it>; Fri, 23 May 2025 08:02:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747980136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPdtQJ1wFuvbTLYl55eUNQwB1R5zd+cnwUVYqTjUdCU=;
 b=aHqlY1jVMWPqeKMklCFJ+Bzdu29w0bngxlDhfFPPDlCV/ynnErPf1Hc7i0vO+cWsWxwM5v
 0ya9qLLZkpOOldjfCWNpW1NBD0nLQWj3zF0LkzJk0/ntnKPqg3YKSp6eWfWNbB0h8Hxnv5
 /FGrHNwXl5x8WkEx8O/TqtP/xaVS9G8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-KZTcG_8VN5iAuelyXRm9VA-1; Fri, 23 May 2025 02:02:14 -0400
X-MC-Unique: KZTcG_8VN5iAuelyXRm9VA-1
X-Mimecast-MFC-AGG-ID: KZTcG_8VN5iAuelyXRm9VA_1747980133
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-44b1f5b91c1so6285355e9.1
 for <ltp@lists.linux.it>; Thu, 22 May 2025 23:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747980133; x=1748584933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPdtQJ1wFuvbTLYl55eUNQwB1R5zd+cnwUVYqTjUdCU=;
 b=nQzGwc+XNWB9xZywi9CSSsLr3tGE52p1AZmRjiZOsmIafDZls7V7SZUscx7hJnsZgq
 5MV3CvmIgHkNrN4yRMBXwYZOo9RT3WZHmDfPWBf8Su2hneabz8R6KjtMrLhdO3R067wJ
 dNYnkbu4ea6YePzIr0Y/ADBwx8TSpKhWmLVZ2tMYyd2vb0mh5Z4UFU6UkxFCLhdUNyo6
 riF9qpYSZnfSFW1CNBZK7CHEbJsGpj7n2OHwW0q+TSHFnopqQqs+FclXMHR8fDUebMpB
 fr9zb4krJ+B1G+GE9FhrEzXIzzOZynDuVSOtxGVOMflSxdVnVGCdwDK/QENG5mv0ZFpX
 fZGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFymLioiBK8gqd2cU1Xx4wVCXEXC+dgsosefQBPn7PjrQDGkAosJpvLVd3JuqoHEnzz3g=@lists.linux.it
X-Gm-Message-State: AOJu0YwnThPoh5OlBQuaOH5Dv2vfUs8GugVLEyvRysCIkHig57FD+RLV
 +uFTjdQWZkLjT6BLcuU8z1NsiCqjx/d+qits+wre1HKQiqZzeo3zNUtHFqQ2lKLyOpsN5O1wcK5
 U752QAAdBSrRNXs/Rz+4t06qypODPN+BA154ZVYGxONfxS90osebEXQZ6wbcxVJbnAS2v92nTON
 1LSfKtnP7rz52ikGPJOOrbE7cwK4M=
X-Gm-Gg: ASbGncu8m9znV4sG3Gc3sVUkbUOM7TB2wruXawxiRqCIvEKaZ2FePkNvtR0VM2VVdIo
 nSNv/gZyBiTJnAcCFI/FZFsfXslJ2Q0yIOEs2g2AqSMiefg6HAGCMhHThcrYijOPiSw==
X-Received: by 2002:a05:6000:2406:b0:3a3:5cca:a54c with SMTP id
 ffacd0b85a97d-3a4c2343a89mr1117378f8f.36.1747980133162; 
 Thu, 22 May 2025 23:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVp1b42tnTckXjPnST090GptWsGGglybRZ570XO7N1lLJ6+pIgTUv2PUFmC3OU2xn+hN2TP2E2dzRS4+qgn88=
X-Received: by 2002:a05:6000:2406:b0:3a3:5cca:a54c with SMTP id
 ffacd0b85a97d-3a4c2343a89mr1117359f8f.36.1747980132787; Thu, 22 May 2025
 23:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250521141655.3202240-1-wegao@suse.com>
 <20250522193910.GA28496@pevik>
In-Reply-To: <20250522193910.GA28496@pevik>
Date: Fri, 23 May 2025 08:01:56 +0200
X-Gm-Features: AX0GCFvFWCdCrpll1dXp91PkCs4NEaki7iAs-Bq0kfKZheH7lemZoGR68ulOsOs
Message-ID: <CAASaF6z7r=NTD0ymx=pZhsKfDQ43aSpufb7EkpsCCC3mA2cNSA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s6tHzYloGNow_urXAnIYOeYqWOZS8zMQ-MSpWgazCbU_1747980133
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_tmpdir: Fix buffer overflow in tst_tmpdir.c
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXkgMjIsIDIwMjUgYXQgOTozOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIFdlaSwgYWxsLAo+Cj4gQGFsbDogaXMgdGhpcyBhIGNhbmRpZGF0
ZSBmb3IgYSByZWxlYXNlPyBJdCdkIGJlIG5pY2UgdG8gZ2V0IGl0IGZpeGVkLgoKSSdkIHdhaXQg
YWZ0ZXIgcmVsZWFzZSwgaXQncyBub3QgYSB0cml2aWFsIGNoYW5nZSBhbmQgb3RoZXIgdGhhbiBz
dGF0aWMgYW5hbHlzaXMKdGhlcmUgYXJlIG5vIHJlcG9ydHMgb2YgaXQgYWN0dWFsbHkgaGFwcGVu
aW5nLiAgQW5kIGl0IGFsc28gYWxsb3dzIG1vcmUgdGltZQpmb3IgcmV2aWV3LgoKPgo+ID4gVXNp
bmcgc3ByaW50ZiB3aXRob3V0IGxlbmd0aCBjaGVja2luZyBpbiB0c3RfdG1wZGlyIG1heSBsZWFk
IHRvIGJ1ZmZlciBvdmVyZmxvdy4KPiA+IFNvIGluIHRoaXMgcGF0Y2ggdXNlIG9wZW5hdCgpIGlu
c3RlYWQgb2Ygb3BlbigpLgo+Cj4gTEdUTSwgYnV0IGl0J2QgYmUgbmljZSBpZiB3ZSBjb3VsZCB1
c2Ugb25seSBybW9iamF0KCkuCj4KPiBDb3VsZCB5b3UgcGxlYXNlIHJlbW92ZSB0aGUgdW51c2Vk
IHZhcmlhYmxlPwo+Cj4gdHN0X3RtcGRpci5jOiBJbiBmdW5jdGlvbiDigJhybW9iamF04oCZOgo+
IHRzdF90bXBkaXIuYzozMjc6MjE6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhzdGF0YnVm
4oCZIFstV3VudXNlZC12YXJpYWJsZV0KPiAgIDMyNyB8ICAgICAgICAgc3RydWN0IHN0YXQgc3Rh
dGJ1ZjsKPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fgo+Cj4KPiBTdWdnZXN0
ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+Cj4gPiBGaXhzOjEyNDEKPgo+
IFRoaXMgaXMgYmV0dGVyIGFzIGl0IHNob3dzIGxpbmsgaW4gR2l0SHViIHdlYjoKPiBGaXhlczog
IzEyNDEKPgo+IE9yLCBJTUhPIGJldHRlcgo+IEZpeGVzOiBodHRwczovL2dpdGh1Yi5jb20vbGlu
dXgtdGVzdC1wcm9qZWN0L2x0cC9pc3N1ZXMvMTI0MQo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIK
PgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
