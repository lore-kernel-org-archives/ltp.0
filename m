Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NjOtc-0001cq-Rc
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 03:23:44 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjOtZ-000753-Sd
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 03:23:44 +0000
Message-ID: <4B81E0C8.9020205@cn.fujitsu.com>
Date: Mon, 22 Feb 2010 09:41:28 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B5E8192.80909@cn.fujitsu.com>	
	<364299f41001252354m16d21845h6c1bd0b53cd5c98@mail.gmail.com>	
	<364299f41001260025v527adde4u44ff82c647d18b4e@mail.gmail.com>	
	<4B5EB72B.7010909@cn.fujitsu.com>
	<364299f41001260843y72e9ac28nbe2cabee41b2055c@mail.gmail.com>
In-Reply-To: <364299f41001260843y72e9ac28nbe2cabee41b2055c@mail.gmail.com>
Subject: Re: [LTP] [PROBLEM?] rt_sigaction01 still failed on x86_64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2591261201543915978=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--===============2591261201543915978==
Content-Type: multipart/alternative;
	boundary="------------070505050605060309090203"

This is a multi-part message in MIME format.
--------------070505050605060309090203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 01/27/2010 12:43 AM, Garrett Cooper wrote:
> On Tue, Jan 26, 2010 at 1:34 AM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>   
>> at 2010-1-26 16:25, Garrett Cooper wrote:
>>     
>>> On Mon, Jan 25, 2010 at 11:54 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>>>       
>>>> On Mon, Jan 25, 2010 at 9:45 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>>>>         
>>>>> Hi, Cooper
>>>>>
>>>>> I noticed that you added a check of platform which not defined
>>>>> sa_sigaction in struct sigaction.
>>>>> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c?r1=1.6&r2=1.7
>>>>>
>>>>> As your expectted, the following message will output on x86_64.
>>>>> ------------
>>>>> Your architecture doesn't support this test (no sa_sigaction field in struct sigaction).
>>>>> ------------
>>>>> But unfortunately, it still failed on my x86_64.
>>>>>
>>>>> On my x86_64, signal.h like this:
>>>>> ------------
>>>>> #ifndef __ASSEMBLY__
>>>>>
>>>>> #ifdef __i386__
>>>>>        (sa_sigaction defined here)  <--
>>>>> #else /* __i386__ */
>>>>>        (no sa_sigaction defined)    <--
>>>>> #endif /* !__i386__ */
>>>>>
>>>>> #endif /* __ASSEMBLY__ */
>>>>> ------------
>>>>> your check still work ? Sorry, I don't know the check process in
>>>>> LTP configure clearly. Could you give me some explanation.
>>>>>           
>>>> Shi,
>>>>    I'm just going to test out the other proposed rt_sigaction, and
>>>> revert this change if it doesn't work back to a semi-functioning state
>>>> (which means that x86_64 will once again be broken).
>>>>         
>>>     Files reverted because liubo's patch didn't stick.
>>>       
>> Do you will pick out some useful code from liubo's patch ?
>> Previously, you said you would do that. (2009-12-22) ;-)
>>     
>
>     Yes, I did; I tried to apply the patch, almost all of the hunks
> failed to apply.
>
> Liubo,
>     Please generate a new patch and attach it someone can apply it and test.
> Thanks,
> -Garrett
>
>
>   
  Hi, Garrett,
  Sorry for replying so late.
  Sure, I'll generate a new patch based on the newest LTP version and
send it then.

  Thanks,
  Liubo


--------------070505050605060309090203
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 01/27/2010 12:43 AM, Garrett Cooper wrote:
<blockquote
 cite="mid:364299f41001260843y72e9ac28nbe2cabee41b2055c@mail.gmail.com"
 type="cite">
  <pre wrap="">On Tue, Jan 26, 2010 at 1:34 AM, Shi Weihua <a class="moz-txt-link-rfc2396E" href="mailto:shiwh@cn.fujitsu.com">&lt;shiwh@cn.fujitsu.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">at 2010-1-26 16:25, Garrett Cooper wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">On Mon, Jan 25, 2010 at 11:54 PM, Garrett Cooper <a class="moz-txt-link-rfc2396E" href="mailto:yanegomi@gmail.com">&lt;yanegomi@gmail.com&gt;</a> wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">On Mon, Jan 25, 2010 at 9:45 PM, Shi Weihua <a class="moz-txt-link-rfc2396E" href="mailto:shiwh@cn.fujitsu.com">&lt;shiwh@cn.fujitsu.com&gt;</a> wrote:
        </pre>
        <blockquote type="cite">
          <pre wrap="">Hi, Cooper

I noticed that you added a check of platform which not defined
sa_sigaction in struct sigaction.
<a class="moz-txt-link-freetext" href="http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c?r1=1.6&amp;r2=1.7">http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c?r1=1.6&amp;r2=1.7</a>

As your expectted, the following message will output on x86_64.
------------
Your architecture doesn't support this test (no sa_sigaction field in struct sigaction).
------------
But unfortunately, it still failed on my x86_64.

On my x86_64, signal.h like this:
------------
#ifndef __ASSEMBLY__

#ifdef __i386__
&nbsp; &nbsp; &nbsp; &nbsp;(sa_sigaction defined here) &nbsp;&lt;--
#else /* __i386__ */
&nbsp; &nbsp; &nbsp; &nbsp;(no sa_sigaction defined) &nbsp; &nbsp;&lt;--
#endif /* !__i386__ */

#endif /* __ASSEMBLY__ */
------------
your check still work ? Sorry, I don't know the check process in
LTP configure clearly. Could you give me some explanation.
          </pre>
        </blockquote>
        <pre wrap="">Shi,
&nbsp; &nbsp;I'm just going to test out the other proposed rt_sigaction, and
revert this change if it doesn't work back to a semi-functioning state
(which means that x86_64 will once again be broken).
        </pre>
      </blockquote>
      <pre wrap="">&nbsp; &nbsp; Files reverted because liubo's patch didn't stick.
      </pre>
    </blockquote>
    <pre wrap="">Do you will pick out some useful code from liubo's patch ?
Previously, you said you would do that. (2009-12-22) ;-)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
    Yes, I did; I tried to apply the patch, almost all of the hunks
failed to apply.

Liubo,
    Please generate a new patch and attach it someone can apply it and test.
Thanks,
-Garrett


  </pre>
</blockquote>
&nbsp; Hi, Garrett,<br>
&nbsp; Sorry for replying so late.<br>
&nbsp; Sure, I'll generate a new patch based on the newest LTP version and
send it then.<br>
<br>
&nbsp; Thanks,<br>
&nbsp; Liubo<br>
<br>
</body>
</html>

--------------070505050605060309090203--


--===============2591261201543915978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============2591261201543915978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2591261201543915978==--

