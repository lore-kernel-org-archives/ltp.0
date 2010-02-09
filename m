Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nehgf-0003ym-M5
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 04:26:57 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nehge-00012n-1O
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 04:26:57 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id o194QldV005849
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 09:56:47 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o194QkqK1798262
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 09:56:47 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o194Qkqp028620
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Feb 2010 09:56:46 +0530
Message-ID: <4B70E405.2030202@linux.vnet.ibm.com>
Date: Tue, 09 Feb 2010 09:56:45 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <cc0b83a21002041616i7cf66f4apbfa1628c69d20dfe@mail.gmail.com>
	<27498190.post@talk.nabble.com>
In-Reply-To: <27498190.post@talk.nabble.com>
Subject: Re: [LTP] Got warning message "FATAL: Test suite not installed
 correctly INFO: as root user type 'make ;
 make install'" on ltp-full-20100131 while running ./runltp even i have
 installed correctly
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
To: shachin <er_sachin@rediffmail.com>
Cc: ltp-list@lists.sourceforge.net

On 02/08/2010 04:34 PM, shachin wrote:
> Hi shachin here,
> Even i am unable to use  ltp-full-20100131 build i also got warning message
> "FATAL: Test suite not installed correctly
> INFO: as root user type 'make ; make install'
> [root@mwg5 ltp-full-20100131]#'
> even i have installed it correctly.
>
> [root@mwg5 ltp-full-20100131]# uname -a
> Linux mwg5 2.6.27-19.mlos1-x86_64-smp #1 SMP Thu Jan 21 16:57:58 CET 2010
> x86_64 x86_64 x86_64 GNU/Linux
> [root@mwg5 ltp-full-20100131]# uname -r
> 2.6.27-19.mlos1-x86_64-smp
> [root@mwg5 ltp-full-20100131]#
>
> is anybody can help out on this?
>    

Hi Shachin,

Can you let us know if you are referring LTPROOT/INSTALL file and also 
please let us know about the following :

- Steps of build
- Environment on which you are building
- H/w
- OS
- autoconf version
- automake version.

Thanks
Rishi
> thanks
> shachin
>
>
>    


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
