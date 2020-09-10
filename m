From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Sep 2020 13:27:30 +0200
Subject: [LTP] [PATCH 00/10] Fanotify tests for v5.9
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200910112730.GA7194@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Following are the tests that were used to develop the upcoming fanotify
> features in v5.9.

> The inotify/dnotify tests and fanotify09 test case are regression tests
> for a mid series bug that has been fixed before the merge.
Patchset merged.

> fanotify10 gets another set of test cases to catch yet another ignored
> mask logic bug. The fix commit will be too hard to backport IMO, so
> perhaps these test cases should go into a new test with .min_kver = "5.9".
Can we just skip particular test with tst_parse_kver() or tst_kvcmp()? Because
other tests are valid, thus why to skip them (which would be when using
.min_kver).

Kind regards,
Petr
