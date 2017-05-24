From: Travis CI <builds@travis-ci.org>
Date: Wed, 24 May 2017 12:05:41 +0000
Subject: [LTP] Still Failing: linux-test-project/ltp#214 (master - f652f65)
In-Reply-To: <linux-test-project/ltp+235611553+still failing@travis-ci.org>
Message-ID: <59257714756ba_43fcb090ba9b4724470@17e68c0e-9823-4cdc-9f5f-73097272f2a4.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #214
Status: Still Failing

Duration: 5 minutes and 5 seconds
Commit: f652f65 (master)
Author: Alexey Kodanev
Message: rup01: fix test for hostname length > 24

'rup' limits the length of host name in output:

  from rup.c:
  ...
  #define HOST_WIDTH 24
  ...
  printf("%-*.*s", HOST_WIDTH, HOST_WIDTH, host);

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/6229357c252a...f652f6583783

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/235611553?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170524/e96b9d40/attachment.html>
