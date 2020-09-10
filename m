From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Sep 2020 10:16:20 +0200
Subject: [LTP] [PATCH 00/10] Fanotify tests for v5.9
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200910081620.GC25487@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Hi Petr,

> Following are the tests that were used to develop the upcoming fanotify
> features in v5.9.
Thanks a lot for perfect update. There is LTP freeze soon (in 2 weeks [1]).
I'd like to merge your patches although it'll be probably v5.9 release.

Patches LGTM, but I'd like to give change the others to look into them.

I tested all fanotify tests on 5.9.0-rc3 from openSUSE and on various old
kernels from various distros.

Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2020-September/018860.html

> The inotify/dnotify tests and fanotify09 test case are regression tests
> for a mid series bug that has been fixed before the merge.

> fanotify10 gets another set of test cases to catch yet another ignored
> mask logic bug. The fix commit will be too hard to backport IMO, so
> perhaps these test cases should go into a new test with .min_kver = "5.9".

> Thanks,
> Amir.
