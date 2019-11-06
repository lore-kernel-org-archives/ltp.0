From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  6 Nov 2019 13:57:42 +0100
Subject: [LTP] [PATCH 0/1] LVM (growfiles) workdir fix
Message-ID: <20191106125743.29952-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The LVM tests are currently failing in OpenQA because the /test/growfiles
directory doesn't exist and the growfiles test program fails to create its 
working subdirectories. It's a simple fix - just create the missing parent
directories.

I've skipped porting the test program to the new API because it's 3000+ lines
long and the fix is almost trivial. Here are OpenQA verification runs
with the fix applied:
https://openqa.suse.de/tests/3563470
https://openqa.suse.de/tests/3563513

We should also move the mkpath() function to the LTP library later because
it'll be useful for other tests.

Martin Doucha (1):
  Create full path to workdir in fs/doio/growfiles.c

 testcases/kernel/fs/doio/growfiles.c | 71 +++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 18 deletions(-)

-- 
2.23.0

