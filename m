From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Mar 2019 11:53:42 +0100
Subject: [LTP] [PATCH v1] syscalls/ioctl08: add file deduplication
 testcases
In-Reply-To: <20190320140058.13944-1-camann@suse.com>
References: <20190320140058.13944-1-camann@suse.com>
Message-ID: <20190321105342.GA23996@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

LGTM, nice, with some comments below.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +#ifndef SUCCESS
I wonder if this needs to be checked for. Not sure, but maybe to get error for redefinition is better than having errors when SUCCESS is defined for something else than 0.
> +#define SUCCESS 0
> +#endif

...
> +static struct tcase {
> +	uint64_t	src_length;
> +	char		*src_fcontents;
> +	char		*dest_fcontents;
> +	int		exp_err;
> +	uint64_t	bytes_deduped;
> +	int		status;
> +} tcases[] = {
> +	{3, "AAA", "AAA", SUCCESS, 3, FILE_DEDUPE_RANGE_SAME},
> +	{3, "AAA", "AAB", SUCCESS, 0, FILE_DEDUPE_RANGE_DIFFERS},
> +	{-1, "AAA", "AAA", EINVAL, 0, 0},

Some old distros don't have FILE_DEDUPE_RANGE_SAME,
FILE_DEDUPE_RANGE_DIFFERS and required structs file_dedupe_range_info [1]
ioctl08.c:50:32: error: 'FILE_DEDUPE_RANGE_SAME' undeclared here (not in a function)
  {3, "AAA", "AAA", SUCCESS, 3, FILE_DEDUPE_RANGE_SAME},
                                ^
ioctl08.c:50:2: warning: missing initializer for field 'status' of 'struct tcase' [-Wmissing-field-initializers]
  {3, "AAA", "AAA", SUCCESS, 3, FILE_DEDUPE_RANGE_SAME},
  ^
ioctl08.c:48:7: note: 'status' declared here
  int  status;
       ^
ioctl08.c:51:32: error: 'FILE_DEDUPE_RANGE_DIFFERS' undeclared here (not in a function)
  {3, "AAA", "AAB", SUCCESS, 0, FILE_DEDUPE_RANGE_DIFFERS},
                                ^
ioctl08.c:51:2: warning: missing initializer for field 'status' of 'struct tcase' [-Wmissing-field-initializers]
  {3, "AAA", "AAB", SUCCESS, 0, FILE_DEDUPE_RANGE_DIFFERS},
  ^
ioctl08.c:48:7: note: 'status' declared here
  int  status;
       ^
ioctl08.c: In function 'verify_ioctl':
ioctl08.c:65:24: error: invalid application of 'sizeof' to incomplete type 'struct file_dedupe_range'
  memset(fdr, 0, sizeof(struct file_dedupe_range) +
                        ^
ioctl08.c:66:11: error: invalid application of 'sizeof' to incomplete type 'struct file_dedupe_range_info'
    sizeof(struct file_dedupe_range_info));
           ^
ioctl08.c:65:50: error: invalid operands to binary + (have 'struct tcase *' and 'struct tcase *')
  memset(fdr, 0, sizeof(struct file_dedupe_range) +
                                                  ^
ioctl08.c:65:17: warning: passing argument 3 of 'memset' makes integer from pointer without a cast
  memset(fdr, 0, sizeof(struct file_dedupe_range) +
                 ^
In file included from /usr/include/features.h:374:0,
                 from /usr/include/stdlib.h:24,
                 from ioctl08.c:22:
/usr/include/x86_64-linux-gnu/bits/string3.h:76:1: note: expected 'size_t' but argument is of type 'struct tcase *'
 __NTH (memset (void *__dest, int __ch, size_t __len))

[1] https://api.travis-ci.org/v3/job/509171728/log.txt

.min_kver is a runtime check, but we need a compile time check. I guess instead
of adding everything into include/lapi/fs.h and then checking for ENOSYS would
be better to do  some autotools checks for these structs (probably
AC_CHECK_TYPES) and failing with TST_TEST_TCONF (as you do, but only as else for
#ifdef HAVE_LINUX_FS_H, which is obviously not enough.

Kind regards,
Petr
