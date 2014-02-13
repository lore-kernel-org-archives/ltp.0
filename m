Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WDtAg-0003db-0x
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 10:05:30 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WDtAf-0001wv-8e
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 10:05:29 +0000
Message-ID: <52FC98EC.80406@oracle.com>
Date: Thu, 13 Feb 2014 14:05:32 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
	<5757763.zAWEHsmlGc@vapier>
In-Reply-To: <5757763.zAWEHsmlGc@vapier>
Subject: Re: [LTP] [PATCH 4/4] lib: add tst_res_r.c
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Hi!
On 02/13/2014 12:47 PM, Mike Frysinger wrote:
> On Tuesday, February 11, 2014 13:48:10 Alexey Kodanev wrote:
>> +static int get_tst_count()
> random note: never never never use () with functions.  always always always
> use (void).  i'm guessing you're not aware, but what you've written here may
> be called (warning free!) like so:
> 	get_tst_count(1, 2, 3);
>
> yes, even with -W -Wall -Wextra.  please stamp this horrible habit out of your
> code.
Thank you for explanation!
There is a trick to try g++ to compile the code, it will throw an error 
on that and stops compilation.

Best regards,
Alexey


------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
