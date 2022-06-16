Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E72C43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 21:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F4F53C8796
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 23:57:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FFE23C021D
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:57:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9B871200D27
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 23:57:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF5E621CA6;
 Thu, 16 Jun 2022 21:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655416658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBSDwIsIyBkCg2uu3lP7OJhHTmh7uakbg+pGLeOy9cI=;
 b=uYX2Ede7YWK5V0r7OxNFrwXtdaq0q4vX5PBAqkIKja9WiVQho2fVJsUTW17NqlV/jfLLpz
 SQsYNzv4xBnRQen382IRtHuzAxwbUL/gaZwsujhLp/+o5zIy4VEcm6EC6nra6eVq/CpY4q
 cIGcLNrPhWVVSYASO6Rz/dTb937eXo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655416658;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBSDwIsIyBkCg2uu3lP7OJhHTmh7uakbg+pGLeOy9cI=;
 b=V9pTnFrIPeyNSmC9N1L1pys41K4graZsPPUstvZuZYH14W7aJ4WakJlrnuIvd21iIhnnHt
 QSPMR1TdRKyXOYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFC961344E;
 Thu, 16 Jun 2022 21:57:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GDwfMVKnq2LNQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jun 2022 21:57:38 +0000
Date: Thu, 16 Jun 2022 23:57:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
Message-ID: <YqunUfT847rSDkLY@pevik>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
 <20220616140717.23708-2-andrea.cervesato@suse.com>
 <YqumDWnqP35qT0t0@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqumDWnqP35qT0t0@pevik>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> > +static inline int safe_mq_close(const char *file, const int lineno,
> > +				mqd_t __mqdes)
> > +{
> > +	int rval;
> > +
> > +	rval = mq_close(__mqdes);
> > +
> > +	if (rval == -1) {
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"mq_close(%d) failed", __mqdes);
> > +	}

> How about check for invalid return value?

> 	} else if (rval < 0) {
> 		tst_brk_(file, lineno, TBROK | TERRNO,
> 			"Invalid mq_close(%d) return value %d", __mqdes, rval);
> 	}

Also safe_mq_open() could have check for invalid return value.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
