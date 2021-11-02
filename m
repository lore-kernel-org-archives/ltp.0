Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1B7C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:03:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0D060C41
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF0D060C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0E2A3C71EC
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:03:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 476F93C0B90
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:03:01 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DCB01A01473
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:03:00 +0100 (CET)
Received: by mail-io1-xd35.google.com with SMTP id n11so11779364iod.9
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y4Ke7Gjt+oIvvdQmct080zVZJp81Fya1LSj3myHU8yY=;
 b=f6piTMk/r1wZxXd+udZggZgRtXjxg9+28o7NUQv2Vog0x7M2PF8m3OM543mrab2jlX
 DqPFzGlfxiEuSYvvX+TQm0vExKQimbO54wB/OZH7puzjp0fa95Z6UK0A0iPQZROMGaAX
 dCSKPOKNHgknqjaIe7jCXE8fgQom5Ij3c9TVcaZZPdgD44AAQCHtOOY0pr2TUFGGDGEK
 7I9YKsQJFWH7ujLARBZ/rqBOSJL9hi+HRqgptYPoT20mYsE28MVTBis+eYgNqUh5Wdqh
 ASAXs5FczPH3dTaVgd67qSjrO9a/OZiVQ+CnyTbEDP5U1CuYIMhY4O0m1jxJuMN89VIJ
 iqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y4Ke7Gjt+oIvvdQmct080zVZJp81Fya1LSj3myHU8yY=;
 b=RaRQMW4TCQj42u3/Sn7i84+45RIvz4kgbWCAcCxPhSOV/XqY/OLPnqP0EPE4QiG9s2
 ufmQmB7W/vAH7bmx6uyp3vvdDzl4KzK47GJwa2GGXrV4gMOx22qgiKyff6G0JkYz0hy2
 5UNOcuu1tt5tXEIJjvukXSiO+TAZUMDF7GgmuLDSPKC4wy9Ndb0XUM/nrlUg3qPqCN/w
 WTXLFyetuJ9Gq4Q0kD5vK4iq/7DU4tIYkR/k43EqAQggqksfd1zg57dv9kSLwJUfOLQ+
 C1M6oRfDLtzzAftpGUHdormIEf4zAHx1eC6Yl0kRF0F6KKiUJYeZC4yF10+igLlFE/Vi
 9d0g==
X-Gm-Message-State: AOAM531okH0JCZ0QuJG6pOLgHux0Py2L/zcz0Fn8wcFL0P7qvELSc508
 VCik5qbFT5i+0Ks6EB1ZmmHGeesLHWRJ8NofJr0=
X-Google-Smtp-Source: ABdhPJzCrprELeiIA0X6ipl2v4DNxON5QzOvtzN6ZOuilu9csaZ0kiBw0D/3Q5QSJQJeQBoq9fyUamQaft+YjK0sgB4=
X-Received: by 2002:a5d:8792:: with SMTP id f18mr24752728ion.52.1635850978920; 
 Tue, 02 Nov 2021 04:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1635849607.git.repnop@google.com>
 <b404edc9a25e9ec09fc975b1bac1947c5eb0408a.1635849607.git.repnop@google.com>
In-Reply-To: <b404edc9a25e9ec09fc975b1bac1947c5eb0408a.1635849607.git.repnop@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Nov 2021 13:02:48 +0200
Message-ID: <CAOQ4uxjhFNJkfKYuQdKpWtn4ZCMr3Er-mp+Jp0oekPTp2Xm1BQ@mail.gmail.com>
To: Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/fanotify20: add new test for
 FAN_REPORT_PIDFD
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 2, 2021 at 12:57 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> This test ensures that the fanotify API returns the expected error
> status code -EINVAL when an invalid flag is supplied alongside the new
> FAN_REPORT_PIDFD initialization flag. Currently, FAN_REPORT_TID is the
> only initialization flag that is not permitted in conjunction with
> FAN_REPORT_PIDFD, so we explicitly provide test coverage for this.
>
> We also add an extra trivial test case to ensure that the
> initialization behavior with the other FAN_REPORT_* related flags is
> working as intended.
>
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Changes since v1:
>  - Introduced a new macro
>    REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_BY_KERNEL() that is
>    responsible for testing whether the supplied initialization flags
>    are supported by the underlying kernel. This is used from
>    do_setup(). Using this is less ambiguous then using something like
>    REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS().

Not like this.
Please start your branch with the first two prep patches from
Gabriel's LTP post (including my reviewed-by tag) preserving
Gabriel's authorship and signed-of-by and adding your own
signed-off-by.

Your LTP tests are expected to be merged before Gabriel's test
because your tests are for a 5.15 feature.
Once your tests are merge, Gabriel would be able to rebase on master
and drop his prep patches.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
