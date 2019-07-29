From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 15:56:55 +0200
Subject: [LTP] [PATCH v5 2/3] syscalls/copy_file_range01: add
 cross-device test
In-Reply-To: <1563356676-2384-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190711125108.GB8709@rei>
 <1563356676-2384-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1563356676-2384-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190729135627.GA31077@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> Amir has relaxed cross-device constraint since kernel commit 5dae222a5(vfs:
> allow copy_file_range to copy across devices), I think we can test it in
> copy_file_range01.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Whole patchset LGTM, but here we got quite a lot of failures after increasing
test coverage with .all_filesystems = 1 (which use should be noted in commit
message):

copy_file_range02.c:120: FAIL: copy_file_range failed unexpectedly; expected EOVERFLOW, but got: EINVAL
copy_file_range02.c:126: FAIL: copy_file_range returned wrong value: 16
...
copy_file_range02.c:126: FAIL: copy_file_range returned wrong value: 16

Kind regards,
Petr
