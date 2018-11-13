From: Travis CI <builds@travis-ci.org>
Date: Tue, 13 Nov 2018 12:59:24 +0000
Subject: [LTP] Errored: linux-test-project/ltp#1136 (master - 158f68e)
In-Reply-To: <linux-test-project/ltp+454470293+errored@travis-ci.org>
Message-ID: <5beacaabd184d_43fb8a2c4a0f0530bc@6dfdcd38-92da-4cca-909d-abbeade9a958.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1136
Status: Errored

Duration: 7 mins and 10 secs
Commit: 158f68e (master)
Author: Steve Muckle
Message: syscalls/sighold02: ignore reserved signals

Some signals may be internally used by the C library. Do not attempt to
verify these.

Signed-off-by: Steve Muckle <smuckle@google.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/f6a2a47feeaa...158f68e5561d

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/454470293?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181113/a0b20e56/attachment.html>
