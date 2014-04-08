Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXXME-0001Qf-45
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 14:50:38 +0000
Date: Tue, 8 Apr 2014 16:49:54 +0200
From: chrubis@suse.cz
Message-ID: <20140408144954.GA1841@rei>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<1396944482.2100.1.camel@G08JYZSD130126>
	<20140408111920.GA8556@rei> <5344069B.8010101@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5344069B.8010101@oracle.com>
Subject: Re: [LTP] [PATCH] lib/tst_uid_gid.c: fix checking return value
 errors about getpwuid_r/getgrgid_r
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > Applied for now, thanks.
> >
> > Howvever if I remeber correctly the past discussion we do not strictly
> > need system unused uid and gid in the  setregid02 and setregid03
> > testcases and the failures were caused by the clash between nobody uid
> > and arbitrary constatnt hardcoded into the source.
> 
> setregid03 doesn't use GET_UNUSED_GID(). That time we talked about 
> setregid02 and setresuid03.

Right, git grep GET_UNUSED shows these two.

> > If I understand this correctly all need is a uid/gid different from the
> > nobody user used for the testing, right?
> >
> Yes.
> 
> And, actually, bin.gr_gid is equivalent to inval_user for purposes of 
> setregid02 testing.
> 
> Therefore, theoretically, we can cut off:
>          &inval_user, &neg_one, EINVAL, &nobody, &nobody,
>                      "After setregid(invalid group, -1),"}, {
>          &neg_one, &inval_user, EINVAL, &nobody, &nobody,
>                      "After setregid(-1, invalid group),"},};
> 
> from there.

Hmm, as far as I can see the the error for bin.gr_gid is EPERM, while
invalid user test expect EINVAL, so something must be different.

And it looks like you can really get EINVAL in the setregid() in
kernel/sys.c. And that it depends on namespace mappings. See
kernel/user_namespace.c make_kgid() that calls map_id_down(), although I
haven't yet figured out exact conditions yet.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
