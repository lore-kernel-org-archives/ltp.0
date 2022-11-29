Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB7DC4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 08:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7073CC5B2
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 09:29:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D52223C714A
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 09:29:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4F5CF20075C
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 09:29:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41FA221BCE;
 Tue, 29 Nov 2022 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669710569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRh9gDUkL6Ekt8GlEtiCzuj3Xm1y/LSuc1cpy9Gflvs=;
 b=zIle4htzoS0qBxYibn/Hsrd+2vnuWB0I9fcdJxFOdmKJn3AhLvO6YffIWcqsM6wuZMNZfZ
 9+wdrhm0HzkpWDg51B6v+Yb3sEQcORE85DQByT4qrgRfYEFPMU/7ULmX6U2U4ygICooKsF
 jLOBK4lVsnHeaBxOjFgPrwKCvTgInBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669710569;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRh9gDUkL6Ekt8GlEtiCzuj3Xm1y/LSuc1cpy9Gflvs=;
 b=nOTRNgBbut4LARHdWjEjmmGrcS4dqddY5IghXnqiMrA3B3GWbYjLC+6UPr5/Fd661Uvyoq
 zho+KKwHgXyq5ZBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12FD013AF6;
 Tue, 29 Nov 2022 08:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PThCA+nChWP1BAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 29 Nov 2022 08:29:29 +0000
Date: Tue, 29 Nov 2022 09:29:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
 ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y4XC5sBLL8z8gviA@pevik>
References: <20221128111833.98937-1-david@redhat.com> <Y4SiDZXCSqMafjIb@pevik>
 <7f71a2c3-a66b-b442-3785-3e251ce2f781@suse.cz>
 <abd991c4-e6eb-349e-807c-71e7283ee83e@redhat.com>
 <Y4UBAa9GS9SU/bVt@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4UBAa9GS9SU/bVt@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/3] userfaultfd: Fix and remove compile-time
 TCONF handling
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

> > On 28.11.22 13:29, Martin Doucha wrote:
> > > On 28. 11. 22 12:57, Petr Vorel wrote:
> > > > Hi David,

> > > > If I remember correctly the reason for runtime check was ppc64le
> > > > missing userfaultfd minor fault support which needs to be check in runtime,
> > > > right? [1]. At least this is how I understand Martin's suggestion [2] to replace
> > > > compile time check with lapi. I'd state this reason at first commit message as
> > > > it's not obvious.

> > > The reason for runtime check is that the presence of the header file
> > > does not guarantee that the kernel supports UFFD API. The reason for
> > > LAPI is that we only care about actual kernel support, not build-time
> > > header files.
Also hope that people compile LTP with relevant headers (including LTP distro
package), but of course it's better to cover the case when kernel headers are
missing or for different kernel version.

> Thx, agree. BTW I was thinking about compile time check #ifdef
> UFFD_FEATURE_MINOR_SHMEM, but that's the same as ifdef HAVE_LINUX_USERFAULTFD_H.

> > Right. Petr, do you still want a commit message state?

> I can just add to commit message of the first commit the reason Martin reported:
> ppc64le on kernel 5.14 does not seem to support userfaultfd minor fault.

In the end I merged without any change in commit message. You described the
reason (runtime check) enough in the second commit. I was wrongly looking at
fist commit, sorry for bothering you.

Thank you both!

Kind regards,
Petr

> (no need to resent new version).

> Kind regards,
> Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
