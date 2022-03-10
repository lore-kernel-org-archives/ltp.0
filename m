Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B0C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 20:49:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C813C3C8BCD
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 21:49:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33A53C0F41
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 21:49:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EDDEB601A75
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 21:49:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FEF221115;
 Thu, 10 Mar 2022 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646945341;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/HHj7WEkHGHwx3CzuQL9N9H/6r+YiORVZhZKCh174dk=;
 b=hNkO79UU04lwaKkZYUG5SjWqTfD09qMWSNSYjLmSdk3ZRgvPL9l7/0oAScu+m3GFuEkf6X
 NKyzKZjyN5OEL0KJacoVJP4YcgX+Rca4R4xebyRn8xqNUKJKOkvdCSVrpDhnRmVQFPvuI1
 ZEpGgTR8nv9ac5jGXzVp04Fo263VJWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646945341;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/HHj7WEkHGHwx3CzuQL9N9H/6r+YiORVZhZKCh174dk=;
 b=VylmMYmT8NWK7MtBGdHqkaPahO07pWbojlUP8mwhOk8RN0YR8q5v2F0HvP99qglVUSX6C4
 ShB3U3PIHb1DvNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A43FD13FA3;
 Thu, 10 Mar 2022 20:49:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dQg4IzxkKmJmdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Mar 2022 20:49:00 +0000
Date: Thu, 10 Mar 2022 21:48:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <YipkOjYIeY4NbQuh@pevik>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
 <Yhxu8elhUJakYJHH@pevik> <YiAqwHabM9qCUjAU@xzhouw.hosts>
 <YiDdRhIdh12/23HM@pevik>
 <20220308013853.yr5qhlkcdjy3a5d2@xzhouw.hosts.qa.psi.rdu2.redhat.com>
 <YiiDlHcCscQqPJBi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiiDlHcCscQqPJBi@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] kernel/fs/fsnotify-stress: fsnotify stress test
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

Hi,

...
> > +static struct tst_test test = {
> > +	.tcnt = 1,
> > +	.forks_child = 1,
> > +	.needs_root = 1,
> > +	.needs_tmpdir = 1,
> > +	.needs_cmds = 0,
> > +	.needs_cgroup_ver = 0,
> > +	.needs_cgroup_ctrls = 0,

> Please do not set anything to 0 here, that is the default value for any
> uninitialized variables. Unfortunatelly gcc is buggy and prints warnings
> for nearly all tst_test initializations in the LTP tree, there is an
> upstream gcc bug for that that haven't been worked on for quite some
> time now. But that is not a reason to work around compiler bugs here.

FYI
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84685
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82283

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
