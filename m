From: Travis CI <builds@travis-ci.org>
Date: Mon, 15 Jan 2018 13:46:38 +0000
Subject: [LTP] Errored: linux-test-project/ltp#614 (master - fdefef3)
In-Reply-To: <linux-test-project/ltp+329049810+errored@travis-ci.org>
Message-ID: <5a5cb0be73bf7_43f949525fef45066aa@24a63346-dc97-4e59-97b4-2ecfe83e5034.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #614
Status: Errored

Duration: 18 minutes and 58 seconds
Commit: fdefef3 (master)
Author: Cyril Hrubis
Message: execltp: Strip newlines from fd.readlines()

Othewise the paths to the runtest files ends up with newline which
causes the script fail with ENOENT when attempting to open the files.

Reported-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Tested-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

View the changeset: https://github.com/linux-test-project/ltp/compare/8cce5de91bc0...fdefef3202f6

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/329049810?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180115/35554f06/attachment.html>
