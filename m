Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2874EC6FD1D
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 08:53:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7B623CD241
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 09:53:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA4D23C0214
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:53:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DF2A1A00CB8
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 09:53:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D9EF339C9;
 Thu, 23 Mar 2023 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679561601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDVaOrfABh5KQFfaK20rKL+0FDyl14ZfoBpq1QCsBz8=;
 b=WDIaWmyMiVF7ncbj8XLQURP9Nby5/r6MglMUh1pn9iMwlPmPLuOzvzoXYbgj2HmuliLJAY
 1hoovjdiANN33dgo8EhgdlA0r9EC+mazfZcqrB6heT9okuRZaivpcmkQl6baJXHvjSKiwZ
 u+4a5KGouAIsBn/qzkz1h2ONhXbHcTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679561601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDVaOrfABh5KQFfaK20rKL+0FDyl14ZfoBpq1QCsBz8=;
 b=Gg/GyBdrcwd+bHWuGBb6Ul2eYYTmJpkQhJO/wJn25loWaLWXnJ3grrBKNxNDh5b12GXGLB
 ojaGdhg3+cc1+OCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 720DA13596;
 Thu, 23 Mar 2023 08:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZOtsGYETHGQAMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 08:53:21 +0000
Date: Thu, 23 Mar 2023 09:53:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20230323085320.GD405493@pevik>
References: <20230320235108.2058967-1-edliaw@google.com>
 <20230320235108.2058967-4-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230320235108.2058967-4-edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] tst_find_backing_dev: Also check
 /dev/block/ for backing device
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

> On Android, the backing devices are created in /dev/block/ and will not
> be found using the method added in e1b1ae66b240 ("tst_find_backing_dev:
> Get dev name from /sys/dev/block/*/uevent").  Adds a check for
> /dev/block/%s as well as /dev/%s.

Fixes: e1b1ae66b240 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
