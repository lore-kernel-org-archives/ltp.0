From: Lei, Shaoting <leist.fnst@cn.fujitsu.com>
Date: Wed, 18 Oct 2017 08:47:03 +0000
Subject: [LTP] [PATCH] ltp/testcases/kernel/fs/doio/rwtest: fix rwtest
In-Reply-To: <1508315410-18147-1-git-send-email-xiangx.dai@intel.com>
References: <1508315410-18147-1-git-send-email-xiangx.dai@intel.com>
Message-ID: <9A231BE5D02F5B4683229C96D4C5BF6601328D59A4@G08CNEXMBPEKD01.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

    fix the following issue:   rwtest01-rwtest04.fail
    -----------
    iogen(rwtest02): get_file_info():  Could not stat() /lkp/benchmarks/ltp/testcases/bin/rw-buffered-12736:  No such file or directory
    iogen(rwtest02) warning:  Error getting file info for rw-buffered-12736
    iogen(rwtest02):  Could not create, or gather info for any test files
    rwtest(rwtest02) : iogen reported errors (r=2)
    -----------
    When the size of test file is 0, we should use the default size. But the code of LTP missed to deal with this situation.

Signed-off-by: Shaoting Lei <leist.fnst@cn.fujitsu.com>
---
 testcases/kernel/fs/doio/rwtest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest index 90b1658..d22b1ff 100644
--- a/testcases/kernel/fs/doio/rwtest
+++ b/testcases/kernel/fs/doio/rwtest
@@ -344,7 +344,7 @@ do
 
 			# check if blks is a number, else set a default value for blks
 			default_sz=1000000
-			if [ $blks -eq $blks 2> /dev/null ]
+			if [ $blks -eq $blks 2> /dev/null && $blks -ne 0 ]
 			then
 
 				case $(uname) in
--
2.7.4





