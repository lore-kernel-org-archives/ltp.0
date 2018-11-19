From: Travis CI <builds@travis-ci.org>
Date: Mon, 19 Nov 2018 17:55:59 +0000
Subject: [LTP] Broken: linux-test-project/ltp#1152 (master - 5b5740c)
In-Reply-To: <linux-test-project/ltp+457083294+broken@travis-ci.org>
Message-ID: <5bf2f92f159c2_43f7f0fb14a542087d4@803409bf-289e-49de-911f-4df3ccb709c8.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1152
Status: Broken

Duration: 9 mins and 3 secs
Commit: 5b5740c (master)
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

View the changeset: https://github.com/linux-test-project/ltp/compare/e139a4dfc878...5b5740c9582c

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/457083294?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181119/40a4f389/attachment-0001.html>
