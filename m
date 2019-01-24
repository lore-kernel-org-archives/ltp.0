From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 24 Jan 2019 10:55:04 -0200
Subject: [LTP] LTP kernel config needs inputs ?
Message-ID: <0B227663-0650-4B24-8721-1D1206E9FBA1@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello all,

Currently we have a list of "bugs", out of LKFT, that are only related
to missing kernel configuration options in boards & systems being tested
by our framework and environment. I would like to get some feedback
regarding this, if possible. Since we use multiple testing frameworks in
LKFT, we usually compare features, from one and another, and we would
like some input about possibility of having kernel config fragments in
LTP (or something better).

kselftests has config fragments in order to enable kernel config options
needed for specific tests (like showed at the end of this e-mail). I see
that, nowadays, we have a file called README.kernel_config that contains
a list of needed kernel options (for the basic framework ?), but this
file hasn't been updated since 2014.

We have a list of some bugs that we have identified missing config
options in our kernel builds. Sometimes we are lucky and the tests get
BROK reported because they test a specific feature requirement before
the real test, but, sometimes, random errors give us no clue if we are
missing kernel features or facing a kernel issue.

Any opinions on something that could relieve this burden ?

Best, Rafael=20
=E2=80=94=20
Rafael D. Tinoco
Linaro Kernel Validation

-------------------------------------------------------

## LTP identified config needs:

Bug #3354: (LTP) quota format not supported in kernel
https://bugs.linaro.org/show_bug.cgi?id=3D3354#c1

CONFIG_QFMT_V1
CONFIG_QFMT_V2

-----

Bug #3834: (LTP) netns_sysfs and kselftests rtnetlink.sh failed to add a
new (host) dummy device on Hikey and Juno
https://bugs.linaro.org/show_bug.cgi?id=3D3834#c0

We should enable full TC support:

CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_CSZ=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_POLICE=3Dy
for all boards/systems. The needed for this bug is only:
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_HTB=3Dy
-----

Bug #4012: (LTP) statx04 STATX_ATTR_COMPRESSED flag is not set for ext2
We should decide if we will test EXT2 code or not:
https://bugs.linaro.org/show_bug.cgi?id=3D4012#c0

CONFIG_EXT4_USE_FOR_EXT2=3Dy
or
CONFIG_EXT2_FS=3Dy
-----

Bug #4255: (LTP) LTP: mm: mem.c:782: BROK: mount /dev/cgroup: ENOENT
https://bugs.linaro.org/show_bug.cgi?id=3D4255#c0

CONFIG_MEMCG=3Dy

-------------------------------------------------------

## kselftests config fragments example:

./memfd/config
-----
CONFIG_FUSE_FS=3Dm
-----
./cpu-hotplug/config
-----
CONFIG_NOTIFIER_ERROR_INJECTION=3Dy
-----
./static_keys/config
-----
CONFIG_TEST_STATIC_KEYS=3Dm
-----
./sysctl/config
-----
CONFIG_TEST_SYSCTL=3Dy
-----
./netfilter/config
-----
CONFIG_NET_NS=3Dy
NF_TABLES_INET=3Dy
-----
./lib/config
-----
CONFIG_TEST_PRINTF=3Dm
CONFIG_TEST_BITMAP=3Dm
CONFIG_PRIME_NUMBERS=3Dm
-----
./cpufreq/config
-----
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
...
-----
./tc-testing/config
-----
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_FW=3Dm
...
-----
./pstore/config
-----
CONFIG_MISC_FILESYSTEMS=3Dy
CONFIG_PSTORE=3Dy
...
-----
./zram/config
-----
CONFIG_ZSMALLOC=3Dy
CONFIG_ZRAM=3Dm

and so on...

