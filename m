Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567B0C433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 10:53:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02EDA3C983A
	for <ltp@archiver.kernel.org>; Wed, 20 Jul 2022 12:53:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 982F43C1B73
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 12:53:36 +0200 (CEST)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5C6420011A
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 12:53:35 +0200 (CEST)
Received: by mail-vk1-xa36.google.com with SMTP id q194so6746068vkb.6
 for <ltp@lists.linux.it>; Wed, 20 Jul 2022 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qgn4lzqB5dYjS3/duAw0VhMmFPHwwY4orb9x1il57Y0=;
 b=p/NER40qAiNH43/fMzdqNcDl8Hm6Lhtl53wLAv4pAMrcxbA7NHDAXBRXddNL8+XesS
 wiui+2bJnSDivAW0+zgd5bcCAMhyrRok88tAlFkkoIMRT3a06lZxgeqrb9FT0KXWgay2
 VJI36Cbe7TQzIUYUdW5wS64tt0Tkoz6o8WJAHUNjf0wrRHUxeoFnrsxKeQXCRrY4C2Gz
 sgmrMJ6TTmoCtsciSI+BQNhl3t66ZkE/pzN5D2zvUKrWJnlCo/zVVfKrI5ULV1gCJQS0
 GllDWoriqDeGbDbTZnZ1YqzOH+xLG+hSAxxx/IkRPHSxlnjgXBfmCaGBgBPZPoA4BrXB
 8E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qgn4lzqB5dYjS3/duAw0VhMmFPHwwY4orb9x1il57Y0=;
 b=DuUl5zLzFOMMFKlyg2sbTh4InLFkRdPZ+rQcMlo2fjru3DN1h8TzIy+TitlNUJXXGW
 5jCd4xcYdvxACjo4CxoAOedIZQ5p7cQ5tFd6AcXK3u88GExMmxW0Akbuj/veYOtajNaf
 XDrm5zBwBQRF8cVzlRqEth7uSHQzOOummsbU/9T61afcMmY59MVHn+MmO7UDdTLMoRfQ
 J9EVkkLUqvEfhi9duHUowGmqYc+cRxLJT/NyPvcRc/SdtwLebAmBAh3DaWPxzhv13ts3
 fHOZBZA2+ybTBtjOQTA2Iu+DUJBqIaT5vPkVVx3WtD4OQd9Wt/73k3hC4+SPoMPmQfrx
 t4iQ==
X-Gm-Message-State: AJIora8rVFHJ8/WOIgi7z1bE2HqlP2/5FINHr81lFf1oYUnhbgwCKOOw
 6NpGSSJBpXRdUMF/rRzpI6QSAa47x9QYHgaC4eE=
X-Google-Smtp-Source: AGRyM1uXn79xIrwYpDIWT+KRoxpZ5cyf023/eJX23rzO2m1oIMSz+qgyxK+SqsdEp/4XF98jw3yJTOqD5SPDvqQ0zzU=
X-Received: by 2002:a1f:2aca:0:b0:370:9de2:51f7 with SMTP id
 q193-20020a1f2aca000000b003709de251f7mr13521113vkq.11.1658314414701; Wed, 20
 Jul 2022 03:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220719095853.3373732-1-amir73il@gmail.com>
 <20220719095853.3373732-2-amir73il@gmail.com>
 <YtcpBkevcBF6iycz@google.com>
In-Reply-To: <YtcpBkevcBF6iycz@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Jul 2022 12:53:23 +0200
Message-ID: <CAOQ4uxi=9iMqOvE+9iNHkXxCqbGBp90QT5sisGwsVtGjoRzihg@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fanotify14: Encode the expected
 errno in test case
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 19, 2022 at 11:58 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Tue, Jul 19, 2022 at 11:58:52AM +0200, Amir Goldstein wrote:
> > So we can add test cases for errors other than EINVAL.
>
> Just one optional nit. We can probably remove the comments which are
> directly above the existing `if (errno == EINVAL)` checks as they're
> specific to one expected errno value, but this is no longer the case
> with ENOTDIR now in some fanotify_init/fanotify_mark cases.

Good point.

>
> Feel free to add RVB tags.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
