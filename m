Return-Path: <SRS0=jFKu=PB=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7053C433EF
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:06:22 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1B160F94
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 10:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F1B160F94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7951A3C1020
	for <ltp@archiver.kernel.org>; Wed, 13 Oct 2021 12:06:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EF863C0148
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 12:06:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ECE0F601E78
 for <ltp@lists.linux.it>; Wed, 13 Oct 2021 12:06:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B6AD22303;
 Wed, 13 Oct 2021 10:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634119570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVyc4M7do4EE70RWZEksD6F5Pz0gGjKX+YtoAPBE1qk=;
 b=mNgmeetfKp9qdDsht3uF3KbGn6Uz1f7y1eca7YFSlm9Q18WYxZxFAJJ0F0on+UPFZkPfWG
 G1YTyUJTOn2CCSgPDy5FvQEiF2L/aqpGj4NXwPkD3CdPoy+BzaIh4Sz1fCM4uzSa3patoC
 5jwgfEVpzpIt6gxFS5mi0uAWtXDpUtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634119570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dVyc4M7do4EE70RWZEksD6F5Pz0gGjKX+YtoAPBE1qk=;
 b=/rm5ZObyjqoAFEg1CHG08olWKBNehFTcwtsBDDuLPqzwDvz0SCBPoOvDF4CrmMEn/7mHCw
 wJTQo8oP39ohN8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 231BC13CEC;
 Wed, 13 Oct 2021 10:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O+ovCJKvZmEIQQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Oct 2021 10:06:10 +0000
Date: Wed, 13 Oct 2021 12:06:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YWavuzI2JrJXLDtO@yuki>
References: <20211012092858.29992-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012092858.29992-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] msgrcv02: Add negative msgtyp tests
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

Hi!
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> index cfb7d7446..fba6a5289 100644
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
> @@ -38,7 +40,7 @@ struct passwd *pw;
>  static struct buf {
>  	long type;
>  	char mtext[MSGSIZE];
> -} rcv_buf, snd_buf = {MSGTYPE, "hello"};
> +} rcv_buf, snd_buf = {2, "hello"};
>  
>  static struct tcase {
>  	int *id;
> @@ -49,12 +51,15 @@ static struct tcase {
>  	int exp_user;
>  	int exp_err;
>  } tcases[] = {
> -	{&queue_id, &rcv_buf, 4, 1, 0, 0, E2BIG},
> -	{&queue_id, &rcv_buf, MSGSIZE, 1, 0, 1, EACCES},
> -	{&queue_id, NULL, MSGSIZE, 1, 0, 0, EFAULT},
> -	{&bad_id, &rcv_buf, MSGSIZE, 1, 0, 0, EINVAL},
> -	{&queue_id, &rcv_buf, -1, 1, 0, 0, EINVAL},
> -	{&queue_id, &rcv_buf, MSGSIZE, 2, IPC_NOWAIT, 0, ENOMSG},
> +	{&queue_id, &rcv_buf, MSGSIZE - 1, 2, 0, 0, E2BIG},
> +	{&queue_id, &rcv_buf, MSGSIZE,     2, 0, 1, EACCES},
> +	{&queue_id, NULL,     MSGSIZE,     2, 0, 0, EFAULT},
> +	{&bad_id,   &rcv_buf, MSGSIZE,     2, 0, 0, EINVAL},
> +	{&queue_id, &rcv_buf, -1,          2, 0, 0, EINVAL},
> +

I wouldn't have added this empty line. The rest of the spaces that
aligns the fields looks good to me though, it's easier to read that way.

> +	{&queue_id, &rcv_buf, MSGSIZE,  3, IPC_NOWAIT,              0, ENOMSG},
> +	{&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT,              0, ENOMSG},
> +	{&queue_id, &rcv_buf, MSGSIZE, -1, IPC_NOWAIT | MSG_EXCEPT, 0, ENOMSG},
>  };

With the empty line removed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
