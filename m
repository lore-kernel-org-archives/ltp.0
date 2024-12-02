Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4BED10DA0
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 06:19:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BC1C3DD114
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 07:19:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695AB3DCA79
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 07:19:00 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 97AD222FDCB
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 07:18:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733120337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxm8yZ6Izuid2ntn9WtLi8ntuAhCJ2bJu+x5Dyf8gOQ=;
 b=fABZP5OT2N14TQpbixWNRAO9uP6FKn6D15hnGePqbhIB3elZBUHMhIQOFuq0buF4nazfg+
 ykJSM3id+YamH60dW8nTabVs3Cb2QC30mPL76TzY471O6DeV+hCGpTKUFl8aX6i0KKmtYr
 oV+dbra9CU+KX7srdxJpysbJHnDGBBw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-N-iOWTcSP3alqv7-ZxyLdg-1; Mon, 02 Dec 2024 01:18:54 -0500
X-MC-Unique: N-iOWTcSP3alqv7-ZxyLdg-1
X-Mimecast-MFC-AGG-ID: N-iOWTcSP3alqv7-ZxyLdg
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-29e2c0d98bdso3267581fac.0
 for <ltp@lists.linux.it>; Sun, 01 Dec 2024 22:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733120332; x=1733725132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxm8yZ6Izuid2ntn9WtLi8ntuAhCJ2bJu+x5Dyf8gOQ=;
 b=EIegr/hXeNKxCQHyicv6jSYG5TMlmGTTPu3+bqpJSHGXOPoqxgbf48uZHppZMxYsh0
 E6nH6R4nt5AWPwzKrr50CJretKtrreACPU1cnEdJ0BsVVNIxPr8KanADJMado1Gy+8EW
 rqE+L4DB4VqgTug4sBMOsMvFvAP6S8AXig6uar9O2jXqa5G9jc/DQWNTzJzlyJ5WXobJ
 1dYuA/0bgpCsZoPSh0uk3yNXJIw7rOrfUOxjyTBbbBay0u2U3zXZRG6z06gkJnyDs3Gr
 PUMnKP1yTNGSpy3QtgV2dEI/DkhWQIh4GDrVh0iCsMrmfx3qre92wEmsujn9fJXYKoWD
 L9/g==
X-Gm-Message-State: AOJu0YzsQZnfKYxJ4VjHl0JMI3kOUwOTaPjcK3WtyJbqU/yoyrmbfVgv
 a6Nvp6PTtbaYvnxhJjWzg/x8m7VePpYB0mXWQFfkXtS6ZZ/DqxG/VLLHAlMCkjdRIL7IW6cr3IO
 Azz//jmhkcEF5oWo9McjFtwOGNery3aH29GrqZoXQTstAveFb8y5rbj9SaZvx3/RPbAgkWffxpF
 x+SdYy4T3PEdvJsZeeUgV6pQs=
X-Gm-Gg: ASbGnct+F3pATfN5rjXVFreSvtFy/AzKRe+bgYPaaP7TFupw72YxM9zMQsEqdNrTS3c
 U8MY9iKZThvUYyaZuTEUprhZZYe0E2Ok=
X-Received: by 2002:a05:6870:f2a3:b0:27b:55af:ca2b with SMTP id
 586e51a60fabf-29dc4019615mr17629463fac.11.1733120332703; 
 Sun, 01 Dec 2024 22:18:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfuKgOIMCi1CQDXEUqxyXpUghAIOhWHV70OQHstwm5s/GQ3euYtFz+cYNf70zZsaCEKT3Y0Ry/IO1RtNVE5ks=
X-Received: by 2002:a05:6870:f2a3:b0:27b:55af:ca2b with SMTP id
 586e51a60fabf-29dc4019615mr17629444fac.11.1733120332322; Sun, 01 Dec 2024
 22:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20241114234839.1680432-1-petr.vorel@gmail.com>
 <20241114234839.1680432-2-petr.vorel@gmail.com>
In-Reply-To: <20241114234839.1680432-2-petr.vorel@gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 2 Dec 2024 07:18:35 +0100
Message-ID: <CAASaF6zmHz34_ONq-Hkm0pF_xp1qeBu+yMDQ1bgzUixxuP7ziQ@mail.gmail.com>
To: Petr Vorel <petr.vorel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7-r35ab4PfY4PGdzSu4mVkRnk80oxrSUg4N5DcxRypI_1733120332
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] rt_tgsigqueueinfo01: Use siginfo_t portable
 members
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

T24gRnJpLCBOb3YgMTUsIDIwMjQgYXQgMTI6NDjigK9BTSBQZXRyIFZvcmVsIDxwZXRyLnZvcmVs
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBQT1NJWCBBUEkgZm9yIHNpZ2luZm9fdCBleHBlY3Qgc2lt
cGxlIHN0cnVjdCBtZW1iZXJzIChzZWUgbWFuCj4gc2lnYWN0aW9uKDIpKS4gTW9zdCBvZiB0aGUg
aW1wbGVtZW50YXRpb25zIChpbmNsdWRpbmcgZ2xpYmMsIHVjbGliYywKPiBtdXNsLCBiaW9uaWMp
IGNvbWJpbmUgbWFueSBmaWVsZHMgaW50byB1bmlvbiBkdWUgb3B0aW1pc2F0aW9uLiBUbwo+IGFj
aGlldmUgUE9TSVggQVBJIGNvbXBhdGliaWxpdHkgaW1wbGVtZW50YXRpb25zIHByb3ZpZGUgZGVm
aW5pdGlvbnMKPiB0byBhY2Nlc3MgbWVtYmVycy4KPgo+IERlcGVuZGluZyBvbiBnbGliYy91Y2xp
YmMgc3BlY2lmaWMgaW50ZXJuYWwgaW1wbGVtZW50YXRpb24gd2FzIHdyb25nLgo+IGVlYTNiYTQ5
NmIgYXR0ZW1wdCB0byBhZGQgYmlvbmljIHN1cHBvcnQuIFRvIGdldCBtdXNsIChvciB3aGF0ZXZl
ciBsaWJjKQo+IHN1cHBvcnQgZG8gd2hhdCBzaG91bGQgaGF2ZSBiZWVuIGRvbmUgZnJvbSB0aGUg
YmVnaW5uaW5nOiB1c2UgcG9ydGFibGUKPiBtZW1iZXJzLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0
ciBWb3JlbCA8cGV0ci52b3JlbEBnbWFpbC5jb20+CgpBY2tlZC1ieTogSmFuIFN0YW5jZWsgPGpz
dGFuY2VrQHJlZGhhdC5jb20+CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
