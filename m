From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 28 Jun 2021 08:24:49 +0100
Subject: [LTP] [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount
 failure
In-Reply-To: <20210628033002.GA1469@andestech.com>
References: <20210628033002.GA1469@andestech.com>
Message-ID: <8735t24fjy.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Leo Liang <ycliang@andestech.com> writes:

> From a151d48235629a125d5db57dd76c96fd951d5293 Mon Sep 17 00:00:00 2001
> From: Leo Yu-Chi Liang <ycliang@andestech.com>
> Date: Mon, 28 Jun 2021 11:05:54 +0800
> Subject: [PATCH 1/1] cgroup/cgroup_regression_test: Fix umount failure
>
> The test sequence
> 	mount -t cgroup -o <controllers> <path>
> 	mkdir <path>/<dir>
> 	rmdir <path>/<dir>
> 	umount <path>
> 	mount -t cgroup -o <controllers> <path>
> would easily fail at the last mount with -EBUSY.
>
> The reason is that this test sequence have the chance of
> missing a release code path when doing rmdir and umount.
>
> Add sync between every "rmdir, umount" pair to fix the problem.
>
> Fixes: #839
>
> Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.
