Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <prvs=220230f150=G.Rajender@lnties.com>)
	id 1Qqljx-000333-JX
	for ltp-list@lists.sourceforge.net; Tue, 09 Aug 2011 12:49:01 +0000
Received: from mailout2.ltindia.com ([125.18.18.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Qqljv-0003bi-Ek
	for ltp-list@lists.sourceforge.net; Tue, 09 Aug 2011 12:49:01 +0000
From: G Rajender <G.Rajender@lnties.com>
Date: Tue, 9 Aug 2011 12:48:44 +0000
Message-ID: <260174ADA4D63F4AA543B9C81F2DE71214C7EA@POCITMSEXMB02.LntUniverse.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] How to add new test case in LTP
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

HI,

Thank you very much for your reply.

I need to add new test cases in LTP to test my kernel running on beagleboard (arm cortex-a8 based dev. Board)

Can you please suggest me  how to add new sample test case in LTP (initially for my testing only).

Thanks in advance,

Regards,

Rajender

-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com]
Sent: Monday, August 08, 2011 9:59 PM
To: G Rajender
Cc: Maxin B John; ltp-list@lists.sourceforge.net
Subject: Re: [LTP] How to test Linux Kernel using LTP on Beagleboard (ARM Cortex-A8 based board)

On Mon, Aug 8, 2011 at 6:04 AM, G Rajender <G.Rajender@lnties.com> wrote:
> Hi,
>
> Thank you for your reply. I have successfully executed LTP test suite on beagleboard.
>
> I want to add a new test cases in LTP and if possible Camera Module related test cases in LTP.
>
> Can you please suggest how to add a new test case in LTP.
>
> Will LTP contains Camera Module related test cases? If Yes please tell me how many test case exists. If No please tell me how to search and add Camera module related test cases in LTP.

There are video4linux testcases IIRC, but no Camera module testcases.
If the testcase is generic enough where it can test out a specific subsystem and you plan on providing changes for the test driver, then yes I think that there is value in it being in LTP. Otherwise, it probably shouldn't be in LTP.

Cheers :)!
-Garrett


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
