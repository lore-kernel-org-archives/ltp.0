Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJ5Q4-0004Qj-HJ
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 13:20:28 +0000
Received: from mail-gx0-f224.google.com ([209.85.217.224])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ5Pz-0003as-2a
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 13:20:28 +0000
Received: by gxk24 with SMTP id 24so976987gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 05:20:17 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000401ca78a3$56963f50$03c2bdf0$@co.jp>
Date: Fri, 11 Dec 2009 05:20:14 -0800
Message-Id: <B84CCDD1-BBED-4243-9A6B-16BAD25D61FC@gmail.com>
References: <000001ca77ef$78ed7f00$6ac87d00$@co.jp>
	<364299f40912082106x43632a8ble8bc334070510932@mail.gmail.com>
	<000401ca78a3$56963f50$03c2bdf0$@co.jp>
Subject: Re: [LTP] Build failure with ltp-2009-12-08 cvs
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net


On Dec 8, 2009, at 11:43 PM, Mitani wrote:

> RHEL4.8's kernel version is 2.6.9-89.ELsmp.
> Fedora 3 has kernel 2.6.9-1.667.
> 
> But Fedora3 and RHEL4.8 diverged halfway, and now they seem to be
> different each other.
> 
> If you want some other informations, I offer them.
> 
> 
> 
> I heard that CentOS4.8 had kernel of the version same as RHEL4.8.
> 
> Thank you--
> 
> -Tomonori Mitani
> 
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com] 
> Sent: Wednesday, December 09, 2009 2:07 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Build failure with ltp-2009-12-08 cvs
> 
> On Tue, Dec 8, 2009 at 2:16 AM, Mitani <mitani@ryobi.co.jp> wrote:
>> Hi,
>> 
>> 
>> I tried to "make" with "ltp-2009-12-08.tar.gz" version
>> in RHEL4.8 (kernel 2.6.9-89.ELsmp) and x86 architecture.
>> 
>> But it failed by following message:
>> 
>> ------------
>> make[4]: Entering directory
>> `/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy'
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/home/LTP/ltp-2009-12-08/testcases/kernel/include
>> 
> -I/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils
>> -I../../../../include -I../../../../include   -L../../../../lib
>> get_mempolicy01.c   -lltp -lnuma -o get_mempolicy01
>> In file included from get_mempolicy01.c:58:
>> 
> /home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy/../utils/nu
>> maif.h:88: error: redefinition of 'nodemask_set'
>> /usr/include/numa.h:45: error: previous definition of 'nodemask_set' was
>> here
>> make[4]: *** [get_mempolicy01] Error 1
>> make[4]: Leaving directory
>> `/home/LTP/ltp-2009-12-08/testcases/kernel/syscalls/get_mempolicy'
>> make[3]: *** [all] Error 2
>> ------------
>> 
>> For reference, "make" succeeded in my following systems:
>>  - RHEL5.4 (kernel 2.6.18-164.el5) and x86 architecture
>>  - RHEL5.4 (kernel 2.6.18-164.el5) and x86_64 architecture
>> 
>> 
>> "nodemask_set" is the structure whitch defined in following two header
>> files:
>>  (a) "${LTPROOT}/testcases/kernel/syscalls/utils/numaif.h"
>>  (b) "/usr/include/numa.h"
>> 
>> In "numaif.h" file, definition is as follows:
> 
> Mitani-san,
>    This issue keeps on coming back to haunt us. Can you tell me what
> the Fedora Core equivalent of RHEL 4.8 is so I can isolate and resolve
> the issue?

    Ok, finally fixed. The problem was that you have a version 1 copy of numa.h, and the newer headers don't have that that definition out of the box.
Thanks,
-Garrett
------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
