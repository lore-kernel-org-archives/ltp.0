From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Tue, 19 Jul 2016 19:54:24 +0300
Subject: [LTP]  [PATCH v2 2/2] syscalls/perf_event_open{01,
	02}: Reduce size of idle loop
In-Reply-To: <1468947264-5812-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1468947264-5812-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <1468947264-5812-2-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


By default do_work() iterates 1000000000 times. However such loop may
take a long time to finish for all available performance counters on
some slow FPGA-based development boards. Thus a number of iterations
is divided by 10 in this patch.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 testcases/kernel/syscalls/perf_event_open/perf_event_open01.c | 2 +-
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-syscalls-perf_event_open-01-02-Reduce-size-of-idle-l.patch
Type: text/x-patch
Size: 1058 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160719/44c4cd97/attachment.bin>
