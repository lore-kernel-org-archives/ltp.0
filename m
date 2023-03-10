Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D2CC742A7
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 14:51:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D90BE3CD804
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 15:51:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CF743CA013
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 15:50:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD5DD1A01223
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 15:50:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7EFC220657;
 Fri, 10 Mar 2023 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678459854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dKBUY0F0l7pXmOfoJbVLaJH7PILbr+F9VNy1IzvxO0=;
 b=Ui3EiMeBFZNsVgItDo+b0UoCqXCuD4yza6LS3+Xt0Z/AqFJ1KUsA+h4LSFUae/u3BXrHYG
 jwwDIqJTJ7rFcmVzvzcWrwOb/Yo/npryj6msVySB+1ps3zNHeQqYn4Zw3oap90fqCJX9KL
 0kAuF9WFC6NsOb4HXGA5Asl3NY0FiKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678459854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dKBUY0F0l7pXmOfoJbVLaJH7PILbr+F9VNy1IzvxO0=;
 b=uf2FPtVcjILPNv7TKcLzInQD2nHP+Cfj5vYzFNRl4Cz1oVMMDz0bn+Umf8lVgIj2LrM35W
 62QFs+3Ziu9hWrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6386B13592;
 Fri, 10 Mar 2023 14:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HoukF85DC2RJbwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Mar 2023 14:50:54 +0000
Date: Fri, 10 Mar 2023 15:52:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZAtEIClci4QximeK@yuki>
References: <20230310140407.20137-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310140407.20137-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] madvise11.c:Check loadable module before rmmod
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
> +static int is_loadable_module(const char *modname)
> +{
> +	char command[MAX_BUF];
> +	char line[MAX_BUF];
> +	char *token;
> +
> +	sprintf(command, "lsmod | grep '^%s'", modname);
> +
> +	FILE *fp = popen(command, "r");
> +
> +	if (fp == NULL)
> +		tst_brk(TBROK, "Popen command %s failed", command);
> +
> +	if (fgets(line, MAX_BUF, fp) != NULL) {
> +		token = strtok(line, " \t\n");
> +		if (strcmp(token, modname) == 0) {
> +			pclose(fp);
> +			return 1;
> +		}
> +	}
> +
> +	pclose(fp);
> +	return 0;
> +}

The code already has if (!find_in_file("/proc/modules", HW_MODULE)), you
are reinventing the wheel.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
