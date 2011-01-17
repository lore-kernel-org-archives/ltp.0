Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <k-seki@np.css.fujitsu.com>) id 1Ped7W-00006c-P7
	for ltp-list@lists.sourceforge.net; Mon, 17 Jan 2011 00:38:54 +0000
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Ped7U-0007Fy-Nb
	for ltp-list@lists.sourceforge.net; Mon, 17 Jan 2011 00:38:54 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EC46B3EE0D4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jan 2011 09:38:42 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D1AC845DE68
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jan 2011 09:38:42 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B2AAF45DE6A
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jan 2011 09:38:42 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A331FE08002
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jan 2011 09:38:42 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 632E31DB8038
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Jan 2011 09:38:42 +0900 (JST)
Message-ID: <1044F3871F984514ACE11A23C55DAFB3@FM38572274>
From: "Kazuki Seki" <k-seki@np.css.fujitsu.com>
Date: Mon, 17 Jan 2011 09:38:26 +0900
MIME-Version: 1.0
Subject: Re: [LTP] Fix the test04 of testcases/kernel/numa/numa01.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: =?iso-2022-jp?B?GyRCNFghIU9CNTEbKEI=?= <k-seki@np.css.fujitsu.com>

Hi,

Did you confirm the following email which I posted before?

Best regards,
K Seki

----- Original Message ----- 
From: "Kazuki Seki" <k-seki@np.css.fujitsu.com>
To: <ltp-list@lists.sourceforge.net>
Cc: "Kazuki Seki" <k-seki@np.css.fujitsu.com>
Sent: Monday, December 13, 2010 3:51 PM
Subject: Fix the test04 of testcases/kernel/numa/numa01.sh

> Hi,
>
> I found the test04 of testcases/kernel/numa/numa01.sh can become either
> PASS or FAIL on the same system.
> As a result of examining the following lines of the shell,
> I noticed the execution way of these processings is wrong.
>
>  - Here is a part of a problem in the shell.
>  ---------------------------------------------------------------------------
>   numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits for
> sigint
>   pid=$!
>   running_on_cpu=$(awk '{ print $39; }' /proc/$pid/stat)
>  ---------------------------------------------------------------------------
>
> The following shows the root cause:
>
>  (A) : numactl --physcpubind=$run_on_cpu support_numa $PAUSE &
>  (B) : running_on_cpu=$(awk '{ print $39; }' /proc/$pid/stat)
>
> If (B) completes its execution before (A) binds a certain CPU,
> (B) doesn't set the number of expected CPU and then the test becomes FAIL.
> Therefore, (B) must start after (A) binds a certain CPU.
>
> I made the patch which executes (B) after cmm field of /proc/$pid/stat
> changes from "(numactl)" into "(support_numa)".
>
>  - Example of changing cmm field of /proc/$pid/stat
>  ---------------------------------------------------------------------------
>    [before (A) binds CPU]
>     # awk '{ print $2; }' /proc/$pid/stat
>       (numactl)
>       ^^^^^^^^^
>       cmm field
>
>    [after (A) bound CPU]
>     # awk '{ print $2; }' /proc/$pid/stat
>       (support_numa)
>  ---------------------------------------------------------------------------
>
> Please apply this patch.
>
> ---
> testcases/kernel/numa/numa01.sh |    4 ++++
> 1 file changed, 4 insertions(+)
>
> Index: ltp-70a3216/testcases/kernel/numa/numa01.sh
> ===================================================================
> --- ltp-70a3216.orig/testcases/kernel/numa/numa01.sh    2010-12-01
> 10:50:43.000000000 +0900
> +++ ltp-70a3216/testcases/kernel/numa/numa01.sh 2010-12-01
> 10:51:55.000000000 +0900
> @@ -471,6 +471,10 @@ test04()
>     run_on_cpu=$[$[$no_of_cpus+1]/2]
>     numactl --physcpubind=$run_on_cpu support_numa $PAUSE & #just waits 
> for
> sigint
>     pid=$!
> +    var=`awk '{ print $2; }' /proc/$pid/stat`
> +    while [ $var == "(numactl)" ];do
> +        var=`awk '{ print $2; }' /proc/$pid/stat`
> +    done
>     # Warning !! 39 represents cpu number, on which process pid is
> currently running and
>     # this may change if Some more fields are added in the middle, may be
> in future
>     running_on_cpu=$(awk '{ print $39; }' /proc/$pid/stat)
>
> Best regards,
> K Seki



------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
