From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jan 2018 14:08:14 +0800
Subject: [LTP] [PATCH] mem/oom03,
	05: Fix failure when setting memory.memsw.limit_in_bytes
In-Reply-To: <1513237484-30831-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1513237484-30831-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <CAEemH2d40dA12H9TDnbybpyUec0qW0Wm+AE_XVh2CFzC9FZ1Mw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Dec 14, 2017 at 3:44 PM, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:

> We got the following error when running oom03 or oom05 on RHEL7.5Alpha
> ----------------------------------------------------------------------
> ...
> mem.c:230: INFO: start OOM testing for KSM pages.
> ...
> mem.c:145: PASS: victim signalled: (9) SIGKILL
> safe_file_ops.c:301: BROK: Failed to close FILE
> '/dev/cgroup/1/memory.memsw.limit_in_bytes' at oom03.c:56: EBUSY
> ...
>

​This problem seems only happened on RHEL7.5Alpha kernel, I hit this with
reproducer oom03/05. But it very probably have been fixed in Beta kernel(I
run the tests many times on the same machine but not able to reproduce).

​Anyway, thanks for reporting this issue.

-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180112/34b67fc6/attachment.html>
