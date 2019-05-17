From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 May 2019 09:50:58 +0200
Subject: [LTP] [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
In-Reply-To: <1558044649.4507.10.camel@linux.ibm.com>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190514121213.GA28655@dell5510>
 <1557889279.4581.14.camel@linux.ibm.com>
 <20190515120853.GA22992@dell5510>
 <1558044649.4507.10.camel@linux.ibm.com>
Message-ID: <20190517075057.GA12489@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> > But what is strange to me is that it continues to execute second line. return 1 [2]
> > should cause ROD() to quit with TBROK [3].
> > Maybe that ROD in test1() should be replaced EXPECT_PASS.

> With just the first patch of Ignaz's path set [1] and the TPM 2.0 test
> [2], there aren't any errors.  Without [1], it's now failing with the
> correct name.  I'm now seeing:
I guess, that justifies [1] to be merged into kernel.

> evm_overlay 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> evm_overlay 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> evm_overlay 1 TINFO: overwrite file in overlay
> tst_rod: Failed to open 'mntpoint/merged/foo1.txt' for writing: Permission denied
> evm_overlay 1 TFAIL: echo overlay > mntpoint/merged/foo1.txt failed unexpectedly
That still does not explain, why test doesn't exit before this last line.
I'll have a closer look into it. But as I wrote, I'll make these changes:

diff --git testcases/kernel/security/integrity/ima/tests/evm_overlay.sh testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index 08ec1ea37..1d05b9e1c 100755
--- testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -40,7 +40,7 @@ test1()
 	local file="foo1.txt"
 
 	tst_res TINFO "overwrite file in overlay"
-	ROD echo lower \> $lower/$file
+	EXPECT_PASS echo lower \> $lower/$file
 	EXPECT_PASS echo overlay \> $merged/$file
 }
 
@@ -49,7 +49,7 @@ test2()
 	local file="foo2.txt"
 
 	tst_res TINFO "append file in overlay"
-	ROD echo lower \> $lower/$file
+	EXPECT_PASS echo lower \> $lower/$file
 	EXPECT_PASS echo overlay \>\> $merged/$file
 }
 
---
If it's ok for you and it's a valid test do you give an ack?

Kind regards,
Petr

> Mimi

> [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> [2] https://lore.kernel.org/linux-integrity/1558041162.3971.2.camel@linux.ibm.com/T/#u

