From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Apr 2019 17:59:14 +0300
Subject: [LTP] [PATCH 4/4] syscalls/fanotify15: verify fid for dirent
	events
In-Reply-To: <20190416142959.GC20437@rei>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
 <2934be190caaaf4bb75caffd731d34711fbf1c61.1554197461.git.mbobrowski@mbobrowski.org>
 <20190416142959.GC20437@rei>
Message-ID: <CAOQ4uxiuLd3C0ctx-+fUkAT8XZyY5SOw61-wB8BTdHh0FVPBXg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 16, 2019 at 5:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> This one misses runtest entry as well.
>
> > +#define BUF_SIZE 256
> > +#define EVENT_MAX 256
> > +
> > +#define MOUNT_POINT "mntpoint"
> > +#define TEST_DIR MOUNT_POINT"/test_dir"
> > +#define DIR1 TEST_DIR"/dir1"
> > +#define DIR2 TEST_DIR"/dir2"
> > +#define FILE1 TEST_DIR"/file1"
> > +#define FILE2 TEST_DIR"/file2"
> > +
> > +struct event_t {
> > +     unsigned long long mask;
> > +     __kernel_fsid_t fsid;
> > +     struct file_handle handle;
> > +     char buf[MAX_HANDLE_SZ];
> > +};
> > +
> > +static int fanotify_fd;
> > +static char events_buf[BUF_SIZE];
> > +static struct event_t event_set[EVENT_MAX];
> > +
> > +static void do_setup(void)
> > +{
> > +     int fd;
> > +
> > +     /* Check kernel for fanotify support */
> > +     fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
> > +     SAFE_CLOSE(fd);
> > +
> > +     fanotify_fd = fanotify_init(FAN_REPORT_FID, O_RDONLY);
> > +     if (fanotify_fd == -1) {
> > +             if (errno == EINVAL)
> > +                     tst_brk(TCONF,
> > +                             "FAN_REPORT_FID not supported in kernel");
> > +             tst_brk(TBROK | TERRNO,
> > +                     "fanotify_init(FAN_REPORT_FID, O_RDONLY) failed");
> > +     }
> > +
> > +     SAFE_MKDIR(TEST_DIR, 0755);
> > +}
> > +
> > +static void get_fid_data(int i, const char *path)
> > +{
> > +     int mount_id;
> > +     struct statfs stats;
> > +
> > +     if (statfs(path, &stats) == -1)
> > +             tst_brk(TBROK | TERRNO,
> > +                     "statfs(%s, ...) failed", path);
> > +     memcpy(&event_set[i].fsid, &stats.f_fsid, sizeof(stats.f_fsid));
> > +
> > +     event_set[i].handle.handle_bytes = MAX_HANDLE_SZ;
> > +     if (name_to_handle_at(AT_FDCWD, path, &event_set[i].handle,
> > +                             &mount_id, 0) == -1) {
> > +             if (errno == EOPNOTSUPP) {
> > +                     tst_brk(TCONF,
> > +                             "filesystem %s does not support file handles",
> > +                             tst_device->fs_type);
> > +             }
> > +             tst_brk(TBROK | TERRNO,
> > +                     "name_to_handle_at(AT_FDCWD, %s, ...) failed",
> > +                     path);
> > +     }
> > +}
>
> Can put this code into an header in the fanotify/ directory along with
> the event_t structure definiton so that we do not carry two copies of
> nearly identical code.

Correct, but I would rather leave the event_t structure private to the test
because it may have other fields in future tests of similar pattern...

>
> If we passed a pointer to the event_t structure instead of the index we
> can call this function in a loop in the get_object_stats() in
> fanotify13, right?
>

...so I'd prefer to pass a pointer to fsid and file_handle to helper instead,
something like:
void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid, and
struct file_handle *handle)

Thanks,
Amir.
