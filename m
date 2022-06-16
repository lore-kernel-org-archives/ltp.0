Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74591C43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 21:52:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD6A63C7C07
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 23:52:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38E633C62D5
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:52:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4ED08200D27
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:52:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E0B621CCA;
 Thu, 16 Jun 2022 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655416335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKJc15nlxzziUXIeBcEZZHO5Khos4QQ300vkOVXfeVI=;
 b=IYUZcqNyJQpsqKQcThG8uh4NzsCdRC5SSL9ZlEcmR8c4o2NF3NuAK02tksVLM99KTtHZAQ
 GD6eIQdkRsyqWtCbeVG+T00c1EJvYM1WPV2Qp2EGt9aZ/2VacwtI1FC0DAwbjhFDMQn5x7
 WgVhtyelPcnAmu5Cl8pbTG++7C7hmEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655416335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LKJc15nlxzziUXIeBcEZZHO5Khos4QQ300vkOVXfeVI=;
 b=cf6B5TC0orStiu25RZWarMfIhEQoruLI8QrYaOwRYM5WjFI9PmrgqbDgdPLDIcuATEbDYM
 ZOXaN4tFKtRDjVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F36851344E;
 Thu, 16 Jun 2022 21:52:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MT7NOQ6mq2IdQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 21:52:14 +0000
Date: Thu, 16 Jun 2022 23:52:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YqumDWnqP35qT0t0@pevik>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
 <20220616140717.23708-2-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616140717.23708-2-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add more safe macros for mqueue API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Added SAFE_MQ_UNLINK and SAFE_MQ_CLOSE in tst_safe_posix_ipc.h

LGTM, few minor notes below.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> +++ b/include/tst_safe_posix_ipc.h
> @@ -11,6 +11,10 @@

>  #define SAFE_MQ_OPEN(pathname, oflags, ...) \
>  	safe_mq_open(__FILE__, __LINE__, (pathname), (oflags), ##__VA_ARGS__)
I'd add blank line here (readability)

> +#define SAFE_MQ_CLOSE(__mqdes) \
> +	safe_mq_close(__FILE__, __LINE__, (__mqdes))

and here.
> +#define SAFE_MQ_UNLINK(name) \
> +	safe_mq_unlink(__FILE__, __LINE__, (name))

>  static inline int safe_mq_open(const char *file, const int lineno,
>  			       const char *pathname, int oflags, ...)
> @@ -46,4 +50,34 @@ static inline int safe_mq_open(const char *file, const int lineno,
>  	return rval;
>  }

> +static inline int safe_mq_close(const char *file, const int lineno,
> +				mqd_t __mqdes)
> +{
> +	int rval;
> +
> +	rval = mq_close(__mqdes);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mq_close(%d) failed", __mqdes);
> +	}

How about check for invalid return value?

	} else if (rval < 0) {
		tst_brk_(file, lineno, TBROK | TERRNO,
			"Invalid mq_close(%d) return value %d", __mqdes, rval);
	}

> +
> +	return rval;
> +}
> +
> +static inline int safe_mq_unlink(const char *file, const int lineno,
> +				const char* name)
> +{
> +	int rval;
> +
> +	rval = mq_unlink(name);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mq_unlink(%s) failed", name);
> +	}
And here.


Kind regards,
Petr

> +
> +	return rval;
> +}
> +
>  #endif /* TST_SAFE_POSIX_IPC_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
