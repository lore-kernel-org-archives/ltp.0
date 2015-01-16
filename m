Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YC1VW-0007lR-SF
	for ltp-list@lists.sourceforge.net; Fri, 16 Jan 2015 07:39:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YC1VV-0007Bo-AV
	for ltp-list@lists.sourceforge.net; Fri, 16 Jan 2015 07:39:50 +0000
Message-ID: <1421393931.3467.7.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 16 Jan 2015 15:38:51 +0800
In-Reply-To: <54B7D920.7050402@oracle.com>
References: <1419591532-15612-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<54B7D920.7050402@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] rlogin: Cleanup
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!

On Thu, 2015-01-15 at 18:13 +0300, Alexey Kodanev wrote:
> Hi!

> > -if [info exists env(LOOPCOUNT)] {
> > -   set LOOPCOUNT $env(LOOPCOUNT)
> > -} else {
> > -   set LOOPCOUNT 25
> > +	for ((count=0;count<${LOOPCOUNT};count++)) {
> > +		rlogin_test
> > +	}
> >   }
> >   
> 
> Why the return status of rlogin_test() not checked here, but only the 
> last one after do_test()? May be, we could write something like this: 
> 'rlogin_test || return 1'.
> 

'rlogin_test || return 1' looks better.

> 'for (())'  is a bash extension, you can do the same with for i in $(seq 
> 0 $LOOPCOUNT); do ... done.
> 

Oh, I got it.

And thank you very much. :)

Best regards,
Zeng


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
