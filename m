Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2GWI-0003em-E6
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 10:12:34 +0000
Date: Tue, 9 Jun 2015 12:11:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609101129.GF24041@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-4-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-5-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20150609101009.GE24041@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150609101009.GE24041@rei.suse.de>
Subject: Re: [LTP] [RFC PATCH 5/5] acl_test01: Wait until the loop device is
 detached
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
> Hmm, we may want to add this into test.sh because otherwise we will need
> to carry this snippet of code in each testcase that works with loop
> devices.
> 
> Would calling umount without -d and detach_device() (from tst_device.c
> via apicmd) help here? (it seems to fix the very same problem, it this
> function does not work, it needs to be fixed anyway)

And we also have tst_umount() to cope with daemons that probe each newly
mounted fs, it would be a good idea to add it to apicmd and make use of
it as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
