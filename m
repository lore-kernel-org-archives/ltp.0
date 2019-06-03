From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Jun 2019 07:06:55 +0200
Subject: [LTP] [PATCH v6 1/2] OVL_MNT: add helpers to setup overlayfs
	mountpoint
In-Reply-To: <20190530025301.9616-1-xzhou@redhat.com>
References: <CAOQ4uxhYVDDh961PCBqikrO=QjPG-yUEUvwWn8hBCkB0ugMuzg@mail.gmail.com>
 <20190530025301.9616-1-xzhou@redhat.com>
Message-ID: <20190603050655.GA27243@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy,

> Define constraints of needed overlayfs dirs;
> create_overlay_dirs() to create lower/upper/work dirs;
> mount_overlay() to mount overlayfs;
> SAFE_MOUNT_OVERLAY macro to mount overlayfs safely, tst_brk TCONF
> if mount fail with errno ENODEV;
> TST_MOUNT_OVERLAY  macro to mount overlayfs and return 0 if succeeds;

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

with tiny change not initialize ret (no need as it's initialized by mount()).

Kind regards,
Petr

diff --git lib/tst_fs_setup.c lib/tst_fs_setup.c
index 32a6218e3..54ea37077 100644
--- lib/tst_fs_setup.c
+++ lib/tst_fs_setup.c
@@ -26,7 +26,7 @@ void create_overlay_dirs(void)
 
 int mount_overlay(const char *file, const int lineno, int skip)
 {
-	int ret = 0;
+	int ret;
 
 	create_overlay_dirs();
 	ret = mount("overlay", OVL_MNT, "overlay", 0,
