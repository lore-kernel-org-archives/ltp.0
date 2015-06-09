Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2IH0-0000Qx-Kf
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 12:04:54 +0000
Date: Tue, 9 Jun 2015 14:03:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609120350.GA26692@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150609105431.GB24843@rei.suse.de> <5576D3E3.5020600@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5576D3E3.5020600@oracle.com>
Subject: Re: [LTP] [PATCH 2/5] acl_test01: Verify the exit code of the
 second test case
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > We should probably wrap the su into a script that makes sure that the
> > return value is compatible with LTP. Because it may set bogus test
> > return status if su reported anything else than 0 or 1.
> 
> Ehm, but -c "$0" will execute the same script which, in turn, will exit 
> using tst_exit.

Yep, but the su man page specifies return values:

128 + signal_nr - command terminated by signal
127 - command cannot be executed (this one is actually handled in test.sh)
126 - command not found
255 - su was asked to terminate and had to kill the program

And if none of the abowe happens it retuns the return value from the
script.

So if the script gets killed by signal of failed to executed (or cannot
be found in $PATH) the return value will be wrong.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
