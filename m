From: Travis CI <builds@travis-ci.org>
Date: Wed, 18 Apr 2018 06:11:10 +0000
Subject: [LTP] Errored: linux-test-project/ltp#759 (master - a0bc40d)
In-Reply-To: <linux-test-project/ltp+367803952+errored@travis-ci.org>
Message-ID: <5ad6e17dcba3c_43f9e196385701307823@6c41ee02-ea54-406b-b1d2-cd774a36365b.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #759
Status: Errored

Duration: 2 mins and 20 secs
Commit: a0bc40d (master)
Author: Petr Vorel
Message: network/vxlan02.sh: Fix duplicate parameters

vxlan02 and vxlan02_ipv6 tests had duplicate parameters 'dev ltp_ns_veth2':
ip li add ltp_v0 type vxlan dstport 0 id 16700000 group 239.1.1.1 dev ltp_ns_veth2 dev ltp_ns_veth2
Error: either "dev" is duplicate, or "ltp_ns_veth2" is a garbage.

Device was specified in in both the test file itself and in virt_add()
function in virt_lib.sh. Removed in test to be consistent with vlan02.sh.

Fixes: 8e5862c20 ("net: vxlan02: specify interface when adding multicast dst")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>

View the changeset: https://github.com/linux-test-project/ltp/compare/06ee2b0273bd...a0bc40d9c6e6

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/367803952?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications







This email was sent to ltp@lists.linux.it (mailto:ltp@lists.linux.it)
unsubscribe from this list (http://clicks.travis-ci.com/track/unsub.php?u=14313403&id=130843886189423486eca4f519056c0f.nwh%2ButJmyvjUjRzsB8BeiP5x1%2B8%3D&r=https%3A%2F%2Fmandrillapp.com%2Funsub%3Fmd_email%3Dltp%2540lists.linux.it)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180418/0c67cb87/attachment-0001.html>
