Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE43C433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Dec 2021 11:48:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29943C8FCC
	for <ltp@archiver.kernel.org>; Wed, 29 Dec 2021 12:48:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06FA53C0CC6
 for <ltp@lists.linux.it>; Wed, 29 Dec 2021 12:47:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 574F510007CB
 for <ltp@lists.linux.it>; Wed, 29 Dec 2021 12:47:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C4B991F391;
 Wed, 29 Dec 2021 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640778477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdJMGikPXocLUVT1Uye1Xs7FvmcbyT1mydiE4OzV5g8=;
 b=UVPFy6zZGjs7F/6XABZNHuZo98XhRyFhBgBT2DWkRrP5zAR52Y6i5VO+Q9tqEXh5fn0CjU
 qDirXF5vU1Zvtr2hJBaoTnoyEy7UKPLbubPIaVnuPmFz/bnxMIv2qWGbILZ5JaB0moYHjD
 xJDXdB4uyD6KXKUB4xGK/r0q+Hy0EtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640778477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BdJMGikPXocLUVT1Uye1Xs7FvmcbyT1mydiE4OzV5g8=;
 b=klEHX6z4HI7hF2bZ64pDV+7nddkcVyaumC54Q5iSGXvSeFmK6L6R1PV6mkUixROlUvxdRf
 AxycSeT6UUlqiuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A877F13B96;
 Wed, 29 Dec 2021 11:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lW64KO1KzGFDIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 29 Dec 2021 11:47:57 +0000
Date: Wed, 29 Dec 2021 12:49:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Brent Yardley <brent.yardley@gmail.com>
Message-ID: <YcxLQ85d6vY4NWW1@yuki>
References: <YcN8AUDq7FyjpGgd@yuki>
 <3DCFDCA8-6622-4619-8C91-96E0C53AF677@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3DCFDCA8-6622-4619-8C91-96E0C53AF677@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
> Interesting. It is used quite a bit and it can be used on SSDs and
> SATA, SAS, as well as NVMe devices. It was never included in a run
> script as it can be data destructive.
>
> It is used a part of other projects and internal to a number of teams.
> I was just recently asked about the man page, and that is when It was
> found to no longer be in the LTP.
>
> So if it is no longer wanted in the LTP, are you saying that I should
> just post it as an independent project?

That would be the best solution. We can create a disktest repository
under the linux-test-project organization on GitHub and give you access
to that repo if you want to keep it under the LTP umbrela.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
