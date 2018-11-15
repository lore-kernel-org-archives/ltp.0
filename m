From: Travis CI <builds@travis-ci.org>
Date: Thu, 15 Nov 2018 15:25:13 +0000
Subject: [LTP] Failed: linux-test-project/ltp#1144 (metan - 3eaa550)
In-Reply-To: <linux-test-project/ltp+455547759+failed@travis-ci.org>
Message-ID: <5bed8fd8ccf6f_43fe21bc429d422451d@95b25bf9-ed58-45a2-a808-4dc37ea0628e.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1144
Status: Failed

Duration: 5 mins and 23 secs
Commit: 3eaa550 (metan)
Author: Cristian Marussi
Message: cpuset_hotplug: fix cpuset_list_compute

cpuset_hotplug failed with:

Usage : cpuset_list_compute [-a|s] list1 [list2]

        -a|s   list1 add/subtract list2.[default: -a]

        -h     Help.
cpuset_hotplug 1 TFAIL: root group's cpus isn't expected(Result: 0,2-5, Expect: ).

It turned out that the helper cpuset_list_compute was always failing
because it was improperly handling getopt retval using a char variable;
in such a case the while() loop used around getopt never gets false,
and as a consequence getopt() keeps on being invoked parsing also the
following unknown non-option input material: this in turn leads to
the loop termination through the default switch-label that finally
terminates the program without doing anything each time.

This condition can also be spotted during the compilation process:

cpuset_list_compute.c: In function 'checkopt':
cpuset_list_compute.c:35:41: warning: comparison is always true due to limited range of data type [-Wtype-limits]
  while ((c = getopt(argc, argv, "ahs")) != -1) {
                                         ^~

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/metan

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/455547759?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181115/d9659f2c/attachment-0001.html>
