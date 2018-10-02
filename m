From: Travis CI <builds@travis-ci.org>
Date: Tue, 02 Oct 2018 12:59:12 +0000
Subject: [LTP] Errored: linux-test-project/ltp#1058 (master - 73f0137)
In-Reply-To: <linux-test-project/ltp+436115159+errored@travis-ci.org>
Message-ID: <5bb36b9ff127c_43f7df9d92b58336140@f9559001-9984-44ae-9e0f-c09435a64cd1.mail>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Build Update for linux-test-project/ltp
-------------------------------------

Build: #1058
Status: Errored

Duration: 24 mins and 38 secs
Commit: 73f0137 (master)
Author: Yixin Zhang
Message: ver_linux: check /usr/lib/os-release in case /etc/os-release not exists

https://www.linux.org/docs/man5/os-release.html:
  "The file /etc/os-release takes precedence over /usr/lib/os-release.
  Applications should check for the former, and exclusively use its data
  if it exists, and only fall back to /usr/lib/os-release if it is missing.
  Applications should not read data from both files at the same time.
  /usr/lib/os-release is the recommended place to store OS release
  information as part of vendor trees.  /etc/os-release should be a
  relative symlink to /usr/lib/os-release, to provide compatibility with
  applications only looking at /etc. A relative symlink instead of an
  absolute symlink is necessary to avoid breaking the link in a chroot or
  initrd environment such as dracut."

To be compatible with some distro which don't have the soft link
"/etc/os-release", check "/usr/lib/os-release" first before checking
"/etc/issue".

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>

View the changeset: https://github.com/linux-test-project/ltp/compare/9c768668e62b...73f01377e162

View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/436115159?utm_medium=notification&utm_source=email

--

You can unsubscribe from build emails from the linux-test-project/ltp repository going to https://travis-ci.org/account/preferences/unsubscribe?repository=1224421&utm_medium=notification&utm_source=email.
Or unsubscribe from *all* email updating your settings at https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email.
Or configure specific recipients for build notifications in your .travis.yml file. See https://docs.travis-ci.com/user/notifications.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181002/e09619e5/attachment-0001.html>
