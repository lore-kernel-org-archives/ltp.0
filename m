Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027FDC47258
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 10:50:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AF5D3CF0AA
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 11:50:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6E63CC9F4
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 11:50:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CEE3B20EB5D
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 11:49:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705402167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTqskiPIX/Ya3bnRPQ7LLnAxlXMqikezioxi4N4LCeM=;
 b=MJor8KYFBGHGC5jlypRtadchb1rVXTOMB8Nc32MjxMUtW/SVugDHf+IhBgKCdivGjxH1t3
 XddnmnlW3Ql7LdnMH3pIJYsNmO01rjQQE6nQSNKpVXU1uFqNQ/VZe13x4kB8OzbgcLehUO
 it9ZUUXE7i0xS1hMsnXgm34a5QMCMjc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-kg2zmOXEMAuvUAf546WCtg-1; Tue, 16 Jan 2024 05:49:25 -0500
X-MC-Unique: kg2zmOXEMAuvUAf546WCtg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4b734027d9dso1547338e0c.0
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 02:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402165; x=1706006965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTqskiPIX/Ya3bnRPQ7LLnAxlXMqikezioxi4N4LCeM=;
 b=M2ucPmJxYs9WEwAj0KXpwj6BOCmGkfGoel7anlRjbRbMn3TiFq1j90uhuiAMwLJlpR
 dsPWwVgl4zjDh/kVwXZJMlAVnLvOkrEGC8DFCcpRJq0xMwRsvFyIZylOUbr2YjAx/CgT
 KqCYiDuB55aKTdJifGERA4zdmghA54n4TeJ2tcADpMuiU2jFv4ydd2gisNGoVHt3mKan
 kSUyvpGD791sp+CAeVIDLiWvHtJPbj1MbA2qMGsnIuKaTTFQK5oHeAdAjjBhMAAhh8Y3
 irEgTcX9Dqv55/pl8zEX/i2YFiAFAtHWg2FbGs6lbokNEoyjSDYPHJdw5N1zp7zoi0te
 KYKw==
X-Gm-Message-State: AOJu0Yz/CzCgbyLs+hYioR0OT/HP2IHKfO1+2ibfq+iPTp67K1QzCSnz
 73RHhdEVnB4237G/7BJ/W/Ne12dXpns36MJEb4M7uTigFi8O9UlzsE72DtN3UiQO1J9bVd51n4w
 XVcPBm+ylP74UiZAj4wcziPpQ9wZ2T3xTWNk=
X-Received: by 2002:a1f:4881:0:b0:4b6:beb2:b44e with SMTP id
 v123-20020a1f4881000000b004b6beb2b44emr1824082vka.30.1705402164942; 
 Tue, 16 Jan 2024 02:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmNeM2oCsftqJEdIgaSLeESsC/XUEPiLV1ElWqxp2LZFYTZtqHqNi6kCFWgec2wJdr7WNr6vw4ZC5uL0H8vnE=
X-Received: by 2002:a1f:4881:0:b0:4b6:beb2:b44e with SMTP id
 v123-20020a1f4881000000b004b6beb2b44emr1824079vka.30.1705402164651; Tue, 16
 Jan 2024 02:49:24 -0800 (PST)
MIME-Version: 1.0
References: <427788e09f3109fa5e48581058597d6998a08fa5.1705066390.git.jstancek@redhat.com>
 <ZaUE6NjMxwsNAYSf@yuki>
In-Reply-To: <ZaUE6NjMxwsNAYSf@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 16 Jan 2024 11:49:07 +0100
Message-ID: <CAASaF6zCMew-aH_KZZMjqvNKvZb1S-QWd7Oyriewu14nCG+DUA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Subject: Re: [LTP] [PATCH] irqbalance01: fix out-of-bounds write in
 collect_irq_info()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKYW4gMTUsIDIwMjQgYXQgMTE6MTHigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKPiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1
YmlzQHN1c2UuY3o+CgpQdXNoZWQuCgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1
c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
