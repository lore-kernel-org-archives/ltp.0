From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Nov 2019 15:59:54 +0100
Subject: [LTP] [PATCH 0/3] perf_event_open02 tweaks
Message-ID: <cover.1574087532.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Motivation for this series is patch 3, because this test
fails pretty reliably on Pentium4 systems.

I talked to Jiri Olsa (one of perf maintainers) and he had his
reservations about how test determines number of HW counters -
by looking at time_enabled/time_running. One idea was to create
a single group and keep adding hw events to it until it fails.
This however didn't work on Pentium4 system either and it failed
on 2nd event. He also pointed out, that test will always succeed
when number of hw counter is over-estimated.

I found one workaround, which seems to work on both Pentium4
and more recent CPUs. It replaces comparison of absolute values
with comparison of increments (see patch 3 for details).

Question about validity of this test remains, but workaround in
patch 3 at least should not make things worse.

Jan Stancek (3):
  perf_event_open02: migrate to newlib
  perf_event_open02: make do_work() run for specified time
  perf_event_open02: workaround for Pentium4

 .../syscalls/perf_event_open/perf_event_open02.c   | 402 +++++++++------------
 1 file changed, 168 insertions(+), 234 deletions(-)

-- 
1.8.3.1

