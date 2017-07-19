From: Travis CI <builds@travis-ci.org>
Date: Wed, 19 Jul 2017 12:55:29 +0000
Subject: [LTP] Fixed: linux-test-project/ltp#318 (master - 19bba3c)
In-Reply-To: <linux-test-project/ltp+255241970+fixed@travis-ci.org>
Message-ID: <596f56c1ad336_43fcd4b15decc16276a@bfe034bd-2c61-42ec-8b19-bf3405812bba.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #318
Status: Fixed

Duration: 18 minutes and 43 seconds
Commit: 19bba3c (master)
Author: Cyril Hrubis
Message: cve/Makefile: Fix LDLIBS vs LDFLAGS.

The order of libraries matters when linking, hence if we use LDFLAGS
incorrectly instead of LDLIBS the test will still fail to link on
certain distributions.

Remeber LDFLAGS is mainly for -I directives while LDLIBS if mainly for
-lfoo.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/81cc0b3353ca...19bba3cf27da

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/255241970?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170719/5a213a62/attachment-0001.html>
