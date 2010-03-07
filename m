Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1No56Z-0004oh-Lt
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 01:16:27 +0000
Received: from mail-pz0-f197.google.com ([209.85.222.197])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1No56Y-0002Ey-Ss
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 01:16:27 +0000
Received: by pzk35 with SMTP id 35so815490pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 06 Mar 2010 17:16:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B922D86.70704@petalogix.com>
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<201003051635.50233.vapier@gentoo.org> <4B922D86.70704@petalogix.com>
Date: Sat, 6 Mar 2010 17:16:21 -0800
Message-ID: <364299f41003061716t5b2a4597oea20b28f76aeeaad@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, ambar.seksena@calsoftinc.com, kamaleshb@in.ibm.com, doug.chapman@hp.com, risrajak@in.ibm.com, Cai Qian <qcai@redhat.com>, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, jburke@redhat.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

On Sat, Mar 6, 2010 at 2:25 AM, Michal Simek <michal.simek@petalogix.com> w=
rote:
> Mike Frysinger wrote:
>> On Saturday 27 February 2010 02:53:48 Rishikesh K Rajak wrote:
>>> We are in process of changing our sf.net host repository to
>>> GIT from CVS.[ Any input/discussion on this is highly appreciable ].
>>
>> the authorship info really should be fixed before anything is finalized.=
 =A0and
>> a git hook added to reject people pushing patches that lack proper
>> author/committer fields. =A0these commits by "root" are a good example o=
f things
>> that should not be happening.
>
> Agree. Do you know about any manual how to fix it by any script or setup
> that conversion? I mean to have any convert table where for example will
> be written conversion:
> vapier -> Mike Frysinger.
> root -> Subrata Modak

One of the root commits was me by accident (sorry...), so I think that
any commits outside of the users with actual write access to the repo
should be rejected.

If git-config isn't setup properly it will complain about usernames,
email, etc; is it possible for a hook to be added, s.t. this becomes a
hard requirement and any proposed commits will be rejected?

git is a cool tool but it lacks complete, easy-to-understand
directions, as it assumes that end-users have been working with git
(or the previous SCM used by kernel.org) for a while... It would be
nice if someone could help provide these directions and they could be
committed back to kernel.org.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
