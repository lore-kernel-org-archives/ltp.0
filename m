From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Mar 2016 15:08:59 +0100
Subject: [LTP] Question about perf_event_open/Cap_bounds/su01 test cases
In-Reply-To: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
References: <AF04265A3FC2B144B9892F621A394E13EA3DB009@tethys>
Message-ID: <20160309140859.GD28171@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The whole analysis can be refer on https://justpaste.it/s32h.

The fanotify06 failure is likely kernel bug fixed in:

commit 8edc6e1688fc8f02c8c1f53a2ec4928cb1055f4d
Author: Jan Kara <jack@suse.cz>
Date:   Thu Nov 13 15:19:33 2014 -0800

    fanotify: fix notification of groups with inode & mount marks

Which is part of Linux 3.18.


The only modification I did to the testcase was adding comment pointing to this
kernel patch that fixes the problem.



Also as Jan said, you are using nearly year old LTP. Using the latest
stable release is always prefered.

-- 
Cyril Hrubis
chrubis@suse.cz
