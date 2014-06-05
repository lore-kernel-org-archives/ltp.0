Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WsWAy-0002Vo-D8
	for ltp-list@lists.sourceforge.net; Thu, 05 Jun 2014 11:49:44 +0000
Date: Thu, 5 Jun 2014 13:49:22 +0200
From: chrubis@suse.cz
Message-ID: <20140605114922.GB13350@rei>
References: <1400844718-26556-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400844718-26556-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] lib: add tst_fs_link_count.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/include/test.h b/include/test.h
> index 43fdc8b..8196f5f 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -321,6 +321,46 @@ const char *tst_strerrno(int err);
>  int tst_path_has_mnt_flags(void (cleanup_fn)(void),
>  		const char *path, const char *flags[]);
>  
> +/*
> + * lib/tst_fs_link_count.c
> + * Return the maximum number of hard links to @path. In its implementation,
> + * it uses link() to try to reach the limit and will try at most 65535 times.
> + * If EMLINK error is hit, we can think the maximum number has been reached,
> + * return this number. If some other errors occur, we think it is infinite
> + * and returns -1.
> + * Note: if @dir is NULL, we do link() in the same directory as @path, if not,
> + * we do it in directory @dir.
> + */
> +int tst_fs_get_max_hardlinks(void (*cleanup_fn) (void), const char *path,
> +	const char *dir);

Given that the function now creates the the file links we should
probably rename it to something as tst_fs_fill_hardlinks() or something
similar.

> diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
> new file mode 100644
> index 0000000..bce9fe65
> --- /dev/null
> +++ b/lib/tst_fs_link_count.c
> @@ -0,0 +1,157 @@
> +/*
> + * Copyright (c) 2014 Fujitsu Ltd.
> + * Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +#define MAX_SANE_HARD_LINKS	65535
> +#define DIR_BASE_NAME_MAGIC	"43xlegeEmApdr23aopGzK"
> +#define FILE_BASE_NAME_MAGIC	"dc4wssd490wAD383s9sfb"
> +
> +int tst_fs_get_max_hardlinks(void (*cleanup_fn) (void), const char *path,
> +	const char *dir)
> +{
> +	int i, j, index = 0;
> +	char filename[PATH_MAX], *pathbase, *pathdir;
> +	char *pathc, *dirc;
> +	struct stat s;
> +
> +	pathc = strdup(path);
> +	dirc = strdup(path);

This creates memory leak, we should free them before exiting.

> +	pathbase = SAFE_BASENAME(cleanup_fn, pathc);
> +	if (dir != NULL) {
> +		index = sprintf(filename, "%s/", dir);
> +	} else {
> +		pathdir = dirname(dirc);
> +		index = sprintf(filename, "%s/", pathdir);
> +	}

Hmm, wouldn't it be easier to pass the directory and filename as
separate parameters.

Or even better define how are the links this function creates named
and pass only path to a directory to create the links to.

I.e.

int tst_fs_get_max_hardlinks(void (*cleanup_fn)(void), const char *path);

Which would be called from test setup as:

max_links = tst_fs_get_max_hardlinks(cleanup, "emlink_dir/");

which would create something as:

emlink_dir/test_file00001
emlink_dir/test_file00002
emlink_dir/test_file00003
...

> +	for (i = 1; i <= MAX_SANE_HARD_LINKS; i++) {
> +		sprintf(filename + index, "%s%s%d", pathbase,
> +			FILE_BASE_NAME_MAGIC, i);
> +
> +		if (link(path, filename) < 0) {
> +			if (errno == EMLINK) {
> +				SAFE_STAT(cleanup_fn, path, &s);
> +				tst_resm(TINFO, "the maximum number of hard "
> +					 "links to %s is hit: %d",
> +					 path, (int)s.st_nlink);
> +				return s.st_nlink;

Careful here, I would assert here that s.st_nlink == i in this case and
do tst_brkm(TBROK, ...) if not.

> +			} else {
> +				fprintf(stderr, "link(%s, %s) failed:%s\n",
> +					path, filename, strerror(errno));
> +				goto max_hardlinks_cleanup;


As we pass the cleanup_fn here, we can do tst_brkm(TBROK, ...) here and
rely on tst_rmdir() called from the cleanup to remove the files.

The unlimited case (i.e. -1) should IMHO apply only when we happen to
create maximal number of links and did not get any error.

> +			}
> +		}
> +
> +	}
> +
> +max_hardlinks_cleanup:
> +	for (j = 1; j < i; j++) {
> +		sprintf(filename + index, "%s%s%d", pathbase,
> +			FILE_BASE_NAME_MAGIC, j);
> +		if (unlink(filename) < 0 && errno != ENOENT) {
> +			fprintf(stderr, "unlink(%s) failed: %s", filename,
> +				strerror(errno));
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +void tst_fs_get_max_hardlinks_clean(void (*cleanup_fn) (void), const char *path,
> +	const char *dir, int limit)
> +{
> +	int i, index = 0;
> +	char filename[PATH_MAX], *pathbase, *pathdir;
> +	char *pathc, *dirc;
> +
> +	pathc = strdup(path);
> +	dirc = strdup(path);
> +
> +	pathbase = SAFE_BASENAME(cleanup_fn, pathc);
> +	if (dir != NULL) {
> +		index = sprintf(filename, "%s/", dir);
> +	} else {
> +		pathdir = dirname(dirc);
> +		index = sprintf(filename, "%s/", pathdir);
> +	}
> +
> +	for (i = 1; i < limit; i++) {
> +		sprintf(filename + index, "%s%s%d", pathbase,
> +			FILE_BASE_NAME_MAGIC, i);
> +		if (unlink(filename) < 0 && errno != ENOENT) {
> +			fprintf(stderr, "unlink(%s) failed: %s", filename,
> +				strerror(errno));
> +		}
> +	}
> +}

Is there actually use for this function?

Because all files created in test temporary directory are deleted upon
tst_rmdir().

> +int tst_fs_max_subdirs_per_dir(void (*cleanup_fn) (void), const char *dir)
> +{
> +	int i, j;
> +	char dirname[PATH_MAX];
> +	struct stat s;
> +
> +	for (i = 1; i <= MAX_SANE_HARD_LINKS; i++) {
> +		sprintf(dirname, "%s/%s%d", dir, DIR_BASE_NAME_MAGIC, i);
> +
> +		if (mkdir(dirname, 0755) < 0) {
> +			if (errno == EMLINK) {
> +				SAFE_STAT(cleanup_fn, dir, &s);
> +				tst_resm(TINFO, "the maximum subdirectories in "
> +					 "%s is hit: %d", dir, (int)s.st_nlink);
> +				return s.st_nlink;
> +			} else {
> +				fprintf(stderr, "mkdir(%s, 0755) failed: %s\n",
> +					dirname, strerror(errno));
> +				goto max_subdirs_cleanup;
> +			}
> +		}
> +
> +	}
> +
> +max_subdirs_cleanup:
> +	for (j = 1; j < i; j++) {
> +		sprintf(dirname, "%s/%s%d", dir, DIR_BASE_NAME_MAGIC, j);
> +		 if (rmdir(dirname) < 0 && errno != ENOENT) {
> +			fprintf(stderr, "rmdir(%s) failed: %s", dirname,
> +				strerror(errno));
> +		}
> +	}
> +
> +	return -1;
> +}

Here as well.

> +void tst_fs_max_subdirs_per_dir_clean(const char *dir, int limit)
> +{
> +	int i;
> +	char dirname[PATH_MAX];
> +
> +	for (i = 1; i < limit; i++) {
> +		sprintf(dirname, "%s/%s%d", dir, DIR_BASE_NAME_MAGIC, i);
> +		if (rmdir(dirname) < 0 && errno != ENOENT) {
> +			fprintf(stderr, "rmdir(%s) failed: %s", dirname,
> +				strerror(errno));
> +		}
> +	}
> +}

The same applies here as well, is there a use for this function?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
