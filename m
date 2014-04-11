Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WYeSE-0002Q2-Hk
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 16:37:26 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WYeSC-0000fh-Ma
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 16:37:26 +0000
Date: Fri, 11 Apr 2014 18:37:12 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140411183712.7ca33b6c@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] Problems compiling
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
To: ltp-list@lists.sourceforge.net

I recently updated my master branch of my ltp git repository, but I now
have a compile error:

make[6]: Entering directory `/nfs/hosts/sestonas06/homes/mlil/git/ltp/testcases/kernel/mem/lib'
make[6]: ../../../../../testcases/kernel/mem/lib/Makefile: No such file or directory

Anyone else having this problem?

Best regards
Mats Liljegren

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
