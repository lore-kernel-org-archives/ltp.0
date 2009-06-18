Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MHLTU-0007gM-Je
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:32 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHLTS-0007eE-K1
	for ltp-list@lists.sourceforge.net; Thu, 18 Jun 2009 17:32:32 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <bb33bcf20906160423r408b3c6awc0b47ec5a2edee1d@mail.gmail.com>
References: <200906161646.50305.knikanth@suse.de>
	<bb33bcf20906160423r408b3c6awc0b47ec5a2edee1d@mail.gmail.com>
Date: Thu, 18 Jun 2009 23:01:51 +0530
Message-Id: <1245346312.5041.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] cpusets: document adding/removing cpus to
	cpuset	elaborately
Reply-To: subrata@linux.vnet.ibm.com
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
To: Nikanth Karthikesan <knikanth@suse.de>
Cc: ltp-list <ltp-list@lists.sf.net>, miaox@cn.fujitsu.com

Hi Nikanth,

On Tue, 2009-06-16 at 16:53 +0530, Subrata Modak wrote: 
> On Tue, Jun 16, 2009 at 4:46 PM, Nikanth Karthikesan
> <knikanth@suse.de> wrote:
>         Writing a pid to the file, tasks adds that task to that
>         cgroup/cpuset. But to
>         add a cpu/mem to a cpuset, the new list of cpus should be
>         written to the
>         cpuset.mems file which would replace the old list of cpus.
>         Make this clearer
>         in the documentation.
>         
>         Signed-off-by: Nikanth Karthikesan <knikanth@suse.de> 
> 
> Hey,
> 
> Great to see that you are working on the documentation part. Have you
> given a try to test the CPUSET features in the kernel with the
> recently added tests from
> LTP(http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/controllers/cpuset/) ? It would be great if you help us in improving them further.
> 

Would you like to share something with us ?

Regards--
Subrata

> Regards--
> Subrata
> 
> 
>         
>         
>         ---
>         
>         diff --git a/Documentation/cgroups/cpusets.txt
>         b/Documentation/cgroups/cpusets.txt
>         index f9ca389..1d7e978 100644
>         --- a/Documentation/cgroups/cpusets.txt
>         +++ b/Documentation/cgroups/cpusets.txt
>         @@ -777,6 +777,18 @@ in cpuset directories:
>          # /bin/echo 1-4 > cpus         -> set cpus list to cpus
>         1,2,3,4
>          # /bin/echo 1,2,3,4 > cpus     -> set cpus list to cpus
>         1,2,3,4
>         
>         +To add a CPU to a cpuset, write the new list of CPUs
>         including the
>         +CPU to be added. To add 6 to the above cpuset:
>         +
>         +# /bin/echo 1-4,6 > cpus       -> set cpus list to cpus
>         1,2,3,4,6
>         +
>         +Similarly to remove a CPU from a cpuset, write the new list
>         of CPUs
>         +without the CPU to be removed.
>         +
>         +To remove all the CPUs:
>         +
>         +# /bin/echo "" > cpus          -> clear cpus list
>         +
>          2.3 Setting flags
>          -----------------
>         
>         
>         
>         
>         --
>         To unsubscribe from this list: send the line "unsubscribe
>         linux-kernel" in
>         the body of a message to majordomo@vger.kernel.org
>         More majordomo info at
>          http://vger.kernel.org/majordomo-info.html
>         Please read the FAQ at  http://www.tux.org/lkml/ 
> 
> 
> 
> -- 
> Regards & Thanks--
> Subrata 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables unlimited
> royalty-free distribution of the report engine for externally facing 
> server and web deployment.
> http://p.sf.net/sfu/businessobjects
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
