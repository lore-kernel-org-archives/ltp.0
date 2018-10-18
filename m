From: Travis CI <builds@travis-ci.org>
Date: Thu, 18 Oct 2018 08:40:12 +0000
Subject: [LTP] Fixed: linux-test-project/ltp#1088 (master - dd79c1f)
In-Reply-To: <linux-test-project/ltp+443068920+fixed@travis-ci.org>
Message-ID: <5bc846ebb79f1_43fa85b417c402004c5@cc8db2bc-8554-4e72-9d97-92a76092c66a.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1088
Status: Fixed

Duration: 13 mins and 47 secs
Commit: dd79c1f (master)
Author: Cyril Hrubis
Message: tracing/intel_pt: Fix build on older userspace.

Older userspace linux headers do not have aux_* fields struct
perf_event_mmap_page. This commit disables the test build if older
headers were detected, the alternative would be adding a fallback
definition to LTP but I doubt that it's worth the effort.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Ammy Yi <ammy.yi@intel.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Jan Stancek <jstancek@redhat.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/e816127e5d8e...dd79c1f16b20

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/443068920?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181018/73ced2b7/attachment-0001.html>
