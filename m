Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXbVB-00081m-GR
	for ltp-list@lists.sourceforge.net; Tue, 08 Apr 2014 19:16:09 +0000
Date: Tue, 8 Apr 2014 21:15:25 +0200
From: chrubis@suse.cz
Message-ID: <20140408191525.GA8069@rei>
References: <1395311334-22330-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140408182052.GA5854@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140408182052.GA5854@rei>
Subject: Re: [LTP] [PATCH v3] testscripts/test_robind.sh: cleanup and make
 some fixes
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I've fixed the script to be POSIX shell compatible (see diff below) and added a
> followup patch to move the test_robind.sh script to
> testcases/kernel/fs/fs_readonly because the runtest file does not work when
> it's in  testscripts directory which is not in $PATH.

And also moved the cleanup definition after the tst_tmpdir because
otherwise you get an error if some of the checks before tst_tmpdir
fails. We may also add the cleanup to ctrl+c trap.

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
