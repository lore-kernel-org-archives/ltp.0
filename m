From: Travis CI <builds@travis-ci.org>
Date: Mon, 19 Nov 2018 18:17:47 +0000
Subject: [LTP] Fixed: linux-test-project/ltp#1153 (master - 56e2f32)
In-Reply-To: <linux-test-project/ltp+457090481+fixed@travis-ci.org>
Message-ID: <5bf2fe4af0152_43fac88629b881054ec@4ab8e342-69a6-4da7-8439-8f420f945584.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1153
Status: Fixed

Duration: 13 mins and 42 secs
Commit: 56e2f32 (master)
Author: Subash Ganesan
Message: Testing statx syscall Timestamp fields

The time before and after the execution of the corresponding
system call is noted.

It is checked whether the time returned by statx lies in this range.

open syscall with O_CREAT flag for birth time.
write syscall for modified time.
read syscall for access time.
chmod syscall for status change time.

Signed-off-by: Subash Ganesan <subash@zilogic.com>
Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/5b5740c9582c...56e2f3253c7b

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/457090481?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181119/3a169cd2/attachment.html>
