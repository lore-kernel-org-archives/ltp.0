Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jburke@redhat.com>) id 1P3aeW-0005K3-55
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 20:31:52 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P3aeU-0007DG-Dn
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 20:31:52 +0000
Date: Wed, 6 Oct 2010 16:31:44 -0400 (EDT)
From: Jeffrey Burke <jburke@redhat.com>
Message-ID: <1001719682.1339131286397104227.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1229185166.1336871286396286678.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] Current state of the selinux tests in ltp-full-20100831
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
To: ltp-list@lists.sf.net
Cc: sds@tycho.nsa.gov

Folks,
 It has been a while since I update LTP for selinux testing. I am currently trying to use ltp-full-20100831 on RHEL5.6. I don't believe the procedure has changed at least according to the README. But here are the steps I followed.

1.) tar -xvf ltp-full-20100831.tar
2.) pushd ltp-full-20100831; ./configure; popd
3.) make -C ltp-full-20100831 all
4.) make -C ltp-full-20100831 install
5.) pushd; make ltp-full-20100831/testcases/kernel/security/selinux-testsuite/tests; popd
6.) pushd ltp-full-20100831/testcases/kernel/security/selinux-testsuite/tests; make install; popd
7.) cd ./ltp-full-20100831
8.) ./testscripts/test_selinux.sh

Here is the error:
# ./testscripts/test_selinux.sh 
Running with security context=root:system_r:unconfined_t:SystemLow-SystemHigh
allow_domain_fd_use --> off
allow_domain_fd_use exists setting
Installing test_policy module...
semodule:  Could not read file '/mnt/tests/kernel/distribution/ltp/20100831/ltp-full-20100831/testcases/kernel/security/selinux-testsuite/refpolicy/test_policy.pp': No such file or directory
Failed to install test_policy module, aborting test run.

Is anyone using this version on RHEL5 successfully?
Am I missing an important step that will allow us to use the test_selinux.sh in this LTP version?

I did see the thread:
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg10290.html
Using the GIT version and following these steps:
 - git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
 - make -C policy load
 - make -C tests test
 - make -C policy unload
Does work fine.

Thanks in advance.
Jeff

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
