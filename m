From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 09:47:20 +0200
Subject: [LTP] [PATCH v6 2/3] syscalls/copy_file_range01: add
 cross-device test
In-Reply-To: <5D413CD8.6040209@cn.fujitsu.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564030915-3211-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190729140043.GB31077@dell5510> <20190729141011.GA1965@dell5510>
 <5D400066.2090204@cn.fujitsu.com> <20190730133530.GA32652@dell5510>
 <5D413CD8.6040209@cn.fujitsu.com>
Message-ID: <20190731074720.GA3894@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > I wonder, what I do wrong. I posted whole output of one machine below.
> Hi Petr

> You do nothing wrong.  It fails on various distros because the patchset was merged into upstream kernel since 5.2.

> I guess it was not merged into any distros stable kernel Now.
Thanks for info. I looked into commits during review, but didn't pay attention
when it was merged into mainline.


> patchurl:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96e6e8f4a
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dae222a5

> also add xfstests case url:
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/553{554,564,565}
https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/{553,554,564,565}

Kind regards,
Petr
