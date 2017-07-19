From: Travis CI <builds@travis-ci.org>
Date: Wed, 19 Jul 2017 12:17:26 +0000
Subject: [LTP] Broken: linux-test-project/ltp#316 (master - 9ebed1f)
In-Reply-To: <linux-test-project/ltp+255229332+broken@travis-ci.org>
Message-ID: <596f4dd6413fc_43fcd4b113b3815738d3@bfe034bd-2c61-42ec-8b19-bf3405812bba.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #316
Status: Broken

Duration: 12 minutes and 58 seconds
Commit: 9ebed1f (master)
Author: Xiao Yang
Message: syscalls/clone09.c: Fix compilation without CLONE_NEWNET

Compilation failed on some older distributions(e.g. RHEL5.11) due
to undefined CLONE_NEWNET, so we include namespaces_constants.h to
fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/1140e920ef74...9ebed1fefc2a

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/255229332?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170719/10254a82/attachment.html>
