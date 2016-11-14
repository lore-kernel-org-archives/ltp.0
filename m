From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Nov 2016 15:05:04 +0100
Subject: [LTP] [RFC] Cleanup of tools/ directory
Message-ID: <20161114140504.GE25055@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've stumbled upon the tools/ directory and there is quite a lot of
broken code that is not really useful for anything.

The Makefile skips netpipe*, pounder21 and top-LTP directories. Apart
from automatic changes nobody touched the top-LTP and netpipe* code for
more than six years, so I would say that it's safe enough to remove
these. The pounder21 had some fixes that looks like somebody is using
that so I guess that we should keep it.

Then there are files that looks like they could be removed as well:

* STPfailure_report.pl - most likely no change since 2004, looks useless o me

* ltp_master, ltp_check, README, ltpoutput*
  - remnants of some automated framework that used ltprun script that
    used runalltests.sh script, I will remove these since there is no
    reason to keep them now

In short has anybody anything agains removal of netpipe*, top-LTP,
STPfailure_report.pl, ltp_master, ltp_check, README, and ltpoutput* from
the tools/ directory?

-- 
Cyril Hrubis
chrubis@suse.cz
