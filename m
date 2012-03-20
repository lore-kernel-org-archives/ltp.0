Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1S9uSW-0007KW-Eh
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 08:30:24 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S9uSM-0003V6-43
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 08:30:24 +0000
Message-ID: <4F68400F.9080702@windriver.com>
Date: Tue, 20 Mar 2012 16:30:07 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
References: <CABxY-SKB1ebi1xEfp_-MysXWQ_d_fh3knfPphoW1c9r5ucWU5w@mail.gmail.com>
In-Reply-To: <CABxY-SKB1ebi1xEfp_-MysXWQ_d_fh3knfPphoW1c9r5ucWU5w@mail.gmail.com>
Subject: Re: [LTP] Query regarding Open Posix Test Case failure
	(pthread_rwlock_rdlock)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0100293330181244940=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jubi Taneja <jubitaneja@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============0100293330181244940==
Content-Type: multipart/alternative;
	boundary="------------070209010605010100090909"

--------------070209010605010100090909
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 2012?03?19? 16:11, Jubi Taneja wrote:
> Hi
>
> In LTP(Jan 2012 release) Open Posix Test Suite, the test case 
> "pthread_rwlock_rdlock/2-1.c"
> fails for Linux Kernel 3.0.18 for target ARM.
>
>
> The exact output of the program is:
> main: has priority: 3
> main: attempt read lock
> main: acquired read lock
> main: create wr_thread, with priority: 2
> wr_thread: attempt write lock
> main: create rd_thread, with priority: 1
> rd_thread: attempt read lock
> rd_thread: acquired read lock
> rd_thread: unlock read lock
> Test FAILED: rd_thread did not block on read lock, when a reader owns 
> the lock, and a higher
> priority writer is waiting for the lock

Hi Jubi,

I am using eglibc and meet the same failure. My analysis is that

   This test case is to test option *Thread Execution Scheduling* of 
pthread rwlock.
   But eglibc/libc don't support this option. They provide a 
rwlock->__data.*__flags* option to identify
   perfer 'read lock' or write lock, and the default is 'read lock' 
first. So second reader can get the lock
   when a higher priority writer is waiting for the lock.

Regards,
Kai

>
>
>
> The path of the program si :
> VDLTP_20120104/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock
>
> Ca anyone please explain why it fails at this point? I am unable to 
> catch the exact reason.
>
> Looking forward to your reply.
>
> Thanks,
> Jubi
>
>
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
>
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--------------070209010605010100090909
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 2012&#24180;03&#26376;19&#26085; 16:11, Jubi Taneja wrote:
    <blockquote
cite="mid:CABxY-SKB1ebi1xEfp_-MysXWQ_d_fh3knfPphoW1c9r5ucWU5w@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      Hi<br>
      <br>
      In LTP(Jan 2012 release) Open Posix Test Suite, the test case
      "pthread_rwlock_rdlock/2-1.c" <br>
      fails for Linux Kernel 3.0.18 for target ARM. <br>
      <br>
      <br>
      The exact output of the program is:<br>
      main: has priority: 3<br>
      main: attempt read lock<br>
      main: acquired read lock<br>
      main: create wr_thread, with priority: 2<br>
      wr_thread: attempt write lock<br>
      main: create rd_thread, with priority: 1<br>
      rd_thread: attempt read lock<br>
      rd_thread: acquired read lock<br>
      rd_thread: unlock read lock<br>
      Test FAILED: rd_thread did not block on read lock, when a reader
      owns the lock, and a higher <br>
      priority writer is waiting for the lock<br>
    </blockquote>
    <br>
    Hi Jubi,<br>
    <br>
    I am using eglibc and meet the same failure. My analysis is that <br>
    &nbsp; <br>
    &nbsp; This test case is to test option <b>Thread Execution Scheduling</b>
    of pthread rwlock. <br>
    &nbsp; But eglibc/libc don't support this option. They provide a
    rwlock-&gt;__data.<b>__flags</b> option to identify<br>
    &nbsp; perfer 'read lock' or write lock, and the default is 'read lock'
    first. So second reader can get the lock<br>
    &nbsp; when a higher priority writer is waiting for the lock.<br>
    <br>
    Regards,<br>
    Kai<br>
    <br>
    <blockquote
cite="mid:CABxY-SKB1ebi1xEfp_-MysXWQ_d_fh3knfPphoW1c9r5ucWU5w@mail.gmail.com"
      type="cite"><br>
      &nbsp;<br>
      <br>
      The path of the program si : <br>
VDLTP_20120104/testcases/open_posix_testsuite/conformance/interfaces/pthread_rwlock_rdlock<br>
      <br>
      Ca anyone please explain why it fails at this point? I am unable
      to catch the exact reason. <br>
      <br>
      Looking forward to your reply.<br>
      <br>
      Thanks,<br>
      Jubi <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
<a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/sfd2d-msazure">http://p.sf.net/sfu/sfd2d-msazure</a></pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070209010605010100090909--


--===============0100293330181244940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
--===============0100293330181244940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0100293330181244940==--

