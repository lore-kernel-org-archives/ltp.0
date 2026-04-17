Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F030F8DFEA
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776414915; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NFXpKNUt46vg33XweFRIU6qXAUNm1RKj9aKqTLjs1a4=;
 b=oDINBwM8CdJNUOGn8neVMdizzFC70OE0z4WXfA0WvmXpjdWe/J0aqqQUou0CGLHOYOmjh
 VV2V6AH7sejO6wyIteBg2CV4rfE5wFScaIwLTzDrOcDeQeyO0T7Y9dlVtaNL8jr4V/KPQMb
 O+txS95TZpKdZOYrR7MX4WJaGigXxkI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C10EE3E2627
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:35:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AE9E3C2B4B
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:34:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 98D4D600A3A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776414889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFknYmXUOSE+SRVcbLK/TE7T7lH2V7GvdxTSG1FI6fg=;
 b=hwrxF+8HnTGxcFbIArfN7dIZq+hf9rR6/0nXZ91b647Bp2BLqAhjUITQx5h07wxgTfytGf
 eq2L8MeZLlc3/HtX8DpOH1lSe4qUzp1Ed/uSQnBWx/wWBaKPIeTwiv0UesX6iz0UYR3ahd
 zmaGd8u3/IzjfHMLvATjIPuU/d9YtZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-T8YxIN9yPqK936tgw3VJww-1; Fri, 17 Apr 2026 04:34:48 -0400
X-MC-Unique: T8YxIN9yPqK936tgw3VJww-1
X-Mimecast-MFC-AGG-ID: T8YxIN9yPqK936tgw3VJww_1776414887
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d1ceb2ddfso320926f8f.2
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 01:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776414887; x=1777019687;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hFknYmXUOSE+SRVcbLK/TE7T7lH2V7GvdxTSG1FI6fg=;
 b=UwkG7UfiS0SJomG8UdAj3/mudlcPoLSWkwKsaMQES9qZJsyv/1hTqv4ldW3Bj7xWp+
 W/kdcZPQ1AsoO8nSJ7n3Tlyiqzbjw+Q9iwRPGYx39dUJAfzP02HVVRze193pvY+0BC7o
 0h9vMfCVXdotdNCAqAzOEhrvyciDsQwNKkMOlKjxtwdL6JSPZkf1IJlLGzfKFNehUmwf
 qAoKQUnWb/uMlx6ZmPMBLh89+ujC/OfiCozR8JyH6OwcpcWT4lHtA5LMloxN+m3osnxL
 FgjVlBLTWn61yy8eesn3fvLS2jV+KAAK40JAc1F/VVhRQq24C7oKCiTupk5IFMkeOOe2
 ghQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/02F5564aSdmpn3oOWgKMu2lqahvm/B0pmsSxBNbJStwb5Gn5uVafx3iBBVaVppaFruoU=@lists.linux.it
X-Gm-Message-State: AOJu0YySLHQzQQa3GVfZ2SndDZhmgOrHRp9kPw3h30xC3qhjyjeK7MRG
 4jt/gLwHgoL/+HGTdnYFdIdwc6YlXMAYSQeHEkPaa6l9RNigr92HqgNVqjGnxNjFJOYHFMGB7YI
 ljI0HvHJDBzyPnlBfmzTg9zihjzRTwr5WhYhjDQ5n97DFUjjKihVF
X-Gm-Gg: AeBDiesIcSkS4GZF+r5HA4aU5EwWxbHcAiqNg5Bqe+5rNUKwBVZH8u86v5pUyF03O7T
 tUcaKxTH5LInQOeOgiw8Vr+yp+t54gvwtByJ9ECq+Fu01r2aN4pvgVJcB42AwzE5Ycs4IUxwiVX
 NU4iyeGshayBuPmzATMXU4xUId+C/dRDNfUJf5XprKSgwpBMStqMYclg5kOuR2rEFyOK9b4J7+v
 nItyxI2ksbiHXViUlbD0rEkSqIc6JQJomc5tg2wrEhyIMu7u/COGPK2/tuWlx51DuzBc6wJt8Ra
 +p71AA/fm6ac9zvOtyAwPfqBTtHJ+yUN/Qfo5JZsLsYXpG+DMmT55PaTaTKlOFw201FkCicfbAn
 zDT7ern9oLReaj6hNklAZKmNgmKT3DP7JHDQPbR+jVqKU
X-Received: by 2002:a05:600c:1389:b0:485:9a50:338d with SMTP id
 5b1f17b1804b1-488fb739d3amr26967885e9.3.1776414886855; 
 Fri, 17 Apr 2026 01:34:46 -0700 (PDT)
X-Received: by 2002:a05:600c:1389:b0:485:9a50:338d with SMTP id
 5b1f17b1804b1-488fb739d3amr26967125e9.3.1776414886200; 
 Fri, 17 Apr 2026 01:34:46 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc11ced7sm24973275e9.0.2026.04.17.01.34.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:34:45 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:34:43 +0200
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260417083443.v2yfuwvz2dstty7s@lida.tpb.lab.eng.brq.redhat.com>
References: <20260415082547.vgn23q2aobxy5gzv@lida.tpb.lab.eng.brq.redhat.com>
 <ad93vsV4GZ4nenoR@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <ad93vsV4GZ4nenoR@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HHmMsZNqmbdDd4hMLzFKdG9w5E3f20Wr5Ng0AzARCY8_1776414887
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Make ioctl_pidfd02 valgrind-compliant
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On  Wed  2026-04-15  13:34 , Cyril Hrubis wrote:
> >  #ifdef __s390x__
> > -	pid = syscall(__NR_clone, NULL, flags);
> > +	pid = syscall(__NR_clone, NULL, flags, args.pidfd);
> >  #else
> > -	pid = syscall(__NR_clone, flags, NULL);
> > +	pid = syscall(__NR_clone, flags, NULL, args.pidfd);
> >  #endif
> 
> Aren't we missing more that that?
> 
> Looking at kernel/fork.c:
> 
> #ifdef __ARCH_WANT_SYS_CLONE
> #ifdef CONFIG_CLONE_BACKWARDS
> SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>                  int __user *, parent_tidptr,
>                  unsigned long, tls,
>                  int __user *, child_tidptr)
> #elif defined(CONFIG_CLONE_BACKWARDS2)
> SYSCALL_DEFINE5(clone, unsigned long, newsp, unsigned long, clone_flags,
>                  int __user *, parent_tidptr,
>                  int __user *, child_tidptr,
>                  unsigned long, tls)
> #elif defined(CONFIG_CLONE_BACKWARDS3)
> SYSCALL_DEFINE6(clone, unsigned long, clone_flags, unsigned long, newsp,
>                 int, stack_size,
>                 int __user *, parent_tidptr,
>                 int __user *, child_tidptr,
>                 unsigned long, tls)
> #else
> SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
>                  int __user *, parent_tidptr,
>                  int __user *, child_tidptr,
>                  unsigned long, tls)
> #endif
> {
>         struct kernel_clone_args args = {
>                 .flags          = (lower_32_bits(clone_flags) & ~CSIGNAL),
>                 .pidfd          = parent_tidptr,
>                 .child_tid      = child_tidptr,
>                 .parent_tid     = parent_tidptr,
>                 .exit_signal    = (lower_32_bits(clone_flags) & CSIGNAL),
>                 .stack          = newsp,
>                 .tls            = tls,
>         };
> 
>         return kernel_clone(&args);
> }
> #endif
> 
> there is at least child_tidptr and tls as well.

I've updated my patch (and commit message) accordingly, and sent
it via git send-email per your suggestion - as a separate email.
Please check.

Cheers,
Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
