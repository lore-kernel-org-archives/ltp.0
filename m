From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 May 2021 18:24:57 +0200
Subject: [LTP] [PATCH v2] syscalls/unlinkat01: Bugfix and update to new
 API
In-Reply-To: <20210506093201.3129-1-zhaogongyi@huawei.com>
References: <20210506093201.3129-1-zhaogongyi@huawei.com>
Message-ID: <YJVp2SHmyvRsDSNs@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhao,

> +static struct tcase {
> +	int fd;
> +	char *filename;
FYI this required adding const:

unlinkat01.c:43:13: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
   43 |         {0, testfile, 0, 0},
      |             ^~~~~~~~
unlinkat01.c:45:13: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
   45 |         {0, testfile, 0, ENOTDIR},
      |             ^~~~~~~~
unlinkat01.c:46:15: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
   46 |         {100, testfile, 0, EBADF},
      |               ^~~~~~~~
unlinkat01.c:47:13: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
   47 |         {0, testfile, 9999, EINVAL},
      |             ^~~~~~~~
unlinkat01.c:48:20: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
   48 |         {AT_FDCWD, testfile, 0, 0},
      |                    ^~~~~~~~
unlinkat01.c:49:13: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
   49 |         {0, subpathname, AT_REMOVEDIR, 0},
      |             ^~~~~~~~~~~

Please next time try to not introduce new warnings.

Thanks, merged!

Kind regards,
Petr

> +	int flag;
> +	int exp_errno;
> +} tc[] = {
> +	{0, testfile, 0, 0},
> +	{0, NULL, 0, 0},
> +	{0, testfile, 0, ENOTDIR},
> +	{100, testfile, 0, EBADF},
> +	{0, testfile, 9999, EINVAL},
> +	{AT_FDCWD, testfile, 0, 0},
> +	{0, subpathname, AT_REMOVEDIR, 0},
