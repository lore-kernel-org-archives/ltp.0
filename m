Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1Nptv2-0001Kd-59
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 01:44:04 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1Nptv1-0002Uk-0S@sfs-web-6.v29.ch3.sourceforge.com>
Date: Fri, 12 Mar 2010 01:44:03 +0000
Subject: [LTP] [ ltp-Bugs-2969069 ] lcov: Fix for "WARNING: cannot find an
	entry for" problem
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

Bugs item #2969069, was opened at 2010-03-12 01:44
Message generated for change (Tracker Item Submitted) made by 
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2969069&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: None
Group: None
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: https://www.google.com/accounts ()
Assigned to: Nobody/Anonymous (nobody)
Summary: lcov: Fix for "WARNING: cannot find an entry for" problem

Initial Comment:
match_filename fails when the filenames in @list contain /../ components.  This causes warnings like "geninfo: WARNING: cannot find an entry for ... in .gcno file, skipping file!" and "geninfo: WARNING: no data found for ...".

Patched match_filename to use solve_relative_path to remove the /../ and /./ components of the path before comparing.  It still returns the original "entry", otherwise you still get the "no data found for" failures.

May not be the most elegant fix but it works for me.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=2969069&group_id=3382

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
