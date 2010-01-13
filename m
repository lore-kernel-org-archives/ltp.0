Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NV44X-0006iE-B8
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:45 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NV44V-0005fb-0i
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:19:45 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <OF3866A0F3.56716AD5-ON652576A5.00433E3D-652576A5.0044B59D@tcs.com>
References: <OF3866A0F3.56716AD5-ON652576A5.00433E3D-652576A5.0044B59D@tcs.com>
Date: Wed, 13 Jan 2010 19:49:24 +0530
Message-Id: <1263392364.5591.28.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Help Required - LTP
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
To: Anish Rawat <anish.rawat@tcs.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi Anish,

On Fri, 2010-01-08 at 18:01 +0530, Anish Rawat wrote:
> 
> hello Subrata, 
> 
> We are planning to use LTP to test our kernel.for our Target Board(ARM
> architecture) and trying to compile the LTP using our target board
> tool chain. 
> After untar of the ltp package 
>  During the configuration  i gave following  command - ./configure
> --build=i386-linux --host=arm-none-linux-gnueabi 
> a new directory is created in opt in the  ltp folder but the directory
> consist of only  bin include lib share folders
> 
> all other folders(which are created in the normal installation of LTP
> for host computer) are not created what should be done regarding
> that. 
> 
> Can you help me or refer me some documentation regarding the cross
> compilation & installation of LTP. 

Please go through the following documents inside LTP sources:

     1. ltp/README* 
     2. ltp/INSTALL

Regards--
Subrata

> 
> Regards
> Anish Rawat
> Mailto: anish.rawat@tcs.com
> Website: http://www.tcs.com
> ____________________________________________
> Experience certainty.        IT Services
>                        Business Solutions
>                        Outsourcing
> ____________________________________________ 
> =====-----=====-----=====
> Notice: The information contained in this e-mail
> message and/or attachments to it may contain 
> confidential or privileged information. If you are 
> not the intended recipient, any dissemination, use, 
> review, distribution, printing or copying of the 
> information contained in this e-mail message 
> and/or attachments to it are strictly prohibited. If 
> you have received this communication in error, 
> please notify us by reply e-mail or telephone and 
> immediately and permanently delete the message 
> and any attachments. Thank you
> 
> 


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
