Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <poornima.nayak@in.ibm.com>) id 1XUX5K-00008N-FH
	for ltp-list@lists.sourceforge.net; Thu, 18 Sep 2014 08:29:02 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XUX5F-00011P-3x
	for ltp-list@lists.sourceforge.net; Thu, 18 Sep 2014 08:29:02 +0000
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <poornima.nayak@in.ibm.com>; 
	Thu, 18 Sep 2014 13:58:46 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id A9C521258048
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Sep 2014 13:59:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	s8I8V2vd55050298
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Sep 2014 14:01:02 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s8I8SgLZ024642
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Sep 2014 13:58:42 +0530
In-Reply-To: <1411009276-1720-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1411009276-1720-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <OF18E477C1.40A629A1-ON65257D57.002E83C4-65257D57.002E91C0@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Thu, 18 Sep 2014 13:55:04 +0530
Subject: Re: [LTP] [PATCH] runtest/containers: fix errors in
	netns_par_chld_ftp	testcase that takes TCONF as TFAIL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2094018788641149622=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============2094018788641149622==
Content-Type: multipart/alternative;
	boundary="=_alternative 002E91B965257D57_="

This is a multipart message in MIME format.
--=_alternative 002E91B965257D57_=
Content-Type: text/plain; charset="US-ASCII"

Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com> wrote on 09/18/2014 08:31:16 
AM:

> Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com> 
> 09/18/2014 08:31 AM
> 
> To
> 
> <ltp-list@lists.sourceforge.net>
> 
> cc
> 
> Subject
> 
> [LTP] [PATCH] runtest/containers: fix errors in netns_par_chld_ftp 
> testcase that takes TCONF as TFAIL
> 
> In test case 'testcases/kernel/containers/netns/
> netns_par_chld_ftp.sh', if iproute tools
> do not support setting network namespaces, child process will return
> TCONF, but parent
> process took this as TFAIL wrongly.
> 
> So in testcases/lib/test.sh, we introduce tst_record_childstatus()'s
> shell version, please
> see doc/test-writing-guidelines.txt for detailed information this 
> function, it helps to
> propagate child process result(child exit status) to the parent 
> process correctly.
> 
> In this patch, we fix this issue by using this function.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  .../kernel/containers/netns/netns_par_chld_ftp.sh     |  8 ++------
>  testcases/lib/test.sh                                 | 19 ++++++++
> +++++++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
> b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
> index 9370a54..67b86bb 100755
> --- a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
> +++ b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
> @@ -40,12 +40,8 @@ if [ $? -ne 0 ]; then
>     flag=1
>  fi
> 
> -netns_par_chld_ftp
> -if [ $? -eq 0 ]; then
> -   tst_resm TPASS "netns_par_child_ftp"
> -else
> -   tst_resm TFAIL "netns_par_child_ftp"
> -fi
> +netns_par_chld_ftp &
> +tst_record_childstatus $!
> 
>  if [ $flag -eq 1 ]; then
>     stop_daemon vsftpd
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index 5b9e576..0d16894 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -66,6 +66,25 @@ tst_brkm()
>     tst_exit
>  }
> 
> +tst_record_childstatus()
> +{
> +   if [ $# -ne 1 ];then
> +      tst_resm TWARN "child process id is not valid"
> +      return
> +   fi
> +
> +   local child=$1
> +   local ret=0
> +
> +   wait $child
> +   ret=$?
> +   if [ $ret -eq 127 ];then
> +      tst_resm TWARN "child process($child) does not exist"
> +      return
> +   fi
> +   LTP_RET_VAL=$((LTP_RET_VAL|ret))
> +}
> +
>  tst_require_root()
>  {
>     if [ "$(id -ru)" != 0 ]; then
> -- 
> 1.8.2.1
>
Patch looks good 
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

--=_alternative 002E91B965257D57_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Xiaoguang Wang &lt;wangxg.fnst@cn.fujitsu.com&gt;
wrote on 09/18/2014 08:31:16 AM:<br>
<br>
&gt; Xiaoguang Wang &lt;wangxg.fnst@cn.fujitsu.com&gt; </font></tt>
<br><tt><font size=2>&gt; 09/18/2014 08:31 AM</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; To</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; &lt;ltp-list@lists.sourceforge.net&gt;</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; cc</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Subject</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; [LTP] [PATCH] runtest/containers: fix errors in netns_par_chld_ftp
<br>
&gt; testcase that takes TCONF as TFAIL</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; In test case 'testcases/kernel/containers/netns/<br>
&gt; netns_par_chld_ftp.sh', if iproute tools<br>
&gt; do not support setting network namespaces, child process will return<br>
&gt; TCONF, but parent<br>
&gt; process took this as TFAIL wrongly.<br>
&gt; <br>
&gt; So in testcases/lib/test.sh, we introduce tst_record_childstatus()'s<br>
&gt; shell version, please<br>
&gt; see doc/test-writing-guidelines.txt for detailed information this
<br>
&gt; function, it helps to<br>
&gt; propagate child process result(child exit status) to the parent <br>
&gt; process correctly.<br>
&gt; <br>
&gt; In this patch, we fix this issue by using this function.<br>
&gt; <br>
&gt; Signed-off-by: Xiaoguang Wang &lt;wangxg.fnst@cn.fujitsu.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;.../kernel/containers/netns/netns_par_chld_ftp.sh &nbsp; &nbsp;
| &nbsp;8 ++------<br>
&gt; &nbsp;testcases/lib/test.sh &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
19 ++++++++<br>
&gt; +++++++++++<br>
&gt; &nbsp;2 files changed, 21 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh<br>
&gt; b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh<br>
&gt; index 9370a54..67b86bb 100755<br>
&gt; --- a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh<br>
&gt; +++ b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh<br>
&gt; @@ -40,12 +40,8 @@ if [ $? -ne 0 ]; then<br>
&gt; &nbsp; &nbsp; flag=1<br>
&gt; &nbsp;fi<br>
&gt; &nbsp;<br>
&gt; -netns_par_chld_ftp<br>
&gt; -if [ $? -eq 0 ]; then<br>
&gt; - &nbsp; tst_resm TPASS &quot;netns_par_child_ftp&quot;<br>
&gt; -else<br>
&gt; - &nbsp; tst_resm TFAIL &quot;netns_par_child_ftp&quot;<br>
&gt; -fi<br>
&gt; +netns_par_chld_ftp &amp;<br>
&gt; +tst_record_childstatus $!<br>
&gt; &nbsp;<br>
&gt; &nbsp;if [ $flag -eq 1 ]; then<br>
&gt; &nbsp; &nbsp; stop_daemon vsftpd<br>
&gt; diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh<br>
&gt; index 5b9e576..0d16894 100644<br>
&gt; --- a/testcases/lib/test.sh<br>
&gt; +++ b/testcases/lib/test.sh<br>
&gt; @@ -66,6 +66,25 @@ tst_brkm()<br>
&gt; &nbsp; &nbsp; tst_exit<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; +tst_record_childstatus()<br>
&gt; +{<br>
&gt; + &nbsp; if [ $# -ne 1 ];then<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TWARN &quot;child process id is not
valid&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;return<br>
&gt; + &nbsp; fi<br>
&gt; +<br>
&gt; + &nbsp; local child=$1<br>
&gt; + &nbsp; local ret=0<br>
&gt; +<br>
&gt; + &nbsp; wait $child<br>
&gt; + &nbsp; ret=$?<br>
&gt; + &nbsp; if [ $ret -eq 127 ];then<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TWARN &quot;child process($child) does
not exist&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;return<br>
&gt; + &nbsp; fi<br>
&gt; + &nbsp; LTP_RET_VAL=$((LTP_RET_VAL|ret))<br>
&gt; +}<br>
&gt; +<br>
&gt; &nbsp;tst_require_root()<br>
&gt; &nbsp;{<br>
&gt; &nbsp; &nbsp; if [ &quot;$(id -ru)&quot; != 0 ]; then<br>
&gt; -- <br>
&gt; 1.8.2.1<br>
&gt;</font></tt>
<br><tt><font size=2>Patch looks good &nbsp;<br>
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
--=_alternative 002E91B965257D57_=--



--===============2094018788641149622==
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
--===============2094018788641149622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2094018788641149622==--


