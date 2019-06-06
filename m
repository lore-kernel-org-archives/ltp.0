From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Jun 2019 14:14:36 +0200
Subject: [LTP] [PATCH v2] syscalls/acct02: add functional testcase
In-Reply-To: <20190604072228.17513-1-camann@suse.com>
References: <20190604072228.17513-1-camann@suse.com>
Message-ID: <20190606121436.GB27083@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Have you tried the test on the !v3 case?

I do have:

CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set

And the test fails with:

tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
acct02.c:159: INFO: Verifying using 'struct acct'
acct02.c:137: INFO: Number of accounting file entries tested: 0
acct02.c:142: FAIL: acct() wrote incorrect file contents!

Looks like the file is empty for me...

-- 
Cyril Hrubis
chrubis@suse.cz
