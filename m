From: Travis CI <builds@travis-ci.org>
Date: Thu, 20 Dec 2018 17:23:51 +0000
Subject: [LTP] Errored: linux-test-project/ltp#1255 (master - db9eace)
In-Reply-To: <linux-test-project/ltp+470610616+errored@travis-ci.org>
Message-ID: <5c1bd026de21d_43fd381d20ca016348e@20234192-579e-48da-866c-ed792f5a2b3e.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1255
Status: Errored

Duration: 15 mins and 29 secs
Commit: db9eace (master)
Author: Alexey Kodanev
Message: lib/tst_net.sh: determine ping command based on dst addr

tst_ping() can be used with the empty TST_IPV6, for example in
the virtual tunnel tests, with IPv6 over IPv4 scenario.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/49cbfb45a050...db9eace87950

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/470610616?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181220/f8c51d73/attachment-0001.html>
