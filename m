Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDcWB-0000Oc-C7
	for ltp-list@lists.sourceforge.net; Wed, 12 Feb 2014 16:18:35 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0F495AC7B
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Feb 2014 16:18:28 +0000 (UTC)
Date: Wed, 12 Feb 2014 17:18:00 +0100
From: chrubis@suse.cz
Message-ID: <20140212161800.GC4905@rei.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC] Calling SAFE_MACROS() from test cleanup()
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

Hi!
Currently we have a ugly hack that allows SAFE_MACROS() to be called
from test cleanup. See tst_brk() function in the tst_res.c especially:

        /*
         * If no cleanup function was specified, just return to the caller.
         * Otherwise call the specified function.
         */
        if (func != NULL) {
                tst_brk_entered++;
                (*func) ();
                tst_brk_entered--;
        }
        if (tst_brk_entered == 0)
                tst_exit();


This piece of code detects if tst_brk() was called from tst_brk() recursively
and aborts only if it gets back to the first instance, which is ugly and
non-intuitive.

It has been added here in order not to abort a cleanup() if one of the
SAFE_MACROS() has failed (in which case it calls tst_brkm()).

If nobody object in a week or so I would:

* Add a deprecation warning in case that SAFE_MACRO was called from a cleanup()

* Add a deprecation warning in case tst_brkm() was called recursively

* Patches that use SAFE_MACROS() or tst_brkm() in cleanup will not be accepted anymore


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
