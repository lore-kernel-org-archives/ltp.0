From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 15 Jul 2016 17:39:41 +0300
Subject: [LTP] waitpid: new API
Message-ID: <1468593589-30545-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

This series is a continuation of [1], i.e. I converted those waitpid*
test cases utilizing wait_for_parent() to use the checkpoint interface
(along with the new test API).

The main difference from [1] is that I moved duplicated code to
a common header.

The only unconverted test case is waitpid10. It needs some more time.

Thanks.

[1] http://lists.linux.it/pipermail/ltp/2016-July/002178.html


