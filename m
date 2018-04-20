From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Apr 2018 11:59:42 +0200
Subject: [LTP] [PATCH] *.py : convert python2 to python3
In-Reply-To: <20180419101038.22451-1-yosun@suse.com>
References: <20180419101038.22451-1-yosun@suse.com>
Message-ID: <20180420095942.js6tpe7dcbdass3z@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yong,

> From: yosun <yosun@suse.com>

> Convert python code to use python3.

> Signed-off-by: Yong Sun <yosun@suse.com>
> ---
>  .../kernel/power_management/lib/pm_sched_mc.py     | 210 ++++++++++-----------
>  .../power_management/pm_cpu_consolidation.py       |  12 +-
>  testcases/kernel/power_management/pm_ilb_test.py   |   6 +-
>  .../kernel/power_management/pm_sched_domain.py     |   6 +-
>  testcases/network/nfsv4/acl/cleangroups.py         |   2 +-
>  testcases/network/nfsv4/acl/cleanusers.py          |   2 +-
>  testcases/network/nfsv4/acl/random_gen.py          |  30 +--
>  testcases/network/nfsv4/acl/setacl_stress.py       |   2 +-
>  testcases/network/nfsv4/acl/test_long_acl.py       |  16 +-
>  testcases/network/nfsv4/locks/locktests.py         |  56 +++---
>  testcases/realtime/scripts/parser.py               |   2 +-
>  testcases/realtime/tools/ftqviz.py                 |  12 +-
>  testscripts/build/ltp-missing-install-files.py     |   4 +-
>  tools/pounder21/src/time_tests/drift-test.py       |  14 +-
>  14 files changed, 187 insertions(+), 187 deletions(-)
Some files are needed.
$ git ls-files |grep '\.py$' | grep -v __init__.py | wc -l
19

The reason is that some files doesn't have shebang. Could you please add it into them and
convert all python scripts?


> diff --git a/testcases/kernel/power_management/lib/pm_sched_mc.py b/testcases/kernel/power_management/lib/pm_sched_mc.py
> index feb4b24d3..92a6dd5c4 100755
> --- a/testcases/kernel/power_management/lib/pm_sched_mc.py
> +++ b/testcases/kernel/power_management/lib/pm_sched_mc.py
> @@ -30,8 +30,8 @@ def clear_dmesg():
>      '''
>      try:
>          os.system('dmesg -c >/dev/null')
> -    except OSError, e:
> -        print 'Clearing dmesg failed', e
> +    except OSError as e:
> +        print('Clearing dmesg failed', e)
>          sys.exit(1)

There are some issues with mixing tabs and spaces. See:
$ python3 -m py_compile testcases/kernel/power_management/lib/pm_sched_mc.py
Sorry: TabError: inconsistent use of tabs and spaces in indentation (pm_sched_mc.py, line 265)

These tabs on sys.exit(1) were here before, but py_compile from python2 is more relax
about it than the one from python3. Could you please fix it as well and check it for all
scripts?


Kind regards,
Petr
