Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pp0Eg-0006sP-Hw
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 15:21:10 +0000
Date: Mon, 14 Feb 2011 16:40:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110214154030.GC426@saboteur.suse.cz>
References: <4D595337.5070801@nokia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D595337.5070801@nokia.com>
Subject: Re: [LTP] [PATCH] Fix the file permissions and other issues in
 "fs_perms" tests
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
To: maxin <john.maxin@nokia.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have checked your patch and it solves the number conversion (octal<->  decimal) issues. Thank you for that.
> However, the file permission issues are still valid. Please find the test execution log with this mail.
> 
> >But then 001 is right to exec by other which should work.
> >        010 is right to exec for group, which is the same on that line
> >        100 is right to exec for owner, which is the same again
> 
> In this case, I partially agree with you. It is true in the case of binary files. However, We need 'read' and 'exec'
> for script files and these testcases deals with script files too.
> 

Hmm I see the problem now. However as a root, I could read and run files
with just an exec flag, at least here. I suppose the test works here by
some saved-id magick. I'll look deeper into this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
