Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D62C0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 12:17:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D90C43C9A95
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:17:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C51B03C9A70
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 13:17:02 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DB6B2641A44
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 13:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739449019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVQi1dLqtYmMwyOTOPEV3mB8pkqw0AfsH+CDfiauCDU=;
 b=DO15MtO9mz+EHYNniMEu+u/OxnKzKa+kou6x3ehspOXBtLMoTsfWM9u3cYtNezYRjn54SM
 xtNo5B3jTwqdIq6JTTP+Bn1BPCkp3IR8nfXv3zqZEnBr8G4ZZQvVP0CLXW9CnswRVvIbst
 gaySZDnMkwHxXufMhXdhCNObVQdIPuM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-AKu0SzBxMaOssfq18O-xZQ-1; Thu, 13 Feb 2025 07:16:57 -0500
X-MC-Unique: AKu0SzBxMaOssfq18O-xZQ-1
X-Mimecast-MFC-AGG-ID: AKu0SzBxMaOssfq18O-xZQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fbfa786aa4so1763412a91.0
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 04:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739449017; x=1740053817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dVQi1dLqtYmMwyOTOPEV3mB8pkqw0AfsH+CDfiauCDU=;
 b=paqF1FROvNyV6SIzhemQrMYNUFlp22pRSYtpruAFS3zxp4nERVaUacDOjJ0RvG0UpY
 hhcxiokr8U6j8BKs0976w+TIy3QBHj8WhQKiR1WIVYpWGeJetCBka7UUBeRJZDeo6E3j
 XSNxODeqZQzvX+Fmn4MAVd1tK+7/LzKZlbUwwTFvzMm1KniGRqI+O1ZuVLjB7f14r7Zr
 kuuNrJsijy0M2lVnC9Seta8MV4fZ9ArEI0YHCruF4myCJjiL+arEWFPZcQxc/o9+EMGL
 rKETLFd2T2liY8/Awnw6/BDYlNFNGmZOfFjSHEdZpmPgT28//FDxmLYpCv6GE/0XHuM2
 TdUw==
X-Gm-Message-State: AOJu0YwXUtKaJNq7ZOxdYYbNvM9ILlORxDC1D0k0Edx9jx2+U56i5S4Z
 0rUEgdedB8I5xiwppgOCLPoImo01HebtpnsdbsStP/KXi5pohOSNdtufz73e4f+fUgT3JEj0Fit
 IZp9kTnehBmFeeJojUFnQ1ezX+gXWFALApV19VXvSlft+KJHmEucArP0IzH6lt1wJNAavpV/ZD9
 sLujRrauTbGlykP3uLIEE6lI4=
X-Gm-Gg: ASbGnctMbJ8C2EXwoCgYegRKs82Kx3fkZmo4XvrpAThC05TOMz+x4MHXXmSx8a99Nk4
 f35KKchtQZcBIaAwL4Vzq5/DBzb6+ZtUKdC4bS+OC+2zq+0tu1fP/cBdRJtbSbQA=
X-Received: by 2002:a17:90b:3d8f:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2fc0fc25d65mr4265630a91.11.1739449016791; 
 Thu, 13 Feb 2025 04:16:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVlMhiaqNcByBohZwxXeyq05ic0p3gOKaS9XnGGF50saR8L6L17blUYawDojENgr88RYF8nVHaQWpMd/UjjH4=
X-Received: by 2002:a17:90b:3d8f:b0:2f1:2e10:8160 with SMTP id
 98e67ed59e1d1-2fc0fc25d65mr4265594a91.11.1739449016421; Thu, 13 Feb 2025
 04:16:56 -0800 (PST)
MIME-Version: 1.0
References: <cf44d644-bfce-4c88-8011-7fa5c15a8d9d@oracle.com>
In-Reply-To: <cf44d644-bfce-4c88-8011-7fa5c15a8d9d@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Feb 2025 20:16:44 +0800
X-Gm-Features: AWEUYZmKsBdyGp-DpjkgS-p9U3_7r7SMWMSp9FC3jmNCCaQacBQ0u-zgzBAdkpM
Message-ID: <CAEemH2fxMxbApmaszJGLvRSG9e0T7ZAYUD=hxBSw9JFZgqan7A@mail.gmail.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sHIf8cCoSV979IRwZGHIse93fiYd-4OrNaBDLmDVdTo_1739449017
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

V2hhdCBraW5kIG9mIGZhaWx1cmVzIGRpZCB5b3UgaGl0PwpDYW4geW91IHRyeSB0aGlzIHNvbHV0
aW9uIHRvIHNlZSBpZiBpdCBwcm9wZXJseSB3b3JrcyAod2l0aCBDZ3JvdXAgdjIpPwoKCk9uIFRo
dSwgRmViIDEzLCAyMDI1IGF0IDY6NTfigK9QTSBIYXJzaHZhcmRoYW4gSmhhIHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4Kd3JvdGU6Cgo+IEhpIHRoZXJlLAo+IEkgZW5jb3VudGVyZWQgYSBm
ZXcgdmFyaWFibGVzIGZvciBtZW1jb250cm9sMDQgdGVzdCBvbiA2LjE0IGtlcm5lbC4KPiBUaGVz
ZSBoYWQgY2dyb3VwIHYyIGVuYWJsZWQuIFRoZSBmYWlsdXJlcyBkaXNhcHBlYXIgd2hlbmV2ZXIg
Y2dyb3VwIHYxCj4gaXMgaW5zdGVhZCB1c2VkLgo+Cj4KPiBUaGFua3MgJiBSZWdhcmRzLAo+IEhh
cnNodmFyZGhhbgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
