From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Jun 2021 12:06:34 +0200
Subject: [LTP] [RFC] fs_bind rework
In-Reply-To: <fc235ab1-4796-c1d4-d5b0-f1f112c9ce54@jv-coder.de>
References: <fc235ab1-4796-c1d4-d5b0-f1f112c9ce54@jv-coder.de>
Message-ID: <YNRZKs9cHbGxzg4Q@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi,

> is there any reason, why the fs_bind suite cannot be reworked into "real"
> ltp tests?
> At the moment all tests from the suite are run by the wrapper script.
Thanks for having a look into dark areas of LTP :). Various testsuites were
imported in 2008, with questionable quality even then, with very little
maintenance since then. There is no reason, just nobody has had a time for that.

First it'd be good to check how much relevant are these tests nowadays.
Ideally asking on relevant kernel mailing list (probably fstests and
linux-fsdevel).

Also checking whether there is a kselftest contain similar test,
to compare which one is more perspective to spend time on improving it.
Quickly looking, there is just tools/testing/selftests/mount (testing whether
unprivileged user cannot remount a read-only mount bind mount as read-write)
and tools/testing/selftests/mount_setattr, thus not really much.

FYI We've been also porting some kselftest tests to LTP (these being relevant
and reasonable clean; benefits are 1) more readable code due lack of reasonable
kselftest API 2) support for more kernel versions).

> If I would convert them, I'd try this programmatically, because of the huge
> number of tests.
> 1. Move stuff from test_fs_bind.sh to a library file
> 2. Convert all tests in fs_bind/* to ltp tests using the library and adding
> them to the runtest file

If there is something just for these tests, maybe just converting it to
fs_bind_lib.sh, which use tst_test.sh and be used by tests - usual approach, see
e.g. cgroup_lib.sh, ipsec_lib.sh (which uses tst_net.sh). Or maybe having more
libs as it looks to me there are more separate test groups (rbind, cloneNS).
Also tools in fs_bind/bin probably have LTP API alternatives.

> This would make every single fs_bind test a single ltp test (~100).
> I do not think that runtime increases significantly, because as far as I see
> it from first glance, test_fs_bind.sh resets the "sandbox" used for the
> tests before every test anyway.
Yep, I wouldn't be worry about increased runtime, this is actually the preferred
approach. Also, various tests can be probably grouped into single shell test,
with $TST_CNT (looking into tests in fs_bind/cloneNS).

> If there is no objection, I would give converting the tests a shot.
+1

> J?rg

Kind regards,
Petr
