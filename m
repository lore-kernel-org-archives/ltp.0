Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MO4dl-0000sS-8l
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 06:58:57 +0000
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149])
	by 1b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO4dg-00069f-V7
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 06:58:57 +0000
Message-ID: <4A52F207.1010106@st.com>
Date: Tue, 07 Jul 2009 08:58:15 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
	<364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
	<200907061806.47824.vapier@gentoo.org>
In-Reply-To: <200907061806.47824.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8196949865293997293=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--===============8196949865293997293==
Content-Type: multipart/alternative;
	boundary="------------070200060506020408080406"

This is a multi-part message in MIME format.
--------------070200060506020408080406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Mike Frysinger wrote:

>On Monday 06 July 2009 13:28:00 Garrett Cooper wrote:
>  
>
>>On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO wrote:
>>    
>>
>>>I've already fixed the same issue you reported. I've tested it
>>>successfully.
>>>
>>>Subrata has already merged my patch (please, find it in attachment).
>>>
>>>Please, check it before to submit another patch.
>>>      
>>>
>>At the end of the day, the real problem is that we're not using the
>>--with- functionality in autoconf, e.g. --with-cgroups, and instead
>>we're hacking a lot of noise into Makefile's.
>>    
>>
>
>selectively compiling groups of code needs to be thought out before we start 
>throwing --with-foo options at the problem.  otherwise we'll still end up with 
>crap, just in a different form.
>
>  
>
>>I can tell at first glance that that Makefile is a mess anyhow,
>>because it's referencing _hardcoded_ /proc references and as such will
>>fail to cross-compile properly if the target or the host are setup
>>differently from one another, in the following two scenarios:
>>    
>>
>
>yes, the merged patch and that makefile suck.  there should never be any 
>filesystem check in a Makefile anymore.  while peeking in /proc is somewhat 
>forgivable, looking for headers never is ok.  we have autoconf tests now and 
>Gowri's approach looks like the correct one.
>-mike
>
I agree with your explanation. My patch tried to address an issue on the 
testcase when  LTP is cross-compiled.

Thanks so much.
Best Regards
--
FR



--------------070200060506020408080406
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<br>
Mike Frysinger wrote:<br>
<blockquote type="cite" cite="mid200907061806.47824.vapier@gentoo.org">
  <pre wrap="">On Monday 06 July 2009 13:28:00 Garrett Cooper wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">I've already fixed the same issue you reported. I've tested it
successfully.

Subrata has already merged my patch (please, find it in attachment).

Please, check it before to submit another patch.
      </pre>
    </blockquote>
    <pre wrap="">At the end of the day, the real problem is that we're not using the
--with- functionality in autoconf, e.g. --with-cgroups, and instead
we're hacking a lot of noise into Makefile's.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
selectively compiling groups of code needs to be thought out before we start 
throwing --with-foo options at the problem.  otherwise we'll still end up with 
crap, just in a different form.

  </pre>
  <blockquote type="cite">
    <pre wrap="">I can tell at first glance that that Makefile is a mess anyhow,
because it's referencing _hardcoded_ /proc references and as such will
fail to cross-compile properly if the target or the host are setup
differently from one another, in the following two scenarios:
    </pre>
  </blockquote>
  <pre wrap=""><!---->
yes, the merged patch and that makefile suck.  there should never be any 
filesystem check in a Makefile anymore.  while peeking in /proc is somewhat 
forgivable, looking for headers never is ok.  we have autoconf tests now and 
Gowri's approach looks like the correct one.
-mike</pre>
</blockquote>
I agree with your explanation. My patch tried to address an issue on
the testcase when&nbsp; LTP is cross-compiled.<br>
<br>
Thanks so much.<br>
Best Regards<br>
--<br>
FR<br>
<br>
<br>
</body>
</html>

--------------070200060506020408080406--



--===============8196949865293997293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--===============8196949865293997293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8196949865293997293==--


