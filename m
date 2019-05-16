From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 16 May 2019 18:10:49 -0400
Subject: [LTP] [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <20190515120853.GA22992@dell5510>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510> <1557889279.4581.14.camel@linux.ibm.com>
 <20190515120853.GA22992@dell5510>
Message-ID: <1558044649.4507.10.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, 2019-05-15 at 14:08 +0200, Petr Vorel wrote:
> > evm_overlay 1 TINFO: overwrite file in overlay
> > tst_rod: Failed to open '(null)' for writing: Operation not permitted
> > evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly

> I've fixed '(null)' [1], with that one applied it should be 'mntpoint/merged/foo1.txt'

Thanks!

> But what is strange to me is that it continues to execute second line. return 1 [2]
> should cause ROD() to quit with TBROK [3].
> Maybe that ROD in test1() should be replaced EXPECT_PASS.

With just the first patch of Ignaz's path set [1] and the TPM 2.0 test
[2], there aren't any errors.  Without [1], it's now failing with the
correct name.  I'm now seeing:

evm_overlay 1 TINFO: $TMPDIR is on tmpfs => run on loop device
evm_overlay 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
evm_overlay 1 TINFO: overwrite file in overlay
tst_rod: Failed to open 'mntpoint/merged/foo1.txt' for writing: Permission denied
evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly

Mimi

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://lore.kernel.org/linux-integrity/1558041162.3971.2.camel@linux.ibm.com/T/#u

