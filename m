Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nn4om-0002cV-QJ
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 06:45:56 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nn4ol-00021k-PL
	for ltp-list@lists.sourceforge.net; Thu, 04 Mar 2010 06:45:56 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o246Yhnc016131
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 01:34:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o246jnGC112134
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 01:45:49 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o246jnpK026300
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Mar 2010 03:45:49 -0300
Date: Thu, 4 Mar 2010 12:15:44 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100304064544.GA11885@linux.vnet.ibm.com>
References: <4B8E3B7F.8050301@calsoftinc.com>
	<20100303124352.GD23601@linux.vnet.ibm.com>
	<4B8E5DF3.7090502@calsoftinc.com>
	<9debc4411003030900t971da33pfbe9ea4e994d74d4@mail.gmail.com>
	<BD77C355-AF47-4A92-8231-145DDBC8F54D@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BD77C355-AF47-4A92-8231-145DDBC8F54D@gmail.com>
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Shwetabh <shwetabh.goel@calsoftinc.com>

On Wed, Mar 03, 2010 at 03:16:47PM -0800, Garrett Cooper wrote:
> On Mar 3, 2010, at 9:00 AM, Maxin John <maxin.john@gmail.com> wrote:
> 
> > Hi Shwetabh,
> >
> >> 3. Went to /opt/ltp directory and tried to execute cpuhotplug test:
> >> [root@localhost ~]# cd /opt/ltp/
> >> [root@localhost ltp]# ./runltp -f cpuhotplug
> >>
> >
> > Please find attached the quick 'n' dirty patch
> > (cpu_hotplugin_makefile.patch) to execute cpuhotplugin test.
> > I have observed that the 'hotplug' directory is not included in
> > "testcases/kernel/Makefile". I have also
> > created a Makefile in 'hotplug/cpu_hotplug' directory.
> >
> > After applying this patch, I have followed the usual ./configure;
> > make; sudo make install steps and executed
> > the cpuhotplug test and observed the below given output . It seems
> > like the test execution is "not so good" in
> > my machine. Your mileage may vary.
> >
> > Garret,Rishi, please review the patch and let me know your comments.
> >
> > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> 
> It looks better but it's going to need a minor amount of fudging in  
> the scripts to source the appropriate scripts to execute cpuhotplug's  
> tests... I'll pick this up tomorrow if it's not done by then...

Yes it looks better, i have tested it and true there are still some
problem with testcase, can you look very closely and try to find the
root cause for that ? Since this patch is important to run cpuhotplug
testcases, i have included this to master branch.

Acked & Tested-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>

-Rishi

> Thanks,
> -Garrett
-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
