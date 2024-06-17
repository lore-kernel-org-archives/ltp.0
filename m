Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE57AC27C6E
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 08:50:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A7983D0D30
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 10:50:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 550103C0343
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 10:50:42 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4EE1514010E5
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 10:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718614239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qnae/6lG8xKDT54nYflZUoyvKkvFkgU15U2K6GyoOm4=;
 b=MkYJAUmNLWETMstGAt5HADzT3UXSzQTSsp09xIwMXdlrwDPnJv0NUrN3CoXzEzKy3UQlol
 H/WBOD5XGkfKqQKoYRpdmxH+AVDJ1B1tgYHDetd1bLmVwtfRfgz8L35MaSi/vJsIAGPtc1
 SXlwJoxh+jL7W0S4lpOPY78W4zKe3Kc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-yoryWP0GP9SXWh28sflutg-1; Mon, 17 Jun 2024 04:50:37 -0400
X-MC-Unique: yoryWP0GP9SXWh28sflutg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6fb1b675545so4151253a12.1
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 01:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718614236; x=1719219036;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qnae/6lG8xKDT54nYflZUoyvKkvFkgU15U2K6GyoOm4=;
 b=U71NCtZD7CDZ3E+0bdQOC5Me69Ohtm2Us0xGpbLSOPKwH+Spn08n40PCVX1mkqYckk
 vccd9+G35Lp+1Wv/7KmLiOIWH1SwRSjEbBGBsIeRs7zF+gLBkdlI202r7uVzUDLl0m5M
 1WY+ZO/ayZA0FYGrRPiMHCNckIExwW6ymO4Nu7ISLP3nYem0SrTJF8bw8NcyWwe1y2lT
 ai2Qw1n0DhTqmMQxYGb/tKPPt5dng2UW8N4TSljhFNIIkc+6ka0ZGLNI2pAClF1WGkSQ
 IHB0YkXWotBrl6aY5qYYlSXl576fKWUeanYXkne/cfGMdbdv0Gz9Qf1yt/kv6ashnA+E
 80jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpEKRmr/LQMd/G8Xvc3YPaAssT5OOo4e2D2b0uxtdtsugg0w2Omw9zDgg+BF1MGKofM/o4R+pdm/96DNpZMYRfCMs=
X-Gm-Message-State: AOJu0YzWaCFB4T5NhZGDHAJ+H8/Jqls1bE8gq5ZW9msf0yEzI5ZylBD3
 XQhKUnV8YF/LPr5AxCDQmGiZzbYWXxFvUTcK+Z5H8s4RKJx+a+6Z+9c+zkiCnmrJcoMOjaPslRa
 WzKaehwTtMTl+/RxXRistHdznmtKXVhYMgutelpzAZRCxZs6RH47qJ2tjHi2V48HlRJhUf7bQfM
 ENpFL9EMyOyFDAZrJAnxeVb/U=
X-Received: by 2002:a05:6a21:3213:b0:1b7:edc9:be56 with SMTP id
 adf61e73a8af0-1bae8001f55mr12374266637.40.1718614236128; 
 Mon, 17 Jun 2024 01:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMvjC//lS3MSV7eEcNne8fBpIKWPIit07JE1TfkxCheMNyqOzvOQWPbXCcpYwNL477zNHU5oM3sYHSGD2DR+8=
X-Received: by 2002:a05:6a21:3213:b0:1b7:edc9:be56 with SMTP id
 adf61e73a8af0-1bae8001f55mr12374249637.40.1718614235760; Mon, 17 Jun 2024
 01:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <SEZPR01MB4527D71946F457A41C66C8ABA8C02@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
 <20240612122644.GA120769@pevik>
In-Reply-To: <20240612122644.GA120769@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Jun 2024 16:50:23 +0800
Message-ID: <CAEemH2dcj9Fxb4G4-d5nDzDgHzWSMWPxnE0KNG-Uo7wWbkGfZA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] genload: fix memory corruption in hogvm()
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
Cc: ahuang12@lenovo.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jiwei,

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
