From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Mar 2021 18:53:37 +0200
Subject: [LTP] [PATCH] syscalls/chdir01: Add umask before mkdir
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E8F1@dggeml531-mbx.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389E8F1@dggeml531-mbx.china.huawei.com>
Message-ID: <YGNXkZMqqJpviwkL@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

> Umask is always 022 in many system env. In this testcase, if umask is not 022,
> for example, umask is 0077, test would fail because the file mode is affected
> by umask.
Thanks a lot for a giving example. I tested only 0066.

I'm sorry I accepted the Ziyao version as it had better description, reverted
back changes and will work on any mode in SAFE_MKDIR(). I put your Reported-by:
tag.

I'll also send one more fix for exfat.

Kind regards,
Petr
