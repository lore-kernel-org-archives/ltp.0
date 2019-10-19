From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 19 Oct 2019 03:41:15 -0400 (EDT)
Subject: [LTP] [bug?] LTP pt_test failing after 38bb8d77d0b9
 "perf/x86/intel/pt: Split ToPA metadata and page layout"
In-Reply-To: <1953570088.7121417.1571470108567.JavaMail.zimbra@redhat.com>
Message-ID: <1311286607.7121481.1571470875734.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

All variants of pt_test:
  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/tracing/pt_test/pt_test.c
started failing after:
  38bb8d77d0b9 ("perf/x86/intel/pt: Split ToPA metadata and page layout")

with following error on console/dmesg:
  pt: ToPA ERROR encountered, trying to recover

on Broadwell-EP:

vendor_id       : GenuineIntel
cpu family      : 6
model           : 79
model name      : Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
stepping        : 1

Regards,
Jan
