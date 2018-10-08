From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Oct 2018 15:23:08 +0200
Subject: [LTP] [PATCH v2 ltp] runtest/{ltplite,
 stress.part1}: update commands for
 gf01-30/rwtest01-05/fs_inod01/iogen01
In-Reply-To: <20180815064405.13247-1-yixin.zhang@intel.com>
References: <20180815064405.13247-1-yixin.zhang@intel.com>
Message-ID: <20181008132308.GA9870@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yixin,

> gf01-30/rwtest01-05/fs_inod01/iogen01 are orignal defined in runtest file 'fs',
> and they are updated multiple times in file 'fs' but missed in
> 'ltplite'/'stress.part1'. So this patch copy all updates to the tests in
> 'ltplite'/'stress.part1'.

> Ref:
> c9dd96e6b2f811dbad119c3558d90cb7dfc3919b
> 95e8b61433efcefb83699aaf859e92ad2b576373
> 606e544932248858f65c7ab3061f77c542c07cfe
> b0458a3c838c86faf2d8855c097628c0c435532a

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  runtest/ltplite      | 71 +++++++++++++++++++++---------------------
>  runtest/stress.part1 | 74 ++++++++++++++++++++++----------------------

while this change is correct, I'd prefer to delete these aggregated runtest files (ltplite,
stress.part*) than keeping them in sync.

Another option is implement some import feature for ltp-pan. But I guess it's
better to invest the effort into Cyril's new test runner [1].

Kind regards,
Petr

[1] https://github.com/metan-ucw/ltp/commits/master
