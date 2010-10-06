Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P3b5g-0007Rd-18
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 20:59:56 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P3b5e-0004wY-Bt
	for ltp-list@lists.sourceforge.net; Wed, 06 Oct 2010 20:59:56 +0000
Date: Wed, 6 Oct 2010 15:59:49 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101006205949.GA28624@hallyn.com>
References: <1229185166.1336871286396286678.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<1001719682.1339131286397104227.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1001719682.1339131286397104227.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] Current state of the selinux tests in ltp-full-20100831
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
To: Jeffrey Burke <jburke@redhat.com>
Cc: ltp-list@lists.sf.net, sds@tycho.nsa.gov

Quoting Jeffrey Burke (jburke@redhat.com):
> Folks,
>  It has been a while since I update LTP for selinux testing. I am currently trying to use ltp-full-20100831 on RHEL5.6. I don't believe the procedure has changed at least according to the README. But here are the steps I followed.
> 
> 1.) tar -xvf ltp-full-20100831.tar
> 2.) pushd ltp-full-20100831; ./configure; popd
> 3.) make -C ltp-full-20100831 all
> 4.) make -C ltp-full-20100831 install
> 5.) pushd; make ltp-full-20100831/testcases/kernel/security/selinux-testsuite/tests; popd
> 6.) pushd ltp-full-20100831/testcases/kernel/security/selinux-testsuite/tests; make install; popd

I don't have ltp source in front of me, but I think there are two
problems here.  The first is that you don't make policy, as you do
below with the kernel.org git tree.

> 7.) cd ./ltp-full-20100831
> 8.) ./testscripts/test_selinux.sh

The second is that you're executing the test out of the source dir.  LTP
now runs out of /opt/ltp.  I *think* the same is also true for the selinux
testsuite.

So can you do:

	pushd ltp-full-20100831/testcases/kernel/security/selinux-testsuite/policy
	make && make install
	popd
	cd /opt/ltp
	./testscripts/test_selinux.sh

?

-serge

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
