Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C20C433F5
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 20:50:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1963C19DF
	for <ltp@archiver.kernel.org>; Thu, 24 Mar 2022 21:50:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27FC13C0358
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 21:50:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E12E200165
 for <ltp@lists.linux.it>; Thu, 24 Mar 2022 21:50:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D53961F38D;
 Thu, 24 Mar 2022 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648155040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGbhE6l49GeajLcxAoQSlrApT8wT+FB6S8n3VakMSFU=;
 b=cmWEqkbpnKeT65qKeabQkvIWQZJ69dRMX6NC13YxIlz5fRkGTdrRICicIOXkrdICYZ4SU7
 CK3xKIw36R/Pn7HuJQiraRrsELO8vHIUU83Rm06vjHf9VkfLE4iGIAyu/nmBoR+2EK3XRK
 Hm4hdI3Ay5YKXLadbt37ML4OrWz9+dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648155040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGbhE6l49GeajLcxAoQSlrApT8wT+FB6S8n3VakMSFU=;
 b=zqH2pwOobu/oHaQaOknCCeyLYwdtV6nKUIGkw8SgpFxTkx030s2LWOY3VH/0/ky+TJS2zR
 23ruL0Z9LrE4CPBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8CDF132E9;
 Thu, 24 Mar 2022 20:50:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2oe9JqDZPGJHHwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 24 Mar 2022 20:50:40 +0000
Date: Thu, 24 Mar 2022 21:50:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YjzZnkrugQyEuWLe@pevik>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315122351.8556-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] Rewrite userns01.c using new LTP API
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

...
> +static inline void updatemap(int cpid, bool type, int idnum, int parentmappid)
nit: This header should #include <stdbool.h>, not all tests (they use UID_MAP,
thus they don't need it).

Kind regards,
Petr

> +{
> +	char path[BUFSIZ];
> +	char content[BUFSIZ];
> +	int fd;
> +
> +	if (type == UID_MAP)
> +		sprintf(path, "/proc/%d/uid_map", cpid);
> +	else if (type == GID_MAP)
> +		sprintf(path, "/proc/%d/gid_map", cpid);
> +	else
> +		tst_brk(TBROK, "invalid type parameter");
> +
> +	sprintf(content, "%d %d 1", idnum, parentmappid);
> +
> +	fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +	SAFE_WRITE(1, fd, content, strlen(content));
> +	SAFE_CLOSE(fd);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
