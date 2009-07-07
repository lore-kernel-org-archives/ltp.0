Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MO4ZK-000191-Vl
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 06:54:22 +0000
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131])
	by 29vjzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO4Z9-00011n-OR
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 06:54:17 +0000
Message-ID: <4A52F0D8.7060509@st.com>
Date: Tue, 07 Jul 2009 08:53:12 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
	<364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
In-Reply-To: <364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============3033897268108633985=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--===============3033897268108633985==
Content-Type: multipart/alternative;
	boundary="------------030104010703000101090906"

This is a multi-part message in MIME format.
--------------030104010703000101090906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Garrett,

thanks for your comment. Below, my consideration:

Garrett Cooper wrote:

>On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO<francesco.rundo@st.com> wrote:
>  
>
>>Hi Gowri,
>>
>>I've already fixed the same issue you reported. I've tested it successfully.
>>
>>Subrata has already merged my patch (please, find it in attachment).
>>
>>Please, check it before to submit another patch.
>>    
>>
>
>At the end of the day, the real problem is that we're not using the
>--with- functionality in autoconf, e.g. --with-cgroups, and instead
>we're hacking a lot of noise into Makefile's.
>

Yes, you're right but your advice can't be applicable in the system in 
which autoconf is not supported/used to build LTP (a possible scenario 
in the embedded system).

>
>Also, you could have called SUBDIRS += once, like so:
>
>+SUBDIRS += cgroup cpuctl memctl io-throttle freezer cpuset
>
>I can tell at first glance that that Makefile is a mess anyhow,
>because it's referencing _hardcoded_ /proc references and as such will
>fail to cross-compile properly if the target or the host are setup
>differently from one another, in the following two scenarios:
>

Yes, check at "/proc" isn't safe as can't be applicable in case of 
cross-compilation made off-line on the host.
I have provided a "work-around" patch to allow off-line 
cross-compilation trying to reduce the number of changes to be applied 
to the Makefile.

Regards
Francesco Rundo

--------------030104010703000101090906
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Hi Garrett,<br>
<br>
thanks for your comment. Below, my consideration:<br>
<br>
Garrett Cooper wrote:<br>
<blockquote type="cite"
 cite="mid364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com">
  <pre wrap="">On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO<a class="moz-txt-link-rfc2396E" href="mailto:francesco.rundo@st.com">&lt;francesco.rundo@st.com&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi Gowri,

I've already fixed the same issue you reported. I've tested it successfully.

Subrata has already merged my patch (please, find it in attachment).

Please, check it before to submit another patch.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
At the end of the day, the real problem is that we're not using the
--with- functionality in autoconf, e.g. --with-cgroups, and instead
we're hacking a lot of noise into Makefile's.</pre>
</blockquote>
<br>
Yes, you're right but your advice can't be applicable in the system in
which autoconf is not supported/used to build LTP (a possible scenario
in the embedded system).<br>
<br>
<blockquote type="cite"
 cite="mid364299f40907061028o4c9c2922ma7d430f5e03f4b38@mail.gmail.com">
  <pre wrap="">

Also, you could have called SUBDIRS += once, like so:

+SUBDIRS += cgroup cpuctl memctl io-throttle freezer cpuset

I can tell at first glance that that Makefile is a mess anyhow,
because it's referencing _hardcoded_ /proc references and as such will
fail to cross-compile properly if the target or the host are setup
differently from one another, in the following two scenarios:</pre>
</blockquote>
<br>
Yes, check at "/proc" isn't safe as can't be applicable in case of
cross-compilation made off-line on the host. <br>
I have provided a "work-around" patch to allow off-line
cross-compilation trying to reduce the number of changes to be applied
to the Makefile.<br>
<br>
Regards<br>
Francesco Rundo<br>
</body>
</html>

--------------030104010703000101090906--



--===============3033897268108633985==
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
--===============3033897268108633985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3033897268108633985==--


