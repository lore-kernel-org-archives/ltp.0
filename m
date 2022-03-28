Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3924C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 14:51:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1D53C9AA2
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 16:51:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DA083C97F1
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 16:50:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B3BF860010F
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 16:50:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A87031F37C;
 Mon, 28 Mar 2022 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648479052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r31rnsZn2rVtnF+PluhjXEVRXanmhJkEL6ZUuKYjDoo=;
 b=rw2wl/MkBW/wyzhknlw26IcMdy6Dr6AqBgxs9KNsT8yuT04LXC0J6eTTfY5c+RAFvSgcqU
 7boc93LusBM0pKvNeg/DzSstXc/rdWB1ere/t4eBRaetHpU6GyHyS6DvqxxiWOLrT1Acl9
 sxRoCoOSC0jlR3Cuh/xcBQr18abXnVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648479052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r31rnsZn2rVtnF+PluhjXEVRXanmhJkEL6ZUuKYjDoo=;
 b=RI4QMRZP5j0SqVROe0+dggsDl1qGSRC/koLDBv5ZAVRGQeo2AdqWv2K9ebOz9XtG88jrvM
 gQ4o2jyJJqF4TOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88B0813215;
 Mon, 28 Mar 2022 14:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V3rqH0zLQWJ2OwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 28 Mar 2022 14:50:52 +0000
Date: Mon, 28 Mar 2022 16:53:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YkHL1zy02XSDL0C6@yuki>
References: <20220325184435.1206-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325184435.1206-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Retry safe_clone() on ENOSPC|EUSERS
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
> +	/* too fast creating namespaces => retrying */
> +	if (pid < 0 && (errno == ENOSPC || errno == EUSERS)) {
> +		tst_res_(file, lineno, TINFO | TERRNO, "%s() failed => retrying",
> +				 pid == -2 ? "clone" : "clone3");
> +		usleep(100000);
> +		pid = tst_clone(args);

Wouldn't it make sense to use the exponential backof macro we have in
tst_common.h?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
