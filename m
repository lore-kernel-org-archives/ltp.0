Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAB4C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:35:08 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D9061181
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6D9061181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8403D3C07B7
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:35:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DACF3C03B3
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:34:56 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5024F601CFB
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:34:55 +0100 (CET)
Received: by mail-il1-x12c.google.com with SMTP id i11so10914249ilv.13
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 02:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NtIGIma1t6qyPhVpQDHMt+iy8pZRdsI1+VnPn9GnDNg=;
 b=n5cAh85wcLsMwqP5zy7+GyUATrPSq+gFypQ9yZTYojT30c6kV1W+uQ6+naqUSV8DiQ
 stn32p5Ny3OAX5rNVA/uDrzP+/CpnY7/9HfsIyhmFv26MpX6GKen66/uTzGoHDCtXAsU
 ywhPyeJvBtScvx07s/3SAqD7xULwHq6t+urUNX6UL6wJ58IHOKlT1MEFB72h5K9i2/Qf
 yGMbr9IyD5Af7QhLFR4cYEiAMZZsagJX+m0+15DnKqDYPFudI3Hhy1RYYN0L1ujXP48C
 mgfTl8F6PIqxRHQ1aFbr2LKExsYveTLYxzdwClAqHPa6lcZMVLCcKd0mvlVcCL4XvuuU
 Mkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NtIGIma1t6qyPhVpQDHMt+iy8pZRdsI1+VnPn9GnDNg=;
 b=NaTmxbBUvVQ9u3XZtNiJZBcbIzIWu7U5dL7Exr4oRiDyfHIr4tQksw9Jfuzbt8PEDr
 x5uKO6ywdEulo96hpU0Yfe+JSMqQo8jkyaSXQtPCYds0SiMUfoMM06DqiuSx39VppkT3
 iWJYooXmB/G/8WImittS6PTLWXpl3PgBOgFk5AltuqwoGp/Q8GWP1sAtUqAWXX3w1bee
 lUAVfr4ng5pk0yXquznuR9/M6qrXDJNI5prgOhxjiFi88TKoGKQ8xYoPyIi/m8AebOLr
 SwxBDrW/aM/2cap4E8S0enw+koBIAY8o6KOcy0B1nIdg+ZHpe6JhEwh1MA6MPbeFP/ad
 /Dmg==
X-Gm-Message-State: AOAM530mOeE0jVTaBrk8nyt7XWsHyQLIGqi+1Y/w5QwTEpZxHsN/sTgS
 ouM9Vg+ktgUZ3JLaaP0RIas2t8yFoe5JNJSy2S8buLxz
X-Google-Smtp-Source: ABdhPJw03b3zQU/iDOia5aA6sKZIRRfsExczb8gxtuQeXE6wkjyzXc2ItC3ruprRTR7yOusnZpletontHz0cSf+Ls9Y=
X-Received: by 2002:a92:d643:: with SMTP id x3mr4407028ilp.107.1636454094070; 
 Tue, 09 Nov 2021 02:34:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635849607.git.repnop@google.com>
 <229fb61317343cf30d481d05da272657c7572f59.1635849607.git.repnop@google.com>
 <CAOQ4uxgphXO16-u2fsm9Ts4nxY3AzSPpyMbKMWb2AtWs2ASB7Q@mail.gmail.com>
 <YYpBAlufyR0nlI7S@google.com>
In-Reply-To: <YYpBAlufyR0nlI7S@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Nov 2021 12:34:43 +0200
Message-ID: <CAOQ4uxij_M7V9m=uyRakL2oSwon1Nbws=rBNTL6BeBR48OLz1g@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/fanotify21: add new test checking
 the returned pidfd from fanotify in FAN_REPORT_PIDFD mode
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

On Tue, Nov 9, 2021 at 11:36 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Fri, Nov 05, 2021 at 06:21:56AM +0200, Amir Goldstein wrote:
> > > +next_event:
> > > +               i += event->event_len;
> > > +               if (event->fd >= 0)
> > > +                       SAFE_CLOSE(event->fd);
> > > +
> > > +               if (info && info->pidfd >= 0)
> > > +                       SAFE_CLOSE(info->pidfd);
> > > +
> > > +               if (event_pidfd_fdinfo)
> > > +                       free(event_pidfd_fdinfo);
> >
> > Need to reset event_pidfd_fdinfo = NULL
> > to avoid double free in do_cleanup
>
> But, the variable event_pidfd_fdinfo is not referenced nor is visible
> outside the scope of the do_test() function and therefore no double
> free would occur, right?
>
> > > +       }
> > > +}
> > > +
> > > +static void do_cleanup(void)
> > > +{
> > > +       if (fanotify_fd >= 0)
> > > +               SAFE_CLOSE(fanotify_fd);
> > > +
> > > +       if (self_pidfd_fdinfo)
> > > +               free(self_pidfd_fdinfo);
>
> Variables self_pidfd_fdinfo do_cleanup() and event_pidfd_fdinfo
> do_test() are different.
>

Right. my bad :)

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
