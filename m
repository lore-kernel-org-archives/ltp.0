Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C6FFB44C3
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 07:08:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5D363E2582
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 09:08:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E3D33E2571
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 09:08:04 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D60C140042A
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 09:08:02 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:07:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777014481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PTlXYIppQeifMJSzpkIaUIkr5rkNGsaEb5utNlmfQqY=;
 b=eUDJMqfEdDj3eRjtz6s5HoUhzC/BBOUSQSGkWzRG8FgqwqFQYpPqB6NMpj3hPAcZ7abCBV
 NXHB+Ox49JZIjFlhyYJ9sXGK6aNEAQ/9+8xDxvwerm1r+Dz8w+jV0PNTrMnZisqQExs5Uo
 UlT11YY1IrXSKQMfNnkNmq4fAOLAkCY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>, Jan Stancek <jstancek@redhat.com>
Message-ID: <aesWy5_fBdPNzvle@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
 Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Wei Gao <wegao@suse.com>
References: <20260424060543.462475-1-pvorel@suse.cz>
 <aesL6YSphAi5vJbO@linux.dev> <20260424063132.GE462697@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424063132.GE462697@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_pidfd06: Update kernel version
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

> > > --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> > > +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> > > @@ -54,7 +54,7 @@ static void setup(void)
> > >  	if (!ioctl_pidfd_info_exit_supported())
> > >  		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
> 
> > > -	if (tst_kvercmp(7, 0, 0) >= 0)
> > > +	if (tst_kvercmp(6, 18, 14) >= 0)
> 
> > What will happen if this test is run on kernel range: v6.19.0 ~ v6.19.9?
> 
> FYI I haven't tested that, but it should fail on 6.18.0..v6.18.13 and on
> v6.19.0..v6.19.9 due missing backport.
> 
> I'd assume that's correct, because on stable/LTS we should IMHO be more strict
> to ensure it behaves as expected. WDYT?

Hmm, maybe that's acceptable. Or just:

  if ((tst_kvercmp(6, 18, 14) == 0 || 
       tst_kvercmp(6, 19, 10) == 0) ||
       tst_kvercmp(7, 0, 0) >= 0)

And it'd be great to have Jan's comments, he is an expert in
the kernel maintenance area:).

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
