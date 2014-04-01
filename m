Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUzCK-0003Re-LH
	for ltp-list@lists.sourceforge.net; Tue, 01 Apr 2014 13:57:52 +0000
Date: Tue, 1 Apr 2014 15:57:15 +0200
From: chrubis@suse.cz
Message-ID: <20140401135714.GA12939@rei.suse.cz>
References: <4506ACC2AE90484D87F9A883BA36C21C548C89@LCHQEX03.lancope.local>
	<20140325153431.GA10754@rei>
	<4506ACC2AE90484D87F9A883BA36C21C548D90@LCHQEX03.lancope.local>
	<20140326102237.GA8207@rei.suse.cz>
	<4506ACC2AE90484D87F9A883BA36C21C548E9F@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C548E9F@LCHQEX03.lancope.local>
Subject: Re: [LTP] Suggested patch for Debian distro testing, part 1 of 2
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
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Sure!  Single unified (suggested) patch appended.
> Not having busybox or loose time right now, I'll just shebang the offenders and let the busyboxers port it out later.
> Also corrects a few 'exit -1' in netns/*.sh scripts as a sop to the busyboxers :-).

I've reverted the change for the runltp script, which I believe was
fixed, rewrote the commit message to something more meaningful and added
warning that the bashism should be fixed to a few of the testcases.

I've also removed the snippet to create the logdir, if really needed
this change should go in separate patch. The script should not create
files in this this directory anyway.

For next time, please send a signed patch (with the signed-of-by line)
and with more descriptive commit message.

The rest is pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
