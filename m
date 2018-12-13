From: Travis CI <builds@travis-ci.org>
Date: Thu, 13 Dec 2018 08:06:35 +0000
Subject: [LTP] Errored: linux-test-project/ltp#1230 (master - 310c9eb)
In-Reply-To: <linux-test-project/ltp+467382075+errored@travis-ci.org>
Message-ID: <5c12130af03f5_43fdc2d58d59c361692@bc2d0b8f-4ec5-42bc-a574-56704f44d91d.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1230
Status: Errored

Duration: 12 mins and 57 secs
Commit: 310c9eb (master)
Author: Enji Cooper
Message: Remove explicit #define's for `_POSIX_C_SOURCE` and `_XOPEN_SOURCE`

These are already set via CFLAGS; there's no need for all of the code
duplication.

Any and all orphan comments and/or `#ifndef WITHOUT_XOPEN` / `#endif`
blocks are removed as part of this commit.

`WITHOUT_XOPEN` will be removed in a subsequent commit.

View the changeset: https://github.com/linux-test-project/ltp/compare/4429c059927c...310c9eb6e6af

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/467382075?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181213/5302b3e6/attachment-0001.html>
