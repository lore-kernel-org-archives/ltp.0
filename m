Return-Path: <SRS0=gHvU=PP=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7052EC433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:20:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E192A60FC0
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 10:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E192A60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 435DE3C691F
	for <ltp@archiver.kernel.org>; Wed, 27 Oct 2021 12:20:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B79A13C6868
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 12:19:55 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A9511A01A54
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 12:19:48 +0200 (CEST)
Received: by mail-il1-x133.google.com with SMTP id l7so2353304iln.8
 for <ltp@lists.linux.it>; Wed, 27 Oct 2021 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZRuknEg+bXzpHdRasbCR+VO8e6gnGIeqPTgWpleV5F4=;
 b=JH4SaBvKR5O8U4dJwVuauo33s+p6H2UNOBc5R/7r3Rqi+YctqoMD0h0C2J1z+ZAn2y
 AvHtVwmrA9gqRDe2T3y+dv9jb2ygo4JvU1lHEdvt526VG0dtNyHbG40R4WKWutuYrjEW
 lCNhOJAbG0dUOO552OQWwmkc16+A3QzNOh1j9m8+3z05k8Hd+bDPJtUkQ//xWV4zaUQe
 UruwJxdgdGOThMCVR0dc1cLULc9l55A7u1Chl3fJv6Nk03n/4rBidkio1M6njFoaEkIS
 eS1jbyziN2P4t579mW8Dt0rCz/pRknwEIg7/BiVL6Vz8Qn0O8TSSfcmOj0U2tvVoh8rk
 4MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZRuknEg+bXzpHdRasbCR+VO8e6gnGIeqPTgWpleV5F4=;
 b=aSKFBR7OCJeENvDhH7X4A9rwQDRZHMSJIbaaTdY671v5z08D1oWwYmcWiBdm0NCRn7
 EcCBV8xd2snLGVOM8QdL1WHn9qtNF8Vi5b8v8LajuiuOwa6BQAV1NyQWctCKNs7LWrB/
 7/9mmSofDL/9D6sbZPJLqvxyHOXpShLNlskxT+81KmCQfk00RME3zkg4+l/uNPJk88Kn
 bX/faT7I5JMI7OY9iakwWIewCGvJr+Sa6oo+zfgsWFa75iFeAeaRMA2g+aTDMitpi17M
 on0vobB0T7rRC4Kn1XklCQkCX73m1IP2qW3RHJuzkWZ/cJkl9+eexNstdrXa0D/kuRMi
 Ntpw==
X-Gm-Message-State: AOAM5338yRKHXT1nvHYO8d14q13ztMqgafqMsv0dZpVbqEbZPq73YlOk
 G1D2iZ8ECfmYtdD7l3aYzLQayublCidl3A+FYZw=
X-Google-Smtp-Source: ABdhPJwNSxhip3enHdK5O5ZdpZUhCLr79/Cu4g5rCXygrWtdPDIM7xYpUoVhjO26KTu50j0PPkBhvQ005qNSAiZtGcU=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id
 s15mr13759138ilu.198.1635329987184; 
 Wed, 27 Oct 2021 03:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211026184239.151156-1-krisman@collabora.com>
 <20211026184239.151156-5-krisman@collabora.com>
 <CAOQ4uxgtkV7kF-YoWH4mau-p2U6bwLb1ajHXmVV1hwoDVpEDTQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgtkV7kF-YoWH4mau-p2U6bwLb1ajHXmVV1hwoDVpEDTQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 Oct 2021 13:19:36 +0300
Message-ID: <CAOQ4uxia1GQPPbZXTiKnP-CWkfVczDhMmTe6+C5R_Gk1USOd-A@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 04/10] syscalls/fanotify20: Validate the
 generic error info
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

On Wed, Oct 27, 2021 at 9:43 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Implement some validation for the generic error info record emitted by
> > the kernel.  The error number is fs-specific but, well, we only support
> > ext4 for now anyway.
> >
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
>
> After fixing and testing configure.ac you may add:
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> > ---
> > Changes since v1:
> >   - Move defines to header file.
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify.h | 32 +++++++++++++++++
> >  .../kernel/syscalls/fanotify/fanotify20.c     | 35 ++++++++++++++++++-
> >  2 files changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index 8828b53532a2..58e30aaf00bc 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -167,6 +167,9 @@ typedef struct {
> >  #ifndef FAN_EVENT_INFO_TYPE_DFID
> >  #define FAN_EVENT_INFO_TYPE_DFID       3
> >  #endif
> > +#ifndef FAN_EVENT_INFO_TYPE_ERROR
> > +#define FAN_EVENT_INFO_TYPE_ERROR      5
> > +#endif
> >
> >  #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
> >  struct fanotify_event_info_header {
> > @@ -184,6 +187,14 @@ struct fanotify_event_info_fid {
> >  };
> >  #endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_FID */
> >
> > +#ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR
> > +struct fanotify_event_info_error {
> > +       struct fanotify_event_info_header hdr;
> > +       __s32 error;
> > +       __u32 error_count;
> > +};
> > +#endif /* HAVE_STRUCT_FANOTIFY_EVENT_INFO_ERROR */
>
> Need to add in configure.ac:
>
> AC_CHECK_TYPES([struct fanotify_event_info_error, struct
> fanotify_event_info_header],,,[#include <sys/fanotify.h>])
>
> (not tested)

According to Matthew's pidfd patches the syntax should be:

AC_CHECK_TYPES([struct fanotify_event_info_fid, struct
fanotify_event_info_header, struct fanotify_event_info_pidfd, struct
fanotify_event_info_error],,,[#include <sys/fanotify.h>])

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
