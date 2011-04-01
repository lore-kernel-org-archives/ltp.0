Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <aelder@sgi.com>) id 1Q5mPQ-0000Rn-OC
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:36 +0000
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1Q5mPP-0007lV-T4
	for ltp-list@lists.sourceforge.net; Fri, 01 Apr 2011 22:01:36 +0000
From: Alex Elder <aelder@sgi.com>
Date: Fri,  1 Apr 2011 17:01:22 -0500
Message-Id: <1301695288-24912-1-git-send-email-aelder@sgi.com>
Subject: [LTP] [PATCH 0/6] ltp: kill off some compile warnings
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The motivation for this series of patches is to eliminate build
warnings in files under "testcases/kernel/fs/doio/".  The main
reason warnings are emitted is that most functions are defined using
old-style C syntax.  So most of the changes amount to updating such
functions to use standard C prototypes.

The first patch fixes a buggy header file.  The next one gathers
type definitions to the top of "doio.c" so they are defined when
needed in declaring all the function prototypes.

The last patch enables the "-Wall" flag to gcc for these files.

					-Alex

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
