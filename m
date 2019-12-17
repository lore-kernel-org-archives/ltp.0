From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 17 Dec 2019 18:16:42 +0800
Subject: [LTP] [PATCH v3 4/5] syscalls/quotactl05: add project quota
 test for xfs filesystem
In-Reply-To: <1576577571-3668-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1576577571-3668-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1576577571-3668-5-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <cfccbfaa-ecf7-3c0b-247a-f8fffafe878c@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All
Sorry, please ingore this email. It has been merged.

Kind Regards
Yang Xu

on 2019/12/17 18:12, Yang Xu wrote:
> This is a variant about quotactl02. It is used to test project quota.
> I split it into a new case instead of adding it in quotaclt02 because
> kernel doesn't permit mount both group and project quota before
> commit d892d5864f02 ("xfs: Start using pquotaino from the superblock.").
> 
> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> ---
>   runtest/syscalls                              |  1 +
>   testcases/kernel/syscalls/quotactl/.gitignore |  2 +
>   .../kernel/syscalls/quotactl/quotactl05.c     | 99 +++++++++++++++++++
>   3 files changed, 102 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/quotactl/quotactl05.c


