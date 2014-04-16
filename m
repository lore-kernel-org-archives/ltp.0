Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WaTdJ-0007WY-So
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 17:28:25 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WaTdH-00059U-SA
	for ltp-list@lists.sourceforge.net; Wed, 16 Apr 2014 17:28:25 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Wed, 16 Apr 2014 19:27:57 +0200
Message-ID: <1397669278-848-1-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <20140416091527.40612b3c@mats-desktop>
References: <20140416091527.40612b3c@mats-desktop>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Make SAFE_* calls more informative when failing
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


When debugging failing test cases I often missed what parameters were used in
those SAFE_* calls. This patch is meant to fix this.

The output has been "standardized" into the following format:
<file>:<line>: <func>(<params>) <error message>

E.g.:
test.c:130: chdir(mydir) failed

This will then be followed by the usual errno stuff if applicable.

The code compiles, but I haven't figured out a good way of testing it. The
changes are pretty simple however.

Regards
Mats Liljegren

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
