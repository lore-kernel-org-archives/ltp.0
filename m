From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 20 Apr 2017 13:41:50 +0200
Subject: [LTP] [RFC 0/1] cve-2017-7277 SOF_TIMESTAMPING_OPT_STATS
Message-ID: <20170420134150.2604b21c@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So this is another CVE test, which will be part of the CVE patch set which I
will submit once the LTP build system is ready for 32-bit compat mode.

To quickly try the CVE tests and 32-bit compat mode you can clone
https://github.com/richiejp/ltp/tree/m32_rfc

As well as testing for CVE-2017-7277 this also provides a partial
functionality test for the timestamping interface. AFAICT we don't test this
in LTP yet.

Richard Palethorpe (1):
  Add cve-2017-7277 SOF_TIMESTAMPING_OPT_STATS

 runtest/cve                   |   1 +
 testcases/cve/.gitignore      |   1 +
 testcases/cve/cve-2017-7277.c | 449 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 451 insertions(+)
 create mode 100644 testcases/cve/cve-2017-7277.c

-- 
2.12.2
