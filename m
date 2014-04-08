Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXSmC-0008F6-If
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 09:57:08 +0000
Date: Tue, 8 Apr 2014 11:56:24 +0200
From: chrubis@suse.cz
Message-ID: <20140408095624.GA7530@rei.Home>
References: <1387812348-23017-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1387812348-23017-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140407181236.GA8332@rei> <5343A0AC.6010803@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5343A0AC.6010803@oracle.com>
Subject: Re: [LTP] [PATCH 2/3] rpc01: moved common functions to a lib
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
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> But why to /usr/lib{,64}?

That depends on parameters passed to configure, in this case that was
rpmbuild %configure macro and rpm build system that reported unpackaged
files.

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
