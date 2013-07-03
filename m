Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UuKjO-0006Vz-Ea
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 10:56:14 +0000
Date: Wed, 3 Jul 2013 12:57:46 +0200
From: chrubis@suse.cz
Message-ID: <20130703105746.GB2906@rei>
References: <51D38B82.5060709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D38B82.5060709@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mount/mount05.c: new case to test MS_BIND of
 mount
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Create new test case for MS_BIND of mount.
> 
> Checking if file is visible from target mountpoint after bind mount.
> 
> +/**************************************************************************
> + *
> + *    EXECUTED BY	: root / superuser
> + *
> + *    DESCRIPTION
> + *	Test for feature MS_BIND of mount.
> + *	"Perform a bind mount, making a file or a directory subtree visible
> + *	 at another point within a file system."
> + *
> + *	Setup:
> + *	  Setup signal handling.
> + *	  Create a mount point.
> + *	  Pause for SIGUSR1 if option specified.
> + *
> + *	Test:
> + *	 Loop if the proper options are given.
> + *	  Execute system call
> + *	  Check return code, if system call failed (return=-1)
> + *		Log the errno and Issue a FAIL message.
> + *	  Otherwise, Issue a PASS message.
> + *
> + *	Cleanup:
> + *	  Delete the mount point.
> + *
> + *    RESTRICTIONS
> + *	test must run with the -D option

Now this part of the comment is not relevant anymore. Which is the
reason we should comment only information that is not easily seen from
the test itself.

If some options are required the test must print error when these are
not passed. Adding these to comments too only creates room for outdated
and misleading informations.

I would just keep the description here which nicely tells what the test
does in one sentence, the rest of the comment is mostly useless.

> + *	test doesn't support -c option to run it in parallel, as mount
> + *	syscall is not supposed to run in parallel.
> + *****************************************************************************/

The test code looks fine to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
