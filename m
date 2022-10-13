Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0209DC433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 14:17:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76CCF3CAEE9
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 16:17:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B71923C9590
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 16:17:33 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 115C31000F64
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 16:17:33 +0200 (CEST)
Received: by mail-vk1-xa29.google.com with SMTP id v81so867655vkv.5
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GvNoRqSiZQd7MMSMzBW0CNT6YK7tyo/wvKsUvymJeQI=;
 b=OnR/lh0GNdC8dujbFzRH5BECzxcl2JBxb6cqeyShwOnjzBu1gEVtuiamO0J4dbNVSX
 CNfQCVmWSf81rAFsql+ABH/PGZ+BSiYwVvIeV4KT1aC9WMOxd9XQXH4qIPRRZheQzQYy
 pj2xNJ48FsSnukj2XJiIB4kbkqdiwCSYFWxauNT/ZsBSJseTv7JJ6B2EbPtpt+AuXqKq
 7ZAtBIeAZdKJF1l1K8w/Sl7RPoy8ad/WKpdNOK2e0kmydtEJzMSD/Gog/X1+EQ1uq/aD
 4qLyXCMjIBi3jiW7kFI2UqtxROsjFCR24ayHxlQ5FHOLtqlkhX5rrv31Sfb34yEBOIl4
 gJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GvNoRqSiZQd7MMSMzBW0CNT6YK7tyo/wvKsUvymJeQI=;
 b=gt+fGeBX8pxrFaRBC4Ks6XauY+3EUrzu4jzJ2C+RAhMfuKkQUEBEekxYXmvKhKU4MQ
 NK0+HH/4hf32MrvXcuo32zDk5xehjTNR4Gihqiyo3TLpc+BXjPbiT8wRcs1WNc2fCvLp
 bUbUZzvSVf5hMjeqO7gHSH3DhtZGyjdfx09sw8SLyozecVCDJl5qgDx09lHMYNUBOubd
 M+V0WO7a0RUFD5h+j2UOXP+Hnk18PlCt5g/u5flG9jB5Z7jeKHjUw4wUM/0OEgtsdTs0
 jB9KXXEk1JoFKNLX+/1chN7j6rXKAls9Wz1Svskw/ZMxuMcro65W5Q7YGfTWjXUKtTC2
 /j1Q==
X-Gm-Message-State: ACrzQf2G5KCg4d38DY7RREW10M3ViZOLQvy92YI2xn5CouecMDMkkWLs
 uoidWxvROzn3qW2UIX8IZtRe44hnicRWkf/bxqCutA==
X-Google-Smtp-Source: AMsMyM7oapMVDKUjHdW88QV3LwdiG0Gj3fUVxCnj8lQXOsfJ0zXAvKxsBI7G+BxmbYAShLG8mPsqKeWr7AlWBNxN55s=
X-Received: by 2002:ac5:c806:0:b0:3af:2296:df5c with SMTP id
 y6-20020ac5c806000000b003af2296df5cmr166661vkl.8.1665670651803; Thu, 13 Oct
 2022 07:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221006184228.3281392-1-edliaw@google.com>
 <Y0RbGMRj8rDC2Eti@yuki>
 <CAG4es9XqHPZJ2Tu9pKy8cpGBy-6Bb=Ztgw5tS-BMroWDdUFW7w@mail.gmail.com>
 <Y0fXIt38+VlpDn6v@yuki>
In-Reply-To: <Y0fXIt38+VlpDn6v@yuki>
Date: Thu, 13 Oct 2022 10:17:05 -0400
Message-ID: <CAG4es9XAy2J3yUrcKNo+jagMObY45N5iNUnbAizDUHV3kRfTNw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/4] mmapstress01: refactor to ltp framework
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1920203055=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1920203055==
Content-Type: multipart/alternative; boundary="00000000000083d40905eaeb2b35"

--00000000000083d40905eaeb2b35
Content-Type: text/plain; charset="UTF-8"

>
> I do not think that this is a valid reason. What that paragraph is
> trying to tell is that you either have to avoid calling anything that
> modifies global state and may cause trouble or block signals in sections
> that do the same but in the normal program context. Either way that
> effectively makes sure that such code is never run concurently.
>
> For example calling malloc()/free() modifies locks and data structures
> in libc, it's not safe to be called from signal handler and can easily
> cause deadlocks and corruptions. Technically you can avoid that either
> by not calling malloc()/free() from a signal handler, or by disabling
> signal handlers before you call malloc()/free() or anything that may
> possibly call malloc()/free() in the rest of the program.
>
> In this case the signal handler is as simple as it gets, it only sets a
> global flag that is checked in the while () loop that reforks. And the
> only important thing we do there is the fork(). However fork() cannot be
> interrupted by a signal and return EINTR so it cannot even fail. It
> would probably made some sense if we wanted to setup different signal
> handlers in the child and avoid getting signals before we do so, but
> that's not the case here either.
>
> So either this is a leftover code that was there to protect something
> that has been removed long in the past, or copy&pasted code from a
> different test that acutally made use of that. At least I do not see any
> other reason to have it there.
>
> --
> Cyril Hrubis
> chrubis@suse.cz


Thanks for the explanation!  That makes sense.

Thanks,
Edward

--00000000000083d40905eaeb2b35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">I do not think that this is a valid reason. What that pa=
ragraph is<br>
trying to tell is that you either have to avoid calling anything that<br>
modifies global state and may cause trouble or block signals in sections<br=
>
that do the same but in the normal program context. Either way that<br>
effectively makes sure that such code is never run concurently.<br>
<br>
For example calling malloc()/free() modifies locks and data structures<br>
in libc, it&#39;s not safe to be called from signal handler and can easily<=
br>
cause deadlocks and corruptions. Technically you can avoid that either<br>
by not calling malloc()/free() from a signal handler, or by disabling<br>
signal handlers before you call malloc()/free() or anything that may<br>
possibly call malloc()/free() in the rest of the program.<br>
<br>
In this case the signal handler is as simple as it gets, it only sets a<br>
global flag that is checked in the while () loop that reforks. And the<br>
only important thing we do there is the fork(). However fork() cannot be<br=
>
interrupted by a signal and return EINTR so it cannot even fail. It<br>
would probably made some sense if we wanted to setup different signal<br>
handlers in the child and avoid getting signals before we do so, but<br>
that&#39;s not the case here either.<br>
<br>
So either this is a leftover code that was there to protect something<br>
that has been removed long in the past, or copy&amp;pasted code from a<br>
different test that acutally made use of that. At least I do not see any<br=
>
other reason to have it there.<br>
<br>
-- <br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a></b=
lockquote><div><br></div><div>Thanks for the explanation!=C2=A0 That makes =
sense.</div><div><br></div><div>Thanks,</div><div>Edward=C2=A0</div></div><=
/div>

--00000000000083d40905eaeb2b35--

--===============1920203055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1920203055==--
