From: Travis CI <builds@travis-ci.org>
Date: Thu, 02 Feb 2017 09:50:13 +0000
Subject: [LTP] Errored: pevik-travis/ltp#56 (test - 121dba5)
In-Reply-To: <pevik-travis/ltp+197585558+errored@travis-ci.org>
Message-ID: <589300f337df8_43fe5000ddc0068863b@98158b4c-e8b1-4cd9-b8ea-6c62f4d4596c.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for pevik-travis/ltp
-------------------------------------

Build: #56
Status: Errored

Duration: 3 minutes and 47 seconds
Commit: 121dba5 (test)
Author: Cyril Hrubis
Message: madvise01: Fix MADV_FREE

Currently MADV_FREE works only on anonymous pages.

Also the test was passing a file descriptor to the MAP_ANONYMOUS mmap(),
which is not wrong since the fd argument is ignored in that case, but it
was mildly confusing. So now we pass -1 and the pointer variable is
called amem instead of pfile which was confusing as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/pevik-travis/ltp/compare/test

View the full build log and details: https://travis-ci.org/pevik-travis/ltp/builds/197585558

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170202/31495ca9/attachment.html>
