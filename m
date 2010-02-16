Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Message-ID: <4B7AA4F1.1070408@linux.vnet.ibm.com>
Date: Tue, 16 Feb 2010 19:30:17 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for Jan
 2010 which contains few hot fixes
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
To: LTP <ltp-list@lists.sourceforge.net>, ltp-announce@lists.sourceforge.net, ltp-results@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: ", subrata@linux.vnet.ibm.com,  svishuku@in.ibm.com, iranna.ankad@in.ibm.com,  sachinp@linux.vnet.ibm.com, deepakraj@in.ibm.com,  Balbir Singh <balbir@linux.vnet.ibm.com>,  risrajak@in.ibm.com"@d28av02.in.ibm.com

Hi All,

This is with reference of mail ( 
http://marc.info/?l=ltp-list&m=126502188611737&w=2 ) which has been sent 
starting of this month by Subrata. I came to know ltp-list@ is facing 
major problem while doing make clean of ltp-full-20100131 release. So i 
have planned to release a subversion of LTP Jan'10 Release which 
contains fix for the problem ( 
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09427.html ).

Though the workaround has been sent by Garret ( "Thanks Garret" ) ( 
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09430.html 
) but i feel this patch is good enough to go to as soon as possible.

ChangeLog:
     - Fixes which has been committed between 1stFeb to 6th Feb to CVS.

The latest version of the test-suite contains 3000+ tests for the Linux 
OS and can be found at:
http://ltp.sourceforge.net/,
Latest happenings in LTP can also be found at:
http://ltp.sourceforge.net/wiki/,
http://ltp.sourceforge.net/wikiArchives.php, and,
IRC: irc.freenode.org #ltp.


We would encourage the community to post results to 
ltp-results@lists.sf.net,
patches, new tests, bugs or comments/questions to ltp-list@lists.sf.net,
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=103382 
<http://sourceforge.net/tracker/?func=add&group_id=3382&atid=103382> (for
New Bug(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=303382 
<http://sourceforge.net/tracker/?func=add&group_id=3382&atid=303382> (for
New Patch(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=353382 
<http://sourceforge.net/tracker/?func=add&group_id=3382&atid=353382> (for
New Feature Request(s))

-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
