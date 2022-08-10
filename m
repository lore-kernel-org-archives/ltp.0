Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F022C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 11:53:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6420A3C95BD
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 13:53:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C8BF3C0135
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 13:52:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39B7B10005B9
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 13:52:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D78BB381D8;
 Wed, 10 Aug 2022 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660132369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xJ+q0CQAaBRK5xG2AQGH3QDdJPEOpVaVuPQ7WrmDYY0=;
 b=2tt4pfnLjwN9iqYxt6bPXpMN3hllPeMB0VHWIOepyu7l8BcjxdZ/ffRQ1NV0nOWa8Yh8FF
 NzkEvWWTZ0J4YTX8STHaNMA7Nqyf55it9kHrETxTqzSPLtHbnBIB9FKjEF4r0kLJJ9OSgF
 yQJFTdSPBkvE/mUHRCH9DcixCQQSwo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660132369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xJ+q0CQAaBRK5xG2AQGH3QDdJPEOpVaVuPQ7WrmDYY0=;
 b=E2ccVih3M0Bc3uIHHv4hnpnSYa79+7M3EZxAVPXNnaQ3qi2mWX2ILP3MBS2EtJM3GaF6S+
 z2PnYqqwx1EaQOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E83613AB3;
 Wed, 10 Aug 2022 11:52:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7T7tHhGc82KdZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 10 Aug 2022 11:52:49 +0000
Date: Wed, 10 Aug 2022 13:52:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Message-ID: <YvOcDymL98FOU1iZ@pevik>
References: <20220804073805.196537-1-zhaogongyi@huawei.com>
 <YvHwwsjr52lZXtVA@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvHwwsjr52lZXtVA@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpuhotplug*.sh: Check return value of
 online_cpu/offline_cpu
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

> Hi Zhao,

> > We need to check the return value of online_cpu() and offline_cpu()
> > although it is always success.

Thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
