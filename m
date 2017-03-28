From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2017 11:22:26 +0800
Subject: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New API
Message-ID: <20170328032239.11917-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset is on purpose to convert lib/mem.c to new API, and the follows
are all related testcase which using the memory test library. As you can see,
one converted commit belong to a common subject(locatd in the same dir) at once.

Btw, I have tried to do cleanup/reorg for most of them, but it probably still not
perfect by now, that's because my knowledge is limited. Anyway, before send out,
test looks good(only two failures) from my x86_64(15G RAM, 2 numa nodes) box:

Seems the failed reason in oom02/5 is not testcase issue, it just because New API sets
test time in 5mins.

<<<test_output>>>
tst_test.c:859: INFO: Timeout per run is 0h 05m 00s
mem.c:919: INFO: set overcommit_memory to 1
oom02.c:41: INFO: OOM on MPOL_BIND mempolicy...
mem.c:222: INFO: start normal OOM testing.
mem.c:144: INFO: expected victim is 13941.
...
mem.c:37: INFO: thread (7f7e99c51700), allocating 3221225472 bytes.
mem.c:37: INFO: thread (7f7dd9450700), allocating 3221225472 bytes.
tst_test.c:909: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:910: BROK: Test killed! (timeout?)

Summary:
passed   5
failed   0
skipped  0
warnings 0


Test Start Time: Mon Mar 27 06:15:30 2017
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
hugemmap01                     PASS       0
hugemmap02                     PASS       0
hugemmap04                     PASS       0
hugemmap05                     PASS       0
hugemmap06                     PASS       0
hugemmap05_1                   PASS       0
hugemmap05_2                   PASS       0
hugemmap05_3                   PASS       0
hugeshmat01                    PASS       0
hugeshmat02                    PASS       0
hugeshmat03                    PASS       0
hugeshmat04                    PASS       0
hugeshmat05                    PASS       0
hugeshmctl01                   PASS       0
hugeshmctl02                   PASS       0
hugeshmctl03                   PASS       0
hugeshmdt01                    PASS       0
hugeshmget01                   PASS       0
hugeshmget02                   PASS       0
hugeshmget03                   PASS       0
hugeshmget05                   PASS       0
ksm01                          PASS       0
ksm01_1                        PASS       0
ksm02                          PASS       0
ksm02_1                        PASS       0
ksm03                          PASS       0
ksm03_1                        PASS       0
ksm04                          PASS       0
ksm04_1                        PASS       0
ksm05                          PASS       0
ksm06                          PASS       0
ksm06_1                        PASS       0
ksm06_2                        PASS       0
oom01                          PASS       0
oom02                          FAIL       2
oom03                          PASS       0
oom04                          PASS       0
oom05                          FAIL       2
swapping01                     CONF       32
cpuset01                       PASS       0
thp01                          PASS       0
thp02                          PASS       0
thp03                          PASS       0
overcommit_memory01            PASS       0
overcommit_memory02            PASS       0
overcommit_memory03            PASS       0
overcommit_memory04            PASS       0
overcommit_memory05            PASS       0
overcommit_memory06            PASS       0
max_map_count                  PASS       0

-----------------------------------------------
Total Failures: 2
Kernel Version: 3.10.0-514.el7.x86_64

-- 
2.9.3

