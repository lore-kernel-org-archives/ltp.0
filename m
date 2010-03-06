Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NnrXw-00085h-V0
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 10:47:48 +0000
Received: from mail-bw0-f219.google.com ([209.85.218.219])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NnrXv-0001SU-Qx
	for ltp-list@lists.sourceforge.net; Sat, 06 Mar 2010 10:47:48 +0000
Received: by bwz19 with SMTP id 19so1160413bwz.6
	for <ltp-list@lists.sourceforge.net>;
	Sat, 06 Mar 2010 02:47:38 -0800 (PST)
Message-ID: <4B922D86.70704@petalogix.com>
Date: Sat, 06 Mar 2010 11:25:10 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<201003051635.50233.vapier@gentoo.org>
In-Reply-To: <201003051635.50233.vapier@gentoo.org>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, jburke@redhat.com, ambar.seksena@calsoftinc.com, kamaleshb@in.ibm.com, doug.chapman@hp.com, risrajak@in.ibm.com, Cai Qian <qcai@redhat.com>, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

Mike Frysinger wrote:
> On Saturday 27 February 2010 02:53:48 Rishikesh K Rajak wrote:
>> We are in process of changing our sf.net host repository to
>> GIT from CVS.[ Any input/discussion on this is highly appreciable ].
> 
> the authorship info really should be fixed before anything is finalized.  and 
> a git hook added to reject people pushing patches that lack proper 
> author/committer fields.  these commits by "root" are a good example of things 
> that should not be happening.

Agree. Do you know about any manual how to fix it by any script or setup 
that conversion? I mean to have any convert table where for example will 
be written conversion:
vampier -> Mike Frysinger.
root -> Subrata Modak

Michal

> -mike
> 
> 
> ------------------------------------------------------------------------
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
