Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE4CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:57:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AC673E6F97
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 13:57:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33E7B3E4E8A
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:57:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0FACB6000BF
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 13:57:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B88D6762A;
 Mon,  8 Jun 2026 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780919846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HqrRLfZ3jpR3TsFDC8RJglcGIMO2VaheRPlQUVbTJ4=;
 b=trA7WBX9p5nbsvao83Gf1dooW2xeDYGLCvVO23kJCrnDHI8M0h8OWCLJHG20i4Vnv5+C7H
 gFF+xoAiEbEtRtFkzD61C3UwmaLEDzm563xRUnLtEEUi9vBAw8XHniin8OymnHk/0gjtvQ
 pHkNrI0vi5lWPLx27R6NzZATaZm9XAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780919846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HqrRLfZ3jpR3TsFDC8RJglcGIMO2VaheRPlQUVbTJ4=;
 b=xd6pd0i/qaaNfvBnVfKKv+Ef39pPArlmXLXC7D/x3vyGemNQy6z6hdGZVRwH+Bfo9TPJh1
 +u9p6jZaMWx8gtAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780919844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HqrRLfZ3jpR3TsFDC8RJglcGIMO2VaheRPlQUVbTJ4=;
 b=u9G98iZk/1Plb+4t9kGbHa9ilb2sJteO8vGPdXkmJltRh9PWMS4038TXTypW2k4BMSehWB
 Ufwa84fSN3piPEFOxHY5LYcaEXkKLnWuwmAwNyusDcjvfX9B28WZBK1KSKIwyaoByN2isQ
 rI6yAwxb55yBXGVX6NKN6Fvx9SwRSRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780919844;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HqrRLfZ3jpR3TsFDC8RJglcGIMO2VaheRPlQUVbTJ4=;
 b=PKhSKFfF4pszGCPb++7Le0Qstx93XYkrGNZdBm0C9LXnFM/O+ByNOuLBQw8++bQoUrGGVa
 BvVdYRz46ljuBmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10F34779A7;
 Mon,  8 Jun 2026 11:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8EKKAySuJmrSHwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jun 2026 11:57:24 +0000
Date: Mon, 8 Jun 2026 13:57:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <aiauHurwBjafsd4R@yuki.lan>
References: <20260608092200.92827-1-sachinp@linux.ibm.com>
 <20260608092200.92827-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260608092200.92827-2-sachinp@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[binfmt_misc02.sh:url,
 imap1.dmz-prg2.suse.org:helo, yuki.lan:mid, binfmt_misc01.sh:url,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/8] fs/acl: Add ACL_USER_OBJ permission test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Add acl_user_obj01 test to validate ACL_USER_OBJ permissions:
> - Owner permissions correctly control file/directory access
> - ACL_USER_OBJ=3Drwx via setxattr() overrides chmod restrictions
> - Owner permissions work independently of group/other permissions
> - Tests use arbitrary UIDs without requiring actual user creation
> =

> The patch also adds acl_lib.h containing shared helpers for ACL
> manipulation via xattr API, including:
> - ACL structure management (acl_init, acl_free, acl_add_entry)
> - ACL serialization/deserialization for kernel xattr format
> - ACL get/set operations using getxattr/setxattr
> - permission testing and file operations
> - Support for both ACCESS and DEFAULT ACL types
> =

> The implementation uses direct xattr API (getxattr/setxattr) to
> test kernel ACL behavior directly. Tests run on ext2/3/4,
> XFS, and Btrfs filesystems with ACL support.
> =

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Sachin Sant <sachinp@linux.ibm.com>
> ---
> V5 changes:
> - Switch to kernel only test validation to remove dependency on libacl
>   and useradd/del commands.
> - v4 link https://lore.kernel.org/ltp/20260604065417.25924-1-sachinp@linu=
x.ibm.com/T/#t
> =

> V4 changes:
> - Add=A0-U=A0flag in create_user_if_needed()=A0to useradd for guaranteed
>   user-private groups.
> - Move EOPNOTSUPP handling into=A0set_acl_file()=A0helper
> - v3 link https://lore.kernel.org/ltp/20260603140147.50738-1-sachinp@linu=
x.ibm.com/T/#t
> =

> V3 changes:
> - Updated copyright header as per LTP format.
> - v2 link https://lore.kernel.org/ltp/20260603065744.47106-1-sachinp@linu=
x.ibm.com/T/#t
> =

> V2 changes:
> - Added reset_test_path_no_chown variant to skip chown step.
>  acl_link01 and xattr_test01 tests are updated to use this
>  variant.
> - Updated acl_user_obj01.c to correct incorrect description
> - v1 link https://lore.kernel.org/ltp/20260602121958.27494-1-sachinp@linu=
x.ibm.com/T/#t
> =

> V1 changes:
> - Use ACL_LIBS variable instead of hardcoded -lacl in Makefile
> - Move ACL header includes inside feature guards in acl_lib.h
> - Use HAVE_LIBACL guards in .c code
> - Report TCONF when libacl is not available
> - rfc link https://lore.kernel.org/ltp/477836fd-80c8-4168-bfe6-00b374bb25=
34@linux.ibm.com/T/#t
> =

> ---
>  runtest/fs                               |   3 +
>  testcases/kernel/fs/acl/.gitignore       |   1 +
>  testcases/kernel/fs/acl/Makefile         |   8 +
>  testcases/kernel/fs/acl/acl_lib.h        | 483 +++++++++++++++++++++++
>  testcases/kernel/fs/acl/acl_user_obj01.c | 154 ++++++++
>  5 files changed, 649 insertions(+)
>  create mode 100644 testcases/kernel/fs/acl/.gitignore
>  create mode 100644 testcases/kernel/fs/acl/Makefile
>  create mode 100644 testcases/kernel/fs/acl/acl_lib.h
>  create mode 100644 testcases/kernel/fs/acl/acl_user_obj01.c
> =

> diff --git a/runtest/fs b/runtest/fs
> index 1d753e0dd..2a878744b 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -87,3 +87,6 @@ binfmt_misc01 binfmt_misc01.sh
>  binfmt_misc02 binfmt_misc02.sh
>  =

>  squashfs01 squashfs01
> +
> +# Run the acl tests
> +acl_user_obj01 acl_user_obj01
> diff --git a/testcases/kernel/fs/acl/.gitignore b/testcases/kernel/fs/acl=
/.gitignore
> new file mode 100644
> index 000000000..d9c46db11
> --- /dev/null
> +++ b/testcases/kernel/fs/acl/.gitignore
> @@ -0,0 +1 @@
> +/acl_user_obj01
> diff --git a/testcases/kernel/fs/acl/Makefile b/testcases/kernel/fs/acl/M=
akefile
> new file mode 100644
> index 000000000..2d9cba46d
> --- /dev/null
> +++ b/testcases/kernel/fs/acl/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 IBM
> +
> +top_srcdir		?=3D ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/acl/acl_lib.h b/testcases/kernel/fs/acl/=
acl_lib.h
> new file mode 100644
> index 000000000..717c9ff1e
> --- /dev/null
> +++ b/testcases/kernel/fs/acl/acl_lib.h
> @@ -0,0 +1,483 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2026 IBM
> + * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
> + * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
> + *
> + * Common library for ACL and extended attribute tests using xattr API
> + */
> +
> +#ifndef ACL_LIB_H
> +#define ACL_LIB_H
> +
> +#include <pwd.h>
> +#include <grp.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <stdint.h>
> +#include <endian.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/xattr.h>
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define TESTDIR		MNTPOINT "/testdir"
> +#define TESTFILE	TESTDIR "/testfile"
> +#define TESTSYMLINK	TESTDIR "/testsymlink"
> +#define XATTR_BACKUP_FILE MNTPOINT "/xattr_backup.txt"
> +
> +/* Extended attribute test values */
> +#define XATTR_TEST_DIR_NAME	"user.test_attr"
> +#define XATTR_TEST_DIR_VALUE	"test_value"
> +#define XATTR_TEST_DIR_SIZE	10
> +#define XATTR_TEST_FILE_NAME	"user.file_attr"
> +#define XATTR_TEST_FILE_VALUE	"file_val"
> +#define XATTR_TEST_FILE_SIZE	8
> +#define XATTR_TEST1_NAME	"user.test1"
> +#define XATTR_TEST1_VALUE	"value1"
> +#define XATTR_TEST1_SIZE	6
> +#define XATTR_TEST2_NAME	"user.test2"
> +#define XATTR_TEST2_VALUE	"value2"
> +#define XATTR_TEST2_SIZE	6
> +
> +/*
> + * POSIX ACL xattr format definitions
> + * These match the kernel's internal representation
> + */
> +#define POSIX_ACL_XATTR_VERSION	0x0002
> +
> +/* ACL entry tag types */
> +#define ACL_UNDEFINED_TAG	0x00
> +#define ACL_USER_OBJ		0x01
> +#define ACL_USER		0x02
> +#define ACL_GROUP_OBJ		0x04
> +#define ACL_GROUP		0x08
> +#define ACL_MASK		0x10
> +#define ACL_OTHER		0x20
> +
> +/* ACL permissions */
> +#define ACL_READ		0x04
> +#define ACL_WRITE		0x02
> +#define ACL_EXECUTE		0x01
> +
> +/* ACL xattr names */
> +#define XATTR_NAME_POSIX_ACL_ACCESS	"system.posix_acl_access"
> +#define XATTR_NAME_POSIX_ACL_DEFAULT	"system.posix_acl_default"
> +
> +/* ACL type for set/get operations */
> +#define ACL_TYPE_ACCESS		1
> +#define ACL_TYPE_DEFAULT	2
> +
> +/* Convert host to little-endian */
> +#if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
> +#define cpu_to_le16(x) (x)
> +#define cpu_to_le32(x) (x)
> +#define le16_to_cpu(x) (x)
> +#define le32_to_cpu(x) (x)
> +#else
> +#define cpu_to_le16(x) __builtin_bswap16(x)
> +#define cpu_to_le32(x) __builtin_bswap32(x)
> +#define le16_to_cpu(x) __builtin_bswap16(x)
> +#define le32_to_cpu(x) __builtin_bswap32(x)
> +#endif
> +
> +/*
> + * POSIX ACL xattr format as stored in kernel
> + * This is the on-disk/in-xattr representation
> + */
> +struct posix_acl_xattr_header {
> +	uint32_t a_version;
> +};
> +
> +struct posix_acl_xattr_entry {
> +	uint16_t e_tag;
> +	uint16_t e_perm;
> +	uint32_t e_id;
> +};
> +
> +/*
> + * In-memory ACL representation for building ACLs
> + */
> +#define MAX_ACL_ENTRIES 32
> +
> +struct acl_entry {
> +	uint16_t tag;
> +	uint16_t perm;
> +	uint32_t id;
> +};
> +
> +struct acl {
> +	int count;
> +	struct acl_entry entries[MAX_ACL_ENTRIES];
> +};
> +
> +/* Helper functions */
> +static inline void reset_test_path_no_chown(void)
> +{
> +	if (unlink(TESTSYMLINK) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
> +
> +	if (unlink(TESTFILE) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
> +
> +	if (rmdir(TESTDIR) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);
> +
> +	SAFE_MKDIR(TESTDIR, 0755);
> +}
> +
> +static inline void reset_test_path(void)
> +{
> +	reset_test_path_no_chown();
> +}
> +
> +static inline void cleanup_testfile(void)
> +{
> +	if (unlink(TESTFILE) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
> +}
> +
> +/*
> + * Initialize an empty ACL structure
> + */
> +static inline struct acl *acl_init(void)
> +{
> +	struct acl *acl =3D malloc(sizeof(struct acl));
> +
> +	if (!acl)
> +		return NULL;
> +
> +	acl->count =3D 0;
> +	return acl;
> +}
> +
> +/*
> + * Free an ACL structure
> + */
> +static inline void acl_free(struct acl *acl)
> +{
> +	free(acl);
> +}
> +
> +/*
> + * Add an ACL entry to the ACL structure
> + */
> +static inline int acl_add_entry(struct acl *acl, uint16_t tag, uint16_t =
perm,
> +				uint32_t id)
> +{
> +	if (acl->count >=3D MAX_ACL_ENTRIES) {
> +		errno =3D ENOMEM;
> +		return -1;
> +	}
> +
> +	acl->entries[acl->count].tag =3D tag;
> +	acl->entries[acl->count].perm =3D perm;
> +	acl->entries[acl->count].id =3D id;
> +	acl->count++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Set ACL on a file using xattr.
> + *
> + * The kernel stores access ACLs only when they differ from the file mod=
e.
> + * If the ACL is equivalent to st_mode, the xattr is removed and future
> + * getxattr() calls return ENODATA. Mirror libacl semantics by treating
> + * ENODATA as a valid minimal ACL derived from st_mode.
> + */
> +static inline int acl_set_file(const char *path, int type, struct acl *a=
cl)
> +{
> +	const char *xattr_name;
> +	size_t size;
> +	char *buf;
> +	struct posix_acl_xattr_header *header;
> +	struct posix_acl_xattr_entry *entries;
> +	int i, ret;
> +
> +	if (type =3D=3D ACL_TYPE_ACCESS)
> +		xattr_name =3D XATTR_NAME_POSIX_ACL_ACCESS;
> +	else if (type =3D=3D ACL_TYPE_DEFAULT)
> +		xattr_name =3D XATTR_NAME_POSIX_ACL_DEFAULT;
> +	else {
> +		errno =3D EINVAL;
> +		return -1;
> +	}
> +
> +	size =3D sizeof(struct posix_acl_xattr_header) +
> +	       acl->count * sizeof(struct posix_acl_xattr_entry);
> +
> +	buf =3D malloc(size);
> +	if (!buf)
> +		return -1;
> +
> +	header =3D (struct posix_acl_xattr_header *)buf;
> +	header->a_version =3D cpu_to_le32(POSIX_ACL_XATTR_VERSION);
> +
> +	entries =3D (struct posix_acl_xattr_entry *)(buf + sizeof(*header));
> +
> +	for (i =3D 0; i < acl->count; i++) {
> +		entries[i].e_tag =3D cpu_to_le16(acl->entries[i].tag);
> +		entries[i].e_perm =3D cpu_to_le16(acl->entries[i].perm);
> +		entries[i].e_id =3D cpu_to_le32(acl->entries[i].id);
> +	}
> +
> +	ret =3D setxattr(path, xattr_name, buf, size, 0);
> +	free(buf);
> +
> +	return ret;
> +}
> +
> +static inline int acl_add_mode_entries(struct acl *acl, mode_t mode)
> +{
> +	if (acl_add_entry(acl, ACL_USER_OBJ, (mode >> 6) & 07, 0) < 0)
> +		return -1;
> +
> +	if (acl_add_entry(acl, ACL_GROUP_OBJ, (mode >> 3) & 07, 0) < 0)
> +		return -1;
> +
> +	if (acl_add_entry(acl, ACL_OTHER, mode & 07, 0) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Synthesize an ACL from file mode bits.
> + * Used when no xattr exists for an access ACL.
> + */
> +static inline struct acl *acl_from_mode(const char *path)
> +{
> +	struct acl *acl;
> +	struct stat st;
> +
> +	if (stat(path, &st) < 0)
> +		return NULL;
> +
> +	acl =3D acl_init();
> +	if (!acl)
> +		return NULL;
> +
> +	if (acl_add_mode_entries(acl, st.st_mode) < 0) {
> +		acl_free(acl);
> +		return NULL;
> +	}
> +
> +	return acl;
> +}
> +
> +/*
> + * Get ACL from a file using xattr.
> + *
> + * Access ACLs equivalent to file mode may not have a backing xattr at a=
ll.
> + * In that case synthesize the base ACL from st_mode so callers observe =
the
> + * same behavior as acl_get_file(3).
> + */
> +static inline struct acl *acl_get_file(const char *path, int type)
> +{
> +	const char *xattr_name;
> +	ssize_t size;
> +	char *buf;
> +	struct posix_acl_xattr_header *header;
> +	struct posix_acl_xattr_entry *entries;
> +	struct acl *acl;
> +	int i, count;
> +
> +	if (type =3D=3D ACL_TYPE_ACCESS)
> +		xattr_name =3D XATTR_NAME_POSIX_ACL_ACCESS;
> +	else if (type =3D=3D ACL_TYPE_DEFAULT)
> +		xattr_name =3D XATTR_NAME_POSIX_ACL_DEFAULT;
> +	else {
> +		errno =3D EINVAL;
> +		return NULL;
> +	}

We are using this in two places, maybe it's worth having an
acl_type_to_name() functions and use that instead.

> +	size =3D getxattr(path, xattr_name, NULL, 0);
> +	if (size < 0) {
> +		if (errno !=3D ENODATA || type !=3D ACL_TYPE_ACCESS)
> +			return NULL;
> +
> +		return acl_from_mode(path);
> +	}
> +
> +	/* Handle race: xattr removed between size check and actual read */
> +	if (size =3D=3D 0)
> +		return acl_from_mode(path);
> +
> +	buf =3D malloc(size);
> +	if (!buf)
> +		return NULL;
> +
> +	size =3D getxattr(path, xattr_name, buf, size);
> +	if (size < 0) {
> +		free(buf);
> +		/* Handle race: xattr removed between size check and read */
> +		if (errno =3D=3D ENODATA && type =3D=3D ACL_TYPE_ACCESS)
> +			return acl_from_mode(path);
> +		return NULL;
> +	}
> +
> +	header =3D (struct posix_acl_xattr_header *)buf;
> +	if (le32_to_cpu(header->a_version) !=3D POSIX_ACL_XATTR_VERSION) {
> +		free(buf);
> +		errno =3D EINVAL;
> +		return NULL;
> +	}
> +
> +	count =3D (size - sizeof(*header)) / sizeof(struct posix_acl_xattr_entr=
y);
> +	entries =3D (struct posix_acl_xattr_entry *)(buf + sizeof(*header));

Maybe we can define a structure with both header and entries in order to
avoid some of the casts here. Maybe this would work:

struct acl_xattr {
	struct posix_acl_xattr_header header;
	struct posix_acl_xattr_entry entries[];
};

And then we could do:

	struct acl_xattr *ax =3D (void*)buf;

	if (le32_to_cpu(ax->header.a_version) =3D=3D ACL_TYPE_ACCESS) {
		...
	}

	...

	for (i =3D 0; i < conut; i++) {
		uint16_t tag =3D le16_to_cpu(ax->entries[i].e_tag);
		...

	}


> +	acl =3D acl_init();
> +	if (!acl) {
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	for (i =3D 0; i < count; i++) {
> +		uint16_t tag =3D le16_to_cpu(entries[i].e_tag);
> +		uint16_t perm =3D le16_to_cpu(entries[i].e_perm);
> +		uint32_t id =3D le32_to_cpu(entries[i].e_id);
> +
> +		if (acl_add_entry(acl, tag, perm, id) < 0) {
> +			acl_free(acl);
> +			free(buf);
> +			return NULL;
> +		}
> +	}
> +
> +	free(buf);
> +	return acl;
> +}
> +
> +/*
> + * Check if an ACL entry has a specific permission
> + */
> +static inline int acl_entry_has_perm(struct acl_entry *entry, uint16_t p=
erm)
> +{
> +	return (entry->perm & perm) =3D=3D perm;
> +}
> +
> +/*
> + * Check if an ACL entry has all rwx permissions
> + */
> +static inline int acl_entry_has_rwx(struct acl_entry *entry)
> +{
> +	return acl_entry_has_perm(entry, ACL_READ) &&
> +	       acl_entry_has_perm(entry, ACL_WRITE) &&
> +	       acl_entry_has_perm(entry, ACL_EXECUTE);

Can't we pass all the bits to a single call of the function like
acl_entry_has_perm(entry, ACL_READ | ACL_WRITE | ACL_EXECUTE) ?

> +}
> +
> +/*
> + * Find an ACL entry by tag type
> + */
> +static inline struct acl_entry *acl_find_entry(struct acl *acl, uint16_t=
 tag,
> +					       uint32_t id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < acl->count; i++) {
> +		if (acl->entries[i].tag =3D=3D tag) {
> +			if (tag =3D=3D ACL_USER || tag =3D=3D ACL_GROUP) {
> +				if (acl->entries[i].id =3D=3D id)
> +					return &acl->entries[i];
> +			} else {
> +				return &acl->entries[i];
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Update ACL mask permissions
> + */
> +static inline int acl_set_mask_perms(struct acl *acl, uint16_t perm)
> +{
> +	struct acl_entry *mask_entry =3D acl_find_entry(acl, ACL_MASK, 0);
> +
> +	if (!mask_entry) {
> +		errno =3D ENOENT;
> +		return -1;
> +	}
> +
> +	mask_entry->perm =3D perm;
> +	return 0;
> +}
> +
> +static inline int create_file_as(uid_t uid, gid_t gid, mode_t mode,
> +				 int use_umask, mode_t mask)
> +{
> +	pid_t pid;
> +	int status;
> +
> +	pid =3D SAFE_FORK();
> +	if (!pid) {
> +		int fd, err;
> +
> +		if (setgroups(0, NULL) =3D=3D -1) {
> +			err =3D errno;
> +			_exit(err);
> +		}
> +
> +		if (setgid(gid) =3D=3D -1) {
> +			err =3D errno;
> +			_exit(err);
> +		}
> +
> +		if (setuid(uid) =3D=3D -1) {
> +			err =3D errno;
> +			_exit(err);
> +		}

These should be SAFE_MACROS().

> +		if (use_umask)
> +			umask(mask);
> +
> +		fd =3D open(TESTFILE, O_CREAT | O_WRONLY, mode);
> +		if (fd >=3D 0) {
> +			close(fd);
> +			_exit(0);
> +		}

Generally in LTP we want to check the test conditions right after they
happen. So this function should get expected errno as last parameter and
we should check for the result right here with something as:

	if (errno)
		ST_EXP_FAIL()
	else
		TST_EXP_FD()

With that we do need to propagate the return value manually, which is
prone to errors, and do not need to process the child exit value
manually, we can just let the library collect the children with
tst_reap_children().

> +		err =3D errno;
> +		_exit(err);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (!WIFEXITED(status))
> +		tst_brk(TBROK, "Child terminated abnormally");
> +
> +	return WEXITSTATUS(status);


> +}
> +
> +static inline int try_create_as(uid_t uid, gid_t gid, mode_t mode)
> +{
> +	return create_file_as(uid, gid, mode, 0, 0);
> +}
> +
> +static inline int create_with_umask_as(uid_t uid, gid_t gid, mode_t mode,
> +					mode_t mask)
> +{
> +	return create_file_as(uid, gid, mode, 1, mask);
> +}
> +
> +static inline void cleanup_test_paths(void)
> +{
> +	if (unlink(TESTSYMLINK) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTSYMLINK);
> +
> +	if (unlink(TESTFILE) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "unlink(%s) failed", TESTFILE);
> +
> +	if (rmdir(TESTDIR) =3D=3D -1 && errno !=3D ENOENT)
> +		tst_res(TWARN | TERRNO, "rmdir(%s) failed", TESTDIR);

Maybe we need SAFE_TRY_UNLINK() and SAFE_TRY_RMDIR() that wouldn't TBROK
on ENOENT and then we could use it here.

> +}
> +
> +#endif /* ACL_LIB_H */
> diff --git a/testcases/kernel/fs/acl/acl_user_obj01.c b/testcases/kernel/=
fs/acl/acl_user_obj01.c
> new file mode 100644
> index 000000000..01abfbf4e
> --- /dev/null
> +++ b/testcases/kernel/fs/acl/acl_user_obj01.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 IBM
> + *
> + * Original shell test by Kai Zhao (ltcd3@cn.ibm.com)
> + * Converted to C by Sachin Sant <sachinp@linux.ibm.com>
> + */
> +
> +/*\
> + * Test ACL_USER_OBJ permissions using direct xattr manipulation.
> + *
> + * Verify that owner permissions (ACL_USER_OBJ) correctly control access
> + * to files and directories. The test validates that:
> + * - ACL_USER_OBJ permissions are applied directly as the owner bits
> + * - Setting ACL_USER_OBJ=3Drwx via setxattr() overrides a previous
> + *   chmod restriction
> + * - Owner permissions work independently of group and other permissions
> + *
> + * This test uses arbitrary UIDs without creating actual users, testing
> + * only the kernel ACL implementation.
> + */
> +
> +#include "acl_lib.h"
> +
> +#define TEST_UID 1000
> +#define TEST_GID 1000
> +
> +/*
> + * Test permission bits deny access.
> + * Owner should be denied write access when mode is 0500.
> + */
> +static void test_deny_by_mode(void)
> +{
> +	int err;
> +
> +	tst_res(TINFO, "Testing permission bits deny access");
> +	reset_test_path();
> +
> +	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
> +	SAFE_CHMOD(TESTDIR, 0500);
> +
> +	err =3D try_create_as(TEST_UID, TEST_GID, 0644);
> +	if (!err) {
> +		cleanup_testfile();
> +		tst_res(TFAIL, "Created file without write permission");
> +		return;
> +	}
> +
> +	if (err !=3D EACCES) {
> +		errno =3D err;
> +		tst_res(TFAIL | TERRNO, "Expected EACCES from owner create");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "File creation denied by permission bits");
> +}
> +
> +/*
> + * Test ACL_USER_OBJ grants access.
> + * Setting ACL_USER_OBJ=3Drwx should override previous chmod restriction.
> + */
> +static void test_grant_by_acl(void)
> +{
> +	struct acl *acl =3D NULL;
> +	int err;
> +
> +	tst_res(TINFO, "Testing ACL_USER_OBJ grants access");
> +	reset_test_path();
> +
> +	SAFE_CHOWN(TESTDIR, TEST_UID, TEST_GID);
> +	SAFE_CHMOD(TESTDIR, 0500);
> +
> +	acl =3D acl_init();
> +	if (!acl)
> +		tst_brk(TBROK | TERRNO, "acl_init failed");
> +
> +	if (acl_add_entry(acl, ACL_USER_OBJ,
> +			  ACL_READ | ACL_WRITE | ACL_EXECUTE, 0) < 0)
> +		goto cleanup_acl;
> +
> +	if (acl_add_entry(acl, ACL_GROUP_OBJ, 0, 0) < 0)
> +		goto cleanup_acl;
> +
> +	if (acl_add_entry(acl, ACL_OTHER, 0, 0) < 0)
> +		goto cleanup_acl;

Maybe we can just call SAFE_MALLOC() and tst_brk() internally in these
functions so that we don't have to complicate the code here. We do call
tst_brk() in cleanup_acl: anyways.

> +	if (acl_set_file(TESTDIR, ACL_TYPE_ACCESS, acl) < 0) {
> +		if (errno =3D=3D EOPNOTSUPP) {
> +			acl_free(acl);
> +			tst_brk(TCONF | TERRNO, "ACL not supported");
> +		}
> +		goto cleanup_acl;
> +	}
> +
> +	acl_free(acl);
> +	acl =3D NULL;
> +
> +	err =3D try_create_as(TEST_UID, TEST_GID, 0644);
> +	if (err) {
> +		errno =3D err;
> +		tst_res(TFAIL | TERRNO,
> +			"Failed to create file with ACL_USER_OBJ rwx");
> +		return;
> +	}
> +
> +	cleanup_testfile();
> +	tst_res(TPASS, "ACL_USER_OBJ permissions work correctly");
> +	return;
> +
> +cleanup_acl:
> +	acl_free(acl);
> +	tst_brk(TBROK | TERRNO, "ACL setup failed");
> +}
> +
> +static void run(unsigned int n)
> +{
> +	switch (n) {
> +	case 0:
> +		test_deny_by_mode();
> +		break;
> +	case 1:
> +		test_grant_by_acl();
> +		break;
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	reset_test_path();
> +}
> +
> +static void cleanup(void)
> +{
> +	cleanup_test_paths();
> +}
> +
> +static struct tst_test test =3D {
> +	.test =3D run,
> +	.tcnt =3D 2,
> +	.setup =3D setup,
> +	.cleanup =3D cleanup,
> +	.needs_root =3D 1,
> +	.mount_device =3D 1,
> +	.mntpoint =3D MNTPOINT,
> +	.forks_child =3D 1,
> +	.filesystems =3D (struct tst_fs[]) {
> +		{.type =3D "ext2", .mnt_data =3D "acl"},
> +		{.type =3D "ext3", .mnt_data =3D "acl"},
> +		{.type =3D "ext4", .mnt_data =3D "acl"},
> +		{.type =3D "xfs"},
> +		{.type =3D "btrfs"},
> +		{}
> +	}
> +};
> -- =

> 2.39.1
> =


-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
