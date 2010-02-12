Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nflun-0000MS-4X
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 03:09:57 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nflui-0003K9-LY
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 03:09:57 +0000
Received: by pzk37 with SMTP id 37so1146491pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Feb 2010 19:09:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100211233919.GB19098@rishikesh.in.ibm.com>
References: <1265891406.10768.10.camel@munipradeep-laptop>
	<20100211233919.GB19098@rishikesh.in.ibm.com>
Date: Thu, 11 Feb 2010 19:09:41 -0800
Message-ID: <364299f41002111909l4c795b44sb3e30a07cf6c5dc4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] memory_hotplug tests are not compiling properly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Feb 11, 2010 at 3:39 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Feb 11, 2010 at 06:00:06PM +0530, Munipradeep Beerakam wrote:
>> Hi Rishi,
>>
>> I am unable to compile the memory_hotplug tests in LTP Sep 2009 release.
>> I am getting the below error.
>>
>> ################################################
>> cc -std=3Dgnu99 -O2 =A0-D_GNU_SOURCE -D_NEED_MIGRATE_PAGES =A0 =A0 -c -o
>> memtoy.o memtoy.c
>> cc -std=3Dgnu99 -O2 =A0-D_GNU_SOURCE -D_NEED_MIGRATE_PAGES =A0 =A0 -c -o
>> commands.o commands.c
>> In file included from commands.c:45:
>> migrate_pages.h:10: error: conflicting types for =91migrate_pages=92
>> /usr/include/numaif.h:17: error: previous declaration of =91migrate_page=
s=92
>> was here
>> make: *** [commands.o] Error 1
>> ################################################
>>
>> Even the patch is not applying properly.
>>
>> @All, Any help is appreciated.
> Hi Muni,
>
> Please use latest ltp, as i have seen some changes has gone from garret f=
or fixinf compilation issues.

    Thanks for heading up the question Rishi. Yes Muni, I've made some
changes with this source and it needs to be migrated back into the
original source as the project is still alive, and any and all changes
that make functional sense should be migrated back upstream. We might
want to sync down a later version, as I think that the maintainer
integrated autoconf into the project and it would make functional
sense to have a more updated / less buggy version of this test tool.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
