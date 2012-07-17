Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1SqwTZ-0005CW-HP
	for ltp-list@lists.sourceforge.net; Tue, 17 Jul 2012 01:21:21 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SqwTX-00014G-VD
	for ltp-list@lists.sourceforge.net; Tue, 17 Jul 2012 01:21:21 +0000
Message-ID: <5004BE07.5070400@windriver.com>
Date: Tue, 17 Jul 2012 09:21:11 +0800
From: "Li, Jin" <Jin.Li@windriver.com>
MIME-Version: 1.0
References: <6F91E0FFDA542149961F7BDED2D2B94B568E0DED0D@EXGMBX01.sasken.com>
In-Reply-To: <6F91E0FFDA542149961F7BDED2D2B94B568E0DED0D@EXGMBX01.sasken.com>
Subject: Re: [LTP] Executing LTP one test at a time
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
To: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Rejish,

Just check the help command :

runltp -h

You will find that the command "runltp -s PATTERN" is what you want 
though it's not very perfect.

Hope this will help

Regards,

Jin




On 07/16/2012 09:05 PM, Rejish Rajagopala wrote:
> Hi,
>
> Please let me know is there way to execute single test using runltp script.
>
> That is, I know we can execute user defined test cases through the command "runltp -f pty" but  is there a way so that I can run ltp like "runltp pty01" that is the test case directly through runltp script.
>
>
> Regards,
> Rejish
>
> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
