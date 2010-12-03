Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1POd6Z-0006iD-PV
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 21:23:47 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1POd6Z-0000bX-Cs@sfs-web-6.v29.ch3.sourceforge.com>
Date: Fri, 03 Dec 2010 21:23:47 +0000
Subject: [LTP] [ ltp-Bugs-3126942 ] cpuset tests should use nftw() instead
	of fts_*()
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
To: noreply@sourceforge.net

Bugs item #3126942, was opened at 2010-12-03 22:23
Message generated for change (Tracker Item Submitted) made by tpetazzoni
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3126942&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Other
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: Thomas Petazzoni (tpetazzoni)
Assigned to: Nobody/Anonymous (nobody)
Summary: cpuset tests should use nftw() instead of fts_*()

Initial Comment:
The cpusets tests use the fts_*() family of functions for tree traversal. Unfortunately, this family of functions is not compatible with Large File Support (to support files larger than 2 GB on 32 bits systems). From /usr/include/fts.h:


/* The fts interface is incompatible with the LFS interface which
   transparently uses the 64-bit file access functions.  */
#ifdef __USE_FILE_OFFSET64
# error "<fts.h> cannot be used with -D_FILE_OFFSET_BITS==64"
#endif

The nftw() function can be used for tree traversal instead.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3126942&group_id=3382

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
