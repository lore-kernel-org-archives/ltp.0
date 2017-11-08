From: Travis CI <builds@travis-ci.org>
Date: Wed, 08 Nov 2017 15:09:27 +0000
Subject: [LTP] Passed: linux-test-project/ltp#535 (master - cecbd0c)
In-Reply-To: <linux-test-project/ltp+299139951+passed@travis-ci.org>
Message-ID: <5a031e26b2d96_43ff77424a2b01431587@403ca7e6-a06f-409a-bfe1-87df42680162.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #535
Status: Passed

Duration: 14 minutes and 58 seconds
Commit: cecbd0c (master)
Author: Veronika Kabatova
Message: Fix buffer overflow in print_result() function

From man page: "The functions snprintf() and vsnprintf() do not write
more than size bytes (including the terminating null byte ('\0')). If
the output was truncated due to this limit, then the return value is the
number of characters (excluding the terminating null byte) which would
have been written to the final string if enough space had been
available. Thus, a return value of `size` or more means that the output
was truncated."

The return value is not checked and blindly subtracted from available
space in the buffer which may cause negative values (which are then
converted to unsigned type size_t) in case the variables to print don't
fit into buffer. The pointer to buffer is also moved forward the same
amount, and writing into memory that is not allocated causes unexpected
failures of tests with segfaults.

This was discovered during rewriting of mtest06/mmap1 testcase to new
library where verbose output tried to print out memory contents longer
than space available in the buffer. The framework should be robust
enough to handle these situations.

Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/f11172e481dc...cecbd0cb36d6

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/299139951?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171108/9ac08f8a/attachment.html>
