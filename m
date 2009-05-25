Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M8cp9-00042Q-ED
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:14:51 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8cp4-0002YT-HL
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 16:14:51 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OF0C37E154.CA4A0A35-ON652575C1.00256153-652575C1.0025D2AB@in.ibm.com>
References: <OF0C37E154.CA4A0A35-ON652575C1.00256153-652575C1.0025D2AB@in.ibm.com>
Date: Mon, 25 May 2009 21:44:35 +0530
Message-Id: <1243268077.6752.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP on System z: runltp segfaults on RHEL 4
Reply-To: subrata@linux.vnet.ibm.com
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
To: Srinivasan Subramanian3 <srinivass@in.ibm.com>
Cc: ltp-list@lists.sf.net

Can you also provide a little info on running pan through gdb ?

Regards--
Subrata

On Mon, 2009-05-25 at 12:20 +0530, Srinivasan Subramanian3 wrote: 
> Hello all,
> 
> When i ran the runltp script on a RHEL4.8 (64 bit machine) on System z, it
> seg faulted..
> 
> Running tests.......
> ./runltp: line 166: 20024 Segmentation fault      ${LTPROOT}/pan/ltp-pan
> $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f
> ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20090430
> 
> uname -r
> 2.6.9-89.EL
> 
> cat /etc/issue
> Red Hat Enterprise Linux AS release 4 (Nahant Update 8)
> 
> Thanks in advance &
> ---------------------------------
> Best Regards,
> Srinivasan S,
> Linux on System z, LTC
> srinivass@in.ibm.com
> srinivass@linux.vnet.ibm.com
> ----------------------------------
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
