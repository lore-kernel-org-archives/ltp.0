From: Travis CI <builds@travis-ci.org>
Date: Tue, 07 Nov 2017 20:17:08 +0000
Subject: [LTP] Errored: linux-test-project/ltp#534 (master - f11172e)
In-Reply-To: <linux-test-project/ltp+298736666+errored@travis-ci.org>
Message-ID: <5a0214c493134_43fcd9f91ada01391594@caa397e9-8422-4638-9470-252a238f6ef0.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #534
Status: Errored

Duration: 14 minutes and 29 seconds
Commit: f11172e (master)
Author: Petr Vorel
Message: numa: Remove HAVE_NUMA_MOVE_PAGES definition

numa_move_pages() was added in NUMA API v2 => replace with
HAVE_NUMA_V2 definition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/c1493efe2357...f11172e481dc

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/298736666?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20171107/437c45d4/attachment-0001.html>
