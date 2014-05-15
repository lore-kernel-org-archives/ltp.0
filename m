Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wkv8D-0002GP-7P
	for ltp-list@lists.sourceforge.net; Thu, 15 May 2014 12:51:29 +0000
Date: Thu, 15 May 2014 14:51:14 +0200
From: chrubis@suse.cz
Message-ID: <20140515125114.GB28445@rei.Home>
References: <1398850017-10751-1-git-send-email-shuang.qiu@oracle.com>
	<5360D024.4000408@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5360D024.4000408@oracle.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/fstatfs: Cleanup
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > From: Shuang Qiu <shuang.qiu@oracle.com>
> >
> > * Delete some useless comments
> >
> > * Make variables and functions static
> >
> > Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
> 
> Reviewed-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Acked by me as well.

We should remove the #ifdef __linux__ as well, we do not promise that
these tests will run on anything but linux.

(you should have just pushed this with you Reviewed-by allready :)
 can you please do that now?)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
