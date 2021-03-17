From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 17 Mar 2021 12:53:40 +0100
Subject: [LTP] [PATCH v3 3/4] lib: Apply the skip_filesystems to rest of
 test as well
In-Reply-To: <20210317105318.32017-4-chrubis@suse.cz>
References: <20210317105318.32017-1-chrubis@suse.cz>
 <20210317105318.32017-4-chrubis@suse.cz>
Message-ID: <b2d54281-2893-2dc1-e2a8-ff789dc1c1f2@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
the whole patchset looks great, just a small nit below.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 17. 03. 21 11:53, Cyril Hrubis wrote:
> There is no reason to use the newly introduced .skip_filesystems only
> for .all_filesystems tests.
> 
> So if .all_filesystems is not enabled and .skip_filesystems is set we
> check if test temporary directory filesystem type is in the list of
> supported filesystem types.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/tst_test.c                                | 12 ++++++++++++
>  testcases/kernel/syscalls/fcntl/fcntl33.c     | 19 +++++++------------
>  .../kernel/syscalls/ioctl/ioctl_loop05.c      | 11 +++++------
>  .../kernel/syscalls/vmsplice/vmsplice01.c     |  9 ++++-----
>  .../kernel/syscalls/vmsplice/vmsplice02.c     |  9 ++++-----
>  5 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 639e21727..2f728de28 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1051,6 +1051,18 @@ static void do_test_setup(void)
>  {
>  	main_pid = getpid();
>  
> +	if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
> +		long fs_type = tst_fs_type(".");
> +		const char *fs_name = tst_fs_type_name(fs_type);
> +
> +		if (tst_fs_in_skiplist(fs_name, tst_test->skip_filesystems)) {
> +			tst_brk(TCONF, "Skipping %s as requested by the test",
> +				fs_name);

This message might be a little confusing when the test didn't ask for
all filesystems. I'd recommend something like "Test does not support %s
workdir, skipping". The else clause below is probably unnecessary.

But feel free to push as is if you disagree.

> +		} else {
> +			tst_res(TINFO, "%s is supported by the test", fs_name);
> +		}
> +	}
> +
>  	if (tst_test->caps)
>  		tst_cap_setup(tst_test->caps, TST_CAP_REQ);
>  

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
