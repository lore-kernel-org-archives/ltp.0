Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1PDLsi-0007rF-Jc
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 18:46:52 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PDLsh-0005kU-Gi
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 18:46:52 +0000
Message-ID: <4CD05C7D.2070608@linux.vnet.ibm.com>
Date: Wed, 03 Nov 2010 00:16:21 +0530
From: Subrata Modak <subrata@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com>	<4CB5615C.4070406@cn.fujitsu.com>
	<4CB59825.7060504@cn.fujitsu.com>
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>
	<4CBBBCB0.8070406@cn.fujitsu.com>	<20101021215212.4a982c85@kryten>
	<4CC13BB8.7090003@cn.fujitsu.com>
	<1287732351.4949.0.camel@subratamodak.linux.ibm.com>
	<20101101201256.66dc6dd7@kryten>
In-Reply-To: <20101101201256.66dc6dd7@kryten>
Subject: Re: [LTP] [PATCH] powerpc: Fix hcall tracepoint recursion
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2845521506403043908=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Anton Blanchard <anton@samba.org>
Cc: ltp-list@lists.sf.net, linux-kernel@vger.kernel.org, linuxppc-dev@vger.kernel.org, linuxppc-embedded@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>

This is a multi-part message in MIME format.
--===============2845521506403043908==
Content-Type: multipart/alternative;
	boundary="------------060706060709000608040808"

This is a multi-part message in MIME format.
--------------060706060709000608040808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Anton Blanchard wrote:
> Hi Subrata,
>
>   
>>> Subrata, could you test the patch below?
>>>       
>> Yes, definitely. Givmme some time.
>>     
>
> Did you get to test this patch? I can push to get it merged if it looks
> good.
>   

Yes, i was able to test this patch on 2.6.37-rc1 and everything looks 
Ok. This can be safely pushed now.
(http://marc.info/?l=ltp-list&m=128766032006665&w=2,)

Regards--
Subrata

> Anton
>   


--------------060706060709000608040808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Anton Blanchard wrote:
<blockquote cite="mid:20101101201256.66dc6dd7@kryten" type="cite">
  <pre wrap="">Hi Subrata,

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Subrata, could you test the patch below?
      </pre>
    </blockquote>
    <pre wrap="">Yes, definitely. Givmme some time.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Did you get to test this patch? I can push to get it merged if it looks
good.
  </pre>
</blockquote>
<br>
Yes, i was able to test this patch on 2.6.37-rc1 and everything looks
Ok. This can be safely pushed now.<br>
(<a class="moz-txt-link-freetext" href="http://marc.info/?l=ltp-list&m=128766032006665&w=2">http://marc.info/?l=ltp-list&amp;m=128766032006665&amp;w=2</a>,)<br>
<br>
Regards--<br>
Subrata<br>
<br>
<blockquote cite="mid:20101101201256.66dc6dd7@kryten" type="cite">
  <pre wrap="">
Anton
  </pre>
</blockquote>
<br>
</body>
</html>

--------------060706060709000608040808--



--===============2845521506403043908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
--===============2845521506403043908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2845521506403043908==--


