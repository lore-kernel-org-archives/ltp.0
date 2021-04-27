From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Apr 2021 21:20:38 +0200
Subject: [LTP] [PATCH] openposix/conformance/interfaces: Correct typos
In-Reply-To: <1619491883-69694-1-git-send-email-wangxin410@huawei.com>
References: <1619491883-69694-1-git-send-email-wangxin410@huawei.com>
Message-ID: <YIhkBsRClMPkyM4Y@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xin,

> Types in the name of the temporary files: For example, in aio_cancel/8-1.c file,
> pts_aio_cancel_1_1 -> pts_aio_cancel_8_1.
> Others like this have been modified.

This patch is also not applicable with git am. Not sure what you do wrong,
but simple 'git format-patch origin/master' should work.

Kind regards,
Petr
