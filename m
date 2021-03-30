From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Mar 2021 14:25:09 +0200
Subject: [LTP] [PATCH 1/1] tst_mkfs: Add -I option to mkfs.vfat
In-Reply-To: <87czvhneqb.fsf@suse.de>
References: <20210329145738.986-1-pvorel@suse.cz>
 <87czvhneqb.fsf@suse.de>
Message-ID: <YGMYpaeR7Mp7rATD@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > +	/*
> > +	 * Workaround a problem:
> > +	 * mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
> > +	 * making filesystem (use -I to override)
> > +	 */
> > +	if (!strcmp(fs_type, "vfat")) {
> > +		argv[pos] = "-I";
> > +		strcat(fs_opts_str, argv[pos++]);

> Doesn't it need a space after -I?
No, it's char *const argv[] passed to execvp() in tst_cmd_fds_(), which does the
separation. Adding spaces on the contrary causes failure (equivalent of
mkfs.vfat " -I " ...).

> Might be better to put this after fs_opts and then you can check i > 0.
Have I overlooked introduced regression? It works, only it needs to add " "
space for formatting output, but functionality works, adding tested file.

Kind regards,
Petr

Testing file:

#include "tst_test.h"
#define MOUNT_POINT "mount_ext"

static void do_test(void)
{
	tst_res(TPASS, "here");
}

static struct tst_test test = {
	.test_all = do_test,
	.mount_device = 1,
	.mntpoint = MOUNT_POINT,
	.needs_root = 1,
	.dev_fs_type = "vfat",
	.dev_fs_opts = (const char *const []){"-v", NULL},
};

Needed fix:

--- lib/tst_mkfs.c
+++ lib/tst_mkfs.c
@@ -60,6 +60,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	if (!strcmp(fs_type, "vfat")) {
 		argv[pos] = "-I";
 		strcat(fs_opts_str, argv[pos++]);
+		strcat(fs_opts_str, " ");
 	}
 
 	if (fs_opts) {
