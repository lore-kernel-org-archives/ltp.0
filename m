Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ED4CEDD89
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:14:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE7353C2E42
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:14:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C6113C2B8B
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:03:55 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99018215482
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:03:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728475433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
 b=ff9/9zgIyW5t4Y9IBXAJhCEiX1ZrxSlwamU5mUi6LDexNCyCbUyxoLrRrOA/FrBss+OZ0E
 4ck/5oCbc53WS/xHbagpexYHoOv+MZHx0H2qcXiHX9GlB4SYd4w9VH5Bq62HH5zG39PtSy
 JsyCwJ3uq7y902GkF4QDD5y/iG3Ax98=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-J65809GmO6OknWgw-CwsCg-1; Wed, 09 Oct 2024 08:03:51 -0400
X-MC-Unique: J65809GmO6OknWgw-CwsCg-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3e04cfa7178so6083334b6e.1
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 05:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728475430; x=1729080230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8Kavz4pG0DrcMSTG519JLahfgY0ngVMi+UX0VgfOxk=;
 b=XysEXLBIMNGNSPdvS+W/F1VXtz5MA4xvZul2PVT7FwLE39Pzn1q3GzPSbOVrMxYL2V
 OWcle+9sD4wYlSk4+vd3f87zEdEc+FzAQMDlybjuTb/OFbyPdd5vfRuhYNyoWAT4oaJL
 E77jh0AQO6RmQswnfd5n4Ig1e0wvxVwFaH3wOr911sPLKHXivP+RAtVXqeH+iUx5tCMS
 m/9PydbqdnzhJxMvA3qbRLWApy6Kdko/VAvrkxEyGx35VG0HixrrtiOlg0RhbBP7jdzs
 jRTUcUHyXBHLfv0W0KVJIodR2lEcyKmQfdB69hHVGytCg+dr8umfchyOegPkBH49bC0h
 RW2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc3yAFMnOm85R95B0VNCH+HHbzd0aTMBun1LsdjiEPn/tw3SmoUbxZuPE+P0R/urB/F7M=@lists.linux.it
X-Gm-Message-State: AOJu0YxQVcIWTKQafkn1slSYDbMqZ72RNwgkJJZttVxfrkwqIPaPleJP
 +TpyU8IHKTqf2Gt1OlUze4kBpxVuJyZ+novN3RZeNxyKXN6vQgw5xVw7/0Qv37v5Dg7O1yGhpRV
 QIcoREHwl6uUFzSGbNQ2U9nGwm64ipnFUFSq3exq5v8RbT4Ukxa03dRU9PZp8n8C/puXRxWlzsS
 wB8trKdpgteX7js2cftFi34PI=
X-Received: by 2002:a05:6870:d88e:b0:261:f30:fda3 with SMTP id
 586e51a60fabf-288343063c1mr1385948fac.21.1728475430492; 
 Wed, 09 Oct 2024 05:03:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEunAW49fg9TRqfk2Wul+wjLgorZM7rhrZCbIHsry+h80qprHZ8RuUHrprF5ApY/0Yivrsxi+udN4/j+iPW3fY=
X-Received: by 2002:a05:6870:d88e:b0:261:f30:fda3 with SMTP id
 586e51a60fabf-288343063c1mr1385884fac.21.1728475430088; Wed, 09 Oct 2024
 05:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241008115648.280954295@linuxfoundation.org>
 <CA+G9fYv=Ld-YCpWaV2X=ErcyfEQC8DA1jy+cOhmviEHGS9mh-w@mail.gmail.com>
 <CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com>
 <ZwZuuz2jTW5evZ6v@yuki.lan>
In-Reply-To: <ZwZuuz2jTW5evZ6v@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Oct 2024 14:03:31 +0200
Message-ID: <CAASaF6wdvXAZyPNn-H4F8qq6MpHmOOm9R+K+ir9T_sOG-nXpoA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 09 Oct 2024 14:14:01 +0200
Subject: Re: [LTP] [PATCH 6.10 000/482] 6.10.14-rc1 review
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
Cc: Jan Kara <jack@suse.cz>, lkft-triage@lists.linaro.org, patches@kernelci.org,
 stable@vger.kernel.org, shuah@kernel.org, f.fainelli@gmail.com,
 jonathanh@nvidia.com, linux@roeck-us.net, srw@sladewatkins.net,
 broonie@kernel.org, LTP List <ltp@lists.linux.it>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 rwarsow@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 allen.lkml@gmail.com, conor@kernel.org, linux-kernel@vger.kernel.org,
 pavel@denx.de, patches@lists.linux.dev, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBPY3QgOSwgMjAyNCBhdCAxOjU24oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4gV29yayBpbiBwcm9ncmVzcywgc2VlOgo+IGh0dHBzOi8v
bGlzdHMubGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI0LU9jdG9iZXIvMDQwNDMzLmh0bWwKCmFu
ZCBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1leHQ0LzIwMjQxMDA0MjIxNTU2LjE5MjIy
LTEtamFja0BzdXNlLmN6LwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
