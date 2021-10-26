Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93052C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 15:16:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D960A6023D
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 15:15:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D960A6023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 311793C6879
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 17:15:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCF703C67D7
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 17:15:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2589C601569
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 17:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635261345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrcIx+1LzgzO+kzfujsKUFFO55BG2ORlzIih50fbvHg=;
 b=MFYWyeMoOPBlo5W1MBS3Uruc/6Eqi4ebU/9+rPxUYLm58Thxl3PhtHDfTlbUjNlS1aDnXc
 vjk54PYjF4GeW7lb0n2F/lx2FUsctYl5FAMdPyqizN2lf3/BIp4f6283dRgOFyV9Dwoj3R
 Lmw/LMEFj61sWGgxb4TMvNXAdTNLF9c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-U2LoJY-4NmimFGkwsdQUMQ-1; Tue, 26 Oct 2021 11:15:44 -0400
X-MC-Unique: U2LoJY-4NmimFGkwsdQUMQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 f21-20020a4abb15000000b002b766ff48feso6000407oop.20
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 08:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rrcIx+1LzgzO+kzfujsKUFFO55BG2ORlzIih50fbvHg=;
 b=sxPzc1jz/bcCgl9m+hJf0bEWDKIdAyX6hZwPUktCsYbHha1Q70zfhuUbxktAEG16Zf
 N81PSuBECCieQi4i4m17T0x8qih+tXt/dkWDORpmjOg3u0nw6U2AabK8xy29zmTYiQVk
 VKRcPNBmPxsOg8I7gLoYfyhHwKKoV2NcectXj4LO6n3KrTY8A9+eLAgs/fRsxngVR+99
 GhKTS9o3Od6ySxtG6f60jCEr+IqBIiEsygWQZmuYKUFT+n1ZigiVVsIwRxkFhjz4nvmT
 D6LUUKNEA9EGeCjZy7GlsgP9kP4XusgSja197syBxMdHMKcee0RZtWM+a1TPF5ITVjHw
 r/5w==
X-Gm-Message-State: AOAM530i/OU904FqTlWE6/OLhbpDAmso/7PLXyqPhx9Pc4K2cMEd8SyH
 L5kXcgKxkoCyXZw/vDs/H/ioo1A8AzJzvdF8/mLFQJkkg3wUPJZL00gBJ2pX9AEAxv92bcvqDYz
 +K+6Z6pydxpamM6Lh9rev41Svvac=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr19418570oth.176.1635261343736; 
 Tue, 26 Oct 2021 08:15:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQCow1tAacXwSz868Rm84SLrg1ejytXpaAkpEl+fQzb/Jm+IGiouMvmTeIqWqwVo1dHb47zTS7kX172fL93kY=
X-Received: by 2002:a9d:53c4:: with SMTP id i4mr19418554oth.176.1635261343575; 
 Tue, 26 Oct 2021 08:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <04692b4000ee415add41128173e395f830ea3e56.1635168255.git.jstancek@redhat.com>
 <b987a73550937e5d5652e4a86e591d72334d8fda.1635244875.git.jstancek@redhat.com>
 <YXfeAnRORHareVtn@yuki>
 <CAASaF6wZEaQjUy8RU9TCp6GpWKN6FkQSWtOb2iLDNY_1KCmE8g@mail.gmail.com>
 <YXgZ0CK737PXTv5Y@yuki>
In-Reply-To: <YXgZ0CK737PXTv5Y@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Oct 2021 17:15:28 +0200
Message-ID: <CAASaF6zO1KAkGmpWN7Gp6u-5NLmxZWvCa6qWtG08QkX=zTDq+A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] finit_module02: fix exp. errno for O_WRONLY
 testcase
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 26, 2021 at 5:07 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > Also I'm starting to wonder if the errno from dir_setup() should be
> > > fixed in the kernel as well. I guess that EISDIR sounds much better
> > > error than EINVAL.
> >
> > It does.
>
> Will you send a kernel patch or should I do it?

Since you found it, I'll leave it to you :-).
On second thought, EBADF might be better, since it covers other fd
types as well.

>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
