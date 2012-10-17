Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOT1b-0006kk-Fh
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 12:47:03 +0000
Date: Wed, 17 Oct 2012 14:44:46 +0200
From: chrubis@suse.cz
Message-ID: <20121017124445.GA27890@rei>
References: <507CC6F5.3090409@cn.fujitsu.com>
	<82432993.665989.1350370438315.JavaMail.root@redhat.com>
	<20121016101101.GB9320@rei.Home>
	<E351E450E8B9F54684A699D42DC5ADF2263AF477@MPBAGVEX02.corp.mphasis.com>
	<E351E450E8B9F54684A699D42DC5ADF22640E162@MPBAGVEX02.corp.mphasis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E351E450E8B9F54684A699D42DC5ADF22640E162@MPBAGVEX02.corp.mphasis.com>
Subject: Re: [LTP] [PATCH] io_submit: uninitialized iocb may notreturn-EINVAL
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
To: Nitin Yadav <Nitin.Yadav@mphasis.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When the test fails, the return value from io_submit() is 1. This means
> that io_submit successfully submitted one I/O request block for
> processing.
> 	Could you please let me know is it correct behavior to
> successfully submit io request for uninitialized iocb with return value
> 1 (-EPERM).

As far as I understand io_submit() return value 1 is success i.e. 1 io
request queued. So I think that in your case the uninitialized structure
contains data valid enough for the operation to be actually queued.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
