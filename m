Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N9yKE-00038F-Oe
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 09:56:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9yK5-0004TA-LQ
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 09:56:44 +0000
Message-ID: <4B0112EC.9020202@cn.fujitsu.com>
Date: Mon, 16 Nov 2009 16:53:00 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF93496.3030408@cn.fujitsu.com>	
	<200911102333.55526.vapier@gentoo.org>
	<4AFA45B0.7070608@cn.fujitsu.com>
	<1258359225.5677.35.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1258359225.5677.35.camel@subratamodak.linux.ibm.com>
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
Content-Type: multipart/mixed; boundary="===============7052523628282262022=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>

This is a multi-part message in MIME format.
--===============7052523628282262022==
Content-Type: multipart/alternative;
	boundary="------------030806030209040307070500"

This is a multi-part message in MIME format.
--------------030806030209040307070500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi, Subrata,
On 11/16/2009 04:13 PM, Subrata Modak wrote:
> Liubo,
>
> Are you sending an updated patch post this discussion ?
>
>   
Yes, I'll resend a updated patch about these rt_sigs.

Regards--
Liubo

> Regards--
> Subrata
>
> On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote: 
>   
>> Mike Frysinger wrote:
>>     
>>> On Tuesday 10 November 2009 04:38:30 liubo wrote:
>>>   
>>>       
>>>> 1) rt_sigaction
>>>>     "sigaction" has the structure:
>>>>
>>>>  struct sigaction {
>>>>          __sighandler_t sa_handler;
>>>>          unsigned long sa_flags;
>>>>   #ifdef SA_RESTORER
>>>>           __sigrestore_t sa_restorer;
>>>>   #endif
>>>>           sigset_t sa_mask;               /* mask last for extensibility */
>>>>  };
>>>>
>>>>     However, on arch x86_64, if we directly get to call rt_sigaction,
>>>> the argument "sa_restorer" will not be fulfilled, and this will lead
>>>>  to segment fault.
>>>>     on arch x86_64, if sa_restorer is not set, kernel will lead to segment
>>>>  fault. In other arch, if sa_restorer is not set, kernel can do the correct
>>>>  work. To avoid this segment fault, we use glibc function
>>>> "int sigaction(...);" instead, which can fulfill the argument
>>>>  "sa_restorer".
>>>>     
>>>>         
>>> which defeats the purpose of the test.  there is no guarantee that the C 
>>> library sigaction function is implemented via the __NR_rt_sigaction syscall.
>>>   
>>>       
>> In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
>> directly, we must fill the sa_restorer and set the RESTORER flag to
>> sa_mask. If we do not set the sa_restorer, kill will always cause
>> segment fault.
>>
>>     
>>>   
>>>       
>>>> 2) rt_sigprocmask
>>>>     This failure contains two aspects,
>>>> the first is the segment fault as described in 1),
>>>> the second is that testcase uses a unknown signal 33 for test,
>>>> and this will lead sigaction cannot bind signal 33 to the action.
>>>>
>>>>     So, we attempt to use a known signal instead, such as 34.
>>>>     
>>>>         
>>> which is just as bogus and unportable.  if the test needs a real time signal, 
>>> it should leverage the sigrtmin...sigrtmax defines.
>>> -mike
>>>   
>>> ------------------------------------------------------------------------
>>>
>>> ------------------------------------------------------------------------------
>>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
>>> trial. Simplify your report design, integration and deployment - and focus on 
>>> what you do best, core application coding. Discover what's new with
>>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>>> ------------------------------------------------------------------------
>>>
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>   
>>>       
>> ------------------------------------------------------------------------------
>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
>> trial. Simplify your report design, integration and deployment - and focus on 
>> what you do best, core application coding. Discover what's new with
>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>     
>
>
>
>   


--------------030806030209040307070500
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi, Subrata,<br>
On 11/16/2009 04:13 PM, Subrata Modak wrote:
<blockquote
 cite="mid:1258359225.5677.35.camel@subratamodak.linux.ibm.com"
 type="cite">
  <pre wrap="">Liubo,

Are you sending an updated patch post this discussion ?

  </pre>
</blockquote>
Yes, I'll resend a updated patch about these rt_sigs.<br>
<br>
Regards--<br>
Liubo<br>
<br>
<blockquote
 cite="mid:1258359225.5677.35.camel@subratamodak.linux.ibm.com"
 type="cite">
  <pre wrap="">Regards--
Subrata

On Wed, 2009-11-11 at 13:03 +0800, Wei Yongjun wrote: 
  </pre>
  <blockquote type="cite">
    <pre wrap="">Mike Frysinger wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">On Tuesday 10 November 2009 04:38:30 liubo wrote:
  
      </pre>
      <blockquote type="cite">
        <pre wrap="">1) rt_sigaction
    "sigaction" has the structure:

 struct sigaction {
         __sighandler_t sa_handler;
         unsigned long sa_flags;
  #ifdef SA_RESTORER
          __sigrestore_t sa_restorer;
  #endif
          sigset_t sa_mask;               /* mask last for extensibility */
 };

    However, on arch x86_64, if we directly get to call rt_sigaction,
the argument "sa_restorer" will not be fulfilled, and this will lead
 to segment fault.
    on arch x86_64, if sa_restorer is not set, kernel will lead to segment
 fault. In other arch, if sa_restorer is not set, kernel can do the correct
 work. To avoid this segment fault, we use glibc function
"int sigaction(...);" instead, which can fulfill the argument
 "sa_restorer".
    
        </pre>
      </blockquote>
      <pre wrap="">which defeats the purpose of the test.  there is no guarantee that the C 
library sigaction function is implemented via the __NR_rt_sigaction syscall.
  
      </pre>
    </blockquote>
    <pre wrap="">In x86_64, it do this. And If we want to use __NR_rt_sigaction syscall
directly, we must fill the sa_restorer and set the RESTORER flag to
sa_mask. If we do not set the sa_restorer, kill will always cause
segment fault.

    </pre>
    <blockquote type="cite">
      <pre wrap="">  
      </pre>
      <blockquote type="cite">
        <pre wrap="">2) rt_sigprocmask
    This failure contains two aspects,
the first is the segment fault as described in 1),
the second is that testcase uses a unknown signal 33 for test,
and this will lead sigaction cannot bind signal 33 to the action.

    So, we attempt to use a known signal instead, such as 34.
    
        </pre>
      </blockquote>
      <pre wrap="">which is just as bogus and unportable.  if the test needs a real time signal, 
it should leverage the sigrtmin...sigrtmax defines.
-mike
  
------------------------------------------------------------------------

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  <a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/bobj-july">http://p.sf.net/sfu/bobj-july</a>
------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  
      </pre>
    </blockquote>
    <pre wrap="">------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  <a class="moz-txt-link-freetext" href="http://p.sf.net/sfu/bobj-july">http://p.sf.net/sfu/bobj-july</a>
_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->


  </pre>
</blockquote>
<br>
</body>
</html>

--------------030806030209040307070500--


--===============7052523628282262022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7052523628282262022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7052523628282262022==--

