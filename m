From: Travis CI <builds@travis-ci.org>
Date: Mon, 12 Mar 2018 14:11:16 +0000
Subject: [LTP] Errored: linux-test-project/ltp#699 (master - 67c95fb)
In-Reply-To: <linux-test-project/ltp+352345577+errored@travis-ci.org>
Message-ID: <5aa68a846c12_43fcf924d5e1c1134186@742623e8-1050-46c6-b205-a80535524ffb.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #699
Status: Errored

Duration: 14 minutes and 43 seconds
Commit: 67c95fb (master)
Author: Richard Palethorpe
Message: Add read_all file systems test

While using a shell script I wrote, which dumps the contents of /sys and
/proc (submitted in a separate patch), I found some minor kernel bugs. There
is already a test specifically for /proc however it is attempting to verify
the behavior of particular files. This test is more general and can be applied
to any file system.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/3de6dcba463e...67c95fbbfc3a

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/352345577?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications







This email was sent to ltp@lists.linux.it (mailto:ltp@lists.linux.it)
unsubscribe from this list (http://clicks.travis-ci.com/track/unsub.php?u=14313403&id=6513cee49f474257bbd77275b99e9383.nwh%2ButJmyvjUjRzsB8BeiP5x1%2B8%3D&r=https%3A%2F%2Fmandrillapp.com%2Funsub%3Fmd_email%3Dltp%2540lists.linux.it)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180312/c031bd28/attachment-0001.html>
