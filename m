Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXsFq-0003sT-JF
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 13:09:26 +0000
Date: Wed, 9 Apr 2014 15:08:42 +0200
From: chrubis@suse.cz
Message-ID: <20140409130842.GA5712@rei>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<1396944482.2100.1.camel@G08JYZSD130126>
	<20140408111920.GA8556@rei> <5344069B.8010101@oracle.com>
	<20140408144954.GA1841@rei> <20140408155251.GA3201@rei>
	<5344E5C8.3070306@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5344E5C8.3070306@oracle.com>
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
> 
> Thank you very-very much.
> 
> It's not bad that we included GET_UNUSED* in LTP. Maybe somebody someday 
> will need it for their purposes... :)
>

I'm personaly for removing any unused code because

 * you may readd it later when needed because it's in the git history
 * there is a price for mantaining each line of code we have
 * and any unused code tend to break sooner or later

So I would rather see it removed now and I promise to readd it when we
found a purpose for it.

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
