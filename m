Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24A9C2BD09
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 01:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A48E23D3DF4
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 03:54:19 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CE613D0F62
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 03:54:04 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 25F75602325
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 03:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720058042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t1QuxKfbfZMwvF+FNNzhLnIFQko/0QT1XTm+V/xQdag=;
 b=Ja3wRp4V5mV3EZnMis3MaezbEUfZVQc/DdUdWOx+hCHO0wPXsxlnch96Daz2JtNxXPrTTl
 6/uUzXxR+FgFJJIYSOaY7BbIQyWiinHdulaY539WciKtTHd5OXz52rIu0eIFzt+5h2Xoy3
 fIsUE8J1c88w8pdGQnSez2TDy6iYPR8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-GrY21yKcPdmQYS2fXOe5Cw-1; Wed, 03 Jul 2024 21:53:59 -0400
X-MC-Unique: GrY21yKcPdmQYS2fXOe5Cw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c9015b0910so1029446a91.1
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 18:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720058039; x=1720662839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t1QuxKfbfZMwvF+FNNzhLnIFQko/0QT1XTm+V/xQdag=;
 b=MVgC8AA9aXredewYeyYJ1i/djHLxRO5eUGLZfSl4tgTiTjAc+Q2ZgHTFeT/agrZN67
 j/tG7h20moUhH1nmH3n4X5fmZFaTX3TeqkEMk/Sp8xQPUE98Mn7dqcGo5Yx8/YzVBtrp
 KVYUBLcmRekGJ1ejgN+7c1MkFNvaTpgy+arj6vdDOja3aV5qgDKeI00hKbegjOy/lPeA
 pG6Ac4XGTCjz4pOBHWw+UVYVjDE77AfyLmnYUf9CwxsOSagoydKllmTWPSIDImRr+u74
 hrsB7dMjniDEG7Wt2e80U/PBbQP8WXau0XZUxDhr/yRqk+Qe8ecZPUcMU+QEe6eydn4D
 5FGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUovPcado7fga3pYwU35xdbEb9EMQ50iSUrv1jJTSWdRD634qBqw93BuGTISYG32x9Rs6BxLSgK0zT8E63WdOK/KyM=
X-Gm-Message-State: AOJu0YxiL1uPuQ4XUSLu1d6uWCU5ZDhVg0QrI0pOvPzHonFOTbn1RVEf
 XKzBsPW1RtRZuV7J/HyyQW3gZ8iVB2H4CTMNNkWZJpLASltC906PwZhUB2DSeSTZSnCqYqs4GvI
 8/m47Pdues5YsM+TxHPqiLrv1dXfG3LHw3mRYkcQLsiJhTCcVxO2/hnCFrWDYbWHTs8vuSguRNZ
 P00BO3kQE1Bpa2NpR3k8s7lGI=
X-Received: by 2002:a17:90a:b38a:b0:2c9:7f8b:f7d8 with SMTP id
 98e67ed59e1d1-2c99f32f1b4mr53930a91.6.1720058038738; 
 Wed, 03 Jul 2024 18:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtSnesMi3p+2JtrDyBt7bmQ6+6xSE1whWKxyZ1wT0OhrF9E8+OcmNvk4aF654DbWmKVXr47/1yQvxRV5Tnq/g=
X-Received: by 2002:a17:90a:b38a:b0:2c9:7f8b:f7d8 with SMTP id
 98e67ed59e1d1-2c99f32f1b4mr53906a91.6.1720058038226; Wed, 03 Jul 2024
 18:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-8-58e9af649a72@suse.com>
 <CAEemH2f_Tq0W46x61FokVYwv4sK=8NhwfM5SY-gj1znbGnAmFg@mail.gmail.com>
 <CAEemH2cM6DMQZ-3j3sQ-0b1zD-rfeaCRTefO00wMnGqYeLn+Pw@mail.gmail.com>
 <65c8c745-fdb7-4172-b81b-cd1930f0dbfd@suse.com>
In-Reply-To: <65c8c745-fdb7-4172-b81b-cd1930f0dbfd@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 09:53:45 +0800
Message-ID: <CAEemH2eOHHfKhi-jUe7rGCGJvsav55jvPRGjWT3gZGi7jjCzgQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 08/10] Add landlock04 test
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

Andrea Cervesato <andrea.cervesato@suse.com> wrote:


> +# the reason why landlock_exec test binary is statically linked, is that
>>> +# we can't read libc out of the sandboxed folder once
>>> LANDLOCK_ACCESS_FS_EXECUTE
>>> +# has been activated
>>> +landlock_exec: LDLIBS += -static -fPIC
>>>
>>
> And, if we decided to build the program as static, we'd better
> adding glibc-static into the dependency list, otherwise it always
> failed to link the binary on RHEL distributions.
>
> We found a solution for this. We compile landlock_exec with dynamic
> linking, then we apply READ + EXEC rules to /lib and /lib64.
> In this way we can easily execute the binary and we don't need more LTP
> dependences.
>

Sounds good.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
