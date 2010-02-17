Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NhnQO-00084n-52
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:10:56 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NhnQM-00020O-Sz
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:10:56 +0000
Received: by pwi5 with SMTP id 5so1020129pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Feb 2010 09:10:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B7BA24F.2010705@linux.vnet.ibm.com>
References: <4B7BA24F.2010705@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2010 09:10:48 -0800
Message-ID: <364299f41002170910i336abf6eh72acbcbec9b72e7b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] sysctl03: sysctl returns EACCES after 2.6.33-rc1
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
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Wed, Feb 17, 2010 at 12:01 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
> Hi Shi,
>
> Thanks for your patch, still i am finding time to look into your patch.
> Will reply you soon.
>
> http://marc.info/?l=ltp-list&m=126502355614857&w=2

I looked at the patch finally.

Please use TTERRNO instead of strerror(...) for the reported value.
There's no reason why you should use strerror(...) there as that's
already done with tst_res(3).
Thanks,
-Garrett

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
