Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <poornima.nayak@in.ibm.com>) id 1XS2Wo-0005Sa-4C
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 11:27:06 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XS2Wk-0008H3-TK
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 11:27:06 +0000
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <poornima.nayak@in.ibm.com>; 
	Thu, 11 Sep 2014 16:56:51 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 7A99D1258043
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Sep 2014 16:57:17 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	s8BBRDqt57606200
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 16:57:13 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s8BBQlHX020006
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 16:56:47 +0530
Received: from d23ml069.in.ibm.com (d23ml069.in.ibm.com [9.182.8.64])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s8BBQlq1020003
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 16:56:47 +0530
In-Reply-To: <20140911022709.GA16027@localhost.localdomain>
References: <20140911022709.GA16027@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <OF5B28F09C.6DC26FB9-ON65257D50.003ECEB8-65257D50.003EE060@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Thu, 11 Sep 2014 16:53:12 +0530
Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4948050400852152839=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============4948050400852152839==
Content-Type: multipart/alternative;
	boundary="=_alternative 003EE05E65257D50_="

This is a multipart message in MIME format.
--=_alternative 003EE05E65257D50_=
Content-Type: text/plain; charset="US-ASCII"

Han Pingtian <hanpt@linux.vnet.ibm.com> wrote on 09/11/2014 07:57:09 AM:

> Han Pingtian <hanpt@linux.vnet.ibm.com> 
> 09/11/2014 07:57 AM
> 
> To
> 
> ltp-list@lists.sourceforge.net
> 
> cc
> 
> Subject
> 
> [LTP]  [PATCH] ldd01: using 'ppc' to check powerpc arch
> 
> Hello,
> The ldd01 always failed on some powerpc systems of ours. I have figured
> out a patch. Please take a look. Thanks in advance.
> 
> 
> On some powerpc system, the 'uname -a' doesn't show 'powerpc' but will
> show 'ppc'. So we need using it to check the powerpc arch.
> 
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> ---
>  testcases/commands/ade/ldd/ldd01 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/
> ade/ldd/ldd01
> index c60d3ac..569902e 100755
> --- a/testcases/commands/ade/ldd/ldd01
> +++ b/testcases/commands/ade/ldd/ldd01
> @@ -47,7 +47,7 @@ do_setup()
>     mkdir $TCtmp
> 
>     # Check for ppc64 architecture or x86_64 architecture
> -   if uname -a | grep -iq powerpc; then
> +   if uname -a | grep -iq 'ppc\|powerpc'; then
>        file lddfile1.obj | grep 64-bit >/dev/null 2>&1
>        if [ $? -eq 0 ]; then
>           CFLAGS="-m64"
> -- 
> 1.9.3
> 
Verified on PPC machine this fix helps
> 
> 
------------------------------------------------------------------------------
> Want excitement?
> Manually upgrade your production database.
> When you want reliability, choose Perforce
> Perforce version control. Predictably reliable.
> 
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

--=_alternative 003EE05E65257D50_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Han Pingtian &lt;hanpt@linux.vnet.ibm.com&gt; wrote
on 09/11/2014 07:57:09 AM:<br>
<br>
&gt; Han Pingtian &lt;hanpt@linux.vnet.ibm.com&gt; </font></tt>
<br><tt><font size=2>&gt; 09/11/2014 07:57 AM</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; To</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; ltp-list@lists.sourceforge.net</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; cc</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Subject</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; [LTP] &nbsp;[PATCH] ldd01: using 'ppc' to check powerpc arch</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Hello,<br>
&gt; The ldd01 always failed on some powerpc systems of ours. I have figured<br>
&gt; out a patch. Please take a look. Thanks in advance.<br>
&gt; <br>
&gt; <br>
&gt; On some powerpc system, the 'uname -a' doesn't show 'powerpc' but
will<br>
&gt; show 'ppc'. So we need using it to check the powerpc arch.<br>
&gt; <br>
&gt; Signed-off-by: Han Pingtian &lt;hanpt@linux.vnet.ibm.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;testcases/commands/ade/ldd/ldd01 | 2 +-<br>
&gt; &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/<br>
&gt; ade/ldd/ldd01<br>
&gt; index c60d3ac..569902e 100755<br>
&gt; --- a/testcases/commands/ade/ldd/ldd01<br>
&gt; +++ b/testcases/commands/ade/ldd/ldd01<br>
&gt; @@ -47,7 +47,7 @@ do_setup()<br>
&gt; &nbsp; &nbsp; mkdir $TCtmp<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # Check for ppc64 architecture or x86_64 architecture<br>
&gt; - &nbsp; if uname -a | grep -iq powerpc; then<br>
&gt; + &nbsp; if uname -a | grep -iq 'ppc\|powerpc'; then<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;file lddfile1.obj | grep 64-bit &gt;/dev/null
2&gt;&amp;1<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if [ $? -eq 0 ]; then<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; CFLAGS=&quot;-m64&quot;<br>
&gt; -- <br>
&gt; 1.9.3<br>
&gt; </font></tt>
<br><tt><font size=2>Verified on PPC machine this fix helps<br>
&gt; <br>
&gt; ------------------------------------------------------------------------------<br>
&gt; Want excitement?<br>
&gt; Manually upgrade your production database.<br>
&gt; When you want reliability, choose Perforce<br>
&gt; Perforce version control. Predictably reliable.<br>
&gt; </font></tt><a href="http://pubads.g.doubleclick.net/gampad/clk?id=157508191&amp;iu=/4140/ostg.clktrk"><tt><font size=2>http://pubads.g.doubleclick.net/gampad/clk?id=157508191&amp;iu=/4140/ostg.clktrk</font></tt></a><tt><font size=2><br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; Ltp-list@lists.sourceforge.net<br>
&gt; </font></tt><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/ltp-list</font></tt></a><tt><font size=2><br>
&gt; <br>
</font></tt>
--=_alternative 003EE05E65257D50_=--



--===============4948050400852152839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
--===============4948050400852152839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4948050400852152839==--


