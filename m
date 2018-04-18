From: Travis CI <builds@travis-ci.org>
Date: Wed, 18 Apr 2018 06:11:10 +0000
Subject: [LTP] Errored: linux-test-project/ltp#758 (master - 06ee2b0)
In-Reply-To: <linux-test-project/ltp+367800244+errored@travis-ci.org>
Message-ID: <5ad6e17ddcc87_43f998730934088732@eb916adb-7a19-4471-b2fc-8a4defefe881.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #758
Status: Errored

Duration: 2 mins and 38 secs
Commit: 06ee2b0 (master)
Author: Petr Vorel
Message: network/vxlan03: Fix getopts parameters passed to virt_lib.sh

vxlan03.sh pass getopts parameter to virt_lib.sh (other than -6 which is
handled by tst_net.sh), so they must be processed before loading
tst_net.sh. Therefore vxlan03.sh must load virt_lib.sh before loading
tst_net.sh and virt_lib.sh must shift parameters.

Also load tst_net.sh in vxlan03.sh, as it uses functions from network
API (old error).

Other users of vxlan03.sh not fixed as they pass just -6 parameter.

Fixes: ba53eb04e tst_net.sh: Support both new and legacy APIs + rename

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Alexey Kodanev <alexey.kodanev@oracle.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/48b24bc626fa...06ee2b0273bd

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/367800244?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications







This email was sent to ltp@lists.linux.it (mailto:ltp@lists.linux.it)
unsubscribe from this list (http://clicks.travis-ci.com/track/unsub.php?u=14313403&id=ff2901e77a5c4910ade75ad0022ea956.nwh%2ButJmyvjUjRzsB8BeiP5x1%2B8%3D&r=https%3A%2F%2Fmandrillapp.com%2Funsub%3Fmd_email%3Dltp%2540lists.linux.it)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180418/89846fd0/attachment.html>
