Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UGuEy-0001m0-QA
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 16:45:52 +0000
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UGuEy-0002ao-0A
	for ltp-list@lists.sourceforge.net; Sat, 16 Mar 2013 16:45:52 +0000
Received: by mail-wi0-f179.google.com with SMTP id ez12so1423423wid.12
	for <ltp-list@lists.sourceforge.net>;
	Sat, 16 Mar 2013 09:45:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201303161148.25654.vapier@gentoo.org>
References: <1363355370-7738-1-git-send-email-markos.chandras@gmail.com>
	<201303161148.25654.vapier@gentoo.org>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Sat, 16 Mar 2013 16:45:24 +0000
Message-ID: <CAG2jQ8jtkfUw6DZ_iVXwsBz8JHcD37YUogQnrWS-_EHsun4Fuw@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] syscalls/getdents: Add parameter to test
 getdents64 syscall
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 16 March 2013 15:48, Mike Frysinger <vapier@gentoo.org> wrote:
> On Friday 15 March 2013 09:49:30 Markos Chandras wrote:
>> Add new "-l" parameter to test the getdents64 syscall along with
>> the getdents one. Use ltp_syscall() to call the system call to get
>> proper return values when an architecture does not support any of the
>> getdents{,64} syscalls. Modify runtest/syscalls to call getdentsXX tests
>> with and without the "-l" parameter
>
> your patch introduces a lot of warnings.  please verify it on a few arches
> first (like x86_64).

Yes I see what you mean. I will prepare a new one.

>
>> --- a/testcases/kernel/syscalls/getdents/Makefile
>> +++ b/testcases/kernel/syscalls/getdents/Makefile
>>
>> +CFLAGS += -D_LARGEFILE64_SOURCE
>
> these are CPPFLAGS, not CFLAGS
> -mike

Indeed. I will fix it too.

-- 
Regards,
Markos Chandras

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
