Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DBAC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 19:25:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39CBB3C9284
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 20:25:37 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A2D3C08F2
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:25:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91575140054D
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:25:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7653C1F389;
 Wed, 22 Dec 2021 19:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640201125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZJiI8h3nIgHgQlJc7ESKhpw20IfSTvHPHiKupEgNtM=;
 b=RUvkEEsxCPVC4CW0Ona3dqgdSWvhDm/OnogV3pA9hYXoRKFgxlJHqooqmOiBieQtiu+UQ3
 sKFUTt8A3iyG1UeGOBUNnwH1LWXrSS5vNtnSn0UfXJqQ96cKiVTwybruFMjqpk8g2OmalV
 IjNgzq7ytvHS7hRzStDUG3IS/oMV1sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640201125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yZJiI8h3nIgHgQlJc7ESKhpw20IfSTvHPHiKupEgNtM=;
 b=9l8PUk4wBoXj1xfWJP41Fw6b1i4O1ahdUZEtWPSHsUBoKD6cw2SUd18E8419hDVMwuZzIB
 XZWrNeWB1Mw3NECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DEEA13D75;
 Wed, 22 Dec 2021 19:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6N8RFaV7w2EvXQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 22 Dec 2021 19:25:25 +0000
Date: Wed, 22 Dec 2021 20:26:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Brent Yardley <brent.yardley@gmail.com>
Message-ID: <YcN8AUDq7FyjpGgd@yuki>
References: <DFDF839E-90B4-4020-B78D-88FC174B6B6D@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFDF839E-90B4-4020-B78D-88FC174B6B6D@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Disktest Removed from LTP?
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
> I was just told that disktest, the tool that I wrote for testing disk
> subsystems, has been removed from the LTP. I was not asked about this
> and was surprised to see that it is considered not maintained. I know
> that I???ve not added anything new to it for many year, but I know
> that it is used as I get questions about it from time to time.
>
> Can I ask someone about this or can I be directed to someone to better
> understand why it is considered not used?

The removal has been discussed in this thread:

https://lists.linux.it/pipermail/ltp/2021-June/022960.html

It has been sitting unused in the source tree for years unused so we
decided to remove it. If it's still used somewhere it could be
ressurected and put somewhere on GitHub.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
