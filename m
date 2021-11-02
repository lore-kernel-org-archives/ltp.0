Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309B6C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:13:47 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB86D60F24
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB86D60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD2613C7144
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 13:13:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95FD63C697C
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:13:34 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BEC6160071B
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 13:13:33 +0100 (CET)
Received: by mail-il1-x135.google.com with SMTP id f10so17116335ilu.5
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mRRv7E+69/vVKkYW5342PCyFEeOfIo3cLN4E2lz8zzw=;
 b=qLJXf/NpGMRi+g1+Ss1mT3nGqoA4huV4gw3WrmPl4Rwag3nrrx2Gg4TzaIp1s2Pxtg
 qWNmf2Zm4kISmuE728jdrTly1UECxCq7PvJ1DdR0NCO8Cxcz32CgRUjHgLn1PiFf/Wqs
 Dx39R1YZAW2CVnCMYw3YR+sIqU9PBwacrCA9kj96L+PlkryTdzcy3Ryxc08syEOledE7
 +oplfcQTepHRS3eFDpIHzngUSa+7IWtAtESX1YpnOsCigYA8AT7u9k9idM+KCzjrcxh7
 0jEt/8CtfakiZUwBzyJNTMZ2FlDQ/YKa8G7GfyfIk+aLjvh4x/a+162uZQAc76QzykJf
 qcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mRRv7E+69/vVKkYW5342PCyFEeOfIo3cLN4E2lz8zzw=;
 b=IDrwkbSoOL6USgpC7CmxgCceB0cq8qQaOLv1fuAatr/SJik+e3IJNKdstb4sCFlrzJ
 L4nz1v4u2lD9GhEymb299H21ketN30aQGdmSkLiMGO7y6DdKZ4mTgpu/XiCjoUcJRszw
 Sb+7AUBjcLKxjzuUvBWV+OX3yCHxeDgMq5gkn6c+Cs72YhcKanyaTqucopBt3rC0JagK
 w0ur7thZLRe6UfVLVJtZECfdjmKjVH5JO8ghj0ULa89ays5GCoIvMqrV39yBJB02qRbV
 EvpkoVBogkGtL+a4hLsTrsIMlrZo/KvgT9WLwVrV4AaBF7D9SJDWRO6fNw0EgQccHwWZ
 gn7w==
X-Gm-Message-State: AOAM5315zj4B5qdXaNUESkXo/E09OkB87M4mFvshl3ATxHvLWJzYiTqd
 CbhE6TcVSYkrXTYLvHwF7kaDWvntbu83I4omMmI=
X-Google-Smtp-Source: ABdhPJydtBHU2UTFcy6EgBHaXPFJYQtGjjUl5mjlDqROX1fwXIOEDiWWkoyCRwRDFGFpYx/opWpn14Qm7zWP1E+C+AE=
X-Received: by 2002:a92:dc0c:: with SMTP id t12mr16924675iln.198.1635855212646; 
 Tue, 02 Nov 2021 05:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-2-krisman@collabora.com> <YYEgqgFoo7oJheFr@google.com>
In-Reply-To: <YYEgqgFoo7oJheFr@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Nov 2021 14:13:21 +0200
Message-ID: <CAOQ4uxiZetvK=r-tedgqNXR4nT=+kWUG5eVRWu8wVUQY5PN0Ew@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: fanotify: Add macro to require
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
 Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 2, 2021 at 1:27 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Oct 29, 2021 at 06:17:24PM -0300, Gabriel Krisman Bertazi wrote:
> > Like done for init flags and event types, and a macro to require a
> > specific mark type.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index a2be183385e4..c67db3117e29 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> >       return rval;
> >  }
> >
> > +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> > +     fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> > +                                 fanotify_mark_supported_by_kernel(mark_type)); \
> > +} while (0)
> > +
> >  #endif /* __FANOTIFY_H__ */
>
> A nit, but I'm of the opinion that s/_ON_/_BY_ within the macro name. Otherwise,
> this looks OK to me.

Agreed. You can change that while cherry-picking to your branch ;-)

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
