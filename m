Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1RnXUT-0002UZ-4r
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:31:57 +0000
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnXUN-00020f-7f
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:31:57 +0000
Message-ID: <4F16E5DA.2050707@st.com>
Date: Wed, 18 Jan 2012 16:31:38 +0100
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <1326897408-26778-1-git-send-email-carmelo.amoroso@st.com>
	<201201181016.39003.vapier@gentoo.org>
In-Reply-To: <201201181016.39003.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2] getcontext01: fix build using uClibc C runtime
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

On 18/01/2012 16.16, Mike Frysinger wrote:
> On Wednesday 18 January 2012 09:36:47 Carmelo AMOROSO wrote:
>> --- a/testcases/kernel/syscalls/getcontext/getcontext01.c +++
>> b/testcases/kernel/syscalls/getcontext/getcontext01.c
>> 
>> #include <features.h> +#include <unistd.h> +#include "test.h" 
>> +char *TCID = "getcontext01";	/* Test program identifier.    */ 
>> + #if !defined(__UCLIBC__)
>> 
>> #include <stdio.h> -#include <unistd.h> #include <errno.h> 
>> #include <ucontext.h>
>> 
>> -#include "test.h" #include "usctest.h"
> 
> all of the system includes should come before LTP includes.  i
> would just move the whole block above the #ifdef check.
> 

ok, make sense.


> also, checking __UCLIBC__ is a bit broken now ... we should use
> configure.ac to test for the func and change this test
> accordingly.

yeah... there are few other occurrences of testing for __UCLIBC__ macro.
I should have sent this a lot of times ago ;-)

I'd send a new version moving the include block all together, and
keeping for now the __UCLIBC__ check, as a temporary solution.

> -mike

thanks,
carmelo


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
