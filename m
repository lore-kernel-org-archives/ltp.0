From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 9 Nov 2016 18:29:22 +0300
Subject: [LTP] du01 with btrfs on systems with > 4k page size
Message-ID: <582340D2.6070502@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

On SPARC the default page size is 8k.

And du01 fails with btrfs at check3:

du01 3 TFAIL : 'du -a' failed
du01 4 TINFO : Looking for '[0-4][[:space:]]\.\/testdir\/testsymlink' in:
10240  ./testfile
8      ./testdir/testsymlink
8      ./testdir
10248  .
du01 4 TFAIL : 'du --all' failed
du01 5 TINFO : Looking for '[0-4][[:space:]]\.\/testdir\/testsymlink' in:
10240  ./testfile
8      ./testdir/testsymlink
8      ./testdir
10248  .

i.e. the testsymlink is 8k whereas at most 4k is expected by the test case.

In commit bdd09b1c6f2c8ad ("du01.sh: Fix failures on Btrfs on ppc64le")
a similar situation was fixed, but for check5 and check6. I'm curious
why check3 doesn't fail on ppc64. It seems it should fail with the
current code.

Could, please, anybody with access to a ppc64 box run this test case
with btrfs and/or provide the output from commands:

[root@skholman-m7 du]# cd /mnt
[root@skholman-m7 mnt]# mkdir basedir
[root@skholman-m7 mnt]# cd basedir/
[root@skholman-m7 basedir]# dd if=/dev/zero of=testfile bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10 MB) copied, 0.00825522 s, 1.3 GB/s
[root@skholman-m7 basedir]# mkdir -p testdir
[root@skholman-m7 basedir]# ln -s ../testfile testdir/testsymlink
[root@skholman-m7 basedir]# du -a
10240	./testfile
8	./testdir/testsymlink
8	./testdir
10248	.
[root@skholman-m7 basedir]#

?

Thanks.
