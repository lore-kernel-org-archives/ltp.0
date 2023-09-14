Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346C1EDE9A1
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 10:37:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33F6B3CE6F7
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 12:37:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C3EC3CB222
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 12:37:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28973200925
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 12:37:38 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1608B21850;
 Thu, 14 Sep 2023 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694687858;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NRgjrYGmkY59tj7Cv2Cf74jHstl3bPUsvrK87M43cQ=;
 b=kSnc0AfUxhaY65jJsW2dN5rm8wlyMugrG/b1ByP/XAe/Oho3LS7PkkB6L10Ez5K74BihF1
 8XGbKsahGtn0vzMx7uU8TuJBSymsHHlu1gLfLvDJBp6ja5Moizp7CXbYPeXccuEkpOmy3V
 xtOQR0h7H0+eM6uESZtHLzlclOWqssM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694687858;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2NRgjrYGmkY59tj7Cv2Cf74jHstl3bPUsvrK87M43cQ=;
 b=iuq3pdcszS7uQ1U4E4/RlkgskhdiufhuUIj9K6IqA1Jh1oqZuOJG7QsI+7Cg3dkBjavsRE
 icn7D2u+KqJXG6Cw==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8BB612C142;
 Thu, 14 Sep 2023 10:37:37 +0000 (UTC)
References: <20230903111558.2603332-1-amir73il@gmail.com>
 <20230903111558.2603332-2-amir73il@gmail.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Sep 2023 11:32:39 +0100
Organization: Linux Private Site
In-reply-to: <20230903111558.2603332-2-amir73il@gmail.com>
Message-ID: <87il8dghw0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fanotify13: Test watching overlayfs upper fs
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Amir,

Amir Goldstein <amir73il@gmail.com> writes:

> Run a test variant with overlayfs (over all supported fs)
> when watching the upper fs.
>
> This is a regression test for kernel fix bc2473c90fca
> ("ovl: enable fsnotify events on underlying real files"),
> from kernel 6.5, which is not likely to be backported to older kernels.
>
> To avoid waiting for events that won't arrive when testing old kernels,
> require that kernel supports encoding fid with new flag AT_HADNLE_FID,
> also merged to 6.5 and not likely to be backported to older kernels.

Unfortunately Petr's not here at the moment.

I guess this first patch doesn't require 6.6? So it could be merged
independently without further considerations for what makes it into 6.6?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
