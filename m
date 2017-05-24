From: Travis CI <builds@travis-ci.org>
Date: Wed, 24 May 2017 11:36:36 +0000
Subject: [LTP] Broken: linux-test-project/ltp#212 (master - dcf361c)
In-Reply-To: <linux-test-project/ltp+235602463+broken@travis-ci.org>
Message-ID: <592570441dc20_43fcb090a111c69322@17e68c0e-9823-4cdc-9f5f-73097272f2a4.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #212
Status: Broken

Duration: 4 minutes and 29 seconds
Commit: dcf361c (master)
Author: Cyril Hrubis
Message: lib,testcases: Make use of MIN() and MAX()

Produced by variations on coccinelle spatch:

@@
expression E1,E2;
@@

- (E1 > E2 ? E1 : E2)
+ MAX(E1, E2)

@@
expression E1,E2;
identifier V;
@@

- if (E1 < E2)
- V = E1;
- else
- V = E2;
+ V = MIN(E1, E2);

...

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/a5bf5254ca94...dcf361cb4f20

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/235602463?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170524/8e50c091/attachment.html>
