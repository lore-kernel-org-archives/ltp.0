From: Travis CI <builds@travis-ci.org>
Date: Fri, 02 Mar 2018 16:09:29 +0000
Subject: [LTP] Errored: linux-test-project/ltp#681 (master - 6f407c7)
In-Reply-To: <linux-test-project/ltp+348283888+errored@travis-ci.org>
Message-ID: <5a997738f383c_43fd27ec5bf1c1744084@aecc662a-23f7-4696-957c-b2387f5c3876.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #681
Status: Errored

Duration: 14 minutes and 53 seconds
Commit: 6f407c7 (master)
Author: Cyril Hrubis
Message: syscalls/inotify04: Fix & Cleanups.

* Move file/directory creation from setup to
  the test fuction, we remove these in the test
  fucntion hence we have to create them on each
  iteration as well for the -i option

* Get rid of TST_TOTAL, use test_cnt instead
  as a side effect this fixes the -i option

* Make use of SAFE_MACROS() in cleanup

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/22d43a959bb7...6f407c76286c

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/348283888?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180302/013ba057/attachment.html>
