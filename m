From: Travis CI <builds@travis-ci.org>
Date: Fri, 14 Dec 2018 13:01:44 +0000
Subject: [LTP] Errored: linux-test-project/ltp#1235 (master - b833bee)
In-Reply-To: <linux-test-project/ltp+467981232+errored@travis-ci.org>
Message-ID: <5c13a9b760a2e_43fb2783d3b90134020@42242627-c582-4aa1-a969-1ba2b76035d1.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1235
Status: Errored

Duration: 12 mins and 16 secs
Commit: b833bee (master)
Author: Xiao Yang
Message: openposix/strncpy1-1: Fix compiler errors/warnings

pragma diagnostic can support push/pop and be allowed inside functions
by commit 0955be65 on gcc-4.6, and it can support -Wstringop-truncation
by commit d8aad78 on gcc-8.1.  We try to avoid some compiler errors or
warnings by removing pragma diagnostic for test directly, because we
don't get any failure after removing it on old/new gcc.

For example:
1)compiling test gets the following error on gcc-4.4:
  ------------------------------------------------------
  error: #pragma GCC diagnostic not allowed inside functions
  ------------------------------------------------------
2)compiling test gets the following warning on gcc-4.8:
  -----------------------------------------------------
  warning: unknown option after ‘#pragma GCC diagnostic’ kind [-Wpragmas]
  ------------------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/00a83ebb71a0...b833bee5fe9f

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/467981232?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181214/6c7f32c2/attachment-0001.html>
