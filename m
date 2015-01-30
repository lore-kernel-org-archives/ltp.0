Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YHCPG-0006lQ-He
	for ltp-list@lists.sourceforge.net; Fri, 30 Jan 2015 14:18:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YHCPE-0002ds-Ie
	for ltp-list@lists.sourceforge.net; Fri, 30 Jan 2015 14:18:46 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0UEIbmQ032290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 30 Jan 2015 09:18:37 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t0UEIasD023428
	for <ltp-list@lists.sourceforge.net>; Fri, 30 Jan 2015 09:18:37 -0500
Message-ID: <54CB92BC.8020605@redhat.com>
Date: Fri, 30 Jan 2015 15:18:36 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] the mandatory (?) nature of testscripts
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

Hello all,
I normally execute the ltp suite using runltp with -f, specifying just
the runtest files I want to execute, possibly even writing my own ones
and using the fact that runltp detects absolute paths in the comma-
separated list and looks for them outside /opt/ltp.

From this viewpoint, and also looking at things like
testscripts/syscalls.sh, this approach seems perfectly valid (there's
at least nothing against it in the documentation, as far as I can tell).
My impression was therefore that testscripts are just convenient
(or legacy?) ways to run big chunks of the suite.

However then I found testscripts/network.sh and all the "mandatory"
variables it exports - not using it resulted in the ping01 test failing
due to recent rewrite in cbab2eed06. And, as it turns out, network.sh
is not alone.

Therefore I would like to ask (since I didn't find this documented);
is running individual tests via runltp -f something "officially"
supported and the network tests should be altered to get their defaults
in another way, or is runltp -f wild west and I'm on my own, with the
only supported way to run the suite being the testscripts?

Thanks,
Jiri

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
