From: Travis CI <builds@travis-ci.org>
Date: Wed, 17 Jan 2018 15:27:59 +0000
Subject: [LTP] Errored: linux-test-project/ltp#616 (master - fecdd88)
In-Reply-To: <linux-test-project/ltp+329915294+errored@travis-ci.org>
Message-ID: <5a5f6b7db41b2_43fe37e51114c302191@e6a90823-4ed8-4a9b-a482-470e35954d28.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #616
Status: Errored

Duration: 16 minutes and 53 seconds
Commit: fecdd88 (master)
Author: Cyril Hrubis
Message: tst_test: Fix exit value on tst_brk(TCONF, ...)

We decided not to propagate TCONF into the test exit value in a case
that the test had at least one TPASS in:

commit 5390d6ea36578c1fac8adc416b6f91aa4a330a08
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Thu Sep 7 15:47:22 2017 +0200

    lib/tst_test: Report 0 if test has both TPASS and TCONF

However this commit missed a case when TCONF is passed directly to the
do_exit() function. This may happen in two cases actually, one of the is
tst_brk(TCONF, ...) called from a test and second one is more subtle and
happens when the last result in the run_tcases_per_fs() produces TCONF
which is then propagated to the do_exit() function.

This commit simply masks the TCONF from the exit value in this cases if
we happen to have non-zero success counter.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Jan Stancek <jstancek@redhat.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/a2e789cac04b...fecdd885eb4b

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/329915294?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180117/c0b008af/attachment-0001.html>
