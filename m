Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A50E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 07:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCA733EB5A9
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 08:59:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D2A73E4BB9
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 08:58:56 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C54163D173
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 08:58:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735891134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PZhD1zw6j0ALInsB9dTeJT3C786OKcEPZheXFnctKY=;
 b=dFw/VLKolMssPpy/SOYjEKl5O+CHSEVWklpWwB95l0bNfh+9HggL0dxzSzjWgq9JeDPuTR
 Z0211lDubEsP3YMEFC/Tf7aa4fvJGCElJ2KHAL3ltKsMOt7sLpWiiKvdFT/x/mY7AvIqMB
 a8Qtfq9Q6K73sa9iRM2bSaQ0pYYOGNI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-b2GdWBoAO3yDT4bZoybbhQ-1; Fri, 03 Jan 2025 02:58:52 -0500
X-MC-Unique: b2GdWBoAO3yDT4bZoybbhQ-1
X-Mimecast-MFC-AGG-ID: b2GdWBoAO3yDT4bZoybbhQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee86953aeaso16099320a91.2
 for <ltp@lists.linux.it>; Thu, 02 Jan 2025 23:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735891131; x=1736495931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/PZhD1zw6j0ALInsB9dTeJT3C786OKcEPZheXFnctKY=;
 b=qL7c4xjAVG7UYKep73S0C6IkMttVo4NqKN8D27MO9KDF3EMM0F1PyW+kyJkAT2QeKw
 7suJ6Osf0VcvQSOBSG7hQ6ZKrLLLgeYvTe4d95NykOOnKlrNpaKmdXwRg7BQPczvvY0W
 IHH6/EQ+ZsS+ex6b/qzWR3HJXt9lJG4LV+NJiaEyK/4vMaOH/X9J4b/NAJhbhVc0rOcg
 8qAO/MjfqLilBWh5lMEG0zEs7aZ87asgHwJuSiZegDBpmPGE+FwYMSLy00AkBFQqHA2U
 0K9pAXqmhgavJXJKM7UA8ORiKJH/D0LHV3AJAXckvY+rT9fqSztjIORl2H4Z5LQzYp00
 Hz6A==
X-Gm-Message-State: AOJu0YwY70vO4aQTkJavnxUgxmNXYEw6Op8E9Mg7tW5zbosZjzZPowN+
 0zU2/b00I3Xoo/BqVLIgyCXocvFfJYdTO9hOp0cRkpcRpCAqRlzkpno1JSka6+D2XbfGBrWdtZT
 E2txSFs6lPLGDrWU/BotJQ/SI+De81fPSZP5dusgP0e4OLyGIIZ92xtIT3ps1rsHG1SJOGSxxxG
 5E15aK3dzwafWz9FKq0mKzS5k=
X-Gm-Gg: ASbGncuO1WRv9hPi5zv2tWHMHCcz+Mqbl+jMiNtTgIkF3SUE/bLz9KOP5xMPrqpXhE3
 C7X42NRzqU7MTc+FQE+vWMsjoUUU3fF7dpzZauWg=
X-Received: by 2002:a17:90b:50c7:b0:2ee:45fd:34ee with SMTP id
 98e67ed59e1d1-2f452eedb72mr72894003a91.37.1735891131092; 
 Thu, 02 Jan 2025 23:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6j4QE7R/gWLJ1/3T+4CqEz0ja7B4j7T9xc3RIRIHRGLRwVAlNewt4NhDW2YYLc+652KJUZPYKozJGsXo4Qyo=
X-Received: by 2002:a17:90b:50c7:b0:2ee:45fd:34ee with SMTP id
 98e67ed59e1d1-2f452eedb72mr72893985a91.37.1735891130807; Thu, 02 Jan 2025
 23:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
 <20250103070634.GA186396@pevik> <20250103073329.GB186396@pevik>
In-Reply-To: <20250103073329.GB186396@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jan 2025 15:58:39 +0800
Message-ID: <CAEemH2fhxU8qA4BA3-dD=MXhzm_MHnaRy3PPP7vKt=tAqeLbMw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 83OaLdtgUwwGrckTi8AVX5WKpUM9Pj-wvGo5CPRx9QE_1735891131
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigs
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMywgMjAyNSBhdCAzOjMz4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwgYWxsLAo+Cj4gdGhpbmtpbmcgYWJvdXQgaXQgdHdpY2UsIEkg
dm90ZSBmb3IgbWVyZ2luZyB0aGUgcGF0Y2hzZXQuCj4gSXQncyBhbiBpbXByb3ZlbWVudCB0byB0
aGUgY3VycmVudCBzdGF0ZS4gQW5kIHdlIGNhbiBzb2x2ZSBzdGFydmF0aW9uCj4gbGF0ZXIuCj4K
ClllcywgdGhlIHBhdGNoIG9ubHkgZXh0ZW5kcyB0aGUgdGltZW91dCB2YWx1ZSBhbmQgZG9lcyBu
b3QgaW1wYWN0IHRoZSByZWFsCmV4ZWN1dGlvbiB0aW1lIG9mIExUUC4KCnN0YXJ2YXRpb24uYyBp
cyBhIGRlZGljYXRlZCB0ZXN0IHdlIGNhbiB0cmVhdCBzZXBhcmF0ZWx5IChpZiBwZW9wbGUgc3Rp
bGwKd2FudCB0byBydW4gaXQgb24gc2xvdyBrZXJuZWwpLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
