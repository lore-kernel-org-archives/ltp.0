Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AF9C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:36:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90BA73C94FC
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:36:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A3A2E3C3129
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:36:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6093B1400E42
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655973381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/EuL0JATHkOLypw9nDmOV5IdTNkECdAdEZ3xhuWj9KE=;
 b=GmhPRT0/VVUFU7dwc4qaKbkDBGMoTMajUhdHfGzmHTddKDV7dP2ipZBzBmaiUiuBWUdquZ
 iJY+rb7/7/xCYtFr2BjTRf9VEmmRgNnlusBztsniq6BewBsmEXSakNFPqI6//fHhREJdxr
 6ju5Pj0WvJ6HH8tsTYySE9WO+mh/1QI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-gE7vWp7sNuWVi12QsnnRSA-1; Thu, 23 Jun 2022 04:36:20 -0400
X-MC-Unique: gE7vWp7sNuWVi12QsnnRSA-1
Received: by mail-lf1-f71.google.com with SMTP id
 e10-20020a19674a000000b0047f8d95f43cso2953625lfj.0
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 01:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/EuL0JATHkOLypw9nDmOV5IdTNkECdAdEZ3xhuWj9KE=;
 b=imwcYe6+qBqFSsSpMCw/DWhC38j+d0HGgvm0Hom7yAfdYJMmTgIeE9E4S6HkJSA0bw
 OkPGFDl+loIZgYupK5QSBiLTzmkWyCfX12a39rAevGAaPoYK7fITUdBgeYsaY/VT8POi
 ZE11fpPzKToFPhQmITTX+arkdwYHiO/sMv4/2AL65QLQOM+Rn50E0QZSW3dxlC8mLisp
 ZnUw7ST1DGEHaui9Wut6teYf34JrKX+q84/3Qe95lUyv6VOTmxciYmlt2EN9ZYg+gxGa
 /48nFTCR6gKBiok9Zg3uGkC4vunhzyrYT+I8vyugqcJu1PK09TTI4FUIXTh5ESw67UU0
 oeBQ==
X-Gm-Message-State: AJIora/XKVN8q6jtkcuEd+2G5zyjca0DkFJp/VQSRfF/MhpYcSW46Elu
 x95DJ6CWZgKI7I/yiye/qB82m6M9Iac4L6sv5YhgeQf7elvtmsdzkz6ES3NNO64w9qHoVyZgV7J
 1bHboiuTkFvAEmdPBidJWt7tc22M=
X-Received: by 2002:a05:651c:a0c:b0:255:94ce:40b8 with SMTP id
 k12-20020a05651c0a0c00b0025594ce40b8mr4041030ljq.22.1655973379263; 
 Thu, 23 Jun 2022 01:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1siLbG3Q2cN4VwFyKLOV6nDBdgkL6lzAKiTYji2C1+YpiT0sar0sriHVvJ/RNXfr1yIY6x30YTVKOmKRXfpP84=
X-Received: by 2002:a05:651c:a0c:b0:255:94ce:40b8 with SMTP id
 k12-20020a05651c0a0c00b0025594ce40b8mr4041025ljq.22.1655973379106; Thu, 23
 Jun 2022 01:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220620063456.528113-1-liwang@redhat.com>
 <CAASaF6xjARnhNAh7cU0pTE5vBfsA7wvvLAdosOmbrAEkHWY2-Q@mail.gmail.com>
 <CAEemH2fq453u0tPNU+0xYtzN+Sutd9XpMgtgBFgm81WPtw4fgg@mail.gmail.com>
In-Reply-To: <CAEemH2fq453u0tPNU+0xYtzN+Sutd9XpMgtgBFgm81WPtw4fgg@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 23 Jun 2022 10:36:02 +0200
Message-ID: <CAASaF6wBVzfPzOhP6CLUDfKXYArDp-iBnU95JFSSbCcgThZuDA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapping01: make use of remaining runtime in
 test looping
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

On Thu, Jun 23, 2022 at 10:34 AM Li Wang <liwang@redhat.com> wrote:
>
> Jan Stancek <jstancek@redhat.com> wrote:
>
>>
>> > Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
>> > Signed-off-by: Li Wang <liwang@redhat.com>
>>
>> Acked-by: Jan Stancek <jstancek@redhat.com>
>
>
> Thanks for reviewing Jan, but seems a bit late.
> I was pushing it together with your two patches a moment ago:).

No worries, thanks for pushing my 2 patches as well.

>
> https://github.com/linux-test-project/ltp/commit/3eb312e1f947782d8a48ff652429e2f81ce2fbca
>
>
> --
> Regards,
> Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
