Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WG8Kx-0008ID-Q8
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 14:41:23 +0000
Date: Wed, 19 Feb 2014 15:41:12 +0100
From: chrubis@suse.cz
Message-ID: <20140219144112.GC2138@rei>
References: <37DEC8B3-1B3C-4FD3-99F8-3E5436311195@gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <37DEC8B3-1B3C-4FD3-99F8-3E5436311195@gmx.net>
Subject: Re: [LTP] runltplite access06 test relies on DEVICE and
 DEVICE_FS_TYPE
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
To: Harry Weppner <harry.weppner@gmx.net>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> using runltplite, access06 is reported as broken because DEVICE and
> DEVICE_FS_TYPE aren't set.
>
> Unlike runltp there's no command line option or fallback mechanism
> implemented in the runltplite script. Should access06 be taken out of
> runltplite!?

There is increasing number testcases that needs a device for EROFS error
tests.

Ideally runltplite.sh should prepare and export the device just as
runltp does, this should fix the testruns for now. Do you care to send a
patch? :)

Better solution would be to skip the EROFS test if device wasn't set and
print a warning but this would require changes in the LTP test library
(I have this on my longterm TODO).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
