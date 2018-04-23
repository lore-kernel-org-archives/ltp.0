From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Apr 2018 08:55:22 +0200
Subject: [LTP] [PATCH v2] *.py : convert python2 to python3
In-Reply-To: <20180423033244.22838-1-yosun@suse.com>
References: <20180419101038.22451-1-yosun@suse.com>
 <20180423033244.22838-1-yosun@suse.com>
Message-ID: <20180423065522.4trbxxngug3qkkkr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yosun,

> From: yosun <yosun@suse.com>

> 1.Convert python code to use python3
> 2.Make shebang same as standard python shebang

> Signed-off-by: Yong Sun <yosun@suse.com>
> ---
>  execltp.in                                         |  12 +-
>  testcases/commands/file/datafiles/in.py            |   2 +-
>  .../kernel/power_management/lib/pm_sched_mc.py     | 218 ++++++++++-----------
>  .../power_management/pm_cpu_consolidation.py       |  14 +-
>  testcases/kernel/power_management/pm_ilb_test.py   |   8 +-
>  .../kernel/power_management/pm_sched_domain.py     |   8 +-
>  testcases/network/nfsv4/acl/cleangroups.py         |   3 +-
>  testcases/network/nfsv4/acl/cleanusers.py          |   3 +-
>  testcases/network/nfsv4/acl/create_users.py        |   1 +
>  testcases/network/nfsv4/acl/random_gen.py          |  31 +--
>  testcases/network/nfsv4/acl/setacl_stress.py       |   3 +-
>  testcases/network/nfsv4/acl/test_acl.py            |   1 +
>  testcases/network/nfsv4/acl/test_long_acl.py       |  17 +-
>  testcases/network/nfsv4/locks/locktests.py         |  58 +++---
>  testcases/realtime/func/pi-tests/parse-testpi1.py  |   1 +
>  testcases/realtime/func/pi-tests/parse-testpi2.py  |   1 +
>  testcases/realtime/scripts/parser.py               |   3 +-
>  testcases/realtime/tools/ftqviz.py                 |  14 +-
>  testscripts/build/ltp-missing-install-files.py     |   6 +-
>  tools/pounder21/src/time_tests/drift-test.py       |  16 +-
>  20 files changed, 215 insertions(+), 205 deletions(-)

there are still some errors (not caused by you), which were ok for python2 but must be
fixed for python3. Can you please fix them?

$ python3 -m py_compile testcases/network/nfsv4/acl/random_gen.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (random_gen.py, line 201)
testcases/network/nfsv4/acl/random_gen.py: 1

$ python3 -m py_compile testcases/network/nfsv4/acl/test_acl.py
  File "testcases/network/nfsv4/acl/test_acl.py", line 22
    for i in range (len(splitedresult)-1)
                                        ^
SyntaxError: invalid syntax

testcases/network/nfsv4/acl/test_acl.py: 1

$ python3 -m py_compile testcases/network/nfsv4/acl/test_long_acl.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (test_long_acl.py, line 33)
testcases/network/nfsv4/acl/test_long_acl.py: 1

$ python3 -m py_compile testcases/network/nfsv4/locks/locktests.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (locktests.py, line 106)
testcases/network/nfsv4/locks/locktests.py: 1

$ python3 -m py_compile testcases/realtime/func/pi-tests/parse-testpi1.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (parse-testpi1.py, line 44)
testcases/realtime/func/pi-tests/parse-testpi1.py: 1

$ python3 -m py_compile testcases/realtime/func/pi-tests/parse-testpi2.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (parse-testpi2.py, line 47)
testcases/realtime/func/pi-tests/parse-testpi2.py: 1

$ python3 -m py_compile testcases/realtime/scripts/parser.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (parser.py, line 34)
testcases/realtime/scripts/parser.py: 1


Kind regards,
Petr
