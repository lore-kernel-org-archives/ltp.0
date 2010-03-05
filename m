Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kiran.Girmaji@emerson.com>) id 1NnWT2-0006zL-Gf
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 12:17:20 +0000
Received: from usstlz-psecap04.emerson.com ([144.191.128.16]
	helo=USSTLZ-PSECAP05.EMERSON.COM)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NnWT1-00011f-Nc
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 12:17:20 +0000
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 5 Mar 2010 20:15:46 +0800
Message-ID: <89D32649C0790143AB985A5BF77A104F02F4E84F@etsmsg-hkexm05.etsmsg.org>
In-Reply-To: <20100305120810.GA12770@linux.vnet.ibm.com>
References: <89D32649C0790143AB985A5BF77A104F02F4E803@etsmsg-hkexm05.etsmsg.org>
	<20100305120810.GA12770@linux.vnet.ibm.com>
From: <Kiran.Girmaji@Emerson.com>
Subject: Re: [LTP] clock_getres01 test fails
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
To: risrajak@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net


Rishi,

Am running LTP on x86_64 target with montavista Linux on it.
I cross compiled LTP for this arch on my redhat EL5 host with
automake-1.9.6-2.1, autoconf213-2.13-12.1.

I'll probably try this latest git tree next week.

Regards.
Kiran 

-----Original Message-----
From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com] 
Sent: Friday, March 05, 2010 5:38 PM
To: Girmaji, Kiran Kumar [NETPWR/EMBCO/IN]
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] clock_getres01 test fails

Hi Kiran,

can you please let us know few things:

    - How did you installed ltp ?
    - What OS you have ?
    - What is the automake & autoconf version ?
    - Can you try latest git tree and let us know if prob still
persists.


--
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
