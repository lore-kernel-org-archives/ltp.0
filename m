Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3701C3271E
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 06:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1BED3CD291
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 08:31:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5147C3C21FF
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 08:31:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10085208DF7
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 08:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720679463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=smWv+alCI7OVlMflLk9RgzY0e5Aw5pXpQa3+DmfHP3k=;
 b=fj1T0bG/Ymw1l+zBBYyNqK7Y0J3kZkSvK5DjwScQvCAKgpAMjkE/ZiYaJCv8bXnRdScdua
 7I1+JdwidF3xLFMiKFzVCYvcBLBplq18gHkVi91ra1mduGbuSaDicAydcaVFpuWSoRgFFz
 7WyznYEIk6nCb+i7vssyNgMCN8d/9X8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-d1wcUup6MO2IcIY-TRvxJQ-1; Thu, 11 Jul 2024 02:31:00 -0400
X-MC-Unique: d1wcUup6MO2IcIY-TRvxJQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c96cb48a8bso525511a91.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 23:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720679460; x=1721284260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=smWv+alCI7OVlMflLk9RgzY0e5Aw5pXpQa3+DmfHP3k=;
 b=rIHbZzgtNAhXF8bXFkyYctA8bmzJa+KU82vqDkbOKSTHx4qlqYcZ2dZBdfhIWXZUgp
 UdF3jDmy9168i1rjcdQHur+OLhTAy1rptRmBnPUQ8TpPM5KyybCmvj14jNbJb5y1qvAt
 YJxIdy8CTXR+HKbjC/5xNvpQNPf2DjahCs2qsq2+ECNwN6yEQBOLSSaXjNP8lvakHUTX
 qq/DUbASbgXxKcxflukJJuBGbqzwuNlYhpNWN7+j1LqrQD7Vbt1oCrT3b1c1DbGt4Vt0
 WxpCqb7ntebZkVC1f5ebAQgMGyRMT47hC4TBLq29FTwKDHbQ3Ex3iPLLP2xknyahlSj5
 T7xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSHsFDEhipQ+MxscPK1k3icWDQ//3DwguIjY5htbV9NoKY6ci/KHn17b7yXnyQbYPM+FnW+gVYk+U0Rya5ZYLTJt8=
X-Gm-Message-State: AOJu0YwPN+4GebZI2AYmy+5zOxxzcHOCv9YWPmqSfR5u8ha4eW3eFJXY
 /KIYQptLW7yYmQCTIsvu26c85UsUTO1YXoX9X1A9D7h5h6SJrP0dli5d+uAG1WATZ8g//AABVVx
 hmO6Z2YrTe5vJw5RTruiuqCh/40pXXSQgD9Govo0U6hx/X0NHnwa7WawTUWRGudIP7MIWh84xCD
 ZYXBHyCq60NWe10enYKAKPYas=
X-Received: by 2002:a17:90a:d714:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2ca35c7bd4cmr7009190a91.23.1720679459761; 
 Wed, 10 Jul 2024 23:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECp+u7x18ZMRfZa1gYYvOMoHalv6PtX57Cs3pf1ssumCPWhCrZqr0AWxJ/dANOBLnoNyivSIAVhFBg6PWcNVU=
X-Received: by 2002:a17:90a:d714:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2ca35c7bd4cmr7009163a91.23.1720679459259; Wed, 10 Jul 2024
 23:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-3-58e9af649a72@suse.com>
 <20240710155308.GB300896@pevik>
 <9a33a68e-3cd2-4a51-b525-97516fe97b7f@suse.com>
 <20240711052704.GB3591@pevik>
In-Reply-To: <20240711052704.GB3591@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 14:30:46 +0800
Message-ID: <CAEemH2f31sAc_ROM7Zum24s0cpmnBFcQd4+fZ6MBdxVw6hmjSA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 03/10] Add landlock SAFE_* macros
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

Petr Vorel <pvorel@suse.cz> wrote:



> > this is already done in the v2 which has not been sent yet.
>
> Thanks for info, this was not obvious until I check github actions in your
> fork
> (or I miss some message). I keep patches with NEW state so that other can
> have
> look until you send v2.
>

V2 has been posted, FYI:
https://lists.linux.it/pipermail/ltp/2024-July/039236.html


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
