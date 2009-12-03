Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NGDLR-0006YE-PC
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:11:49 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGDLK-0006wj-Gk
	for ltp-list@lists.sourceforge.net; Thu, 03 Dec 2009 15:11:49 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <653A85C7F32C4741880F71219266EA020315E35C98@EXGMBX01.sasken.com>
References: <653A85C7F32C4741880F71219266EA020315E35C98@EXGMBX01.sasken.com>
Date: Thu, 03 Dec 2009 20:41:18 +0530
Message-Id: <1259853078.5085.33.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Regarding LTP for Device drivers.
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
To: Sujatha Angadi <sujatha.angadi@sasken.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi,

On Mon, 2009-11-23 at 13:08 +0530, Sujatha Angadi wrote: 
> Hi Sir,
> This is Sujatha from Sasken Communications. 
> I need a small help.
> I am new to device driver testing and LTP . 
> I wanted to know where are the test cases for character devices like keypad, mouse on on LTP source code.
> If you are busy, please help me getting some pointer or links to know about the same.

Please look inside ltp-full-20091130/testcases/kernel/device-drivers/.

Regards--
Subrata

> 
> Sorry if I have bothered and wasted your precious time.
> Thanking you,
> Sujatha
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
> 


------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
