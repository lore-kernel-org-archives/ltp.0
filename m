From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 16:00:43 +0200
Subject: [LTP] [PATCH v6 2/3] syscalls/copy_file_range01: add
 cross-device test
In-Reply-To: <1564030915-3211-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <5D30200B.4050306@cn.fujitsu.com>
 <1564030915-3211-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564030915-3211-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190729140043.GB31077@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Amir has relaxed cross-device constraint since commit[1], I think we can test it in
> copy_file_range01.

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dae222a5

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Now sent to the correct patchset version:

Whole patchset LGTM, but here we got quite a lot of failures after increasing
test coverage with .all_filesystems = 1 (which use should be noted in commit
message):

copy_file_range02.c:120: FAIL: copy_file_range failed unexpectedly; expected EOVERFLOW, but got: EINVAL
copy_file_range02.c:126: FAIL: copy_file_range returned wrong value: 16
...
copy_file_range02.c:126: FAIL: copy_file_range returned wrong value: 16

Kind regards,
Petr
