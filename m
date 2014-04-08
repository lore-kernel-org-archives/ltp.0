Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXU4T-00072V-NU
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 11:20:05 +0000
Date: Tue, 8 Apr 2014 13:19:20 +0200
From: chrubis@suse.cz
Message-ID: <20140408111920.GA8556@rei>
References: <1392862246.1997.6.camel@G08JYZSD130126>
	<1396944482.2100.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1396944482.2100.1.camel@G08JYZSD130126>
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
Applied for now, thanks.

Howvever if I remeber correctly the past discussion we do not strictly
need system unused uid and gid in the  setregid02 and setregid03
testcases and the failures were caused by the clash between nobody uid
and arbitrary constatnt hardcoded into the source.

If I understand this correctly all need is a uid/gid different from the
nobody user used for the testing, right?

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
