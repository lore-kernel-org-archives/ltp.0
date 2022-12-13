Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C66C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 09:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2E613CBD9E
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:41:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05F723C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 10:40:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 54CC91A007AB
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 10:40:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9F0422CD4;
 Tue, 13 Dec 2022 09:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670924449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sys2SHqo5ozrEw7pkTaudTCfO34VviQDyagGBhR5Txg=;
 b=bpIrufHlAiM8+ebmWq/6bo9ULl8m9lOJK/RWkVZAdEqdv5zmCT9+EIhfqG5M9YNxEpl3lU
 6Aja81mbgGZgFQoSYkmbLvF/XjhSlhOLx3z+TmAmQyd+OUhSiB9Rho1Ae8yF3MddOPL7Ul
 uz/a/cH40fa90/Ugd/p/XVb+UWnCI9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670924449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sys2SHqo5ozrEw7pkTaudTCfO34VviQDyagGBhR5Txg=;
 b=SOMQoPA7fSUGTRJLq0H2MN7Z32tupZyfJq7wNgmzikrFbArKoNOSJRPaT8crhPiOT/fzGT
 7rLkzooJsVTZPrAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88C42138F9;
 Tue, 13 Dec 2022 09:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uwGAHaFImGPXSAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Dec 2022 09:40:49 +0000
Date: Tue, 13 Dec 2022 10:40:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Y5hIn5r39G5gnZWt@pevik>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y5dJDFk5DpAhTKDV@pevik>
 <CAASaF6wrx+0bkVa2_sSViOYHE25O08GbW_Jy2MQBfWKuJWtZkw@mail.gmail.com>
 <b4b93a47-d106-3a65-939d-230fee359f13@fujitsu.com>
 <CAASaF6wpj3YcJ1gX4g6n7koXL0WnX=9td5RqSjNumrCB+ncmhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wpj3YcJ1gX4g6n7koXL0WnX=9td5RqSjNumrCB+ncmhw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Dec 13, 2022 at 3:31 AM xuyang2018.jy@fujitsu.com
> <xuyang2018.jy@fujitsu.com> wrote:

> > Hi Jan, Petr

> > > On Mon, Dec 12, 2022 at 4:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> > >> Hi,

> > >>> Our travis-ci has dropped or never used them, they are useless.
> > >>> So delete.
> > >> They were here before CI. They were meant for using by tests
> > >> (no CI related at all).

> > > Right, it's not just CI. RHEL5 is EOL, presumably Oracle as well, so
> > > those likely won't be missed.
> > > RHEL6 has 2 more years - Isn't this removal going to break tst_kvercmp2()?

> > I have removed tst_kvercmp2 usage for RHEL6 in
> > testcases/kernel/syscalls/inotify/inotify04.c and
> > ../kernel/tracing/dynamic_debug/dynamic_debug01.sh, so it should not
> > break tst_kvercmp2.

> OK, you convinced me it's OK to drop it.


> > Also, the current lastest ltp can't ensure that can be compile
> > successfully on rhel6 because of lack of ci, so I think we don't need to
> > still maintain the old version check.  If people want to use old kernel
> > ie RHEL6, why not use the old ltp release?

> They can, but they also likely want fixes to tests. I know there have been
> some workarounds, such as using pre-configured LTP to workaround
> autotools issue.

BTW if anybody wishes (and have time) to run some sort of stable branch in LTP
tree, why not? Not sure how many people would be interested to be worth for that
person to invest time.

Kind regards,
Petr


> > ps: @Jan, if you want to keep RHEL6, I will keep it. But two more years,
> > we still need to drop it.

> You showed this isn't significant change for those few users that still might
> exist (and EOL is coming), so:

> Acked-by: Jan Stancek <jstancek@redhat.com>

Thanks Jan for review (suppose ack is just for this first patch).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
