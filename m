Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C90C48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 16:19:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA7E23D086F
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 17:19:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A4263CD900
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 17:19:13 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A1600100158C
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 17:19:12 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2412A22244;
 Wed, 21 Feb 2024 16:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708532349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXc9QyCnsPD5tFa0O3qTlqxNVx8T4eELNEQM5aJdDus=;
 b=Q8ct2O2lKN1F1dl5EbqicGyGMIjbXuRCYeykyIBCsk51e9gCKYpxxfe9vvZlM2Fk6mgI9k
 a1uW4vd1dVR3ErnEvOMAMqO1oQB6yNbyUUynUTJTL4WKxr1rIwGnYOEkC1zwa4jRbKiraF
 FoPwMT0yTB5Qdmrh/7PK05etlzSZB9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708532349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXc9QyCnsPD5tFa0O3qTlqxNVx8T4eELNEQM5aJdDus=;
 b=rJAr5GFktQ6iuCKbOHbZ6l1wlt6ECOjxdQ7TqGAIzf/0ZjcxC65oZJQUgVWfaP/iwYr2jN
 3XFo3UBvgbcvYFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708532349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXc9QyCnsPD5tFa0O3qTlqxNVx8T4eELNEQM5aJdDus=;
 b=Q8ct2O2lKN1F1dl5EbqicGyGMIjbXuRCYeykyIBCsk51e9gCKYpxxfe9vvZlM2Fk6mgI9k
 a1uW4vd1dVR3ErnEvOMAMqO1oQB6yNbyUUynUTJTL4WKxr1rIwGnYOEkC1zwa4jRbKiraF
 FoPwMT0yTB5Qdmrh/7PK05etlzSZB9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708532349;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uXc9QyCnsPD5tFa0O3qTlqxNVx8T4eELNEQM5aJdDus=;
 b=rJAr5GFktQ6iuCKbOHbZ6l1wlt6ECOjxdQ7TqGAIzf/0ZjcxC65oZJQUgVWfaP/iwYr2jN
 3XFo3UBvgbcvYFBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E6243139D1;
 Wed, 21 Feb 2024 16:19:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id dFCCNXwi1mWAZAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 21 Feb 2024 16:19:08 +0000
Date: Wed, 21 Feb 2024 17:19:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
 Martin Doucha <martin.doucha@suse.com>
Message-ID: <20240221161907.GA1266903@pevik>
References: <20231204002623.17302-1-wegao@suse.com>
 <20240219134845.22171-1-wegao@suse.com>
 <20240220091837.GA1088847@pevik> <ZdW1UDq17nHx0eE2@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdW1UDq17nHx0eE2@wegao>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test.c: Set system default umaks to 0022
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

> On Tue, Feb 20, 2024 at 10:18:37AM +0100, Petr Vorel wrote:
> > Hi Wei,

> > >  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");

> > > +	umask(0022);

> > I don't think this is a good idea. Changing umask() in the library can influent
> > tests. Could you please instead add umask(0) (to reset umask) on the tests which
> > need it? The way it's done in open07.c.

First I thought that modifying umask (either with umask(0022) or just reset with
umask(0)) is not a good idea, but now I'm not sure:

1) We have quite a few tests, which will needs it:
NEW API tests:
$ git grep '^\s*umask(0' $(git grep -l tst_test.h) | wc -l
15

All tests:
$ git grep '^\s*umask(0' testcases/ | wc -l
34

And for sure some other, which will fail when too restrictive umask is set.

Wouldn't be better to have it in the library? Hopefully fewer tests would be
influenced this setup (and would need to set different umask()).

> cgroup_core01.c and statx07.c can use umask(0) in tests and i have updated the patch.

> But chdir01 will still failed on vfat and exfat. Like following error msg:
> chdir01.c:100: TFAIL: nobody: chdir("subdir") returned unexpected value -1: EACCES (13)

FYI test fails on vfat and ntfs when umask is 0077 (because override file and
directory permissions) (other filesystems are ok).

> The reason is umask(0) should set before mount /dev/loop0 to /tmp/xxx/mntpoint, otherwise you 
> have no chance modify permission of file. What's your suggestion?

> susetest:/tmp/LTP_chd5JtblL/mntpoint # mount | grep loop0
> /dev/loop0 on /tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> /dev/loop0 on /var/tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

2) tests, which set .mount_device = 1 and have more restrictive umask will not
work. Workaround would be to not use it and mount manually in the setup().
Or, reset umask with umask(0).

WDYT?

Kind regards,
Petr

> susetest:/tmp/LTP_chd5JtblL # chmod 777 mntpoint <<<< 
> susetest:/tmp/LTP_chd5JtblL # ll
> total 307216
> drwx------ 4 root root     16384 Dec 31  1969 mntpoint  <<<<<<<< group and other has no any permission even try chmod
> -rw------- 1 root root 314572800 Feb 19 04:51 test_dev.img

> susetest:/tmp/LTP_chd5JtblL/mntpoint # touch aa
> susetest:/tmp/LTP_chd5JtblL/mntpoint # ll
> total 16
> -rwx------ 1 root root    0a
> drwx------ 2 root root 8192 Feb 19 04:50 keep_out
> drwx------ 2 root root 8192 Feb 19 04:50 subdir
> -rwx------ 1 root root    0 Feb 19 04:50 testfile <<<<<<

> Thanks.


> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
