Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1No5FT-0004DC-K1
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 01:25:39 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1No5FS-0003cF-PR
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 01:25:39 +0000
Received: by pwi5 with SMTP id 5so2822711pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 06 Mar 2010 17:25:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100227075348.GA3077@linux.vnet.ibm.com>
References: <20100227075348.GA3077@linux.vnet.ibm.com>
Date: Sat, 6 Mar 2010 17:25:32 -0800
Message-ID: <364299f41003061725p33b15a59hc89fce80be0746f5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] A note from Maintainer
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

On Fri, Feb 26, 2010 at 11:53 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> Welcome to ltp community.
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

As suggested before, branching maint off of master and labeling
appropriately is be the best way to go as it keeps things simple.
Having a release label suffixed with a revision number would be the
best way, and once the next release comes out, any `maintenance' fixes
that could go into prior releases shouldn't and won't (again, to avoid
branching and labeling messes).

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

Getting back to this message, I honestly think that we shouldn't allow
for `pu' branches because the number of commits going into `next' is
still relatively small, meaning that having too many branches will
make us dyslexic and we'll fail to test changes properly. It is the
job of everyone proposing a commit to fully test it, if at all
possible, and for cases where they can't they provide a patch and
others who can test it could and should test it (I know this is a
highly ideal case and it's something that I'm going to hold myself to
more going forward, now that we're moving away from cvs).

Thanks,
-Garrett

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
