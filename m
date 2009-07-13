Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MQOq4-0002ZN-LT
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 16:57:16 +0000
Received: from wf-out-1314.google.com ([209.85.200.170])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQOpw-0005JD-O0
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2009 16:57:16 +0000
Received: by wf-out-1314.google.com with SMTP id 26so801237wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Jul 2009 09:57:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1247473352.26478.14.camel@subratamodak.linux.ibm.com>
References: <4A5AED18.2090201@cn.fujitsu.com>
	<1247473352.26478.14.camel@subratamodak.linux.ibm.com>
Date: Mon, 13 Jul 2009 09:57:07 -0700
Message-ID: <364299f40907130957i5bffc7acofe0be466ae22ce43@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix "make clean"'s failure in case cpuset
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Jul 13, 2009 at 1:22 AM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2009-07-13 at 16:15 +0800, Shi Weihua wrote:
>> In case cpuset, the file cpuset_syscall_test.o was not deleted after "ma=
ke clean".
>> The following patch fixed this problem.
>>
>> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
>
> Garret,
>
> If this is safe and does not interfere with your patches, please check
> this in.
>
> Regards--
> Subrata
>
>> ---
>> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cp=
uset_syscall_test/Makefile ltp-full-20090630/testcases/kernel/controllers/c=
puset/cpuset_syscall_test/Makefile
>> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_sy=
scall_test/Makefile =A0 2009-06-23 10:18:17.000000000 -0400
>> +++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall=
_test/Makefile =A0 =A0 =A0 =A02009-07-13 12:24:01.000000000 -0400
>> @@ -8,7 +8,8 @@ all:cpuset_syscall_test
>> =A0cpuset_syscall_test: %: %.o $(LIBOBJECTS)
>>
>> =A0clean:
>> - =A0 =A0 rm -rf cpuset_syscall_test
>> + =A0 =A0 rm -rf cpuset_syscall_test cpuset_syscall_test.o
>> + =A0 =A0 rm -f $(LIBOBJECTS)
>>
>> =A0install:
>> =A0 =A0 =A0 @set -e; \

    I wish I could say that's the only area that needs clean fixed,
but there are other spots in the tree that suffer from that issue too.
    I'll submit a quick diff with all of the problem children in an hour or=
 so.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
