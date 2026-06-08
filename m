Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB6CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:13:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411743E56C6
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 16:13:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C83C3C8679
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:13:13 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFAC110007B6
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 16:13:11 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so3095107f8f.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780927991; cv=none;
 d=google.com; s=arc-20240605;
 b=jLks/j/rjfXZ9WjqR/XkcENLfIpVcLf2tFyh+o5OzFB/5tg+1m0oZU8WxyUvpwbFx5
 KAwdKa7vQUTkOcbtzDPRsrfCr7SnsB7dV8qrDHEchySZSKvzV5GFhhLKJSERW5FNabLu
 JwHXLuXlQ35JpFzMayA8kbPrJna4nuRTh5y8Pgu/3abUNpzV3wtgmtVuh0iVeJVq0WvW
 eHnTQveDL82fTQoDja2VjvUcL0Nj+N5NWjHUY4ScSKA9n4Ci6lXyNfDd2NIueEXA9ORE
 E5NUhnEeFMeRNN5CPC9CzVp4OLWZTniKMt1ggTVDyP6PIRzDeJryzEfzDm8Ta49+4BFP
 ShVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=asu3zEliwHeScXpAbXlPOmJqDKfTyJhHx0iWc99DjGs=;
 fh=6BHTRZs0fq26Pu1/Vq2EC9nEfgkqMZLdRlTIOrnG7LY=;
 b=UV+t3bauSVr2RSLrEpg+u5pKIxL+4Go8Us8FwHbmSgeXZuYQxQeCr46SF7QBwkj1uC
 d5GjROuIYTF+nk3J1DFaERa3lGJZJWSCgzAfNz24fp1d5Sjo1sNyXk8+WGUabL6H5vOP
 lap8qxYuJkKKlzzMFsS1AKDkR4IUvfYK3ok52sVtCCT93GeF9vdR+A8cBR7D++xnplQU
 iXyoVrogeFH+nT6jh7z9ssgRV/6gBPgH1O+sXsYPcb0s6HGDnw3KbR6VH+sK5xtlBsID
 AMxFi/ih7kP7hraFQ82yCJT7KozHkjKHQbwwVtNwIYUTMjC4MTjqGxwv+mia06dosigL
 22HA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780927991; x=1781532791; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=asu3zEliwHeScXpAbXlPOmJqDKfTyJhHx0iWc99DjGs=;
 b=j13q3FU6hYCTRGhV7Ejnqj3mOAgRN4tViwBJtyLRJMtPHsVgwAhQC+qpGj4obw7ppK
 eON/pk5b/QNst9JIlXP0O3qZFCHn1ye4qUB+UcwpT/67fM1dHK9G5iBIoEI2a5d6XAkb
 2YeH09odvgqucrEuTo2pkAmAmLf5P5CVcSioSd70RKj0AzoxSJmm6fP0eWXW3JJiefV+
 z/jbK+5ucvGtUx33jK+pJUrza5hNd9Oc4AWES3hZSW6sXrHuTHHYKbqzDL416po2QW0T
 zoV5kh6rUbKY5wM5Guk/eUuBg0EzDmNeaV9cIAaS/gpEjGnoHicX7mCCe1dETkLzuQrr
 PDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780927991; x=1781532791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asu3zEliwHeScXpAbXlPOmJqDKfTyJhHx0iWc99DjGs=;
 b=Z/U4AVbOliudoSwNPT8NnAc4ipfnC29eL7GdIU8F06vNecuetqLg0qwEF+TqaFtGBy
 zaRuey4kr58TRXYl/xzWDFOTlamUYrDOJsm+M5C0Bx/A4wUSv8moHj6oKaBbQx84599I
 A8hbwgGQDYK/YBteRl41LHPhZitZJmXhs9ri4DSs+cEdmkp9ph3RGjhUHjQn4Zsi0VJ0
 1C9kjeguYeblpNqjOMMCbr3DQK8uX5979NjIiO+sBaroJvrJyjOMyFwOumNqLKDLsfmI
 2euJkBnXIZvLSKP4SGxUEJvsgUKrE6JxLcfhwN9HaXbmctfl4mz6a7XUmuu0CfDQywm5
 8ghQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2LLHvFT+BbT8TeyBQHm6zo0c0ltj2AyHAiKO7co+w4uCsZ+dEBPal2ZQmUxA+sHye1z8=@lists.linux.it
X-Gm-Message-State: AOJu0YxESkNWfbwtd9uPScdzHc6CxBfzOPhocJn7r0Qy8R4wVJ1WS7Tq
 yY4/B6mn7yqJvsdp6TXCzmKcallOoJHYD3vG3Rwodk0KIIaQOjeeNDfbEyGB8v8uVM0O5TqP+Mj
 cHMIo6QgJPUawQWB2gfvMFcdpsa3ZNpA=
X-Gm-Gg: Acq92OGROL57Bop5Uezn6aUj5VSNjJ+irPHoyOdbq/i2BCOfTe6wgLqewhv/IVVmC9I
 ZbV4zXQvTbr5XnXZ+Mf4QpW7hasRMWmMcTG+13ptkmJQ0sSyKHG/YGVOwP9ZbO7+LEEmBMLX2we
 QXFIm0lSlgaCGxLU/rK273qaX9mUQ3KY3Ta16ZZwB3pIKS7YAKAELMPX3L4lX1L2PfO6IBOSA7D
 2pFXB1TPQXieqfN1C1gLqHveu9fBMAUtW6ghOS/svOVqshz7otH+fdX4r2D5AJrtC9Ustc8g86T
 K9wAtdWbKJbx2rXUQD21+ZoWaWRyhrYNZlgUQJjDI/iA5Rn3UWo=
X-Received: by 2002:a05:600c:83c3:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-490c25a5970mr285907995e9.11.1780927991066; Mon, 08 Jun 2026
 07:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260507073417.64123-1-sachinp@linux.ibm.com>
 <51507e20-d908-4213-967e-df74bacd87fa@linux.ibm.com>
 <CAJCsO8fQOQfa08bN92zkbqhU_B0B0Ojx2xRm0+TA6jP6WSkZ5g@mail.gmail.com>
 <84984062-a7fb-4cb3-b036-510c6cf4ca25@linux.ibm.com>
In-Reply-To: <84984062-a7fb-4cb3-b036-510c6cf4ca25@linux.ibm.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon, 8 Jun 2026 16:12:58 +0200
X-Gm-Features: AVVi8Cf7XT2836W0XS6NTPdtB5BlICaBvaM09mYHHmlqwWWi-goC3S_4RgHJPDU
Message-ID: <CAJCsO8eP4395bv7vXLXQ=xn1-77dDBPGnutMiAmh7P-o41F=4A@mail.gmail.com>
To: Sachin Sant <sachinp@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 1/4] io_uring: Add io_uring04 test for vectored
 I/O operations
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

On Mon, 8 Jun 2026 at 13:27, Sachin Sant <sachinp@linux.ibm.com> wrote:

>
> Hi Sebastian
> > I see some fundamental problems here which admittedly started before this
> > series. I believe these need to be fixed before we apply more tests on
> top
> > of it.
> >
> > In io_uring_submit_sqe() and io_uring_submit_sqe_vec(), opcode is passed
> as
> > user_data:
> > io_uring_submit_sqe_internal(s, fd, opcode, (unsigned long)buf,
> >                               len, offset, opcode);
> >
> > user_data is supposed to be a unique per-request identifier for
> correlating
> > CQEs back to their SQEs. Using opcode there is meaningless as a tag.
> >
> > The existing tests happen to pass because io_uring_do_io_op() and
> > io_uring_do_vec_io_op() always submit exactly one SQE and immediately
> > block waiting for its CQE, so correlation is never actually needed.
> > However, any test with multiple in-flight SQEs of the same opcode would
> > pass;
> > the user_data check in io_uring_wait-cqe() would match regardless of
> which
> > CQE corresponds to which request.
> >
> > Please hold off on applying this series until the underlying issue is
> > fixed. I will send a patch to correct the user_data handling.
> You're right.
>
> In io_uring_submit_sqe() and io_uring_submit_sqe_vec(), we currently
> pass the
> opcode as user_data through io_uring_submit_sqe_internal().
> As you pointed out, that is not a meaningful per-request identifier and it
> breaks CQE-to-SQE correlation once there is more than one in-flight request
> with the same opcode.
>
> > I also think io_uring_do_io_op() and io_uring_do_vec_io_op() should not
> > tightly couple SQE submission with waiting for a CQE.
> > Keeping them as a single helper makes the tests effectively synchronous
> and
> > does not model real io_uring usage.
> > It would be cleaner to have separate helpers for submitting SQEs and
> > waiting/reaping CQEs, and let each test handle CQE validation and
> > result reporting in its own body.
> > Having basic smoke tests, sending single SQE and checking CQE makes sense
> > in LTP, but I doubt we shall have this as a helper.
>
> The existing helpers
> io_uring_do_io_op() and io_uring_do_vec_io_op() hide this because they
> submit a single SQE and immediately wait for a single CQE, so the tests
> are effectively synchronous. That makes the current code work for simple
> smoke coverage, but it is not a good base for adding more
> io_uring tests.
>
> I agree that we should fix this first before applying more tests on top.
>
> The right direction seems to be:
>
> - stop using opcode as user_data
> - make user_data a caller-provided per-request tag/context
> - separate SQE submission from CQE waiting/reaping
> - let each test validate CQEs and report results explicitly as needed
>
> I'll wait for your patch and rework the helpers/tests on top of that
> approach.
> > Thanks and let me know if I misunderstand something here. It's the first
> > time I look at this code really.
> > Sebastian
> >
>
> Nope, you are spot-on with the analysis. Let me know if I can help in
> any way.
>
>
I have the patches ready, so you could absolutely help with the review of
those.
I'm about to send them to the mailing list

Thanks,
Sebastian



> --
> Thanks
> - Sachin
>
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
