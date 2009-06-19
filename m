Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <knikanth@novell.com>) id 1MHVD3-0000eZ-6I
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 03:56:13 +0000
Received: from victor.provo.novell.com ([137.65.250.26])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MHVD2-0003yb-3d
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 03:56:13 +0000
Message-Id: <4A3B59AD020000C5000399AB@victor.provo.novell.com>
Date: Thu, 18 Jun 2009 21:56:05 -0600
From: "Nikanth Karthikesan" <knikanth@novell.com>
References: <200906161646.50305.knikanth@suse.de>
	<bb33bcf20906160423r408b3c6awc0b47ec5a2edee1d@mail.gmail.com>
	<1245346312.5041.40.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1245346312.5041.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: Re: [LTP] cpusets: document adding/removing cpus to	
	cpusetelaborately
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
To: subrata@linux.vnet.ibm.com, Nikanth Karthikesan <knikanth@suse.de>
Cc: ltp-list <ltp-list@lists.sf.net>, miaox@cn.fujitsu.com



>>> On 6/18/2009 at 11:01 PM, Subrata Modak <subrata@linux.vnet.ibm.com> wrote: 
> Hi Nikanth, 
>  
> On Tue, 2009-06-16 at 16:53 +0530, Subrata Modak wrote:  
> > On Tue, Jun 16, 2009 at 4:46 PM, Nikanth Karthikesan 
> > <knikanth@suse.de> wrote: 
> >         Writing a pid to the file, tasks adds that task to that 
> >         cgroup/cpuset. But to 
> >         add a cpu/mem to a cpuset, the new list of cpus should be 
> >         written to the 
> >         cpuset.mems file which would replace the old list of cpus. 
> >         Make this clearer 
> >         in the documentation. 
> >          
> >         Signed-off-by: Nikanth Karthikesan <knikanth@suse.de>  
> >  
> > Hey, 
> >  
> > Great to see that you are working on the documentation part. Have you 
> > given a try to test the CPUSET features in the kernel with the 
> > recently added tests from 
> >  
> LTP(http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/controller 
> s/cpuset/) ? It would be great if you help us in improving them further. 
> >  
>  
> Would you like to share something with us ? 
>  

Hey Subrata

Great to hear from you. I was working  on a patch that touches cpuset, and
mis-understood the doc, hence the patch. But I haven't worked on it after that,
as I was occupied with something else.

Thanks a lot for pointing me to the LTP test cases. It should help me. Surely,
would use it when I get back to it, after I am back from vacation and and report
my experience. :)

Thanks
Nikanth

> >  
> >  
> >          
> >          
> >         --- 
> >          
> >         diff --git a/Documentation/cgroups/cpusets.txt 
> >         b/Documentation/cgroups/cpusets.txt 
> >         index f9ca389..1d7e978 100644 
> >         --- a/Documentation/cgroups/cpusets.txt 
> >         +++ b/Documentation/cgroups/cpusets.txt 
> >         @@ -777,6 +777,18 @@ in cpuset directories: 
> >          # /bin/echo 1-4 > cpus         -> set cpus list to cpus 
> >         1,2,3,4 
> >          # /bin/echo 1,2,3,4 > cpus     -> set cpus list to cpus 
> >         1,2,3,4 
> >          
> >         +To add a CPU to a cpuset, write the new list of CPUs 
> >         including the 
> >         +CPU to be added. To add 6 to the above cpuset: 
> >         + 
> >         +# /bin/echo 1-4,6 > cpus       -> set cpus list to cpus 
> >         1,2,3,4,6 
> >         + 
> >         +Similarly to remove a CPU from a cpuset, write the new list 
> >         of CPUs 
> >         +without the CPU to be removed. 
> >         + 
> >         +To remove all the CPUs: 
> >         + 
> >         +# /bin/echo "" > cpus          -> clear cpus list 
> >         + 
> >          2.3 Setting flags 
> >          ----------------- 
> >          
> >          
> >          
> >          
> >         -- 
> >         To unsubscribe from this list: send the line "unsubscribe 
> >         linux-kernel" in 
> >         the body of a message to majordomo@vger.kernel.org 
> >         More majordomo info at 
> >          http://vger.kernel.org/majordomo-info.html 
> >         Please read the FAQ at  http://www.tux.org/lkml/  
> >  
> >  
> >  
> > --  
> > Regards & Thanks-- 
> > Subrata  
> > ------------------------------------------------------------------------------ 
> > Crystal Reports - New Free Runtime and 30 Day Trial 
> > Check out the new simplified licensing option that enables unlimited 
> > royalty-free distribution of the report engine for externally facing  
> > server and web deployment. 
> > http://p.sf.net/sfu/businessobjects 
> > _______________________________________________ Ltp-list mailing list  
> Ltp-list@lists.sourceforge.net  
> https://lists.sourceforge.net/lists/listinfo/ltp-list 
>  
>  


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
