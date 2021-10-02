Return-Path: <SRS0=v0/1=OW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37911C433F5
	for <ltp@archiver.kernel.org>; Sat,  2 Oct 2021 17:30:19 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599E661A7D
	for <ltp@archiver.kernel.org>; Sat,  2 Oct 2021 17:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 599E661A7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BE163C86FD
	for <ltp@archiver.kernel.org>; Sat,  2 Oct 2021 19:30:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F3A33C8151
 for <ltp@lists.linux.it>; Sat,  2 Oct 2021 19:30:07 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C616310009F3
 for <ltp@lists.linux.it>; Sat,  2 Oct 2021 19:30:06 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so21029588wra.8
 for <ltp@lists.linux.it>; Sat, 02 Oct 2021 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to;
 bh=QKUXF8d91HzUt75YqXb5uGVG7oX5kXqgwCjRJFOwo1E=;
 b=kyfAkTn0ZPSRm0Jm3muKsDb/WlVDEJrR94qU8QKMxwch2zYpRNdBcJP0UCQo5p87r+
 qKRLrILgw18BB3480aME2zLS68/uKC5IVouYtU3DcFmRfkoynFfavQ52oW73t1SCctu0
 Vr+FjcsX9wrQeKWThgSsXj+U64qs1u8WmmBDBhAbyaFLVbpVemWvAihwFc/eTwHH6Scg
 PBWxvhkj7hVH0OfohMhT63PRB2Ppy5LMD9Jq0f+Bwzx95lvchGiK0Mm1v5t4dnf1PA5u
 eH2vsqvVCYZl6pH9dghk8zjS1TPFSewNnQ1S2kh897jrk/AFxCK1SVfi2DZAgbnoLzYC
 37ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=QKUXF8d91HzUt75YqXb5uGVG7oX5kXqgwCjRJFOwo1E=;
 b=DaCcLfAuoTxQ71JBAE1zIyiOMEJNbe2lq8h5L8dwqvyWMUQq0YHx5C+T7NgsZDY+In
 JuUbh5bG6jdrXMNpk+CyqEDugEYxzpKU+AxIEmtUdYpo/zhpEo8+MVkf4nQhTwF6dqEk
 PJGqunK7divsV+/2rIa6WNxOIRvg/7Xd+CXmZG9VBy7jo/PlqQBgDsWp+nzg4t1xrnLf
 wpqmGa8xs2W+BNPQXLTVAlvJqdpISc8nz5A2ORTtctScLxnnhD4YYNHyiROjC7bTLYFk
 v2jGX9i0FydT6HgAjuZYStO0Jqhy9J0oAPbfjhBmQeflNXzcARDP//CoQPakhoNhg+nm
 Lhjg==
X-Gm-Message-State: AOAM533uNMIOI9DQWqudOfB7UC+bBQ1H+vyEMb/Zej6B9c05/axFOGWF
 5Z5HJis9o3JScHKhZK1M9uM=
X-Google-Smtp-Source: ABdhPJy1DKwRNqBlrrb0NbH6iTMVqGgdH8lX0vjpcnfI0u6waqyEoiSSpO8NS7WxmMRkd+OdptqAhA==
X-Received: by 2002:adf:a51e:: with SMTP id i30mr3405251wrb.206.1633195806314; 
 Sat, 02 Oct 2021 10:30:06 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id y8sm5829550wrr.21.2021.10.02.10.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Oct 2021 10:30:05 -0700 (PDT)
Date: Sat, 2 Oct 2021 19:30:03 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Sandeep Patil <sspatil@android.com>
Message-ID: <YViXG27dz6u9DS+q@pevik>
References: <linux-test-project/ltp/releases/50325863@github.com>
 <YVQf9xSxrXjobBM9@pevik>
 <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+nhYX2qvXjaxOBRmEJyqBr0B3JY053PiqMZ3MN-M8HdYvEnRA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Requested user & group [was: Re: [linux-test-project/ltp]
 Release 20210927 - LTP 20210927]
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: Sandeep Patil <sspatil@google.com>, ltp <ltp@lists.linux.it>,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sandeep,

> On Wed, Sep 29, 2021 at 1:12 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi,

> > from 20210927 LTP release:
> > > * Testcases were fixed not to expect certain users and groups to be
> > present on the system
> > >   - some tests were expecting bin, daemon and similar groups and users
> > to exist on the system
> > >   - now LTP depends only on user 'nobody' and group 'nogroup'

> > At least some tests (e.g. fchmod02.c, chmod07.c) require other groups
> > ('users',
> > fallback to 'daemon' which is on AOSP):
> > ltpgroup = SAFE_GETGRNAM_FALLBACK("users", "daemon");

> > @Sandeep: is 'nobody' on AOSP or do we still need SAFE_GETGRNAM_FALLBACK()?


> AID_NOBODY seems to be part of the AOSP already[1], so I think that might
> work.
> I dont have a way to test this immediately right now, so adding others who
> may be able
> to verify in CC.

Thanks for info, it'd be great to have anybody to test it before we drop it.

Kind regards,
Petr

> - ssp

> 1.
> https://cs.android.com/android/platform/superproject/+/master:system/core/libcutils/include/private/android_filesystem_config.h;l=183?q=AID_NOBODY




> > Kind regards,
> > Petr

> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
