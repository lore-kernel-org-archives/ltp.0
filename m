From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Aug 2021 08:27:46 +0300
Subject: [LTP] [PATCH 6/7] syscalls/fanotify20: Test file event with
 broken inode
In-Reply-To: <87k0l1hkuz.fsf@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-7-krisman@collabora.com>
 <CAOQ4uxizX0ar7d9eYgazcenQcA7Ku7quEZOLbcaxKJiY0sTPLA@mail.gmail.com>
 <87k0l1hkuz.fsf@collabora.com>
Message-ID: <CAOQ4uxis23+T3=+R+9rKkxtZLtS4S4LJ6RBgG0AEHsg4=MJyRA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 4, 2021 at 7:52 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> This test corrupts an inode entry with an invalid mode through debugfs
> >> and then tries to access it.  This should result in a ext4 error, which
> >> we monitor through the fanotify group.
> >>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >> ---
> >>  .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >>
> >> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> index e7ced28eb61d..0c63e90edc3a 100644
> >> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> >> @@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
> >>                    MS_REMOUNT|MS_RDONLY, "abort");
> >>  }
> >>
> >> +#define TCASE2_BASEDIR "tcase2"
> >> +#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
> >> +
> >> +static unsigned int tcase2_bad_ino;
> >> +static void tcase2_prepare_fs(void)
> >> +{
> >> +       struct stat stat;
> >> +
> >> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
> >> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
> >> +
> >> +       SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
> >> +       tcase2_bad_ino = stat.st_ino;
> >> +
> >> +       SAFE_UMOUNT(MOUNT_PATH);
> >> +       do_debugfs_request(tst_device->dev, "sif " TCASE2_BAD_DIR " mode 0xff");
> >> +       SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> >> +}
> >> +
> >> +static void tcase2_trigger_lookup(void)
> >> +{
> >> +       int ret;
> >> +
> >> +       /* SAFE_OPEN cannot be used here because we expect it to fail. */
> >> +       ret = open(MOUNT_PATH"/"TCASE2_BAD_DIR, O_RDONLY, 0);
> >> +       if (ret != -1 && errno != EUCLEAN)
> >> +               tst_res(TFAIL, "Unexpected lookup result(%d) of %s (%d!=%d)",
> >> +                       ret, TCASE2_BAD_DIR, errno, EUCLEAN);
> >> +}
> >> +
> >>  static const struct test_case {
> >>         char *name;
> >>         int error;
> >> @@ -92,6 +122,14 @@ static const struct test_case {
> >>                 .error_count = 1,
> >>                 .error = EXT4_ERR_ESHUTDOWN,
> >>                 .inode = NULL
> >> +       },
> >> +       {
> >> +               .name = "Lookup of inode with invalid mode",
> >> +               .prepare_fs = tcase2_prepare_fs,
> >> +               .trigger_error = &tcase2_trigger_lookup,
> >> +               .error_count = 1,
> >> +               .error = 0,
> >> +               .inode = &tcase2_bad_ino,
> >
> > Why is error 0?
> > What's the rationale?
>
> Hi Amir,
>
> That is specific to Ext4.  Some ext4 conditions report bogus error codes.  I will
> come up with a kernel patch changing it.
>

Well, I would not expect a FAN_FS_ERROR event to ever have 0 error
value. Since this test practically only tests ext4, I do not think it
is reasonable
for the test to VERIFY a bug. It is fine to write this test with expectations
that are not met and let it fail.

But a better plan would probably be to merge the patches up to 5 to test
FAN_FS_ERROR and then add more test cases after ext4 is fixed
Either that or you fix the ext4 problem along with FAN_FS_ERROR.

Forgot to say that the test needs to declare .needs_cmds "debugfs".

In any case, as far as prerequisite to merging FAN_FS_ERROR
your WIP tests certainly suffice.
Please keep your test branch around so we can use it to validate
the kernel patches.
I usually hold off on submitting LTP tests for inclusion until at least -rc3
after kernel patches have been merged.

Thanks,
Amir.
