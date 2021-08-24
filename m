From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Aug 2021 14:46:53 +0200
Subject: [LTP] [PATCH v7,
 4/4] Make argument to tst_umount an absolute path
In-Reply-To: <YSTj7CB6PdG2HZsQ@ubuntu02>
References: <YSTj7CB6PdG2HZsQ@ubuntu02>
Message-ID: <YSTqPdIl493giI1t@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo,

Also evm_overlay.sh needs to be fixed, I'll change it before merge:

+++ testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -34,7 +34,7 @@ setup()
 	TST_FS_TYPE="overlay"
 
 	mntpoint_backup="$TST_MNTPOINT"
-	TST_MNTPOINT="$merged"
+	TST_MNTPOINT="$PWD/$merged"
 
 	params_backup="$TST_MNT_PARAMS"
 	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"

Reviewed-by: Petr Vorel <pvorel@suse.cz>
for whole patchset.

Kind regards,
Petr
