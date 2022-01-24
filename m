Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B70C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 14:21:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64CD03C8D84
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:21:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263BD3C7E58
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:21:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB77F2009AB
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 15:21:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11F3C21993;
 Mon, 24 Jan 2022 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643034088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7ynQBtOKE9H4uDYKAzEUUHm9aWU7Kmq06htmQAwIhM=;
 b=zmDL745O4sE26TSFbvzFOrPAe+8r9g5rgE31ix7gTS0NZSOYHmPn9Kdf6P12IdqRZf0z0h
 5rXQvVt6Yxc55o+Vfz9ycsOHptvssOj3QEnmi/QqqCJkt6LMJhNnG5cFt0DlkTkZ6eS2md
 BIb8ewgFRQN4+rquWRXomKuL3FvjNRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643034088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7ynQBtOKE9H4uDYKAzEUUHm9aWU7Kmq06htmQAwIhM=;
 b=dsU2LxwOnngNO7fIEMTfiTQnYwoq3bGfXxQ57kiRJgqzfmQRgnDAIih2EW2RL7Y/yD4uU5
 0OjIzAU9WkbL4QBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E321513BA5;
 Mon, 24 Jan 2022 14:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 46JSNee17mGEcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Jan 2022 14:21:27 +0000
Date: Mon, 24 Jan 2022 15:21:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ye615gN0Yv1/WskD@pevik>
References: <20211220201814.31596-1-pvorel@suse.cz>
 <YcH7m45TKEWaDrG3@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcH7m45TKEWaDrG3@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sched_get_priority_max01: Add more policies
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

Hi Cyril,

> Hi!
> > diff --git a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> > index a1c54efd0e..0d01317033 100644
> > --- a/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> > +++ b/testcases/kernel/syscalls/sched_get_priority_max/sched_get_priority_max01.c
> > @@ -13,6 +13,8 @@
> >   * compare them with expected value.
> >   */

> > +#define _GNU_SOURCE

> I supposed that we need this for SCHED_DEADLINE right? What about
> alternative libc implementations, does they define SCHED_DEADLINE as
> well? Do we need a fallback?

Sorry for the delay (I did write a reply, but probably forget to sent).
musl and glibc support all of them, but uclibc-ng doesn't have SCHED_DEADLINE.
(and SCHED_RESET_ON_FORK). I'll send v2 with SCHED_DEADLINE fallback.

I guess SCHED_RESET_ON_FORK would deserve it's own test (man sched(7):
when set, children created by fork(2) do not inherit privileged scheduling
policies).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
