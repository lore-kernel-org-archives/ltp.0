From: Travis CI <builds@travis-ci.org>
Date: Tue, 27 Mar 2018 15:18:25 +0000
Subject: [LTP] Errored: linux-test-project/ltp#726 (master - 05398fa)
In-Reply-To: <linux-test-project/ltp+358922312+errored@travis-ci.org>
Message-ID: <5aba60c15a6ad_43fcd67aa370411368a5@23d99168-b82a-45d2-8a55-b84fa9a8a92a.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #726
Status: Errored

Duration: 25 minutes and 37 seconds
Commit: 05398fa (master)
Author: Petr Vorel
Message: travis: Reintroduce repetition of apt update

as failures occurred again (unofficial packages, again):
E: Failed to fetch http://dl.bintray.com/apache/cassandra/dists/39x/main/binary-amd64/Packages  502  Bad Gateway [IP: 52.27.175.225 80]
E: Failed to fetch http://dl.bintray.com/apache/cassandra/dists/39x/main/binary-i386/Packages  502  Bad Gateway [IP: 52.27.175.225 80]
E: Some index files failed to download. They have been ignored, or old ones used instead.

Signed-off-by: Petr Vorel <pvorel@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/fc42ec9f78b6...05398fae705c

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/358922312?utm_source=email&utm_medium=notification

--

You can configure recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications







This email was sent to ltp@lists.linux.it (mailto:ltp@lists.linux.it)
unsubscribe from this list (http://clicks.travis-ci.com/track/unsub.php?u=14313403&id=febe2f86720d4bf3a5ab4e6179948e11.nwh%2ButJmyvjUjRzsB8BeiP5x1%2B8%3D&r=https%3A%2F%2Fmandrillapp.com%2Funsub%3Fmd_email%3Dltp%2540lists.linux.it)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180327/c0b7ee54/attachment.html>
