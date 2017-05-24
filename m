From: Travis CI <builds@travis-ci.org>
Date: Wed, 24 May 2017 12:21:46 +0000
Subject: [LTP] Fixed: linux-test-project/ltp#215 (master - 77b5e70)
In-Reply-To: <linux-test-project/ltp+235614259+fixed@travis-ci.org>
Message-ID: <59257ada28bd4_43fcb08d7ac7c7464cd@17e68c0e-9823-4cdc-9f5f-73097272f2a4.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #215
Status: Fixed

Duration: 14 minutes and 1 second
Commit: 77b5e70 (master)
Author: Cyril Hrubis
Message: fallocate02: Fix compilation

This fixes commit:

commit a14f756d5890cee192f1cffe403b7607074a9b72
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Tue May 23 16:25:25 2017 +02001

    Unify MIN()/MAX() implementation + cleanup

The LLONG_MAX definition is missing on some distributions unless the
test includes limits.h as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/f652f6583783...77b5e7078af6

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/235614259?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170524/cc7b6c3d/attachment-0001.html>
