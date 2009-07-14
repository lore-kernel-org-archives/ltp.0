Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MQVS1-0007KO-4h
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 00:00:53 +0000
Received: from wf-out-1314.google.com ([209.85.200.173])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQVRr-0002cp-Ud
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 00:00:53 +0000
Received: by wf-out-1314.google.com with SMTP id 26so863922wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Jul 2009 17:00:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A5BC7F3.1030307@cn.fujitsu.com>
References: <4A5AED18.2090201@cn.fujitsu.com>
	<1247473352.26478.14.camel@subratamodak.linux.ibm.com>
	<364299f40907130957i5bffc7acofe0be466ae22ce43@mail.gmail.com>
	<364299f40907131109lcc15653m2d2610d8f7c2bc6@mail.gmail.com>
	<4A5BC7F3.1030307@cn.fujitsu.com>
Date: Mon, 13 Jul 2009 17:00:42 -0700
Message-ID: <364299f40907131700n49ece310ra89265ef512ecd75@mail.gmail.com>
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Jul 13, 2009 at 4:49 PM, Shi Weihua<shiwh@cn.fujitsu.com> wrote:
> Garrett Cooper wrote:
>> On Mon, Jul 13, 2009 at 9:57 AM, Garrett Cooper<yanegomi@gmail.com> wrot=
e:
>>> On Mon, Jul 13, 2009 at 1:22 AM, Subrata
>>> Modak<subrata@linux.vnet.ibm.com> wrote:
>>>> On Mon, 2009-07-13 at 16:15 +0800, Shi Weihua wrote:
>>>>> In case cpuset, the file cpuset_syscall_test.o was not deleted after =
"make clean".
>>>>> The following patch fixed this problem.
>>>>>
>>>>> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
>>>> Garret,
>>>>
>>>> If this is safe and does not interfere with your patches, please check
>>>> this in.
>>>>
>>>> Regards--
>>>> Subrata
>>>>
>>>>> ---
>>>>> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuset=
/cpuset_syscall_test/Makefile ltp-full-20090630/testcases/kernel/controller=
s/cpuset/cpuset_syscall_test/Makefile
>>>>> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset=
_syscall_test/Makefile =A0 2009-06-23 10:18:17.000000000 -0400
>>>>> +++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_sysc=
all_test/Makefile =A0 =A0 =A0 =A02009-07-13 12:24:01.000000000 -0400
>>>>> @@ -8,7 +8,8 @@ all:cpuset_syscall_test
>>>>> =A0cpuset_syscall_test: %: %.o $(LIBOBJECTS)
>>>>>
>>>>> =A0clean:
>>>>> - =A0 =A0 rm -rf cpuset_syscall_test
>>>>> + =A0 =A0 rm -rf cpuset_syscall_test cpuset_syscall_test.o
>>>>> + =A0 =A0 rm -f $(LIBOBJECTS)
>>>>>
>>>>> =A0install:
>>>>> =A0 =A0 =A0 @set -e; \
>>> =A0 =A0I wish I could say that's the only area that needs clean fixed,
>>> but there are other spots in the tree that suffer from that issue too.
>>> =A0 =A0I'll submit a quick diff with all of the problem children in an =
hour or so.
>>
>> Actually, the damage is a lot less than expected ;).
>>
>> gcooper@orangebox /scratch/ltp-dev2/ltp $ find | grep -v CVS | xargs
>> file | egrep 'archive|ELF' | grep -v 'shell archive'
>> gcooper@orangebox /scratch/ltp-dev2/ltp $
>>
>> A patch to fix a minor leak, which will get redone with the Makefile
>> changes I'm bringing in soon.
>>
>> Thanks Shi for the heads up!
>>
>> Here's the patch I'm committing, which cleans out all objects in
>> testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile --
>> not just $(LIBOBJECTS).
>>
>> NOTE: This patch is for viewing only, as the tabs were turned into
>> spaces when copied from xterm.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> I tested your patch, but unfortunately it does not work successfully. ;-)
> The file cpuset_syscall_test.o has not been deleted after "make clean".
> I think "$(OBJECTS)" has not been defined definitely in this Makefile.
> Maybe you should to try my following patch which based on yours.
>
> Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
> ---
> diff -urpN ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpu=
set_syscall_test/Makefile ltp-full-20090630/testcases/kernel/controllers/cp=
uset/cpuset_syscall_test/Makefile
> --- ltp-full-20090630.orig/testcases/kernel/controllers/cpuset/cpuset_sys=
call_test/Makefile =A0 =A0 2009-06-23 10:18:17.000000000 -0400
> +++ ltp-full-20090630/testcases/kernel/controllers/cpuset/cpuset_syscall_=
test/Makefile =A02009-07-14 04:14:55.000000000 -0400
> @@ -1,4 +1,5 @@
> -SRCS =3D $(wildcard *.sh)
> +SRCS =3D $(wildcard *.c)
> +OBJECTS=3D$(patsubst %.c,%.o,$(SRCS))
>
> =A0LIBSRCS=3D$(wildcard ../cpuset_lib/*.c)
> =A0LIBOBJECTS=3D$(patsubst %.c,%.o,$(LIBSRCS))
> @@ -8,7 +9,7 @@ all:cpuset_syscall_test
> =A0cpuset_syscall_test: %: %.o $(LIBOBJECTS)
>
> =A0clean:
> - =A0 =A0 =A0 rm -rf cpuset_syscall_test
> + =A0 =A0 =A0 rm -rf cpuset_syscall_test $(OBJECTS) $(LIBOBJECTS)
>
> =A0install:
> =A0 =A0 =A0 =A0@set -e; \

    Yeah... you're right.. bleh.
    I'll commit this when I get home tonight :).
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
