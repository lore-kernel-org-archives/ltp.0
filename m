From: Martin Karac <martin.karac@oracle.com>
Date: Mon,  5 Jun 2017 17:00:46 +0000
Subject: [LTP] [PATCH 1/1] do not test undefined behavior
Message-ID: <1496682046-19155-1-git-send-email-martin.karac@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test_flags() function's first test for each file is an attempt
to write a space character into that file (NULL translates to " ").
The test expects that this attempt will be successful and that the flag
will get set to 0.

This behavior was changed in Linux kernel between versions 3.13.74 and
3.14. with the commit a742c59de66ea080afa3edaf3428b3cdd5aa87cd
"cgroup: unify cgroup_write_X64() and cgroup_write_string()".
With the new behavior, attempting to write a space character into
a flag file returns EINVAL; I find this behavior more consistent.

Flag files are an interface which is known to expect numeric values.
We already have a test in test_flags() which covers invalid input.
We should not attempt to write a space into a flag file because
the resulting behavior is not strictly defined anywhere.
Therefore, it would be best to drop the first test.

Signed-off-by: Martin Karac <martin.karac@oracle.com>
---
 .../cpuset_base_ops_testset.sh                     |    1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
index 992b8f2..70e7203 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_base_ops_test/cpuset_base_ops_testset.sh
@@ -181,7 +181,6 @@ test_flags()
 		do
 			base_op_test "$CPUSET/$filename" "$flags" "$result"
 		done <<- EOF
-			NULL	0
 			0	0
 			1	1
 			-1	WRITE_ERROR
-- 
1.7.9.2

