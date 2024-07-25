Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743C5C3DA49
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 12:55:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E06D83D1C9E
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 14:55:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0983D0FA8
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 14:55:25 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EB072001C6
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 14:55:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4F8421191;
 Thu, 25 Jul 2024 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721912124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPKoZQuCJnzWIUvl89TH60GdFjWVVbX4whA7xLx38Hk=;
 b=zBifvxJGDZ6zUWHtbGxRarqWnrmRBYIDuQU+pQJRdEnlHYnuvJfnEy0ITVrhBY8nt1jEzd
 Fxv/AVrYY0Oi6PgA2WWxSBlrFGLrkIsAjjdc4C6JD51i7Gz18K8HrN0HE+HrQmtewol566
 MULLacEk0kxp28sQ7jCWkbc30awitvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721912124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPKoZQuCJnzWIUvl89TH60GdFjWVVbX4whA7xLx38Hk=;
 b=Ym88sY1AGW+WLjTW0xXrvxvNgMzXTgd0cXSIl0DGTqR16AoBFbTP1Tx5ml/A7SGOsLX9qi
 HAqnibNlNDE/7sDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GEX1QTFt;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bU844LkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721912123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPKoZQuCJnzWIUvl89TH60GdFjWVVbX4whA7xLx38Hk=;
 b=GEX1QTFtLBKFxuHOEks9aHeQtJClBXjzARb4d6GMfIXVPblnrjVl2w04nmW09jb1czx4EB
 8OVsswUjsBurb652QxyWmsIcT3nmQ48YW9icL3Osdg9zDjjNzqcjpNlxvol2L5ZNkdruGM
 k8ZpaOgJNMESPC6wnfdNQQmWnjeJniM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721912123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPKoZQuCJnzWIUvl89TH60GdFjWVVbX4whA7xLx38Hk=;
 b=bU844LkG264UMBXPNIwjjnX8j0ozi4E6bXyN7ozzqf8Zcv9gbrVSzcd7JFYuw4ENzg/Z3V
 OaDru+1oS/jn3MCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C591213874;
 Thu, 25 Jul 2024 12:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QRJMLjtLombHdgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Jul 2024 12:55:23 +0000
Date: Thu, 25 Jul 2024 14:55:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240725125516.GA987417@pevik>
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com>
 <ZqErzC4PMRrrk929@yuki>
 <CAEemH2eaTSuyD3GT5QGwq7wDUe0eX79+-XpfnzhQqN8ztJ2Vog@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eaTSuyD3GT5QGwq7wDUe0eX79+-XpfnzhQqN8ztJ2Vog@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: E4F8421191
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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

Hi all,

...
> >  #include "config.h"
> > -#ifndef HAVE_MOUNT_SETATTR
> > -# ifdef HAVE_LINUX_FS_H
> > -#  include <linux/fs.h>
> > -# endif
> > +
> > +#ifdef HAVE_LINUX_FS_H
> > +# include <linux/fs.h>
> >  #endif

> >  #include <sys/user.h>


> > @Li do we still need that ifdef or can we get rid of it?


> Theoretically, we can remove it because that problem is addressed in
> Glibc-2.37 by:


> https://github.com/kraj/glibc/commit/774058d72942249f71d74e7f2b639f77184160a6

> It is essentially a glibc bug we don't need to fix that in LTP.

> We ever discussed in
> https://lists.linux.it/pipermail/ltp/2023-March/033138.html

> However, if we want LTP could be built with all the middle glibc versions
> (2.22 < glibc < 2.36)
> this might be thinking over. Because we announce support the minimal
> glibc-version is 2.22.

Hm, it makes sense to keep it. But nobody will remember once we raise the
support.

Also, removing HAVE_LINUX_FS_H [1] works in the CI [2], including distros with
glibc 2.36 (minimal build [3] or all cross-compile builds, e.g. [4]).

I wonder how realistic is that somebody is still affected by this issue.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/4bc155448559bc2ff75381c0e04662d585677bc4
[2] https://github.com/pevik/ltp/actions/runs/10093238273
[3] https://github.com/pevik/ltp/actions/runs/10093238273/job/27908521308
[4] https://github.com/pevik/ltp/actions/runs/10093238273/job/27908520925

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
