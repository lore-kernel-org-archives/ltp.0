Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N85fJ-0002hm-40
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 05:22:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N85f8-0000Al-Cj
	for ltp-list@lists.sourceforge.net; Wed, 11 Nov 2009 05:22:40 +0000
Message-ID: <4AFA4A2E.8040400@cn.fujitsu.com>
Date: Wed, 11 Nov 2009 13:22:54 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com> <4AFA133F.3020808@cn.fujitsu.com>
	<364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com>
In-Reply-To: <364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2115686941871816826=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, maknayak@in.ibm.com

This is a multi-part message in MIME format.
--===============2115686941871816826==
Content-Type: multipart/alternative;
	boundary="------------090401030608040007050404"

This is a multi-part message in MIME format.
--------------090401030608040007050404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/11/2009 12:14 PM, Garrett Cooper wrote:
> On Tue, Nov 10, 2009 at 5:28 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
>   
>> Hi,
>> On 11/10/2009 05:38 PM, liubo wrote:
>>     
>>> 1) rt_sigaction
>>>     "sigaction" has the structure:
>>>
>>>  struct sigaction {
>>>          __sighandler_t sa_handler;
>>>          unsigned long sa_flags;
>>>   #ifdef SA_RESTORER
>>>           __sigrestore_t sa_restorer;
>>>   #endif
>>>           sigset_t sa_mask;               /* mask last for extensibility */
>>>  };
>>>       
>
> Not true... from glibc 2.9 / gentoo-sources-2.6.30-r4:
>
> #ifdef __i386__
> /* Here we must cater to libcs that poke about in kernel headers.  */
>
> struct sigaction {
>         union {
>           __sighandler_t _sa_handler;
>           void (*_sa_sigaction)(int, struct siginfo *, void *);
>         } _u;
>         sigset_t sa_mask;
>         unsigned long sa_flags;
>         void (*sa_restorer)(void);
> };
>
> /* ... */
>
> #else
>
> struct sigaction {
>         __sighandler_t sa_handler;
>         unsigned long sa_flags;
>         __sigrestore_t sa_restorer;
>         sigset_t sa_mask;               /* mask last for extensibility */
> };
>
> #endif
>
> What do the manpages say is required for rt_sigaction to function on
> your machine? Mine just says:
>
> SYNOPSIS
>        #include <signal.h>
>
>        int sigaction(int signum, const struct sigaction *act,
>                      struct sigaction *oldact);
>
>    Feature Test Macro Requirements for glibc (see feature_test_macros(7)):
>
>        sigaction(): _POSIX_C_SOURCE >= 1 || _XOPEN_SOURCE || _POSIX_SOURCE
>
>   

On my machine,

man sigaction
===========
NAME
       sigaction - examine and change a signal action

SYNOPSIS
       #include <signal.h>

       int sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oldact);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       sigaction(): _POSIX_C_SOURCE >= 1 || _XOPEN_SOURCE || _POSIX_SOURCE
===========
The same as you.

BTW, I got the sigaction from kernel code instead of glibc.

And I use "strace" to investigate, it shows that function
sigaction do call rt_sigaction on my x86_64 arch.


>>>     However, on arch x86_64, if we directly get to call rt_sigaction,
>>> the argument "sa_restorer" will not be fulfilled, and this will lead
>>>  to segment fault.
>>>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment fault.
>>> In other arch, if sa_restorer is not set, kernel can do the correct work.
>>>     To avoid this segment fault, we use glibc function
>>> "int sigaction(...);" instead, which can fulfill the argument "sa_restorer".
>>>
>>> 2) rt_sigprocmask
>>>     This failure contains two aspects,
>>> the first is the segment fault as described in 1),
>>> the second is that testcase uses a unknown signal 33 for test,
>>> and this will lead sigaction cannot bind signal 33 to the action.
>>>
>>>     So, we attempt to use a known signal instead, such as 34.
>>>
>>>
>>>       
>>  I am sure signal 32 and 33 cannot be used in rt_sigprocmask test
>>  on arch x86_64, but I'm not sure which signal else should be used
>>  here, Is there anyone can provide suggestions?
>>     
>
> RT signals are all signals above SIGRTMIN (typically 32+, but not
> always), up to SIGRTMAX (usually 64, but on mips it's 128). So... why
> is setting the signal number to anywhere between SIGRTMIN and SIGRTMAX
> unacceptable?
>
> Thanks,
> -Garrett
>
>
>   


--------------090401030608040007050404
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 11/11/2009 12:14 PM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com"
 type="cite">
  <pre wrap="">On Tue, Nov 10, 2009 at 5:28 PM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi,
On 11/10/2009 05:38 PM, liubo wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">1) rt_sigaction
&nbsp; &nbsp; "sigaction" has the structure:

&nbsp;struct sigaction {
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__sighandler_t sa_handler;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned long sa_flags;
&nbsp; #ifdef SA_RESTORER
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __sigrestore_t sa_restorer;
&nbsp; #endif
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; sigset_t sa_mask; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* mask last for extensibility */
&nbsp;};
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
Not true... from glibc 2.9 / gentoo-sources-2.6.30-r4:

#ifdef __i386__
/* Here we must cater to libcs that poke about in kernel headers.  */

struct sigaction {
        union {
          __sighandler_t _sa_handler;
          void (*_sa_sigaction)(int, struct siginfo *, void *);
        } _u;
        sigset_t sa_mask;
        unsigned long sa_flags;
        void (*sa_restorer)(void);
};

/* ... */

#else

struct sigaction {
        __sighandler_t sa_handler;
        unsigned long sa_flags;
        __sigrestore_t sa_restorer;
        sigset_t sa_mask;               /* mask last for extensibility */
};

#endif

What do the manpages say is required for rt_sigaction to function on
your machine? Mine just says:

SYNOPSIS
       #include &lt;signal.h&gt;

       int sigaction(int signum, const struct sigaction *act,
                     struct sigaction *oldact);

   Feature Test Macro Requirements for glibc (see feature_test_macros(7)):

       sigaction(): _POSIX_C_SOURCE &gt;= 1 || _XOPEN_SOURCE || _POSIX_SOURCE

  </pre>
</blockquote>
<br>
On my machine,<br>
<br>
man sigaction<br>
===========<br>
NAME<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sigaction - examine and change a signal action<br>
<br>
SYNOPSIS<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #include &lt;signal.h&gt;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int sigaction(int signum, const struct sigaction *act,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sigaction *oldact);<br>
<br>
&nbsp;&nbsp; Feature Test Macro Requirements for glibc (see
feature_test_macros(7)):<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sigaction(): _POSIX_C_SOURCE &gt;= 1 || _XOPEN_SOURCE ||
_POSIX_SOURCE<br>
===========<br>
The same as you.<br>
<br>
BTW, I got the sigaction from kernel code instead of glibc. <br>
<br>
And I use "strace" to investigate, it shows that function <br>
sigaction do call rt_sigaction on my x86_64 arch. <br>
<br>
<br>
<blockquote
 cite="mid:364299f40911102014p1f2c28adr75700a126ef03d86@mail.gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">&nbsp; &nbsp; However, on arch x86_64, if we directly get to call rt_sigaction,
the argument "sa_restorer" will not be fulfilled, and this will lead
&nbsp;to segment fault.
&nbsp; &nbsp; on arch x86_64, if sa_restorer is not set, kernel will lead to segment fault.
In other arch, if sa_restorer is not set, kernel can do the correct work.
&nbsp; &nbsp; To avoid this segment fault, we use glibc function
"int sigaction(...);" instead, which can fulfill the argument "sa_restorer".

2) rt_sigprocmask
&nbsp; &nbsp; This failure contains two aspects,
the first is the segment fault as described in 1),
the second is that testcase uses a unknown signal 33 for test,
and this will lead sigaction cannot bind signal 33 to the action.

&nbsp; &nbsp; So, we attempt to use a known signal instead, such as 34.


      </pre>
    </blockquote>
    <pre wrap="">&nbsp;I am sure signal 32 and 33 cannot be used in rt_sigprocmask test
&nbsp;on arch x86_64, but I'm not sure which signal else should be used
&nbsp;here, Is there anyone can provide suggestions?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
RT signals are all signals above SIGRTMIN (typically 32+, but not
always), up to SIGRTMAX (usually 64, but on mips it's 128). So... why
is setting the signal number to anywhere between SIGRTMIN and SIGRTMAX
unacceptable?

Thanks,
-Garrett


  </pre>
</blockquote>
<br>
</body>
</html>

--------------090401030608040007050404--


--===============2115686941871816826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2115686941871816826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2115686941871816826==--

