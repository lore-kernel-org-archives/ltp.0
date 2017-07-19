From: Travis CI <builds@travis-ci.org>
Date: Wed, 19 Jul 2017 12:40:21 +0000
Subject: [LTP] Still Failing: linux-test-project/ltp#317 (master - 81cc0b3)
In-Reply-To: <linux-test-project/ltp+255239913+still failing@travis-ci.org>
Message-ID: <596f5335c65b_43fb95256566c12420ae@8d97d202-482c-4637-955b-9a730e0b38cd.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #317
Status: Still Failing

Duration: 9 minutes and 8 seconds
Commit: 81cc0b3 (master)
Author: Cyril Hrubis
Message: cve/Makefile: Fix build.

When compiling with pthreads we should set CFLAGS+=-pthread rather than
LDFLAGS+=-lpthread.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/9ebed1fefc2a...81cc0b3353ca

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/255239913?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170719/d8af2fcd/attachment.html>
