Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PxJnA-0004eQ-RT
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 13:51:08 +0000
Date: Wed, 9 Mar 2011 15:12:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110309141226.GB7793@saboteur.suse.cz>
References: <4D75E7B9020000E800071530@novprvoes0310.provo.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D75E7B9020000E800071530@novprvoes0310.provo.novell.com>
Subject: Re: [LTP] pidns errors
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> Are there still known issues with the pidns tests and 20110228 stable
> release?  I've got the same failure on 2 unrelated pieces of hardware
> but both running SLE11SP1 (2.6.32) kernel.  The pidns tests just hang
> with multiple child processes.  I haven't started debugging yet, but
> it looks like a signal problem in the child processes.

Which testcases do hang? There is more than ten pidnsXX tests in LTP, do
they all hang?

Have you tried to connect debugger to the test process? 
(gdb /path/to/binary PID)

Also witch architectures are these failing on? The tests are ported from
crackerjack project. Which is IMHO not designed/tested to run on
anything else but x86 (at least some of crackerjack tests).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
