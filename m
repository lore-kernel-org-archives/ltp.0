Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NoVzC-0007nA-10
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 05:58:38 +0000
Received: from mail-iw0-f202.google.com ([209.85.223.202])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NoVzB-0004ID-61
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 05:58:37 +0000
Received: by iwn40 with SMTP id 40so683875iwn.1
	for <ltp-list@lists.sourceforge.net>;
	Sun, 07 Mar 2010 21:58:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201003071312.58906.vapier@gentoo.org>
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<201003061633.16026.vapier@gentoo.org>
	<4B93EBBC.5070004@petalogix.com>
	<201003071312.58906.vapier@gentoo.org>
Date: Sun, 7 Mar 2010 21:58:31 -0800
Message-ID: <364299f41003072158l7e74650r429b4502b07ce570@mail.gmail.com>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, ambar.seksena@calsoftinc.com, Cai Qian <qcai@redhat.com>, kamaleshb@in.ibm.com, doug.chapman@hp.com, risrajak@in.ibm.com, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, jburke@redhat.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

On Sun, Mar 7, 2010 at 10:12 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Sunday 07 March 2010 13:09:00 Michal Simek wrote:
>> Anyway don't you have another script which will check commit message and
>> if is there Signed-off-by line then change author name?
>> There are a lot of commits with that line and will be good to fix this too.
>> Adding some new lines to commit messages (At least before Sign-off-by
>> line) make sense too.
>
> i dont have any such script, and i'm not sure it's a good idea ...

Agreed. I was originally thinking of something similar with the
committers yesterday and the git config values, but even that's
overengineered, IMO.
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
