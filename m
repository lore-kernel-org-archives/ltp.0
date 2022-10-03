Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264C6C433F5
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 13:57:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2372A3C8965
	for <ltp@archiver.kernel.org>; Mon,  3 Oct 2022 15:57:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BA253C654F
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 15:57:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A42D3600E4D
 for <ltp@lists.linux.it>; Mon,  3 Oct 2022 15:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664805429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7NqqtqIU7uVJ5EUquZnNDMjDVSF1JH2AXwfaEgxdVi4=;
 b=JpA6OM1o+oSe06USRms+ZZ2UFPo7cbChG8lE51IM7XUqxtt2+Q7ZR/XKGWfN8i5e9Vg8hj
 FsyK7EFrsnC+LRLUyk6NHaAIbnNfA73BbqPLzpts0McWpTjsez9mveXLBGLgsv8KDixenu
 vekK+HoXmMYuk0MbzRD/YKRrV2Vg2xo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-196-o7gHZsKwMZmnOEx8hPPn6w-1; Mon, 03 Oct 2022 09:57:08 -0400
X-MC-Unique: o7gHZsKwMZmnOEx8hPPn6w-1
Received: by mail-vk1-f197.google.com with SMTP id
 b198-20020a1fb2cf000000b003a344f1be22so2310610vkf.12
 for <ltp@lists.linux.it>; Mon, 03 Oct 2022 06:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=7NqqtqIU7uVJ5EUquZnNDMjDVSF1JH2AXwfaEgxdVi4=;
 b=CMB24qveY8sGxENIQjaiN2KJY049b84cd0z3ir0W7ac4zASGiDNlCduWHcSdGaH0rP
 USD0GEUO5aUEIpDd1+rb0YdZVvjCLfg4lcfv3qekTNtMSM4IPTIM3XcNem9vcHzS//vS
 GarvuFTIY8XqOkpOY2YTdpU2d1j96rYeG464P6xUym4SRlI3+t79FZRt3hM1y0WvWrpJ
 ERERAZqSPNjWnwLoTxmEqtZXpHq3elJ7qpVqAZ4/32Q2khRgc9AKug9DObFVUhu9MNrc
 sENlp7WM9rfupjRINd1gqqtM2smqMKm1lmAZB+2qkmzPtzN+0HEF876PwMm/3EPaufYw
 vCpA==
X-Gm-Message-State: ACrzQf2WgdmrgDjQPN/bzfLa8bTcuoyT+zbQt0YkOPJufry2FfCe8n9o
 rJyoTRjm021pHHgFwRcfVcrEO7PRNdhnUO31lEfU2yCjl9gCNZttVmCEAP06BCmnbNJY9VroHNv
 xBHQUTZ+sqNwuP6aoLAnTRGjl/Sk=
X-Received: by 2002:a67:d89c:0:b0:3a6:9871:bdbc with SMTP id
 f28-20020a67d89c000000b003a69871bdbcmr864351vsj.72.1664805427714; 
 Mon, 03 Oct 2022 06:57:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ZESlFUXMt2RMj0vB35sNG/3x9Eb+6gD2CfsdS8Qkhrf9GvCKMasPnM51TiyDPe4jQngDDxZJyPzvSJ3UtZN4=
X-Received: by 2002:a67:d89c:0:b0:3a6:9871:bdbc with SMTP id
 f28-20020a67d89c000000b003a69871bdbcmr864340vsj.72.1664805427343; Mon, 03 Oct
 2022 06:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
 <YzrguY3J3YLJhU//@yuki>
In-Reply-To: <YzrguY3J3YLJhU//@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Oct 2022 15:56:50 +0200
Message-ID: <CAASaF6wmVVjattUS=XpAjs03692R8BLU+GE4ao+VpVz29eO2Pw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: introduce safe_write_fully()
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

On Mon, Oct 3, 2022 at 3:14 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > In case there is a short (but otherwise successful) write(),
> > safe_write_fully() repeats write() and attempts to resume
> > with the remainder of the buffer.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >  include/tst_safe_macros.h |  5 +++++
> >  lib/tst_safe_macros.c     | 19 +++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> > index 81c4b0844267..caee0e9cf842 100644
> > --- a/include/tst_safe_macros.h
> > +++ b/include/tst_safe_macros.h
> > @@ -645,4 +645,9 @@ int safe_sysinfo(const char *file, const int lineno, struct sysinfo *info);
> >  #define SAFE_SYSINFO(info) \
> >       safe_sysinfo(__FILE__, __LINE__, (info))
> >
> > +ssize_t safe_write_fully(const char *file, const int lineno,
> > +     int fildes, const void *buf, size_t nbyte);
> > +#define SAFE_WRITE_FULLY(fildes, buf, nbyte) \
> > +     safe_write_fully(__FILE__, __LINE__, (fildes), (buf), (nbyte))
>
> We already have a flag for SAFE_WRITE() to fail/not-fail on partial
> write, what about turning that into three way switch?
>
> Something as:
>
> enum safe_write_opts {
>         SAFE_WRITE_PARTIAL = 0,
>         SAFE_WRITE_FULL = 1,
>         SAFE_WRITE_RETRY = 2,
> };

I do find those names little confusing. What do you think about:

SAFE_WRITE_ANY = 0 // no strictness
SAFE_WRITE_ALL = 1 // all strict
SAFE_WRITE_RETRY = 2 // retry


>
> Or maybe just rename the SAFE_WRITE_FULLY() to SAFE_WRITE_RETRY().
>
> >  #endif /* SAFE_MACROS_H__ */
> > diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> > index c4cdc87e7346..e4d4ef4269a4 100644
> > --- a/lib/tst_safe_macros.c
> > +++ b/lib/tst_safe_macros.c
> > @@ -591,3 +591,22 @@ void safe_cmd(const char *file, const int lineno, const char *const argv[],
> >               tst_brk_(file, lineno, TBROK, "%s failed (%d)", argv[0], rval);
> >       }
> >  }
> > +
> > +ssize_t safe_write_fully(const char *file, const int lineno,
> > +     int fildes, const void *buf, size_t nbyte)
> > +{
> > +     ssize_t rval;
> > +     size_t len = nbyte;
> > +
> > +     do {
> > +             rval = write(fildes, buf, len);
> > +             if (rval == -1) {
> > +                     tst_brk_(file, lineno, TBROK | TERRNO,
> > +                             "write(%d,%p,%zu) failed", fildes, buf, len);
>
> I guess that we may print potentionally confusing output here since we
> modify the buf and len in the loop. I guess that we should store the buf
> pointer at the start just for a case of this message and use the nbyte
> and possibly write how many bytes we have managed to write before the
> failure.

ack


>
> > +             }
> > +             buf += rval;
> > +             len -= rval;
> > +     } while (len > 0);
> > +
> > +     return nbyte;
> > +}
> > --
> > 2.27.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
