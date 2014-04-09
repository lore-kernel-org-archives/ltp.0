Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXtfc-00088H-3N
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 14:40:08 +0000
Date: Wed, 9 Apr 2014 16:39:20 +0200
From: chrubis@suse.cz
Message-ID: <20140409143920.GC22137@rei>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<1396944482.2100.1.camel@G08JYZSD130126>
	<20140408111920.GA8556@rei> <5344069B.8010101@oracle.com>
	<20140408144954.GA1841@rei> <20140408155251.GA3201@rei>
	<5344E5C8.3070306@oracle.com> <20140409130842.GA5712@rei>
	<53454939.2030704@oracle.com> <20140409132320.GC5712@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140409132320.GC5712@rei>
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
> > Just to make it clear. Are you going to remove it by yourself? Or do you 
> > want me to prepare a patch for this?
> > 
> > Actually, I would like the first option :)
> 
> OK, I will remove them.

And, done.

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
