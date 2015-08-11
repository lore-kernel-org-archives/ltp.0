Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZPAKS-0008SX-Sq
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 14:15:00 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZPAKQ-0000Lb-E4
	for ltp-list@lists.sourceforge.net; Tue, 11 Aug 2015 14:15:00 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C3E18AD4E
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Aug 2015 14:14:51 +0000 (UTC)
Date: Tue, 11 Aug 2015 16:14:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150811141432.GA21861@rei.suse.de>
References: <1439215460-15670-1-git-send-email-jack@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1439215460-15670-1-git-send-email-jack@suse.com>
Subject: Re: [LTP] [PATCH v2] inotify: Add test for inotify mark destruction
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
Pushed with following changes:

* Added GPL header at the start of the file

* Removed cleanup parameter from SAFE calls in child
  because if one of the calls in child fails the temporary
  directory would be deleted, then parent would attempt to
  remove the directory and that will fail horribly.

* Moved to body of the test to separate function to spare
  some indentation.

* Used tst_fork() instead of fork() (flushes userspace stdio buffers
  before fork, otherwise messages from test may end up duplicated
  several times)

* Used ltp_syscall() instead of syscall() which handles ENOSYS etc.

* Added inotify06 binary to gitignore.

And checked that it still Opses kernel after these changes, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
