From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 28 Mar 2019 10:27:26 +0530
Subject: [LTP] [PATCH v3] syscalls/sync_file_range: add partial file
	sync test-cases
In-Reply-To: <20190327144826.GA30619@rei>
References: <1551962651-22261-1-git-send-email-sumit.garg@linaro.org>
 <20190327144826.GA30619@rei>
Message-ID: <CAFA6WYPxhVSub1SQyAk_51=NB0=yhjBfWPKdXoAjJB_TP0Za1Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 27 Mar 2019 at 20:18, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Sorry for the long delay.
>
> This is altmost perfect, the only problem is that the third test fails
> on vfat. As far as I can tell the reason is that vfat does not support
> sparse files, hence seeking to the middle of file and writing there also
> schedulles I/O to write zeros from the start of the file to the offset
> we started writing to.
>

Hmm, I see.

> Following ugly patch solves the problem:
>
> diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> index 334ea5e88..774524c2f 100644
> --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> @@ -45,6 +45,12 @@ static void verify_sync_file_range(struct testcase *tc)
>
>         fd = SAFE_OPEN(tc->fname, O_RDWR|O_CREAT, MODE);
>
> +       if (!strcmp(tst_device->fs_type, "vfat")) {
> +               tst_res(TINFO, "Pre-filling file");
> +               tst_fill_fd(fd, 0, tc->write_off, 1);
> +               fsync(fd);
> +       }
> +
>         lseek(fd, tc->write_off, SEEK_SET);
>
>
> So either we limit the tests so that the sync region does not overlap with the
> possible hole at the start of the file and loose some test coverage.
>
> Or we can add a function to the test library that would return true/false if
> sparse files are supported for a given FS.
>

My initial thought behind this test-case was to run sync over a range
which is partially written. The other partial region not being written
could either be a hole or already synced data. So pre-fill file in
case of vfat looks sane option, but how about if we add pre-fill as
part of setup? Something like:

--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -86,6 +86,12 @@ static void setup(void)
 {
        if (!check_sync_file_range())
                tst_brk(TCONF, "sync_file_range() not supported");
+
+       if (!strcmp(tst_device->fs_type, "vfat")) {
+               tst_res(TINFO, "Pre-filling file");
+               tst_fill_file(FNAME3, 0, TST_MB, FILE_SZ_MB);
+               sync();
+       }
 }

-Sumit

> --
> Cyril Hrubis
> chrubis@suse.cz
