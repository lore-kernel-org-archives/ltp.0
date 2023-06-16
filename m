Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B25EB64D9
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 02:42:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2375D3CC7BD
	for <ltp@archiver.kernel.org>; Fri, 16 Jun 2023 04:42:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D6E43CA907
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 04:41:48 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E06A41A00163
 for <ltp@lists.linux.it>; Fri, 16 Jun 2023 04:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686883306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53Wzp6PFErA/HW5l5+O0xH8EmmmFWSBhGej7f1dMn9Y=;
 b=QhBDhLgDDgFvnhEbWusqMKuP07GKaXQX1CCFheQz48y/hmiUJLhmUiemVU7SfId+F2LQfQ
 CuN+F/2Z81cCx4pCrxLyNqQLxskQZPGDM+ytVd34CvEbsgL4Ce2QhyyBNHKW+5thk6+ZUh
 zGSEhssMOj1kXGpLT4ogSYRBLYcEqUA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-zR3vDUnsO222kaXQBcAUIA-1; Thu, 15 Jun 2023 22:41:43 -0400
X-MC-Unique: zR3vDUnsO222kaXQBcAUIA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f627f1bb49so762285e87.1
 for <ltp@lists.linux.it>; Thu, 15 Jun 2023 19:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686883301; x=1689475301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53Wzp6PFErA/HW5l5+O0xH8EmmmFWSBhGej7f1dMn9Y=;
 b=dDP7sLbH0PtKZfx2b1Opef9edPWUHRpJ0TDNi1z0YQydHzNfobLp59MtUQlMe/cIqX
 LskqFNA8lcNG98TVM7y2S5OkdamVo31Vtu5828KJeWN19g7tnJkatRg2dIVuegLHzn/h
 pwmfxDr3xZGmgt5NYXOUFYfIfpWRIpSUwzSpCCBSuSkG93x0iKoi8QTI9bNaKhv880nI
 GFI5P7gRbuL+rzyYs3F9Y9P4iUzDUR54+F4u9indk+FizdGnEkYGk6LMV6hA8gF3kilJ
 V+z7ve6tZ305SJFWrfOmOq+WZk1tc7RRqG3qGYMU3t5Ufer/YAVE/2yzkXcxYRBpo0XK
 l5Lw==
X-Gm-Message-State: AC+VfDyxg4i8T4XkeMTGDsOc+IEuGDdHAyIrZwfnTHP+yCdIrJvotb3g
 rOH7CQHhxG9iX+tnz45UvI7uHOSwfQTx2P4mQX0XhnQ97eQdHjwgSdibbnsO2cIt1pYVx1Ph1rL
 xvARMNw+JCLxzX9s036koB4JwfSs=
X-Received: by 2002:a05:6512:3e15:b0:4f3:7974:2f32 with SMTP id
 i21-20020a0565123e1500b004f379742f32mr2085140lfv.9.1686883301616; 
 Thu, 15 Jun 2023 19:41:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4IyX+jV9OxyaGvbL/ZhCxdhbMFiEYSta13qW64AbW/23xP9kTuHzo+s40HZxyYGkbjFfX7dtvsKJeHRD9D+dU=
X-Received: by 2002:a05:6512:3e15:b0:4f3:7974:2f32 with SMTP id
 i21-20020a0565123e1500b004f379742f32mr2085135lfv.9.1686883301336; Thu, 15 Jun
 2023 19:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230615012445.4184243-1-jencce.kernel@gmail.com>
In-Reply-To: <20230615012445.4184243-1-jencce.kernel@gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Jun 2023 10:41:29 +0800
Message-ID: <CAEemH2edFty3Oz8L2bSwO-qzXrM1u9Nvne-MghkhJPFF-=d2Mw@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] safe_mount: safe_umount: print debug info
 about the operation
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

Patch applied, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
