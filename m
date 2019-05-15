From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 14:08:53 +0200
Subject: [LTP] [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <1557889279.4581.14.camel@linux.ibm.com>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
 <1557889279.4581.14.camel@linux.ibm.com>
Message-ID: <20190515120853.GA22992@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Mimi,

> The first two patches are fine. =C2=A0From the test, I'm seeing the
> following results:
Thanks a lot for reviewing and testing.

> evm_overlay 1 TINFO: overwrite file in overlay
> tst_rod: Failed to open '(null)' for writing: Operation not permitted
> evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexp=
ectedly
I've fixed '(null)' [1], with that one applied it should be 'mntpoint/merge=
d/foo1.txt'
But what is strange to me is that it continues to execute second line. retu=
rn 1 [2]
should cause ROD() to quit with TBROK [3].
Maybe that ROD in test1() should be replaced EXPECT_PASS.

> evm_overlay 2 TINFO: append file in overlay: mntpoint/lower/foo2.txt
> evm_overlay 2 TPASS: echo overlay >> mntpoint/merged/foo2.txt passed as e=
xpected
> evm_overlay 3 TINFO: create a new file in overlay
> evm_overlay 3 TPASS: echo overlay > mntpoint/merged/foo3.txt passed as ex=
pected
> evm_overlay 4 TINFO: read all created files
> evm_overlay 4 TFAIL: cat mntpoint/merged/foo1.txt > /dev/null 2> /dev/nul=
l failed unexpectedly
> evm_overlay 4 TFAIL: cat mntpoint/merged/foo2.txt > /dev/null 2> /dev/nul=
l failed unexpectedly
> evm_overlay 4 TFAIL: cat mntpoint/merged/foo3.txt > /dev/null 2> /dev/nul=
l failed unexpectedly
> evm_overlay 5 TINFO: SELinux enabled in enforcing mode, this may affect t=
est results
> evm_overlay 5 TINFO: You can try to disable it with TST_DISABLE_SELINUX=
=3D1 (requires super/root)
> evm_overlay 5 TINFO: loaded SELinux profiles: none

> With "evm: instead of using the overlayfs i_ino, use the real i_ino"
> patch, I'm only seeing the first failure.

> Mimi

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/8a35daf6bb175391fd43cd=
28d9ca2d0d5b06157c
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst=
_rod.c#L117
[3] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst=
_test.sh#L150
