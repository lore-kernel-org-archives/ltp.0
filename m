Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NnV5W-0001Qj-4E
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 10:48:58 +0000
Received: from fg-out-1718.google.com ([72.14.220.158])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnV5T-0008A7-OZ
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 10:48:58 +0000
Received: by fg-out-1718.google.com with SMTP id d23so726069fga.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 05 Mar 2010 02:48:49 -0800 (PST)
Message-ID: <4B90D9BA.2030803@petalogix.com>
Date: Fri, 05 Mar 2010 11:15:22 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <20100227075348.GA3077@linux.vnet.ibm.com>
In-Reply-To: <20100227075348.GA3077@linux.vnet.ibm.com>
Subject: Re: [LTP] A note from Maintainer
Reply-To: michal.simek@petalogix.com
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
To: ltp-list@lists.sourceforge.net, yanegomi@gmail.com, risrajak@in.ibm.com, "Serge E. Hallyn" <serue@us.ibm.com>, Kumar Gala <galak@kernel.crashing.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, Cai Qian <qcai@redhat.com>, Masatake YAMATO <yamato@redhat.com>, jburke@redhat.com, sachinp@linux.vnet.ibm.com, paul.larson@canonical.com, Mike Frysinger <vapier@gentoo.org>, Khem Raj <kraj@mvista.com>, carmelo.amoroso@st.com, Nadia Derbey <Nadia.Derbey@bull.net>, doug.chapman@hp.com, ambar.seksena@calsoftinc.com, aneesh.kumar@linux.vnet.ibm.com, kamaleshb@in.ibm.com

Rishikesh K Rajak wrote:
> Welcome to ltp community.
> 
> We are in process of changing our sf.net host repository to
> GIT from CVS.[ Any input/discussion on this is highly appreciable ]. If
> possible this month end release may get delayed based on responses from 
> list or next month end (i.e: March ) release will be based on git tree.
> 
> I usually try to read all patches posted to ltp mailing list, and follow
> almost all discussions on list, unless the topic is about an obscure
> corner that i do not personally use. But i am obviously not perfect.If
> you sent a patch that you did not hear from anybody for three days, 
> that is a very good indication that it was dropped on the floor --- please 
> do not hesitate to remind me.
> 
> The list archive is available at:
> 
> http://marc.info/?l=ltp-list&r=1&w=2
> 
> 
> Please use this public site to point out messages in mailing list if you
> want to remind someone or again start same thread without altering
> subject line.
> 
> Now coming to git transformation this month, you can find gitweb
> interface at :
> 
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=summary
> 
> There are four branches in ltp-dev.git repository that track the source tree
> of ltp: "master", "maint", "next", "pu". I may add more maintanance
> branch if we have huge backward of incompatible feature updates in the
> future to keep an older release alive.
> 
> The master branch is meant to contain what are very well tested and
> ready to be used in production environment. There could occassionaly be
> minor breakage but they are not expected to be anything major, and more
> importantly those will be quickly and trivially fixable.
> 
> So if some hotfixes has gone with this branch, you can find one more
> digit has been added to version release (e.g: YYYYMMDD.1 ), So it means
> it is more stable than YYYYMMDD release. I may be changing this format
> if i can see a better format or if you have some suggestion then it is
> most welcome.
> 
> The "maint" branch is called one step before master branch, which will
> contain all features or patches that are going to following month end
> release.
> (e.g: If this month end ltp-full-YYYYMMDD is going be to released
> then all the stable patches you can find in this branch through out the
> month, and one important point for this branch is all the patches which
> has gone to this branch will be well tested and make sure that there is
> no regression or breakage and Acked/Reviewed by Someone from mailing
> list.)
> 
> "next" branch will contain all the patches which has been sent on
> ltp-mailing list after getting "Acked-By" and/or "Reviewed-By" anyone
> from list. This branch is quite unstable but user can find their 
> immediate patches over here to see the stability.You can find most 
> unstable about this branch w.r.t feature wise or may be sometime build wise. 
> 
> 
> NOTE:
> =====
> So i always encourage testcase developer/ltp-list member to send me the
> patches against this branch. And it will be closely reviewed and
> acknowledged by any member from ltp-list community members. Once it gets
> Acked/Reveiwed-By then it will promoted to maint branch for maintainer
> testing and checking for stability, otherwise it will go to "pu" branch
> for further discussion and decision. These pending patch can be worked
> on following month and once it is mature enough to meet the stability
> then it can be directly jump to maint branch, here i may ask the
> submitter to submit the patch once again against maint branch.
> 
> "pu" branch is basically "proposed update" branch which will contain all
> the remainder of above branches. By the above definition of how "next"
> works, you can tell that this branch will contain quite experimental and
> obviosuly broken stuff.
> 
> I would like to thanks everybody who helped me to release ltp-dev git into
> current shape. Especially i would like to thank following:
>     - git.git from where actually i picked up this branch
>       identification.
>     - Garret, who has worked with me step by step to release this git
>       tree implementation to ltp-list@.
>     - All my team member from IBM who basically gave encourageable
>       input and specially Aneesh, Subrata, Iranna & kamalesh.
>     - And finally to Linux kernel, who motivated me to maintain such a
>       testsuits with git.
> 
> This Maintainer Note will be available under doc/MaintNotes of
> month end release.
> 
> 
> Usage:
> 
> #git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev
> (Make sure you have the latest autoconf/automake before running make
> autotools )
> #make autotools
> #./configure
> #make
> #make install
> #cd /opt/ltp
> #./runltp
> 
> Please do not hesitate to reply this mail if you have any query in your
> mind, it may help me to generate a good FAQ :) .
> 
> Happy Testing!!!

Nice. I briefly looked at git via gitweb and will be good to add some 
more tags. I prefer to add different tag than you used. For example for 
this comming will be good to use tag "LTP-20100228"
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commitdiff;h=c288167e111d34d5146dbbe5ebb19c84153ee67b

And also will be good to call that commit in better way - not "Fixed the 
typo in changelog".

There are several funny commits too ( for example: 
2279bf46ad12b3e75c512e9f146bc60a49220444, 
dfac29ccbb03db3e4ee3fa5674cbbbf0104b08aa and others).

I hope that there will be the correct description in commit message. For 
example this commit message should be better.
http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=commitdiff;h=c0e37ca6731cada152573522d48d08513029e44a

Anyway. I like that ltp was moved to git.

Thanks for that,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

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
