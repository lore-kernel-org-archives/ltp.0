From: Travis CI <builds@travis-ci.org>
Date: Fri, 03 Mar 2017 12:56:30 +0000
Subject: [LTP] Fixed: linux-test-project/ltp#105 (master - 4db6b7e)
In-Reply-To: <linux-test-project/ltp+207344317+fixed@travis-ci.org>
Message-ID: <58b967fe22154_43fab50ec49703518fb@bf31a8dc-5424-4bfb-8e65-3f4e4b19ce23.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #105
Status: Fixed

Duration: 13 minutes and 55 seconds
Commit: 4db6b7e (master)
Author: Cyril Hrubis
Message: syscalls/keyctl: Fix build

Fixes build without the keyutils devel library.

Introduced in:

commit 91b515cae8cb954927e99a3732b2ee31bc4c15a2
Author: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date:   Fri Mar 3 16:07:35 2017 +0800

    syscalls/keyctl02: Add new regression test

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/91b515cae8cb...4db6b7efb14b

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/207344317

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170303/36dc3fe2/attachment.html>
