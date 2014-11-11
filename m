Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xo7py-0003eR-5I
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 09:34:10 +0000
Date: Tue, 11 Nov 2014 10:33:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141111093331.GA28225@rei>
References: <1415639518-4906-1-git-send-email-jack@suse.cz>
	<1415673144.3244.11.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1415673144.3244.11.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH v2] syscalls/fanotify: Verify that inode ignore
 masks are properly reflected
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Jan Kara <jack@suse.cz>

Hi!
> > Verify that when inode has an ignore mask set, it is properly reflected
> > when notifying a mountpoint. The test verifies fix "fanotify: Fix notification
> > of groups with inode & mount marks" in the Linux kernel.

This tests looks like a regression test for a bug that hasn't been
fixed in the mainline kernel yet, have a look at:

http://permalink.gmane.org/gmane.linux.file-systems/89872
https://bugzilla.kernel.org/show_bug.cgi?id=87721

So I would expect testcase failures until the patch is backported to
stable and you get distribution kernel update.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
