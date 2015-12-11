From: Roman Gushchin <klamm@yandex-team.ru>
Date: Fri, 11 Dec 2015 18:07:52 +0300
Subject: [LTP] [bug report] readahead02: readahead hardcoded bytes limit
In-Reply-To: <20151211135323.GA31048@red-moon>
References: <20151211135323.GA31048@red-moon>
Message-ID: <135641449846472@webcorp01f.yandex-team.ru>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lorenzo!

Thank you! I'll prepare a patch during next week.

--
Roman


11.12.2015, 16:52, "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>:
> Hi,
>
> following kernel commit:
>
> commit 600e19afc5f8a6 ("mm: use only per-device readahead limit")
>
> LTP readahead02 test produces warnings such as:
>
> readahead02 0 TINFO : creating test file of size: 67108864#
> readahead02 (1698): drop_caches: 1#
> readahead02 0 TINFO : read_testfile(0)#
> readahead02 (1698): drop_caches: 1#
> readahead02 0 TINFO : read_testfile(1)#
> readahead02 1 TPASS : expected ret success - returned value = 0#
> readahead02 2 TPASS : offset is still at 0 as expected#
> readahead02 0 TINFO : read_testfile(0) took: 125319 usec#
> readahead02 0 TINFO : read_testfile(1) took: 119364 usec#
> readahead02 0 TINFO : read_testfile(0) read: 67357696 bytes#
> readahead02 0 TINFO : read_testfile(1) read: 63098880 bytes#
> readahead02 3 TPASS : readahead saved some I/O#
> readahead02 0 TINFO : cache can hold at least: 67372 kB#
> readahead02 0 TINFO : read_testfile(0) used cache: 65420 kB#
> readahead02 0 TINFO : read_testfile(1) used cache: 4120 kB#
> readahead02 0 TWARN : readahead02.c:323: using less cache than expected
>
> It is caused by the hardcoded 2MB readahead02 limit used to issue
> the readahead syscall, the kernel now caps the number of pages
> using the per-device readahead limit, so the readahead count parameter
> should be updated accordingly.
>
> There are multiple ways to fix it, simplest is reading the bdi backing
> the testfile and use its readahead limit as readahead syscall count
> parameter.
>
> Please consider updating the test.
>
> Thanks,
> Lorenzo
