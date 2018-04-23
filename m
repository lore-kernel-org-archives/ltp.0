From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Mon, 23 Apr 2018 11:46:35 +0200
Subject: [LTP] [RFC PATCH 5/9] testcases: logrotate: Check if "file" command
	exists
In-Reply-To: <20180423094639.14612-1-mylene.josserand@bootlin.com>
References: <20180423094639.14612-1-mylene.josserand@bootlin.com>
Message-ID: <20180423094639.14612-6-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Add "file" binary in the list of commands to check if
they exist or not.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/commands/logrotate/logrotate_tests.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/commands/logrotate/logrotate_tests.sh b/testcases/co=
mmands/logrotate/logrotate_tests.sh
index f5a22ddde..021972294 100755
--- a/testcases/commands/logrotate/logrotate_tests.sh
+++ b/testcases/commands/logrotate/logrotate_tests.sh
@@ -97,10 +97,11 @@ init()
 		 return $RC
 	fi
=20
-	# check if commands tst_*, logrotate, awk exists.
+	# check if commands tst_*, logrotate, awk and file exists.
 	chk_ifexists INIT tst_resm  || return $RC
 	chk_ifexists INIT logrotate || return $RC
 	chk_ifexists INIT awk       || return $RC
+	chk_ifexists INIT file      || return $RC
=20
 	return $RC
 }
--=20
2.11.0

