Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1Mxdsc-0007qk-Tc
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 09:41:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxdsV-0003iM-S8
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 09:41:18 +0000
Message-ID: <4AD44B1C.4000103@cn.fujitsu.com>
Date: Tue, 13 Oct 2009 17:40:44 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AD2F942.1090004@cn.fujitsu.com>	<364299f40910121128w48dbef1bpb8ab9fe4b48029ec@mail.gmail.com>
	<200910121436.26663.vapier@gentoo.org>
In-Reply-To: <200910121436.26663.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] ppoll01: Fix to set the signal handler of SIGINT
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8477789560491169947=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mike Frysinger <vapier@gentoo.org>

This is a multi-part message in MIME format.
--===============8477789560491169947==
Content-Type: multipart/alternative;
	boundary="------------080702090003080208030706"

This is a multi-part message in MIME format.
--------------080702090003080208030706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 12/24/-28158 03:59 AM, Mike Frysinger wrote:
> On Monday 12 October 2009 14:28:02 Garrett Cooper wrote:
>   
>> On Mon, Oct 12, 2009 at 2:39 AM, liubo <liubo-fnst@cn.fujitsu.com> wrote:
>>     
>>> The test case ppoll01 does not register the signal handler
>>> of SIGINT, so the program will be terminated by SIGINT
>>> from child process.
>>>
>>> Then, the rest cases will not be tested.
>>>
>>> This patch fixed the problem.
>>>
>>> --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
>>> +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
>>> @@ -124,9 +124,17 @@ extern void cleanup() {
>>> +/*
>>> + * sighandler()
>>> + */
>>> +void sighandler(int sig)
>>> +{
>>> +       return;
>>> +}
>>>  void setup() {
>>>         /* Capture signals if any */
>>> -        /* Create temporary directories */
>>> +       signal(SIGINT, sighandler);
>>> +       /* Create temporary directories */
>>>         TEST_PAUSE;
>>>         tst_tmpdir();
>>>  }
>>> @@ -404,16 +412,6 @@ TEST_END:
>>>  }
>>>
>>>
>>> -/*
>>> - * sighandler()
>>> - */
>>> -void sighandler(int sig)
>>> -{
>>> -        if (sig == SIGINT)
>>> -                return;
>>> -        // NOTREACHED
>>> -        return;
>>> -}
>>>       
>> 1. If all that the signal handler does is just return, it should have
>> been doing SIG_IGN from the beginning.
>> 2. I don't understand how your change fixes this because the signal
>> handler's function is almost the same (the original handler was more
>> generic).
>>     
>
> default behavior with SIGINT is to terminate, and going by this patch, no one 
> set up a signal handler for SIGINT.  so the fix as you implied sounds like:
> 	- call signal(SIGINT, SIG_IGN);
> 	- delete sighandlerr()
> -mike
>   
>   
Mike,

I apply your suggestions on a X86_64 system, and it shows
signal(SIGINT, SIG_IGN) also blocks the case04 itself.

        { // case04
                .ttype          = SEND_SIGINT,
                .ret            = -1,
                .err            = EINTR,
        },

Then, the testcase will hang on here.

So, I suggest we remain "void sighandler(int sig)" to fix the problem.

Thanks,

> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


--------------080702090003080208030706
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
On 12/24/-28158 03:59 AM, Mike Frysinger wrote:
<blockquote cite="mid:%3C200910121436.26663.vapier@gentoo.org%3E"
 type="cite">
  <pre wrap="">On Monday 12 October 2009 14:28:02 Garrett Cooper wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mon, Oct 12, 2009 at 2:39 AM, liubo <a class="moz-txt-link-rfc2396E" href="mailto:liubo-fnst@cn.fujitsu.com">&lt;liubo-fnst@cn.fujitsu.com&gt;</a> wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">The test case ppoll01 does not register the signal handler
of SIGINT, so the program will be terminated by SIGINT
from child process.

Then, the rest cases will not be tested.

This patch fixed the problem.

--- a/testcases/kernel/syscalls/ppoll/ppoll01.c
+++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
@@ -124,9 +124,17 @@ extern void cleanup() {
+/*
+ * sighandler()
+ */
+void sighandler(int sig)
+{
+       return;
+}
 void setup() {
        /* Capture signals if any */
-        /* Create temporary directories */
+       signal(SIGINT, sighandler);
+       /* Create temporary directories */
        TEST_PAUSE;
        tst_tmpdir();
 }
@@ -404,16 +412,6 @@ TEST_END:
 }


-/*
- * sighandler()
- */
-void sighandler(int sig)
-{
-        if (sig == SIGINT)
-                return;
-        // NOTREACHED
-        return;
-}
      </pre>
    </blockquote>
    <pre wrap="">1. If all that the signal handler does is just return, it should have
been doing SIG_IGN from the beginning.
2. I don't understand how your change fixes this because the signal
handler's function is almost the same (the original handler was more
generic).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
default behavior with SIGINT is to terminate, and going by this patch, no one 
set up a signal handler for SIGINT.  so the fix as you implied sounds like:
	- call signal(SIGINT, SIG_IGN);
	- delete sighandlerr()
-mike
  </pre>
  <pre wrap="">
  </pre>
</blockquote>
Mike,<br>
<br>
I apply your suggestions on a X86_64 system, and it shows <br>
signal(SIGINT, SIG_IGN)
also blocks the case04 itself. <br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { // case04<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ttype&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = SEND_SIGINT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ret&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .err&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = EINTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>
<br>
Then, the testcase will hang on here. <br>
<br>
So, I suggest we remain "void sighandler(int sig)" to fix the problem. <br>
<br>
Thanks,<br>
<br>
<blockquote cite="mid:%3C200910121436.26663.vapier@gentoo.org%3E"
 type="cite">
  <pre wrap=""><hr size="4" width="90%">
------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/devconference">http://p.sf.net/sfu/devconference</a></pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  </pre>
</blockquote>
<br>
</body>
</html>

--------------080702090003080208030706--


--===============8477789560491169947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============8477789560491169947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8477789560491169947==--

