Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39594C636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 16:34:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E15733CD0F1
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 17:34:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 083A73CB111
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 17:33:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E1981A0068B
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 17:33:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675787634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPOSy1V0oXGMXeXhaddCA9hHoHdZPoWNxv1ettv8oMQ=;
 b=CJskKUwdJmYb/jA4rkXC91TdQS3SxFjSmmlZ+CHOl71esWp0qpGUVqRlyJtTH17yVgxdFu
 SrzX5WblI4kyWCLJ8EGidp+QiE8Esc5FafM2bONxBdP2QZkTDbbLT0TY60meGL0hZ56xZd
 k1nkcTlHsEZv3KaRIbUILslGLVKiQ68=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-iaSD2chdOv6_TXdZee_1Ug-1; Tue, 07 Feb 2023 11:33:53 -0500
X-MC-Unique: iaSD2chdOv6_TXdZee_1Ug-1
Received: by mail-ua1-f71.google.com with SMTP id
 r2-20020ab06dc2000000b00683be78a794so2287227uaf.23
 for <ltp@lists.linux.it>; Tue, 07 Feb 2023 08:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPOSy1V0oXGMXeXhaddCA9hHoHdZPoWNxv1ettv8oMQ=;
 b=eHGzhVPcJchWwo2JANllaqkfOy8eldU+0Z1dQOAu0ody0Ey9IFuEfI2ygKv4cCL7hs
 IbSlgePs9vnR8oDs2UQiVyo9TsA1OTsAB1MGZKCz6Ca8zsl4jM3EoEsuoMjaRrxyIfQN
 /xQ49Yc3GyB4mVh+TRMERhMNgDIXkLhHape0O2QJzO6c9lfnWcAR+JVvyhB6bvRQznaN
 jTXc0ln3HIbR6MqztiCucZi9LQt+KpDYreFzc3aHCsKA1wTzIykRYd1S2JDjNsgVPcAP
 NnJLwtnt5TzWWa3U2BN0vRqouGH2S3M4UIoyzsgHMkCN5BkL3kaOYLEyzU43CRDCq0vj
 S0Qg==
X-Gm-Message-State: AO0yUKWYZQBqsQkJRrSqEgfyIWN4YbcJYBXQ0ArSDfxVpddO4KTc3eDg
 c9eV5ib9csI11ThcD7U5J1bwhZC8/tXpe/hDdMYsVYjH16OVNXwney71jxfvKojo4wVZdie8PMS
 +WGnMwqDttsHuUIwQwMm0nDYzjgw=
X-Received: by 2002:a67:e3b8:0:b0:411:a761:635f with SMTP id
 j24-20020a67e3b8000000b00411a761635fmr333884vsm.8.1675787633092; 
 Tue, 07 Feb 2023 08:33:53 -0800 (PST)
X-Google-Smtp-Source: AK7set8aAE4K5PJWy3IkNc1GCFRzI/vJgJ6FLsfDm11Te7ZJY/KVmebt8aAnZMtyxj/B7hbtvVSZuQfCBX98cyIsxqI=
X-Received: by 2002:a67:e3b8:0:b0:411:a761:635f with SMTP id
 j24-20020a67e3b8000000b00411a761635fmr333877vsm.8.1675787632775; Tue, 07 Feb
 2023 08:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20230207124008.1788759-1-ycliang@andestech.com>
 <Y+JVPi5jo++joA/g@pevik>
In-Reply-To: <Y+JVPi5jo++joA/g@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Feb 2023 17:33:37 +0100
Message-ID: <CAASaF6wHSR9JsBE=Wk-tjNcA+379E2XVz+7XuyX9Ax4CqFESqA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_pids.c: fix fork failure on small memory
 systems
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

On Tue, Feb 7, 2023 at 2:42 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Leo,
>
> > Running syscalls/msgstress03 on a system with less than ~1 GB of RAM fails:
>
> >       msgstress03    1  TFAIL  :  msgstress03.c:163:  Fork failed (may be OK if under stress)
>
> > The reason is that besides /proc/sys/kernel/pid_max, /proc/sys/kernel/threads-max
> > is another factor determining how many processes a system could create.
>
> > Use the smaller number between pid_max and threads-max as the nprocs.
>
> Makes sense.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
