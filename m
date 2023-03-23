Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4933EC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 09:27:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9FF23CCB5B
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 10:27:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CBA13C0277
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 10:26:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95A3F1400E58
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 10:26:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91A343421D;
 Thu, 23 Mar 2023 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679563617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7aREQdKBzv9VrwTXko/qNEojeF3L/EjXA4eUJq4XnA=;
 b=2TevTPvkTyzAb6Nym1NqNCVbh4AB7rLfF2CooaVW+1IeM6tXSKKNB4tGRBomqRe1iu0JSx
 bVQLAqKUD7X+7pRGP5LNB83N0dQ8j2KssQdBvlQYK3UBawfRZtKbIVVtMMIhZvnC/mfciK
 QY4x0X4pHX40ecbE4Kq6KW16mndMBQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679563617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b7aREQdKBzv9VrwTXko/qNEojeF3L/EjXA4eUJq4XnA=;
 b=X3kybKVxn/Ang0MNlBwYd2YfW79Xjqxrw6aNjWcXZQgvjxw/pOIWEUFsgp1O1EqF2nqjap
 zB3RIdoON6eQOBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6D5A613596;
 Thu, 23 Mar 2023 09:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kdgdGWEbHGRpRgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 09:26:57 +0000
Date: Thu, 23 Mar 2023 10:26:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230323092655.GF405493@pevik>
References: <20230226003526.8733-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230226003526.8733-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] clone3: Add clone3's clone_args cgroup
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Do you plan to use this somewhere? Otherwise I don't see the point to just
add it.

Kind regards,
Petr

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/lapi/sched.h | 3 +++
>  include/tst_clone.h  | 1 +
>  lib/tst_clone.c      | 1 +
>  3 files changed, 5 insertions(+)

> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 1065665d1..3ad16d136 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -54,6 +54,9 @@ struct clone_args {
>  	uint64_t __attribute__((aligned(8))) stack;
>  	uint64_t __attribute__((aligned(8))) stack_size;
>  	uint64_t __attribute__((aligned(8))) tls;
> +	uint64_t __attribute__((aligned(8))) set_tid;
> +	uint64_t __attribute__((aligned(8))) set_tid_size;
> +	uint64_t __attribute__((aligned(8))) cgroup;
>  };

>  static inline int clone3(struct clone_args *args, size_t size)
> diff --git a/include/tst_clone.h b/include/tst_clone.h
> index 9ffdc68d1..7b278dfa7 100644
> --- a/include/tst_clone.h
> +++ b/include/tst_clone.h
> @@ -11,6 +11,7 @@
>  struct tst_clone_args {
>  	uint64_t flags;
>  	uint64_t exit_signal;
> +	uint64_t cgroup;
>  };

>  /* clone3 with fallbacks to clone when possible. Be aware that it
> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index ecc84408c..2aa00beb1 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -15,6 +15,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>  	struct clone_args args = {
>  		.flags = tst_args->flags,
>  		.exit_signal = tst_args->exit_signal,
> +		.cgroup = tst_args->cgroup,
>  	};
>  	int flags;
>  	pid_t pid = -1;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
