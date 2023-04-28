Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D333AC77B61
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 08:04:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C5AB3CBA73
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 10:04:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10B43C08CE
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 10:04:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5202920090A
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 10:04:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E6F121E70;
 Fri, 28 Apr 2023 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682669084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lIMLh5DqgzzMZfXwB4YQIfSV2uJEZl2AZA4InKCkhxU=;
 b=DNHe1U0fk14evyF93+KTtfS4awfJht7q3180YwoxFsnMHSY37d+YSxVzosV4YE6LIpKimP
 IHVOtG3NfPqtDzGdx/83KX1om5F7Bid+dg9x7KGqUxh/2Fq/AuNSAqjRF2xcKa8SGcowNg
 nELpN/VolGZxP6Fa8lztyAFGGjKxrI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682669084;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lIMLh5DqgzzMZfXwB4YQIfSV2uJEZl2AZA4InKCkhxU=;
 b=geqnjrEshRDpPTzqGCWM+I512UQ1TNIE2rWBpqDIislUCzhSVmC82LH4cmo2yNV8GBCfM4
 MYv102O195fo11Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69A611390E;
 Fri, 28 Apr 2023 08:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4dENGBx+S2SAaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 08:04:44 +0000
Date: Fri, 28 Apr 2023 10:04:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230428080454.GB3191151@pevik>
References: <20230422135337.12087-1-wegao@suse.com>
 <20230428001701.31670-1-wegao@suse.com>
 <20230428001701.31670-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230428001701.31670-2-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 1/2] kill01: New case cgroup kill
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

Hi Wei,

this commit should be second, after "tst_cgroup.c: Add a cgroup base
controller". Because it depends on it. With the current (wrong) order,
it compiles, but it fails in runtime:

$ ./cgroup_core03
tst_cgroup.c:803: TBROK: 'base' controller is unknown to LTP

We try to have each commit "working": 1) possible to compile
2) test actually working. This is needed when we try to search for error with
git bisect.

You can mention in "tst_cgroup.c: Add a cgroup base controller",
that it will be needed in the test added in following commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
