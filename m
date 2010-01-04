Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NRp1O-0007Pv-Pm
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 15:39:06 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRp1N-0007mP-S0
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 15:39:06 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o04FXEk0023982
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 08:33:14 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o04Fcs2j155246
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 08:38:56 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o04FcfSU014813
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 08:38:42 -0700
Date: Mon, 4 Jan 2010 09:38:44 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100104153843.GA25671@us.ibm.com>
References: <20100104004355.GA760@us.ibm.com>
	<51111C51-DD4E-44E6-B093-3B3FC0DEE8C5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51111C51-DD4E-44E6-B093-3B3FC0DEE8C5@gmail.com>
Subject: Re: [LTP] [PATCH ltp] p9auth: add missing checkp9auth.sh script
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> Hi Serge,
>     When do this script need to be run? Before compiling or before /
> while running?
> -Garrett

Hi,

Either could do, but there's reason to do it at both.  It doesn't need to be
run before each test, but has to load the module and set up devices after each
boot.  So I originally had it both in the makefile, as a condition for doing
the compilation (and especially installation), as well as before the test, in
case the system was rebooted after compilation and before running.

-serge

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
