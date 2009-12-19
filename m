Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NLohE-0004Ql-S3
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:28 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLoh6-000541-JB
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 02:05:28 +0000
Date: Sat, 19 Dec 2009 03:05:50 +0100
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <200912041649.nB4GnQbj014719@e35.co.us.ibm.com>
	<1260186841.6866.20.camel@subratamodak.linux.ibm.com>
	<364299f40912071042o50d0ac40le913ac35b6003dda@mail.gmail.com>
Message-ID: <op.u45xf011u2flwt@debian>
In-Reply-To: <364299f40912071042o50d0ac40le913ac35b6003dda@mail.gmail.com>
Subject: Re: [LTP] [PATCH] New sigwaitinfo test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Mon, 07 Dec 2009 19:42:13 +0100, Garrett Cooper <yanegomi@gmail.com>  =

wrote:

> On Mon, Dec 7, 2009 at 3:54 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>> On Fri, 2009-12-04 at 17:46 +0100, Jiri Palecek wrote:
>>> Hello,
>>>
>>> this is the test for the rt_sigtimedwait et al. functions I promised  =

>>> earlier. The code is unchanged since I sent it for the first time, but  =

>>> the Makefiles are adapted to the new build system, with the help of  =

>>> Garret Cooper.
>>>
>>> Regards
>>> =A0 =A0 Jiri Palecek
>>>
>>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>>
>> Thanks Jiri. Would you also take the trouble to make entries in the
>> runtest/syscalls file for these tests to run ?
>
> Someone needs to verify whether or not the rt_* test is functional on
> x86_64 as well, because these tests require additional setup for
> x86_64; unfortunately my desktop is disconnected (and will remain so
> for the next week while I move), so I can't verify this.

Could you, please? IMHO there shouldn't be a problem with SA_RESTORER  =

(because the test doesn't use rt_sigaction), but there may be problems  =

with SIGSETSIZE.

   Jiri Palecek

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
