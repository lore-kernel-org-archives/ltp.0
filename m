From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 1 Mar 2021 10:57:30 +0800
Subject: [LTP] [PATCH] De-duplication: Remove requirement of needs_tmpdir
In-Reply-To: <20210301022550.96228-1-zhaogongyi@huawei.com>
References: <20210301022550.96228-1-zhaogongyi@huawei.com>
Message-ID: <603C581A.9040202@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi
> The flag is not needed to be set when use these flags: '.all_filesystems',
> '.format_device', '.mntpoint', '.mount_device' '.needs_checkpoints',
> '.needs_device', '.resource_file'. These flags imply creating temporary
> directory.
Merged, thanks!



