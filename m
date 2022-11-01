Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E40EFA3743
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:50:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BF313CAD42
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 12:50:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44F043CAC37
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:50:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6E6EA1000643
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 12:50:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 509F21F8D5;
 Tue,  1 Nov 2022 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667303430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKeTWz4PxQsQGCPKG4/H7BAG/MlJbI9ZTA6yaH3IzXU=;
 b=MsLpq/UluHXm5EZXWyhRWtX47BWkrwUbognrs0sv1iQRNWl6zqbI1XEA1WBIKUJPJm7NaE
 Mny/KdOU1+kpEsYmWA4l3+Ogi0iWztncjZtqJRVwv8xt1F+ItmbJ65DhtlPvyGzD8Nj2zX
 +Odd7DpXGlujJ6hsD6TfMayNwJu4Qbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667303430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKeTWz4PxQsQGCPKG4/H7BAG/MlJbI9ZTA6yaH3IzXU=;
 b=F8e685Xz7SyqRlYPWE8o3y0mm5c+4eQtcP9eAdvJlx1acvcSm9hyGE9ySZZEu5LQQuhnSN
 lBK+CHj7BDS5RnBg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E47962C141;
 Tue,  1 Nov 2022 11:50:29 +0000 (UTC)
References: <20220816113142.25638-1-andrea.cervesato@suse.com>
 <20220816113142.25638-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 11:48:25 +0000
Organization: Linux Private Site
In-reply-to: <20220816113142.25638-2-andrea.cervesato@suse.com>
Message-ID: <87v8ny99mi.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] Add more mqueue safe macros
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

Ah, I see you had two similar patches on the queue and merged the one
with less functions added.

Anyway, now merged this as well with inline added and trailing
whitespace removed.

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/tst_safe_posix_ipc.h | 73 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
> index b60c12c9e..78ce660b5 100644
> --- a/include/tst_safe_posix_ipc.h
> +++ b/include/tst_safe_posix_ipc.h
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 2017-2019 Petr Vorel pvorel@suse.cz
> + * Copyright (C) 2022 Andrea Cervesato andrea.cervesato@suse.com
>   */
>  
>  #ifndef TST_SAFE_POSIX_IPC_H__
> @@ -12,6 +13,18 @@
>  #define SAFE_MQ_OPEN(pathname, oflags, ...) \
>  	safe_mq_open(__FILE__, __LINE__, (pathname), (oflags), ##__VA_ARGS__)
>  
> +#define SAFE_MQ_NOTIFY(mqdes, sevp) \
> +	safe_mq_notify(__FILE__, __LINE__, (mqdes), (sevp))
> +
> +#define SAFE_MQ_SEND(mqdes, msg_ptr, msg_len, msg_prio) \
> +	safe_mq_send(__FILE__, __LINE__, (mqdes), (msg_ptr), (msg_len), (msg_prio))
> +
> +#define SAFE_MQ_CLOSE(mqdes) \
> +	safe_mq_close(__FILE__, __LINE__, (mqdes))
> +
> +#define SAFE_MQ_UNLINK(name) \
> +	safe_mq_unlink(__FILE__, __LINE__, (name))
> +
>  static inline int safe_mq_open(const char *file, const int lineno,
>  			       const char *pathname, int oflags, ...)
>  {
> @@ -46,4 +59,64 @@ static inline int safe_mq_open(const char *file, const int lineno,
>  	return rval;
>  }
>  
> +static int safe_mq_notify(const char *file, const int lineno,
> +			  mqd_t mqdes, const struct sigevent *sevp)
> +{
> +	int rval;
> +
> +	rval = mq_notify(mqdes, sevp);
> +
> +	if (rval == -1)
> +		tst_brk_(file, lineno, TBROK | TERRNO, "mq_notify() failed");
> +
> +	return rval;
> +}
> +
> +static int safe_mq_send(const char *file, const int lineno,
> +			mqd_t mqdes, const char *msg_ptr,
> +			size_t msg_len, unsigned int msg_prio)
> +{
> +	int rval;
> +
> +	rval = mq_send(mqdes, msg_ptr, msg_len, msg_prio);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO, 
> +			"mq_send(%d,%s,%lu,%d) failed", mqdes, msg_ptr,
> +			msg_len, msg_prio);
> +	}
> +
> +	return rval;
> +}
> +
> +static int safe_mq_close(const char *file, const int lineno,
> +			  mqd_t mqdes)
> +{
> +	int rval;
> +
> +	rval = mq_close(mqdes);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mq_close(%d) failed", mqdes);
> +	}
> +
> +	return rval;
> +}
> +
> +static int safe_mq_unlink(const char *file, const int lineno,
> +			  const char *name)
> +{
> +	int rval;
> +
> +	rval = mq_unlink(name);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mq_unlink(%s) failed", name);
> +	}
> +
> +	return rval;
> +}
> +
>  #endif /* TST_SAFE_POSIX_IPC_H__ */
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
