From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 13 Sep 2018 17:44:37 +0300
Subject: [LTP] [RFC] Unique test case ids in runtest files ?
Message-ID: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

Here is a list of test cases which are referenced in
scenario_groups/default multiple times:

cve-2012-0957
cve-2016-4997
cve-2017-5669
cve-2017-6951
keyctl01
move_pages01
move_pages02
move_pages03
move_pages04
move_pages05
move_pages06
move_pages07
move_pages08
move_pages09
move_pages10
move_pages11
move_pages12
pipeio_1
#pipeio_2
pipeio_3
pipeio_4
pipeio_5
pipeio_6
#pipeio_7
pipeio_8
sched_getattr01
sched_getattr02
sched_setattr01
sysctl01
unshare01

I.e. if we run LTP with the default scenario then
 1) most of the test cases above are executed twice.
 2) keyctl01, sysctl01, unshare01 are executed twice.
    Each time they actually point to a different binary/command.

This causes some ambiguity in parsing LTP output logs/results,
especially in group 2.

The proposed solution to this problem is
 a) let tests of group 1 be defined only in one runtest file (referenced
    by the default scenario file)
 b) rename tests of group2

The issue is not new, and it actually hit me only after keyctl01, sysctl01,
unshare01 were introduced in runtest/commands.

It's no doubt, that other names are required for that keyctl01, sysctl01,
unshare01 (be it b) or another patch). However, changes in a)
are more questionable.

I'd like to hear your opinion about this approach.

Thanks a lot.
 
