Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <oliver.hartkopp@volkswagen.de>) id 1Ms9yb-00089z-2T
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 06:44:49 +0000
Received: from mxout1.volkswagen.de ([194.114.62.41])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.69) id 1Ms9yW-00078y-4d
	for ltp-list@lists.sourceforge.net; Mon, 28 Sep 2009 06:44:48 +0000
Message-ID: <4AC05866.1050909@volkswagen.de>
Date: Mon, 28 Sep 2009 08:32:06 +0200
From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
MIME-Version: 1.0
References: <1252847803.5357.35.camel@subratamodak.linux.ibm.com>
	<1254075368.10457.33.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1254075368.10457.33.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [Testing 2.6.31] CAN Network device driver and
	Netlinkinterface
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
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: ltp-list <ltp-list@lists.sf.net>, "David S. Miller" <davem@davemloft.net>


> On Sun, 2009-09-13 at 18:46 +0530, Subrata Modak wrote: 
>   
>> Hi Oliver,
>>
>> Good day. CAN has undergone lot of changes since you added the CAN tests
>> to LTP. Would you like to send us some changes in the CAN tests w.r.t
>> the changes it had in both 2.6.30 to 2.6.31 kernels:
>>
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=39549eef3587f1c1e8c65c88a2400d10fd30ea17,
>> http://git.kernel.org/linus/429da1cc841bc9f2e762fd7272fc2b80314b890a,
>>
>>     
>
>   

Hello Wolfgang,

the changes in 2.6.30 and 2.6.31 are mainly the netlink driver 
configuration interface (and some new drivers).

As we already described, the test of CAN hardware drivers within LTP is 
senseless - do you see any possibility to test the netlink configuration 
interface itself? Maybe some monkey tests or so?

I wonder if this could be done without a real CAN hardware ?!?

Regards,
Oliver


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
