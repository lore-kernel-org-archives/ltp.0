Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1NSbKD-000866-Oi
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 19:13:45 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NSbK9-0007mu-Ml
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 19:13:45 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Wed, 6 Jan 2010 11:13:44 -0800
Message-ID: <8368651DACC1964480F951191B94A07801A20FA3@svexch01.mvista.com>
In-Reply-To: <BA3B15F55552CA46B604A1E50E9FEE7F032CFFD8@ba-exch3.ds.amrdec.army.mil>
References: <BA3B15F55552CA46B604A1E50E9FEE7F032CFFD8@ba-exch3.ds.amrdec.army.mil>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] Question about LTP (UNCLASSIFIED)
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
To: "Fowler, Michael (AMRDEC)" <michael.a.fowler@us.army.mil>, ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Fowler, Michael (AMRDEC) [mailto:michael.a.fowler@us.army.mil]
> Sent: Tuesday, January 05, 2010 12:48 PM
> To: ltp-list@lists.sourceforge.net
> Subject: [LTP] Question about LTP (UNCLASSIFIED)
> 
> Classification:  UNCLASSIFIED
> Caveats: NONE
> 
> Can LTP be applied to embedded real time Linux?
> 
> Thanks,
> -Mike
> 
> 
> --------------------------------------------
> Mike Fowler
> Computer engineer
> CompTIA A+ 2007 certified
> USARMY - AMRDEC
> Software Engineering Directorate
> Building 6264 - Room 2048
> (256)876-0434
> michael.a.fowler@us.army.mil
> --------------------------------------------

There are many individual test suites within LTP, but yes, most of it can be applied to an embedded real time linux system.
At the minimum, we've validated  the LTP file systems tests and all tests within the default test scenario on our own embedded linux offerings in real time and other modes  there has not been any major "real time" test problems.

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
