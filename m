From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 30 Dec 2020 16:28:41 +0800
Subject: [LTP] [PATCH v2 3/3] syscalls/ipc: semctl09: add a test for
 SEM_STAT_ANY
In-Reply-To: <1608803896-17634-3-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1608803896-17634-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <1608803896-17634-3-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <5FEC3A39.6070607@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Merged this patchset, thanks!

Best Regards
Yang Xu
> Validate the content of the seminfo structure and the return value.
>
> The return value is highest used index to a kernel table, so we call
> semctl() with SEM_STAT_ANY which shouldn't fail if the value is correct.
>
> We also test SEM_STAT_ANY by calling semctl() directly by syscall(),
> because glibc have a bug that caused fails to pass the buffer specified
> by the caller to the kernel.
>
> We parse /proc/sysvipc/sem and check that the information is
> consistent with the content of seminfo structure.
>
> Signed-off-by: Feiyu Zhu<zhufy.jy@cn.fujitsu.com>
> Reviewed-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---



