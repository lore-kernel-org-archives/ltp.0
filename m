Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NLfIg-00034M-H8
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 16:03:30 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLfIZ-0007go-E3
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 16:03:30 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <2232D399F8A83941B65D6392638870D7030B4B7C73@EXGMBX01.sasken.com>
References: <2232D399F8A83941B65D6392638870D7030B4B7C73@EXGMBX01.sasken.com>
Date: Fri, 18 Dec 2009 21:32:59 +0530
Message-Id: <1261152179.8993.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Core Components of LTP
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
To: Swamy Tota <swamy.tota@sasken.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Tue, 2009-12-15 at 18:10 +0530, Swamy Tota wrote: 
> Hi,
>  
> Any pointer to the Core components of LTP and architecture of LTP.

Everything in LTP is CORE ;-) Perhaps you are looking for tests that run
by default in all archs. Please find them inside ltp/runltp script, and
then get the pointers.

Regards--
Subrata

>  
> Thanks in advance.
>  
> Regards
> Swamy Tota
> Senior Software Engineer -- SEMC,
> Sasken Communication Technologies Ltd
> Unit No 702,7th Floor
> Campus 3B, RMZ Millenia Business Park, 143
> Dr M G R Road, Kandanchavady
> Chennai 600 096
> Tel: +91  44 39818188
> Fax: +91 44 39818029
>  
> SASKEN BUSINESS DISCLAIMER
> -------------------------
> This message may contain confidential, proprietary or legally privileged information. In 
> case you are not the original intended Recipient of the message, you must not, directly or 
> indirectly, use, Disclose, distribute, print, or copy any part of this message and you are 
> requested to delete it and inform the sender. Any views expressed in this message are 
> those of the individual sender unless otherwise stated. Nothing contained in this message 
> shall be construed as an offer or acceptance of any offer by Sasken Communication 
> Technologies Limited ("Sasken") unless sent with that express intent and with due 
> authority of Sasken. Sasken has taken enough precautions to prevent the spread of 
> viruses. However the company accepts no liability for any damage caused by any virus 
> transmitted by this email
> ------------------------------------------------------------------------------
> Return on Information:
> Google Enterprise Search pays you back
> Get the facts.
> http://p.sf.net/sfu/google-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
