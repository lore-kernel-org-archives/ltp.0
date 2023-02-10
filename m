Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A266AC05027
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 08:01:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60A703CC08C
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 09:01:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1DA223CC055
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:01:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 27C9F200C8F
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 09:01:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676016061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4TCp7YYTheGQKsJl+inRfp1YUM3CbQfQrU0+xqdHaU8=;
 b=H4mmoQm7AqGXnhTTY5WsttJ9c/YHTE9qqom29lxuUFnLzTJ8qBcS55Nvb8bOwHyOLGabXZ
 Ktid00DNjQ29dYSvy0QsQ4rfsje+DDWmMLPiuLs6hcYCzz2BqdpBmS6IkhdC44wlkP+bAI
 DUJ6RLckPTigZP8xecOJl3u83VmRcLE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-3CW3f4U7OwaHP2_wZkIFIg-1; Fri, 10 Feb 2023 03:00:58 -0500
X-MC-Unique: 3CW3f4U7OwaHP2_wZkIFIg-1
Received: by mail-wm1-f69.google.com with SMTP id
 m3-20020a05600c3b0300b003dfdc6021bcso2247111wms.3
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 00:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C5RmLZBoN75eU9R+SnLMNA8Et0r8sHBQ2nLTgs9/SMY=;
 b=URV/UZv69umSd2TSdLkTyaNsOwpsnXNmOGAtm0b2CBpW9tHs05/2CLelEjxHXEseaH
 JfcaFALRQtRgrs/EpFHyPcmKu2s5VFBhQHB0dd3ROuuHjeRCVbuEij83MK2lEZqHihbE
 uImnBmZoyO/mGSLXy9DpWpyWAWBLBUIlJqxyDzVtBdMevERU6IzivdVEGo/MaXb/A2q+
 YIAiSG0YdYJ7erIug+8NFpNv2xhEiDcIunr0MOFxYkl1HHGTlqnGFiK84sXCl2eQqBSh
 u8lts/LSAez2CY+wuwfA6YJLh+QyuMF6sWiYtNGnJHe79mNbx0mgYKA/jR1eNXXtimas
 v7eg==
X-Gm-Message-State: AO0yUKUvXNOePq1FOlhJHRH5zJcJEfASdT5/H7TTMk94ps4r9LfueaR3
 w/nNpWf3/c989uFWjxfYT11wpoizgk+2+ibMmFWFS1Qv1WXqluDnnO1CN+KnysFBKKYRl6VAEt/
 iMWa3t2QysowNtUnpr7HqW+O+Bsbn4PhSSzOMSOzF
X-Received: by 2002:a5d:5949:0:b0:2c3:36d4:edea with SMTP id
 e9-20020a5d5949000000b002c336d4edeamr658419wri.528.1676016056997; 
 Fri, 10 Feb 2023 00:00:56 -0800 (PST)
X-Google-Smtp-Source: AK7set+KWYps5Qjgg/pqz0eUROBg0ToS/8pkfEYgzDuJ2aTtQ7ahUVSOD8/8RU3ejIhWOmnD6Sp2dGEDu9JlXHZQtKg=
X-Received: by 2002:a5d:5949:0:b0:2c3:36d4:edea with SMTP id
 e9-20020a5d5949000000b002c336d4edeamr658418wri.528.1676016056624; Fri, 10 Feb
 2023 00:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20230209142016.494090-1-pifang@redhat.com>
 <a4e0b95e-47dd-0c05-9575-a844d1e05953@suse.com>
 <CAEemH2d2CoivWG_A+aDURAHSTaY_pE+djDYTeVu8tmWdGnw86g@mail.gmail.com>
In-Reply-To: <CAEemH2d2CoivWG_A+aDURAHSTaY_pE+djDYTeVu8tmWdGnw86g@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Feb 2023 16:00:45 +0800
Message-ID: <CAEemH2dwdokuU+PJEGWcM43HLxKnyoJyZRzLLddD84QxcEu4hw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] aiocp: remove the check read unnecessary flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

Just for curious, I copy this complete patch into chatGPT,
and the analysis answer from it is below FYI:

From chatGPT:

"
This patch modifies the code of the "aiocp" utility. The purpose of this
patch is to remove the check for the "read unnecessary flag" in the code.
The check was causing the "aiocp" utility to fail when executed with the
"-f DIRECT" option.

The code that was checking that the data had been written correctly was
using the O_DIRECT flag incorrectly, which caused the failure. The patch
removes the usage of the O_DIRECT flag from the code by changing the open
flags for the source and destination files from srcflags | O_RDONLY to
O_RDONLY.

This patch has been reviewed by multiple people and has received approval
from them. The author of the patch is Ping Fang, and it has been signed off
by them.
"



On Fri, Feb 10, 2023 at 1:27 PM Li Wang <liwang@redhat.com> wrote:

> Hi All,
>
> Thanks for the patch and review, merged!!
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
