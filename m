Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AF1C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 20:16:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20E263CA364
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 21:16:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BD233C9B7F
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 21:16:30 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A86C71001340
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 21:16:29 +0100 (CET)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-2d07ae0b1c0so31835127b3.2
 for <ltp@lists.linux.it>; Wed, 02 Mar 2022 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s67k1EJaVHxhbvHcAvfuqUxfoKCbqS5gFyMqywS2VG8=;
 b=XcytHnVbWT2BCtJIxUY3icFBZrzB/UM6egb4+8ldoQNwtxdhCmQtI0kuab6DQqU6qo
 gREp7w5CH5ciETcu04uh43n3wOUL0XtK/NgBnH5tLLMjYEm+WiN46gn7Fl3yGjipLbuQ
 PZ1W/MJEd/F0PAjXjZRmRjAMCrzJe+N+NRgaVUq/qG+zKn5R7aGFuTlKoebQrLjx/w9y
 PsXY3fEydh4c+QBEe37955ZDdEnyAmoBtwiXUwAHkChgyAqFm/TDdhko67VIx/mABpHA
 wqocT9Ek4mHW7K0k4CusZJO6d9qTP6cgnO878m0rfVkdc5gvMmkaFNTM4zQ2LQozzoVB
 E4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s67k1EJaVHxhbvHcAvfuqUxfoKCbqS5gFyMqywS2VG8=;
 b=WVECTNDZE0Lpc8EfXIg4Xo8zDLlBHt2hV0B0wIjijLKMZlFP/WO3AppboUxZLX48UL
 58hJ10LSgBxUhX0dFWH79HyiHLEgPM/aJjDOVajAtQ0nIlQsry/4n7E7uMDigqfqFx/m
 qEphPMHEefwqbY5gez59B8q4wCTh8G2CTlqOBhpy8gw5zAzary1LPinf9gAAGmKAZw7w
 wJXeWTRXdNKF7HuzlTkXvDyCEB9bzCy8/CSbis18pw0JCpRpHFQkYl5P0Nb0ud1/b+p6
 0Ek6Jtm7oCGyNvaYZN/O82hRnwMSFQbTT3iJi7r8QBY7mzG59v4gJ+XkTRwCi/J3wUYn
 IboQ==
X-Gm-Message-State: AOAM531yHxIrsU+sStg6br9961iem5BW90pnmsto4hL+yyvnnoSLuPLc
 DBzIdly8Jvnfurt3Q+hF14ov24W1X5tUP4h6KLILAw==
X-Google-Smtp-Source: ABdhPJzrH2if6CDf5wHK5EtuFMgfqu1uxju7OgWv0aks44zYH+1hcVNDxiRW4mKpFQe+z5VHbHFZvo9CV5G/1sjJr44=
X-Received: by 2002:a81:a552:0:b0:2dc:15ce:21e with SMTP id
 v18-20020a81a552000000b002dc15ce021emr3588744ywg.250.1646252188339; Wed, 02
 Mar 2022 12:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
In-Reply-To: <Yh+S7JD2q8oalRoM@yuki>
Date: Wed, 2 Mar 2022 15:16:17 -0500
Message-ID: <CAKoutNsWCE9wuXwBW544FFe5NDNdbRNOUyD335yEEaMQHbqqug@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
From: Yael Tzur via ltp <ltp@lists.linux.it>
Reply-To: Yael Tzur <yaelt@google.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 2, 2022 at 10:50 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> The test looks good to me now.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> Looking at the kernel counterpart it is still in the next tree. We
> usually wait until the kernel functionality is part of a kernel release
> in order to make sure that there are no changes done to the
> kernel-userspace API.
>
> I this case I guess that in this case the change is so minimal that we
> can add this test into LTP once it reaches Linus tree.
>
> --
> Cyril Hrubis
> chrubis@suse.cz

Sounds good. Thank you!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
