From: yang xu <xuyang.jy@cn.fujitsu.com>
Date: Mon, 19 Mar 2018 18:38:35 +0800
Subject: [LTP] [PATCH v2] runtest/fs: filter /dev/watchdog* for read_all_dev
	by default
In-Reply-To: <87vadsv34j.fsf@rpws.prws.suse.cz>
References: <87vadsv34j.fsf@rpws.prws.suse.cz>
Message-ID: <1521455915-3081-1-git-send-email-xuyang.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On some distros with Magic Close feature or built-in CONFIG_WATCHDOG_NOWAYO=
UT,
just closing /dev/watchdog* enabled by open leads to system reboot as expec=
ted.

If Magic Close feature is supported, just writing a specific magic characte=
r 'V'
into /dev/watchdog* before closing it can disable the watchdog.

If CONFIG_WATCHDOG_NOWAYOUT is built-in, there is no way to disable the wat=
chdog.

Magic Close feature is introduced by:
commit 017cf080("watchDog Timer Driver Core - Add Magic Close feature")

Please see the following url for detailed watchdog info:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/watchdog/watchdog-api.txt

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/fs b/runtest/fs
index a595edb..42a9bfc 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -69,7 +69,7 @@ fs_di fs_di -d $TMPDIR
 # Was not sure why it should reside in runtest/crashme and won=C2=B4t get =
tested ever
 proc01 proc01 -m 128
=20
-read_all_dev read_all -d /dev -q -r 10
+read_all_dev read_all -d /dev -e '/dev/watchdog?(0)' -q -r 10
 read_all_proc read_all -d /proc -q -r 10
 read_all_sys read_all -d /sys -q -r 10
=20
--=20
1.8.3.1



