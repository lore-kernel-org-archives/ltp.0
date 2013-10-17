Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VWn4J-0006KA-Nr
	for ltp-list@lists.sourceforge.net; Thu, 17 Oct 2013 12:52:47 +0000
Date: Thu, 17 Oct 2013 14:52:33 +0200
From: chrubis@suse.cz
Message-ID: <20131017125233.GC24992@rei>
References: <9C261B4871671149A8D67C0E65957391507046@039-SN1MPN1-003.039d.mgd.msft.net>
	<20131016112213.GB24451@rei.Home>
	<9C261B4871671149A8D67C0E659573915077DF@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9C261B4871671149A8D67C0E659573915077DF@039-SN1MPN1-003.039d.mgd.msft.net>
Subject: Re: [LTP] "cpu_hotplug/functional/cpuhotplug05.sh" failed
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
To: Liao Guoqi-B25230 <B25230@freescale.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> ---
>  .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index e64b91c..e893f04 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -57,8 +57,8 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>         sleep 2
>         SAR_PID=$!
> 
> -       # Verify that SAR has correctly listed the missing CPU as 'nan'
> -       while ! grep -iq nan $TMP/log_$$; do
> +       # Verify that SAR has correctly listed the missing CPU
> +       while ! awk '{print $8}' $TMP/log_$$|grep -i "^0.00"; do
>                 tst_resm TFAIL "CPU${CPU_TO_TEST} Not Found on SAR!"
>                 exit_clean 1
>         done
> @@ -66,7 +66,7 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>         sleep .5
> 
>         # Verify that at least some of the CPUs are offline
> -       NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
> +        NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | awk '{print $8}' |grep -i "^0.00" | wc -l)
>         if [ ${NUMBER_CPU_OFF} -eq 0 ]; then
>                 tst_resm TBROK "no CPUs found offline"
>                 exit_clean 1
> @@ -83,7 +83,7 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>         sleep .5
> 
>         # Check that SAR registered the change in CPU online/offline states
> -       NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$ | grep -i nan | wc -l)
> +        NEW_NUMBER_CPU_OFF=$(grep "$time" $TMP/log_$$|awk '{print $8}'|grep -i "^0.00"| wc -l)
>         : $(( NUMBER_CPU_OFF -= 1 ))
>         if [ "$NUMBER_CPU_OFF" = "$NEW_NUMBER_CPU_OFF" ]; then
>                 tst_resm TPASS "CPU was found after turned on."

Ok, that fixes it for sar that does not print nan. Do you have an idea
for how long the sar behaves this way?

Because I do not wan't to break the test for anybody with slightly older
sasstat package.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
