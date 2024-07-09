Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A859BC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:00:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C98B3D3940
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 14:00:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEAA53D2BB5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:00:11 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2E433200A1E
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 14:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720526409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/AivoL9gpie0Rj0U76svclzQ2UE43GUo6N7vH2TzAAs=;
 b=g/lsb+3ENxhsJhCM1Xh6eSLvGASMFSJ95d0o/mPVDX8CgNIgmSxo+UasjI1A0szd1jh3u7
 ai5Ect2c5tB4VHRIcrUVy7LQwwudp5scv5ibArxMH2gxFEGyPYKhsREIWAdN/m1Nc82yeT
 wAJkAbRqA5u7PuVYncW9xol+0aH7Sd4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-BfKAIQWpNSesHB-wRi2Byw-1; Tue, 09 Jul 2024 08:00:07 -0400
X-MC-Unique: BfKAIQWpNSesHB-wRi2Byw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c975c0c765so3963800a91.0
 for <ltp@lists.linux.it>; Tue, 09 Jul 2024 05:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720526406; x=1721131206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/AivoL9gpie0Rj0U76svclzQ2UE43GUo6N7vH2TzAAs=;
 b=a1j4Egv1/CpPMSInid1ryRxI0HY0n9g3iVZTyx26CWK0fUAJYu/rt7tO37xKX2B10C
 Qz4vC90PHradYiuUFsroQJAo474R06GooHZW4Tt5AL9vuWBmrKRXCuBJVRIMRzmZO40o
 QihZdOGkTAL0Lh3cnGlaiUResCAGaHjG6BHs12RUk3TYZ/y5Y13FEY44GAaHSIIWX2Xg
 mJfnQpBt8wPVUehTuYHY25SDPP0joJmfiHrU/ZybBYJWlxUgYH3V6ZfGdV/zquOG1CXz
 ezu3oMI+J3I2ucPcc/yFqbcZ4IdTcsvDHBPl4h47X2VhZ08g9xHSweNbet3IzZBkEqMW
 hNBw==
X-Gm-Message-State: AOJu0YzR+F3+B96U4uUnRyOh06PE2uqtnV8u3irwOEd4WVzodliJNGJE
 OcUGjY2ipFYW4eBwfKAeQipYRhmouQv0uNvTskLVTuOSeehhPOfpF35i/Zb0H4ZdcTYOQ6YNEXG
 I7NbgvQOZWsSpDL/1eUkdmNTvt/iO+cKLgz7VAZEQzIgLuAKIz5xXC5rpNqWr59FwQH0ueQFzDB
 1nISHNnQmvYzqFjOqOwN0uYmI=
X-Received: by 2002:a17:90a:3047:b0:2c8:f3b4:425 with SMTP id
 98e67ed59e1d1-2ca35c694ecmr1965878a91.23.1720526406107; 
 Tue, 09 Jul 2024 05:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGmp7O2rSXY+ltVwETC0z2cZA5umF8LzQaFm1KXkySt+fXKZpiV9DPpJAoEGJ+y8z8idfuwiaWKwJaXAkRGMA=
X-Received: by 2002:a17:90a:3047:b0:2c8:f3b4:425 with SMTP id
 98e67ed59e1d1-2ca35c694ecmr1965862a91.23.1720526405819; Tue, 09 Jul 2024
 05:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-3-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-3-2693a473a2ab@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 9 Jul 2024 19:59:53 +0800
Message-ID: <CAEemH2e3qwHmDU89P3s8UmDi6CBhXLz0bN28Af2ZRnR-rzoqfQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 3/5] Add lstat03 test
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
