Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mwenzel@novell.com>) id 1O4eLB-0001c2-RD
	for ltp-list@lists.sourceforge.net; Wed, 21 Apr 2010 18:08:01 +0000
Received: from sinclair.provo.novell.com ([137.65.248.137])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4eLA-0006rq-Mm
	for ltp-list@lists.sourceforge.net; Wed, 21 Apr 2010 18:08:01 +0000
Message-Id: <4BCEEA98020000E800062212@sinclair.provo.novell.com>
Date: Wed, 21 Apr 2010 12:07:52 -0600
From: "Murlin Wenzel" <mwenzel@novell.com>
References: <4B8558A6020000E80005EF62@sinclair.provo.novell.com>
	<364299f41002241708g1cd33c48k5f1e0e4553c02bec@mail.gmail.com>
	<20100225062615.GB3377@linux.vnet.ibm.com>
	<20100310121544.GB11404@linux.vnet.ibm.com>
	<4B98AE5B020000E80005FC3D@sinclair.provo.novell.com>
	<364299f41003122332u3c4f93a7td3c1f9db1a360bec@mail.gmail.com>
	<4B9B684F020000E80005FE67@sinclair.provo.novell.com>
	<364299f41003131356p3ac589b0mcc0ffe22d8e3ec18@mail.gmail.com>
	<20100331092225.GB5048@linux.vnet.ibm.com>
In-Reply-To: <20100331092225.GB5048@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: Re: [LTP] [patch] swapon03 cleanup v2
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

>>> On 3/31/2010 at 03:22 AM, in message
<20100331092225.GB5048@linux.vnet.ibm.com>, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote: 
> Hi Murlin,
> 
> Can you please look into this problem again ? It seems you had some 
> discussion
> with garret to reach to some conclusion about the reported failure.

I hope to grab a little time to look at this again.  The big problem is the fact that the MAX_SWAPFILES supported by a particular kernel is not an exported variable.  It's a compile time macro defined in a kernel header.  There is nothing to export.  That brings up a question about what constraints LTP should run under.  1.  Can I require kernel headers and the current .config file be present on the build or install system that is going to run LTP?  2.  Is there a common place to find the correct kernel headers and config file?  3.  How hard would it be to use something like autoconf or some other tool to setup the correct define during LTP build?

The only other option I see at this point is similar to what the current code does.  Start at a given number of swapfiles expected, then start trying to create more one at a time until an error is returned.  That's ugly since the starting point is always subject to change.

Murlin


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
