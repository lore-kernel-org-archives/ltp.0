Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKnOj-0002V3-Jj
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 12:57:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKnOi-00040T-E6
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 12:57:21 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 847C8AC22
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2015 12:57:13 +0000 (UTC)
Date: Thu, 30 Jul 2015 14:57:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150730125703.GE18339@rei.suse.de>
References: <1438016307-28805-1-git-send-email-jack@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438016307-28805-1-git-send-email-jack@suse.com>
Subject: Re: [LTP] [PATCH] inotify: Add test for inotify mark destruction
	race
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Kara <jack@suse.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		pid = fork();
> +		if (pid == 0) {
> +			while (1) {
> +				for (i = 0; i < FILES; i++) {
> +					fd = SAFE_OPEN(cleanup, names[i],
> +						       O_CREAT | O_RDWR, 0600);
> +					SAFE_CLOSE(cleanup, fd);
> +				}
> +				for (i = 0; i < FILES; i++)
> +					SAFE_UNLINK(cleanup, names[i]);
> +			}
> +		} else if (pid == -1)
> +			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> +
> +		start = time(NULL);
> +		while (time(NULL) - start < DURATION) {

Using time() for measuring how long something has been executed is not a
good idea for several reasons. Can't we settle for large enough number
of iterations instead?

> +			inotify_fd = syscall(__NR_inotify_init1, O_NONBLOCK);
> +			if (inotify_fd < 0) {
> +				if (errno == ENOSYS) {
> +					tst_brkm(TCONF, cleanup,
> +					 	 "inotify is not configured in this "
> +						 "kernel.");
> +				} else {
> +					tst_brkm(TBROK | TERRNO, cleanup,
> +						 "inotify_init failed");
> +				}
> +			}

The rest looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
