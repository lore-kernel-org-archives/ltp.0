Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NRwRT-0006mo-O8
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 23:34:31 +0000
Received: from mail-yw0-f176.google.com ([209.85.211.176])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRwRO-0007cw-8X
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 23:34:31 +0000
Received: by ywh6 with SMTP id 6so15848988ywh.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 15:34:20 -0800 (PST)
References: <20100104004355.GA760@us.ibm.com>
	<51111C51-DD4E-44E6-B093-3B3FC0DEE8C5@gmail.com>
	<20100104153843.GA25671@us.ibm.com>
Message-Id: <F8523418-52E0-4EEE-BEF3-FE159EAF6D56@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100104153843.GA25671@us.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Mon, 4 Jan 2010 15:34:07 -0800
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Sent from my iPhone

On Jan 4, 2010, at 7:38 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Garrett Cooper (yanegomi@gmail.com):
>> Hi Serge,
>>    When do this script need to be run? Before compiling or before /
>> while running?
>> -Garrett
>
> Hi,
>
> Either could do, but there's reason to do it at both.  It doesn't  
> need to be
> run before each test, but has to load the module and set up devices  
> after each
> boot.  So I originally had it both in the makefile, as a condition  
> for doing
> the compilation (and especially installation), as well as before the  
> test, in
> case the system was rebooted after compilation and before running.
>
> -serge

Ok, that's why I yanked it. Here's what we should do then:

1. Take code required for compile and put it in an autoconf test.
2. Take code required for execution (loading modules, etc) and move it  
into a separate script.
3. Take all sourceable code and move it into a separate script that  
gets sourced in both places.

I'll add it back into the repo when I get back tomorrow, but we need  
to get a proper plan as far as how we are going to enable / disable  
features and tests that require interpreters, special system configs,  
etc.

Thanks!
-Garrett

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
