Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEA3C87FCE
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 20:11:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61F33C7AA4
	for <ltp@archiver.kernel.org>; Sun, 27 Jul 2025 22:11:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EA953C65E7
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 22:11:22 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA9B46EEEAA
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 22:11:21 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60bfcada295so6115043a12.1
 for <ltp@lists.linux.it>; Sun, 27 Jul 2025 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753647081; x=1754251881; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcPVczID5Kg1JeFo5VmXxgWQ1Z1BQm2uOBljKVmU2cI=;
 b=MHrmJwpMWjDZepZxQh7oAU6Px90QzEWej2ZCuOTYAh4hUWCtEAnFRjsc9Hp/UkhqTh
 szMXa5+RFv5AEq40YtrkdotSb1aqeEQoF0fNlFOxkZDc0Qss2hXRVz7cWG9D5Vuu2DHo
 Z513rUCYkGYsvydDIUaFzh51k+5mTdNAz4Aw8rm5iIEQQTIl2AVno5xXXec3T1CWW+zM
 bjb+P+tcQ9eGmOV2beRvADQepXbOsWQ2KD0IRlgBYJuoM9XgbJ3dA+A86v9GH3rx6D1r
 NKQ2Nl0yu6bjWT361olbE8sb0+33JSVwfx+zytjxvJRx+SJA92aYWbnjtaSZ7TcCrn3B
 Q56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753647081; x=1754251881;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcPVczID5Kg1JeFo5VmXxgWQ1Z1BQm2uOBljKVmU2cI=;
 b=kwGlDRyeNOVlqgLT3vVoTJt3pzdNSp2Fr2+ZgdWdEpXXJPVbqMe1jryBSR/cc81J5b
 ZEK9hhVDlJfMotTlirIPegYJHv9Rz6rjPTOGri37WWCoTOXQTjKRHzdmLfoeYWJWsHDB
 91ZPFV43EOiCM49dJup3C8O0bY9U00xCp0ysUVxT+8JcfeogkWFG+fipUq/mHnhlLdFH
 u9QrV6fQ6jYQZUn3Q9bzDkWluMwZvVOvjvznU4vtg04fIimG7kiojFxXAdedtS+SDEBi
 oMVPhAmaPMVggfK2z+yD7/7FMvbNTDVZfUioX5zbCyoUHS6/X40pv9rEhz3+7DjPCKtb
 qUFQ==
X-Gm-Message-State: AOJu0YxLe8wbb6ym+KTvVAvedNlQtRlVvWskfwp2rlGPo7v8s8wn+82h
 u3MYiXA5IS4nD6cQHoLplTII/ZSsd1hW0aTiRJYI7su1jaw7YXQX7r08
X-Gm-Gg: ASbGncurRTNtnv5+RIAq/tEzKYR2vCYNYwLA8evL3WpBO+5k7VjM/PHigukK5AsNN26
 nhKGmJ4TQGzCQgsZ+aglSpdGZNCPpZOSMBT5l15vkoxPQSh+AQQLUfQl1aPpY6f9DWGNBBa3QuO
 sO79zoAVrb8Rhostj4+34N2p9TSi1Ha2yptX3gzwYLfb1TflPUIP7xETJ7BDALRJlLPS3tDtTth
 Uh1kPFVRNACISIxIQeW4Wnf9Kds38OkWydN9pzDHHI881C34RWC0s/MHNRXVq10ZzPKE/aX4mNB
 kYIcfiU3vdkH43NJx/Ye7ZZSGgRwi9aHCghrGUDhgF126X7rqO/UVVcvhZ720zHx+Wda4U58r0p
 dHHtSDdZkHz0FqUt6ddXJvspLF4A=
X-Google-Smtp-Source: AGHT+IH6QxWvnSE7AwDIqvbzt4XjLWVmaoekldgI6T/nwmYkI6hVHgUhTAf6BEbmEPFZDVdc6NZ1BA==
X-Received: by 2002:a05:6402:d08:b0:602:241c:345 with SMTP id
 4fb4d7f45d1cf-614f1dd2d91mr9185477a12.23.1753647080739; 
 Sun, 27 Jul 2025 13:11:20 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615120d3ef8sm1828671a12.34.2025.07.27.13.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 13:11:20 -0700 (PDT)
Date: Sun, 27 Jul 2025 22:11:18 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250727201118.GA108672@pevik>
References: <20250724190946.338828-1-petr.vorel@gmail.com>
 <aIM5op4uuHdee6Sy@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aIM5op4uuHdee6Sy@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tlibio: Restore uclibc-ng support
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > uclibc-ng does not implement <aio.h>. Requiring it for the core LTP
> > library breaks the build. Restore unintentional removal in fed3e3ee63.

> Can we instead of hardcoding UCLIBC add a proper configure check for the
> aio.h header? That way it would work on any libc that does not include
> aio.h...

Thanks for the point and sorry to forget a basic rule to avoid hardcoding any
libc if detectable with autotools.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
