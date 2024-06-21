Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FDEC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 12:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA39F3D0EA4
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 14:05:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A4B43CE02D
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:05:32 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 331F21B60ED7
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 14:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718971530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEzgIVPXh/Fn/3LImcgo5TlMu4li4AgpMZYkPOCwgZs=;
 b=OBF8GnCEh+8bLuR4k3Ta2VMIjP0LyTJ4j3OwnYj0nE+btmZ3fRrPCTAds1DnlZxDkYeHNd
 k9L5Vmsrng1b2hx+mw5ES6spsqE4VWVRs1sj5fXjcnqVbXv7aghGg7EpKb2hNL+bO6T3O4
 3F9oUXMvlk/NcQ+PtYxwMiqMpCESBco=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-GifH7Ak1NR2ivluIozB50w-1; Fri, 21 Jun 2024 08:05:27 -0400
X-MC-Unique: GifH7Ak1NR2ivluIozB50w-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c6f1c0365eso1892284a91.2
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 05:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971525; x=1719576325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eEzgIVPXh/Fn/3LImcgo5TlMu4li4AgpMZYkPOCwgZs=;
 b=QZX4Kow63kG/ionY68orHfkaPKSR9RvHTQ5RcFlgq7FqWdMpzn3XcDvbT2Dha2YBON
 7lRM0B1W4C0IzLvpFplatDr6qWKfgZoY4zIb5Zw0cHboqu1HapmL4wliW9xPEYkkNXzK
 oEDeIX4qrM1TrK3xPr9iQoXNjAgsAzqLkX/3a66TwXiDOAAngxE+bfRoeWUR005qvZe1
 wtBof+La602Oec+0G82OK7jOmYKcGt5nV6u/qjDuiDCOg7PNuueuGjVZPVmBYzGF/A8v
 w8wT0Pdf1WJcmyPODnbbtkryqREtmS6+nbdQaFBNp7oEFy4XVEE5knGMdef7QQTZJhbD
 GG9w==
X-Gm-Message-State: AOJu0YxguRMZFusdnO2dB5Q//0aFwk4/acGzc9Wf/SXvo2OsCGaO05N6
 5HPiPG6FIgM96qhdBa/e0yN4QNWd8K3A7iAjlV7lFdvC65hIw7NM9bpiWZ3bKB69gTQD9oxZoIR
 2F7sTmjgXYLJfJonEfr7SWA6x7Qz3zhzG474HoXWC8BOitBWGkyOMR4GGPKIDsobTIP18LKlTvw
 tMrcPWZs1WPrWiB/rXNgFWMDIJqQ6tFO26g5Fz
X-Received: by 2002:a17:90a:3ec1:b0:2c3:1216:c2a5 with SMTP id
 98e67ed59e1d1-2c7b5da5574mr8251937a91.38.1718971525578; 
 Fri, 21 Jun 2024 05:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFotb1bLa/fHWdlw5aFqHz6XSFUWRHwj1xStoSXjQqLRyGs2N6hg/9E9TszVTKm4py6fhz8cDl3++Y7MH5y3RY=
X-Received: by 2002:a17:90a:3ec1:b0:2c3:1216:c2a5 with SMTP id
 98e67ed59e1d1-2c7b5da5574mr8251918a91.38.1718971525206; Fri, 21 Jun 2024
 05:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240620021635.489505-1-liwang@redhat.com>
 <CAEemH2ctF+3AEZkm4Y+KkcTUgYGM4XD24pkfwdJo=6ynQ-Wgxg@mail.gmail.com>
 <20240620052100.GC537887@pevik>
 <CAEemH2fd-b-apt-ifnAMDcq5ogCD1FJm+rHpq6R_6D9yvxuDbA@mail.gmail.com>
 <CAEemH2dv-LfYvEtD=1F+4wQkXwwvLwVZ8O=sd-VpBicOZhDYog@mail.gmail.com>
 <20240621110320.GB668048@pevik>
In-Reply-To: <20240621110320.GB668048@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Jun 2024 20:05:12 +0800
Message-ID: <CAEemH2fJ3MweAWbAy1yatfHE1KNK=NJLv8w3RVsnAJtJ+K-k+w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_kconfig: Avoid reporting buffer overflow
 when parsing /proc/cmdline
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, All,


> I'll add macros to my TODO list, working on it sometimes during July.
>

The tricky part may be for TFAIL (TBROK) to distinguish from TERRNO or
TTERRNO in one macro.

  tst_res(TFAIL, " ")
  tst_res(TFAIL | TTERRNO, " ")
  tst_res(TFAIL | TERRNO, " ");

I haven't got a better idea unless we allow creating more macros like:

 TST_RES_TFAIL()
 TST_RES_TFAIL_TTERRNO()
 TST_RES_TFAIL_TERRNO()

But TBH, this looks a bit messy and not good for memories.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
