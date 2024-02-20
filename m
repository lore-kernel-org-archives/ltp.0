Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23957C48BC3
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 09:18:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8968C3CEFAE
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 10:18:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B22DD3CDB7F
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 10:18:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9FF9D1011BDE
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 10:18:40 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BD4A1FD7C;
 Tue, 20 Feb 2024 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708420719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWDhj2rfw6dfU0whPzyqB0JmsP5gIPbN7LViTNWz9Xs=;
 b=kNHTs482eToG3m4r+2zVnafx7fX0GkG8BVBMrs6XX54iUcWVXvacoakt1BvMuhySZRg5R9
 6lGIzZuyqdYeuHi+oPJk/6meS1oJtq5rJZwGQx8YAHC0azAz/xNT88ZptnkrYOerQG4aR+
 NNh6PlwXH2LfSV3q9zHPOjBj2P7XJBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708420719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWDhj2rfw6dfU0whPzyqB0JmsP5gIPbN7LViTNWz9Xs=;
 b=sUy4KI9BFWZKnheUao//zpXDhriWrAtEpud7jZFW5Ccc/GR4va4Gj+rzTPqXaI8leH39aL
 DS4UMY+uq4Zrz9BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708420719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWDhj2rfw6dfU0whPzyqB0JmsP5gIPbN7LViTNWz9Xs=;
 b=kNHTs482eToG3m4r+2zVnafx7fX0GkG8BVBMrs6XX54iUcWVXvacoakt1BvMuhySZRg5R9
 6lGIzZuyqdYeuHi+oPJk/6meS1oJtq5rJZwGQx8YAHC0azAz/xNT88ZptnkrYOerQG4aR+
 NNh6PlwXH2LfSV3q9zHPOjBj2P7XJBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708420719;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EWDhj2rfw6dfU0whPzyqB0JmsP5gIPbN7LViTNWz9Xs=;
 b=sUy4KI9BFWZKnheUao//zpXDhriWrAtEpud7jZFW5Ccc/GR4va4Gj+rzTPqXaI8leH39aL
 DS4UMY+uq4Zrz9BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 208D7139EF;
 Tue, 20 Feb 2024 09:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id tZDQBm9u1GUeZQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 20 Feb 2024 09:18:39 +0000
Date: Tue, 20 Feb 2024 10:18:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240220091837.GA1088847@pevik>
References: <20231204002623.17302-1-wegao@suse.com>
 <20240219134845.22171-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240219134845.22171-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
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

Hi Wei,

> Some system's default umask is 0077, this will trigger issues for LTP case.

> Example 1:
> cgroup_core01.c will report following error msg:
> cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)

> Detail reason:
> Code:
> cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
> cg_child_b = tst_cg_group_mk(tst_cg, "child_b");

> Result:
> wegao:/sys/fs/cgroup # ll ltp/test-25304/
> drwx------ 2 root root 0 Feb 10 10:37 child_a   <<<<<< group and other has no any permission
> drwx------ 2 root root 0 Feb 10 10:38 child_b

> Code:
> SAFE_CG_FCHOWN(cg_child_a, "cgroup.procs",  nobody_uid, -1);
> SAFE_CG_FCHOWN(cg_child_b, "cgroup.procs",  nobody_uid, -1);

> Result:
> wegao:/sys/fs/cgroup # ll ltp/test-26388/child_a/
> total 0
> -rw-r--r-- 1 nobody root 0 Feb 10 10:44 cgroup.procs  <<<<<<

> Code:
> SAFE_SETEUID(nobody_uid); <<<< after switch to nobody then can not access child_{a,b} or any file
> under child_{a,b}

> Result:
> nobody@wegao:/sys/fs/cgroup/ltp/test-26730> ll child_a/  <<< nobody has no permission on child_a
> ls: cannot open directory 'child_a/': Permission denied

> Code:
> loops = SAFE_CG_OPEN(cg_child_b, "cgroup.procs", O_RDWR, fds);
> Result:
> cgroup_core01.c:76: TBROK: openat(9</sys/fs/cgroup/ltp/test-26388/child_b>, 'cgroup.procs', 2, 0): EACCES (13)

> Example 2:
> chdir01
> chdir01.c:107: TFAIL: nobody: chdir("testfile") returned unexpected error: EACCES (13)

> Reason:
> susetest:/tmp/LTP_chd5JtblL/mntpoint # mount | grep loop0
> /dev/loop0 on /tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)
> /dev/loop0 on /var/tmp/LTP_chd5JtblL/mntpoint type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

> susetest:/tmp/LTP_chd5JtblL # ll
> total 307216
> drwx------ 4 root root     16384 Dec 31  1969 mntpoint <<<< nobody has no permission on mount directory
> -rw------- 1 root root 314572800 Feb 19 04:51 test_dev.img

> susetest:/tmp/LTP_chd5JtblL/mntpoint # ll
> total 16
> -rwx------ 1 root root    0 Feb 19 04:53 aa
> drwx------ 2 root root 8192 Feb 19 04:50 keep_out
> drwx------ 2 root root 8192 Feb 19 04:50 subdir
> -rwx------ 1 root root    0 Feb 19 04:50 testfile <<<< nobody has no permission on testfile

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_test.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index edb42f7f4..e03fd93e7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1174,6 +1174,8 @@ static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");

> +	umask(0022);

I don't think this is a good idea. Changing umask() in the library can influent
tests. Could you please instead add umask(0) (to reset umask) on the tests which
need it? The way it's done in open07.c.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
