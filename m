Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29C3C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:59:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 705A53CA10B
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 11:59:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C9223C0204
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:58:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 789541402E35
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 11:58:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F5801F37D;
 Fri, 18 Feb 2022 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645181933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FQvJFE7qJ2Pur2adqfZJnV3ylzJ63xsdXllrsxl/Cg=;
 b=a2oQ9dl0QlWw++/OpNbJZlleV5N1i3nGMk4wUXKiKiD5MhU4NaOxoi+08AGTcKbxNzZAp6
 W0Z0j2dPfyJ/Tfx5PmwzETl3aDwa+gYZ3O8NUoJHckhVUwMOemTzpSoiyqLFh36DHNW1YQ
 TsLGtaTu97abd9c9DyH+xo1oQd2X+4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645181933;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FQvJFE7qJ2Pur2adqfZJnV3ylzJ63xsdXllrsxl/Cg=;
 b=GmGdwjcNlSuLuXeW+GC0iXeWuaiCws/h3GAmr3hR72T+aFez97kb54cJba2ahydyD6o1dQ
 HiINxxt1MoG3ufCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2243C13C6E;
 Fri, 18 Feb 2022 10:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iFuhA+17D2KyGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 10:58:53 +0000
Date: Fri, 18 Feb 2022 11:58:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg976lg4tvxLdyTm@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yg6oZLaYz6Dj1FY4@pevik> <620F1768.7060100@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <620F1768.7060100@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> >> +	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open");
> > If you wait for Cyril's patch adding auto stringification
> > https://lore.kernel.org/ltp/20220217142730.19726-1-chrubis@suse.cz/

> > you can use just:
> > TST_EXP_FD_SILENT(pidfd_open(getpid(), 0));

> > and get more info.
> I will look Cyril's patch and wait.

FYI Cyril is not planning to merge that patch, replaced by
https://lore.kernel.org/ltp/20220218103413.18540-1-chrubis@suse.cz/

But I'd still drop "pidfd_open", because
pidfd_getfd02.c:55: TFAIL: pidfd_open(getpid(), -9) failed: EINVAL (22)
is better than:
pidfd_getfd02.c:55: TFAIL: pidfd_open failed: EINVAL (22)

But as fanotify21.c also needs SAFE_PIDFD_OPEN() (and more tests will come in
the future I'd vote for adding SAFE_PIDFD_OPEN() as you suggested.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
