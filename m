Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1OlSLk-0006Ws-RM
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:01:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSLj-0006dt-MA
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:01:32 +0000
Message-ID: <4C6AEA91.6080004@redhat.com>
Date: Tue, 17 Aug 2010 15:01:21 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
References: <4C6AD62B.2010905@redhat.com>
	<AANLkTimTbSmbAf+sVJz6KsMxcYsg0Em6+1jrgcNLuDcF@mail.gmail.com>
In-Reply-To: <AANLkTimTbSmbAf+sVJz6KsMxcYsg0Em6+1jrgcNLuDcF@mail.gmail.com>
Subject: Re: [LTP] problems building lchown02.c for uClinux
Reply-To: dmarlin@redhat.com
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


Garrett Cooper wrote:
> On Tue, Aug 17, 2010 at 11:34 AM, David Marlin <dmarlin@redhat.com> wrote:
>> 'lchown02.c' does not build properly due to calls to mmap and
>> get_high_address (which references sbrk) when UCLINUX=1 is defined.
>>
>> Attached is a patch to skip those sections of the test when building for
>> uClinux.
> 
>     I understand the mmap(2) part, but couldn't the get_high_address
> portion be done in the LTP headers and library files? 

Possibly.  I was just copying the way it was handled in some other LTP 
tests, i.e.,

   testcases/kernel/syscalls/link/link04.c
   testcases/kernel/syscalls/lstat/lstat02.c

but I'm open to suggestions.

> It would help if
> there was a breakdown of what functionality is and isn't available in
> uclinux that's gating builds / testing (I honestly don't know right
> offhand what those pieces are).

Me either.  I'm just using trial and error at the moment (see what 
works).  Many (most) syscalls tests have code to skip unsupported 
functions based on UCLINUX=1, but a few seem to be missing that test.

I'm working my way through the list, so suggestions are welcome.


Thank you,

d.marlin
==========

> Thanks!
> -Garrett

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
