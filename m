Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PPgrL-0001v3-3e
	for ltp-list@lists.sourceforge.net; Mon, 06 Dec 2010 19:36:27 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D1BF093F19
	for <ltp-list@lists.sourceforge.net>;
	Mon,  6 Dec 2010 20:36:16 +0100 (CET)
Date: Mon, 6 Dec 2010 20:49:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101206194946.GA12546@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] open posix testsuite fork 7-1.c
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

Hi!
The fork 7-1 testcase tests that child gets a copy of the parent message
catalog descriptor. For that the test creates catalog from file
messcat_src.txt that is not being installed now and even if would be,
the test has wrong hardcoded path, so we have two options here:

* fix the makefile generator so the file gets installed and then fix the
  test to find the input file

* make the test self-contained so it creates and fills the input file,
  generates message catalog, opens it, forks ...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
