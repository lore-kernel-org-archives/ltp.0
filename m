Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8D6EE6427
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 07:08:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 498243CB1C8
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 09:08:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E3D73CB0EE
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 09:07:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2283600A37
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 09:07:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B59CF218E4;
 Fri, 15 Sep 2023 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694761669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKUwVCA6+JW0BfsyDk8NpOHnPd77VoLX8rg8l4pWlCQ=;
 b=FzkdgfyY1S+VfYhkMSLoi7QsepiKR7cMRqaw6NYk2c3d5aaJsKvOCakwzHSJuzfUkkO9Jp
 tL0w1jXY/fJ4tf/gplrn0EXLv93fNocPswoqOSIdxMDSLFp7fp14m0R8Vfi5CnVTkl6inY
 paKFKe5kSjxiHz6Vlk7WS9afa3bdjog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694761669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKUwVCA6+JW0BfsyDk8NpOHnPd77VoLX8rg8l4pWlCQ=;
 b=K26jDLtSYMmEJ6pWo1dQmGjz8LNH5xa5d+pWqNA1lpogz9GHVJonWVoTDjNE7A3LAV0Qg4
 5iZq4LHwE5GY5RDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51F5013251;
 Fri, 15 Sep 2023 07:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nb+JEMUCBGWJGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 07:07:49 +0000
Date: Fri, 15 Sep 2023 09:07:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>,
 Li Wang <liwang@redhat.com>, Martin Doucha <martin.doucha@suse.com>
Message-ID: <20230915070747.GA19381@pevik>
References: <ZQF5J0UJ25_QLwcQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

Hi Cyril, all,

> Hi!
> As usuall we are supposed the release LTP at the end of the month. In
> order to get at least two weeks of pre-release testing I would like to
> freeze the git starting next week. I will try to review and merge as
> much as possible till the end of this week. If there is anything that
> you think should go into the release let me know so that I can have a
> look.

I'd like to merge first patch [1] of Amir's fanotify13 patchset (Richie noticed
it's not v6.5 related and I tested it correctly TCONF on older kernels). The
other two patches should be merged after v6.6 is released (they test v6.6
functionality).

I'd also like to get merged my patchset TST_SKIP_IN_{LOCKDOWN,SECUREBOOT}=1 for
shell [2]. It follows the same approach we chose for C  based tests.

I also want to have a closer look on ipneigh01.sh related fix [3].

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20230903111558.2603332-2-amir73il@gmail.com/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=366240&state=*
[3] https://patchwork.ozlabs.org/project/ltp/patch/20230815085706.1077725-1-xusenmiao@huawei.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
