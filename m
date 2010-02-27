Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NlHVA-0003Lz-Up
	for ltp-list@lists.sourceforge.net; Sat, 27 Feb 2010 07:54:16 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NlHV9-0000Wu-V2
	for ltp-list@lists.sourceforge.net; Sat, 27 Feb 2010 07:54:16 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1R7oxnA014507
	for <ltp-list@lists.sourceforge.net>; Sat, 27 Feb 2010 02:50:59 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1R7s9S6171024
	for <ltp-list@lists.sourceforge.net>; Sat, 27 Feb 2010 02:54:09 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1R7s7mn014345
	for <ltp-list@lists.sourceforge.net>; Sat, 27 Feb 2010 02:54:09 -0500
Date: Sat, 27 Feb 2010 13:23:48 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100227075348.GA3077@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] A note from Maintainer
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
Cc: sachinp@linux.vnet.ibm.com, doug.chapman@hp.com, Mike Frysinger <vapier@gentoo.org>, ambar.seksena@calsoftinc.com, kamaleshb@in.ibm.com, risrajak@in.ibm.com, Cai Qian <qcai@redhat.com>, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, jburke@redhat.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

Welcome to ltp community.

We are in process of changing our sf.net host repository to
GIT from CVS.[ Any input/discussion on this is highly appreciable ]. If
possible this month end release may get delayed based on responses from 
list or next month end (i.e: March ) release will be based on git tree.

I usually try to read all patches posted to ltp mailing list, and follow
almost all discussions on list, unless the topic is about an obscure
corner that i do not personally use. But i am obviously not perfect.If
you sent a patch that you did not hear from anybody for three days, 
that is a very good indication that it was dropped on the floor --- please 
do not hesitate to remind me.

The list archive is available at:

http://marc.info/?l=ltp-list&r=1&w=2


Please use this public site to point out messages in mailing list if you
want to remind someone or again start same thread without altering
subject line.

Now coming to git transformation this month, you can find gitweb
interface at :

http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=summary

There are four branches in ltp-dev.git repository that track the source tree
of ltp: "master", "maint", "next", "pu". I may add more maintanance
branch if we have huge backward of incompatible feature updates in the
future to keep an older release alive.

The master branch is meant to contain what are very well tested and
ready to be used in production environment. There could occassionaly be
minor breakage but they are not expected to be anything major, and more
importantly those will be quickly and trivially fixable.

So if some hotfixes has gone with this branch, you can find one more
digit has been added to version release (e.g: YYYYMMDD.1 ), So it means
it is more stable than YYYYMMDD release. I may be changing this format
if i can see a better format or if you have some suggestion then it is
most welcome.

The "maint" branch is called one step before master branch, which will
contain all features or patches that are going to following month end
release.
(e.g: If this month end ltp-full-YYYYMMDD is going be to released
then all the stable patches you can find in this branch through out the
month, and one important point for this branch is all the patches which
has gone to this branch will be well tested and make sure that there is
no regression or breakage and Acked/Reviewed by Someone from mailing
list.)

"next" branch will contain all the patches which has been sent on
ltp-mailing list after getting "Acked-By" and/or "Reviewed-By" anyone
from list. This branch is quite unstable but user can find their 
immediate patches over here to see the stability.You can find most 
unstable about this branch w.r.t feature wise or may be sometime build wise. 


NOTE:
=====
So i always encourage testcase developer/ltp-list member to send me the
patches against this branch. And it will be closely reviewed and
acknowledged by any member from ltp-list community members. Once it gets
Acked/Reveiwed-By then it will promoted to maint branch for maintainer
testing and checking for stability, otherwise it will go to "pu" branch
for further discussion and decision. These pending patch can be worked
on following month and once it is mature enough to meet the stability
then it can be directly jump to maint branch, here i may ask the
submitter to submit the patch once again against maint branch.

"pu" branch is basically "proposed update" branch which will contain all
the remainder of above branches. By the above definition of how "next"
works, you can tell that this branch will contain quite experimental and
obviosuly broken stuff.

I would like to thanks everybody who helped me to release ltp-dev git into
current shape. Especially i would like to thank following:
    - git.git from where actually i picked up this branch
      identification.
    - Garret, who has worked with me step by step to release this git
      tree implementation to ltp-list@.
    - All my team member from IBM who basically gave encourageable
      input and specially Aneesh, Subrata, Iranna & kamalesh.
    - And finally to Linux kernel, who motivated me to maintain such a
      testsuits with git.

This Maintainer Note will be available under doc/MaintNotes of
month end release.


Usage:

#git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev
(Make sure you have the latest autoconf/automake before running make
autotools )
#make autotools
#./configure
#make
#make install
#cd /opt/ltp
#./runltp

Please do not hesitate to reply this mail if you have any query in your
mind, it may help me to generate a good FAQ :) .

Happy Testing!!!
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
