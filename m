Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <noreply@sourceforge.net>) id 1OQwSz-0003Lj-BB
	for ltp-list@lists.sourceforge.net; Tue, 22 Jun 2010 05:56:13 +0000
From: "SourceForge.net" <noreply@sourceforge.net>
Mime-Version: 1.0
Message-Id: <E1OQwSz-0002lN-5P@sfs-web-9.v29.ch3.sourceforge.com>
Date: Tue, 22 Jun 2010 05:56:13 +0000
Subject: [LTP] [ ltp-Bugs-3019408 ] lcov failed to anaylze "return"
	statement after goto label
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

Bugs item #3019408, was opened at 2010-06-22 05:56
Message generated for change (Tracker Item Submitted) made by 
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3019408&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Tools
Group: Miscellaneous
Status: Open
Resolution: None
Priority: 5
Private: No
Submitted By: https://www.google.com/accounts ()
Assigned to: Nobody/Anonymous (nobody)
Summary: lcov failed to anaylze "return" statement after goto label

Initial Comment:
code like,
-------------------------


       1                 :            : 
       2                 :            : #include <stdio.h>
       3                 :            : 
       4                 :            : 
       5                 :          1 : int main()
       6                 :            : {
       7                 :          1 :         int n = 199;
       8                 :          1 :         int i = 0;
       9                 :            : 
      10         [ +  + ]:        200 :         for (i = 0; i < n; i++) {
      11                 :        199 :                 printf("gcov goto testing %d/199\n", i + 1);
      12                 :            :                 
      13         [ -  + ]:        199 :                 if (i < 0) {
      14                 :          0 :                         goto fail;
      15                 :            :                 }
      16                 :            :         }
      17                 :            :         
      18                 :          1 :         return 0;
      19                 :            : 
      20                 :            : fail:
      21                 :          1 :         return -1;
      22                 :            :         
      23                 :            : }
      24                 :            : 
--------------------------

on line 21, lcov definitely did wrong.

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3019408&group_id=3382

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
