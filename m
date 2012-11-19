Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <noreply@sourceforge.net>) id 1TaXQ1-0004BH-Dk
	for ltp-list@lists.sourceforge.net; Mon, 19 Nov 2012 19:54:09 +0000
From: SourceForge.net <noreply@sourceforge.net>
Date: Mon, 19 Nov 2012 11:54:09 -0800
Content-Disposition: inline
MIME-Version: 1.0
Subject: [LTP] [ ltp-Bugs-3578432 ] -S SKIPFILE
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
Message-Id: <E1TkTx7-0000SA-PW@sfs-ml-2.v29.ch3.sourceforge.com>
To: "SourceForge.net" <noreply@sourceforge.net>

Bugs item #3578432, was opened at 2012-10-19 13:07
Message generated for change (Settings changed) made by shayanb
You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3578432&group_id=3382

Please note that this message will contain a full copy of the comment thread,
including the initial issue submission, for this request,
not just the latest update.
Category: Testcases
Group: Commands
Status: Open
>Resolution: Works For Me
>Priority: 2
Private: No
Submitted By: Shayan Es (shayanb)
Assigned to: Nobody/Anonymous (nobody)
Summary: -S SKIPFILE

Initial Comment:
There is an error with using the -S flag to skip failed tests from previous test fail file

./runltp -S /home/shayan/Desktop/LtpResults/runltpfail2 -C /home/shayan/Desktop/LtpResults/runltpfail21shouldbenull -l /home/shayan/Desktop/LtpResults/ltplog21failsafe.log -o /home/shayan/Desktop/LtpResults/ltpout21failsafe -p -T 1

ERROR IN THE OUTPUT:

    INFO: no command files were provided. Will execute the following
          runtest scenario files:

syscalls fs fs_perms_simple fsx dio io mm ipc sched math nptl pty containers fs_bind controllers filecaps cap_bounds fcntl-locktests connectors admin_tools timers power_management_tests numa hugetlb commands hyperthreading 
    
sed: -e expression #1, char 42: unterminated `s' command
sed: can't find label for jump to `estcases/bin'
sed: -e expression #1, char 32: unknown command: `['


----------------------------------------------------------------------

>Comment By: Shayan Es (shayanb)
Date: 2012-11-19 11:54

Message:
I found some ways to work around this issue,
I guess the only problem with this is the misspelling of some testcases in
scripts

----------------------------------------------------------------------

You can respond by visiting: 
https://sourceforge.net/tracker/?func=detail&atid=103382&aid=3578432&group_id=3382

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
