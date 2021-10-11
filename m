Return-Path: <SRS0=Ux39=O7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD6C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 08:50:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549AA60F24
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 08:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 549AA60F24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03BB33C0BA3
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 10:49:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CE313C0264
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 10:49:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B86B71401265
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 10:49:44 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 186402003C
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 08:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633942184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=41svvjr9xAyqbVe6llFcCHAZM510znAlws9ElpQOenk=;
 b=0bk8Y8s2Qy9g4GqZFdsjk270xD72/mF+HlwyXP7EhGrsTytf7q+Svjiu5JBefbaPM8jpWp
 1nTpybQ/BC3+Z7JV7hlBQkXVfkAgjNR896yI8rwT7CzPpF47hv/Q+h2Isad/G+zww3yU0Q
 9QGntJ3nie15oh2+UpQIeYHk3bqvvGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633942184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=41svvjr9xAyqbVe6llFcCHAZM510znAlws9ElpQOenk=;
 b=95IAMWL+QnRnuvtB+Iv6Yyv5FnQn/N0tdk0ll/F5YN/LMSGVE9Mzk1U1Ekq5BRXqw4xulF
 gAiVkoS22bI0i5AQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id DAC02A3B85;
 Mon, 11 Oct 2021 08:49:43 +0000 (UTC)
References: <20210924092111.20012-1-rpalethorpe@suse.com>
 <YWBSXzdO/gaq9lS6@yuki>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Oct 2021 09:46:47 +0100
In-reply-to: <YWBSXzdO/gaq9lS6@yuki>
Message-ID: <87sfx89c9k.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] msgrcv07: Check negative msg type filters
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> I guess that it would make more sense to add this to the msgrcv02.c as:
>
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> index cfb7d7446..b305d1f92 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> @@ -21,6 +21,8 @@
>   *   msgflg and no message of the requested type existed on the message queue.
>   */
>
> +#define _GNU_SOURCE
> +
>  #include <string.h>
>  #include <sys/wait.h>
>  #include <sys/msg.h>
> @@ -35,10 +37,12 @@ static int queue_id = -1;
>  static int bad_id = -1;
>  struct passwd *pw;
>
> +#define MSGTYP 2
> +
>  static struct buf {
>         long type;
>         char mtext[MSGSIZE];
> -} rcv_buf, snd_buf = {MSGTYPE, "hello"};
> +} rcv_buf, snd_buf = {MSGTYP, "hello"};
>
>  static struct tcase {
>         int *id;
> @@ -49,12 +53,14 @@ static struct tcase {
>         int exp_user;
>         int exp_err;
>  } tcases[] = {
> -       {&queue_id, &rcv_buf, 4, 1, 0, 0, E2BIG},
> -       {&queue_id, &rcv_buf, MSGSIZE, 1, 0, 1, EACCES},
> -       {&queue_id, NULL, MSGSIZE, 1, 0, 0, EFAULT},
> -       {&bad_id, &rcv_buf, MSGSIZE, 1, 0, 0, EINVAL},
> -       {&queue_id, &rcv_buf, -1, 1, 0, 0, EINVAL},
> -       {&queue_id, &rcv_buf, MSGSIZE, 2, IPC_NOWAIT, 0, ENOMSG},
> +       {&queue_id, &rcv_buf, 4, MSGTYP, 0, 0, E2BIG},
> +       {&queue_id, &rcv_buf, MSGSIZE, MSGTYP, 0, 1, EACCES},
> +       {&queue_id, NULL, MSGSIZE, MSGTYP, 0, 0, EFAULT},
> +       {&bad_id, &rcv_buf, MSGSIZE, MSGTYP, 0, 0, EINVAL},
> +       {&queue_id, &rcv_buf, -1, MSGTYP, 0, 0, EINVAL},
> +       {&queue_id, &rcv_buf, MSGSIZE, MSGTYP+1, IPC_NOWAIT, 0, ENOMSG},
> +       {&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT, 0, ENOMSG},
> +       {&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT | MSG_EXCEPT, 0, ENOMSG},
>  };
>
>
> What do you think?

I don't know, the functionality in each test seems arbitrary. I would be
happy with either patch.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
