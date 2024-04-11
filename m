Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E62C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 20:52:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 454473CF85E
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 22:52:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 316193C60FA
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 22:51:58 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7658C201199
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 22:51:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41A993797B;
 Thu, 11 Apr 2024 20:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712868716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3DhqOjlD8IlfEvlLH3sqGpYcT/CESlEgmuqk0w6KU4=;
 b=i7rOczRMthl5fR5n40kKUrMuo97v7psvC+9gsLJMcrDRg6Ap0tMxg2cl6eMV1yBRw/DOyy
 pR7NVgumOTQFsciFnhcdaa4/++h07cnBJzj6TO21elb0+J02dbZneIvbUgdu7LTxgOBFSI
 S/CSVkuZbfO4FD5A043DTd+ud8LZ+xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712868716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3DhqOjlD8IlfEvlLH3sqGpYcT/CESlEgmuqk0w6KU4=;
 b=OdtKosF0ZjHw9ulVq9+92joaLWolMkWTcWSo0vfEfA3FcklHcTUT0x75OPw/mqYvr32+0g
 uq+XAz5IH8wKuDAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712868716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3DhqOjlD8IlfEvlLH3sqGpYcT/CESlEgmuqk0w6KU4=;
 b=i7rOczRMthl5fR5n40kKUrMuo97v7psvC+9gsLJMcrDRg6Ap0tMxg2cl6eMV1yBRw/DOyy
 pR7NVgumOTQFsciFnhcdaa4/++h07cnBJzj6TO21elb0+J02dbZneIvbUgdu7LTxgOBFSI
 S/CSVkuZbfO4FD5A043DTd+ud8LZ+xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712868716;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3DhqOjlD8IlfEvlLH3sqGpYcT/CESlEgmuqk0w6KU4=;
 b=OdtKosF0ZjHw9ulVq9+92joaLWolMkWTcWSo0vfEfA3FcklHcTUT0x75OPw/mqYvr32+0g
 uq+XAz5IH8wKuDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C86161368B;
 Thu, 11 Apr 2024 20:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H1wpJmtNGGbxPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 20:51:55 +0000
Date: Thu, 11 Apr 2024 22:51:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240411205154.GB368229@pevik>
References: <20240411143025.352507-1-pvorel@suse.cz>
 <20240411143025.352507-15-pvorel@suse.cz> <ZhgDnR6A9oMjOr0w@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZhgDnR6A9oMjOr0w@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 14/31] madvise02: Remove UCLINUX
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
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/syscalls/madvise/madvise02.c | 25 ++++++++-----------
> >  1 file changed, 11 insertions(+), 14 deletions(-)

> > diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
> > index 90c0431c5..793bda98d 100644
> > --- a/testcases/kernel/syscalls/madvise/madvise02.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise02.c
> > @@ -65,17 +65,17 @@ static struct tcase {
> >  	int exp_errno;
> >  	int skip;
> >  } tcases[] = {
> > -	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL, 0},
> > -	{1212,             "MADV_NORMAL",      &file1,    EINVAL, 0},
> > -	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL, 0},
> > -	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL, 1},
> > -	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL, 0},
> > -	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL, 0},
> > -	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM, 0},
> > -	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM, 0},
> > -	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
> > -	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
> > -	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
> > +	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL},
> > +	{1212,             "MADV_NORMAL",      &file1,    EINVAL},
> > +	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL},
> > +	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL},
> > +	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL},
> > +	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL},
> > +	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM},
> > +	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM},
> > +	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF},
> > +	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL},
> > +	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL},
> >  	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared_anon", &shared_anon, EINVAL, 0},
> >  	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed", &file3, EINVAL, 0},

> You should have removed these two zeroes as well, it's a bit confusing
> that they stayed in there.

I wonder why I left these two. I'll amend the patch with the diff bellow.

Kind regards,
Petr

+++ testcases/kernel/syscalls/madvise/madvise02.c
@@ -76,8 +76,8 @@ static struct tcase {
 	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF},
 	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL},
 	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL},
-	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared_anon", &shared_anon, EINVAL, 0},
-	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed", &file3, EINVAL, 0},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared_anon", &shared_anon, EINVAL},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed", &file3, EINVAL},
 };
 
 static void tcases_filter(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
