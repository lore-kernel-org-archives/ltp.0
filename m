From: Travis CI <builds@travis-ci.org>
Date: Wed, 30 Aug 2017 15:15:43 +0000
Subject: [LTP] Fixed: linux-test-project/ltp#399 (master - 6bf30c6)
In-Reply-To: <linux-test-project/ltp+270031988+fixed@travis-ci.org>
Message-ID: <59a6d69fa2f52_43fc1de11d688118294@219c492c-e9bc-4db4-93f8-b8479e5f11a2.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #399
Status: Fixed

Duration: 14 minutes and 16 seconds
Commit: 6bf30c6 (master)
Author: Cyril Hrubis
Message: tracing/dynamic_debug01: Fix Makefile

I should have checked that the top_srcdir is set correctly and that the
make && make install works, sorry.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/79ff3609ec94...6bf30c65f088

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/270031988?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170830/2cb13700/attachment.html>
