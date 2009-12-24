Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NNtvf-0003In-RI
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 20:04:59 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NNtvX-0004pB-9K
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 20:04:59 +0000
Received: by pzk31 with SMTP id 31so5642614pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Dec 2009 12:04:44 -0800 (PST)
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
	<20091224181601.12571.78565.sendpatchset@localhost.localdomain>
Message-Id: <AD1061EF-C689-4456-A892-B7B828754850@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20091224181601.12571.78565.sendpatchset@localhost.localdomain>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Thu, 24 Dec 2009 12:04:25 -0800
Subject: Re: [LTP] [Patch 4/4]Readme modified based on review comments
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "ego@in.ibm.com" <ego@in.ibm.com>, "arun@linux.vnet.ibm.com" <arun@linux.vnet.ibm.com>

On Dec 24, 2009, at 10:16 AM, Poornima Nayak  
<mpnayak@linux.vnet.ibm.com> wrote:

> Patch to update readme with information on how to use Power  
> management testcases
> to test consolidation testcases.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/ 
> power_management/README ltp-intermediate-20091209.fixes/testcases/ 
> kernel/power_management/README
> --- ltp-intermediate-20091209.orig/testcases/kernel/power_management/ 
> README    2009-12-09 13:18:25.000000000 +0530
> +++ ltp-intermediate-20091209.fixes/testcases/kernel/ 
> power_management/README    2009-12-24 23:12:55.293026448 +0530
> @@ -77,6 +77,8 @@ Power Management    1  FAIL  :  Required
>
> Then either configuration is not set or the system won't support.
>
> +Command to test CPU consolidation & ILB testcases on any system  
> syntax is 'runltp -f power_management_tests_exclusive'. CPU  
> consolidation testcases has to be triggered on a system which is  
> totally idle i.e do not execute exclusive testcases on KVM/xen test  
> setup.
> +
> For CPU consolidation verification ebizzy is included in utils  
> directory of LTP.
> To run cpu consolidation test user has to provide -w <workload> -l  
> <sched_mc_level>.
> Refer to README in LTPROOT/utils/benchmark/ebizzy-0.2 directory for  
> details of ebizzy.

This is 0.3 now.

> @@ -84,4 +86,6 @@ Refer to README in LTPROOT/utils/benchma
> To test CPU consolidation for sched_mc 2 kernbench has to run.  
> Kernbench needs linux kernel source as input in /root directory .  
> For example download from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2 
> . If Linux kernel source not found kernbench wiil  not execute.
> CPU consolidation testcases will not execute if number of CPU's in  
> package is less then 2. If system is hyper threaded but number of  
> CPU is 1 only sched_smt testcases will be excuted. For better  
> coverage of testcases select a system which is atleast quad core and  
> then hyper threaded so that you will observe 8 CPU's in each package.
>
> -Timer migration interface test will execute on kernel versions  
> 2.6.31 and above. Timer migration functionality verification  
> testcases will be executed only on suitable architecture like quad  
> core or the number of CPU's in each package should be atleast 4 and  
> above
> +Timer migration interface test will execute on kernel versions  
> 2.6.31 and above.
> +
> +On Power platform sched_smt & cpu_idle testcases will be executed.
>
> --- 
> --- 
> --- 
> ---------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast  
> and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
