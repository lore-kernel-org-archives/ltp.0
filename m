Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D764C433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:11:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48FE4610A4
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 06:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48FE4610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 420E33C687E
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 08:11:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C8823C6801
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:11:08 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35AFE6008DB
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 08:11:08 +0200 (CEST)
Received: by mail-io1-xd31.google.com with SMTP id n67so2268514iod.9
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SqwaGiTpzQBE07WRbVBGvjb01yKJSD6j1sWmM16zRSg=;
 b=JgOgf5hcNhpRL9tnTailOk1lpbZcRs0t2yssc+1//VDrQOeh9wpXS5kJ+MDkJIPvk+
 P3tXhTv8tX80udsa17JfPX7O1VxLW5tSx7INFOG7b41/qTdNWSoAP8yWxHeQfJ8tBTX2
 t4maWlUYkED5JFWxH6h2PZgFZ7mpyd+rG5BTztC7PLHY4jkluYPns49ODbv5i414m593
 WAEMNt3LHrlq0rFuBJqwXKiNBArEZ1whXf26y7l3B+P5xZDREGI0cDDxHkhabtc0UqpF
 Acuvn39naiSVP4/2ufXaiSKh5SZzLikI2HvD7HhevJDFH0Cx90W8lur5zyKHvETxBM82
 IGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SqwaGiTpzQBE07WRbVBGvjb01yKJSD6j1sWmM16zRSg=;
 b=M4qI2MfmibrrclEWDNpDODzWMeilnk67+YbtTZfVp9HrZWbTyBFl5Tnrp9Bsl1Q7hB
 hP+F3kTc43ODnhe9KpP5bN150ZPNXp6bWW5ehdcoy31g2FM2DGLFstAJ0xbWeeM5IgiK
 cZT9Gi/+8iQtydZgE14qchjz0WM2QIaEJUQJpduqf6gGBqElavVeaRJM5mmBxfwngTrC
 axETn62GisLm17ma9dCw30AqdskFy8MCg8TIGNB1qH7z1MBHGBwIiFZx0JmkjbeXn86l
 0yl/473bUZia44mxypF92kcMJYZhwT7riOrpHqowkLUPz7z9aBe6EoiHwz/TZBI5iExE
 9wwg==
X-Gm-Message-State: AOAM531Jut1qGyQm1QvwExffzJ+UOt/zMR6R4NoTyg0msHBEksge5fIa
 d8HrksfmSpT2ZDQuF0RaJJAp2jma8Ka3z/3tITk=
X-Google-Smtp-Source: ABdhPJz/kkv/EWi6r/D4S7PT9bYM43ovca5FpB7VwlgVaJc4ZHGp39Y0fwcxosXffF8lVjG3k488ty5rsD1AM9G/zzY=
X-Received: by 2002:a05:6602:2ac8:: with SMTP id
 m8mr19102149iov.112.1635315066947; 
 Tue, 26 Oct 2021 23:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-2-krisman@collabora.com>
In-Reply-To: <20211026184239.151156-2-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 09:10:56 +0300
Message-ID: <CAOQ4uxgPM=D4_5ky=uADSFBFXOXia8A+XCabC3tF5wq1FmKQuA@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/10] syscalls: fanotify: Add macro to require
 specific mark types
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Like done for init flags and event types, and a macro to require a
> specific mark type.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index a2be183385e4..c67db3117e29 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>         return rval;
>  }
>
> +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> +       fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> +                                   fanotify_mark_supported_by_kernel(mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> --
> 2.33.0
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
