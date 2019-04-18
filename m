From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Apr 2019 15:47:36 +0800
Subject: [LTP] [PATCH v3] syscalls/sync_file_range: add partial file
	sync test-cases
In-Reply-To: <CAFA6WYMZcvPN0SHUa=pwEOw04fS2Oc7xzb6k=kxd8LgHj-peCw@mail.gmail.com>
References: <1551962651-22261-1-git-send-email-sumit.garg@linaro.org>
 <CAEemH2dUC8pQmN5BTM7qm9vZyudqZeATY+oD63OEQ+UOcY2G9A@mail.gmail.com>
 <CAFA6WYMZcvPN0SHUa=pwEOw04fS2Oc7xzb6k=kxd8LgHj-peCw@mail.gmail.com>
Message-ID: <CAEemH2fnM2XrGEW0O=Fnrqt3utBgeS6X2A6pC9HEcbRRj2fLKQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 3, 2019 at 7:17 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> Hi Li,
>
> Firstly apologies for the late reply due to travelling for Linaro Connect
> BKK19.
>
> On Mon, 1 Apr 2019 at 13:54, Li Wang <liwang@redhat.com> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, Mar 7, 2019 at 8:44 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> Add partial file sync tests as part of sync_file_range02 test-case.
> >>
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>
> >> Changes in v3:
> >> 1. Add upper bound check for synced size to device.
> >> 2. Refactor tests for more code reuse.
> >> 3. Add another test to check sync over partial write.
> >>
> >> Changes in v2:
> >> 1. Do full file write instead of partial and test sync partial file.
> >>
> >>  .../syscalls/sync_file_range/sync_file_range02.c   | 47
> +++++++++++++++++-----
> >>  1 file changed, 37 insertions(+), 10 deletions(-)
> >>
> >> diff --git
> a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> >> index 82d77f7..334ea5e 100644
> >> --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> >> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> >> @@ -22,23 +22,36 @@
> >>  #include "check_sync_file_range.h"
> >>
> >>  #define MNTPOINT               "mnt_point"
> >> -#define FNAME          MNTPOINT"/test"
> >> -#define FILE_SIZE_MB   32
> >> -#define FILE_SIZE (FILE_SIZE_MB * TST_MB)
> >> +#define FNAME1                 MNTPOINT"/test1"
> >> +#define FNAME2                 MNTPOINT"/test2"
> >> +#define FNAME3                 MNTPOINT"/test3"
> >> +#define FILE_SZ_MB             32
> >> +#define FILE_SZ                        (FILE_SZ_MB * TST_MB)
> >>  #define MODE                   0644
> >>
> >> -static void verify_sync_file_range(void)
> >> +struct testcase {
> >> +       char *fname;
> >> +       off64_t sync_off;
> >> +       off64_t sync_size;
> >> +       size_t exp_sync_size;
> >> +       off64_t write_off;
> >> +       size_t write_size_mb;
> >> +};
> >> +
> >> +static void verify_sync_file_range(struct testcase *tc)
> >>  {
> >>         int fd;
> >>         unsigned long written;
> >>
> >> -       fd = SAFE_OPEN(FNAME, O_RDWR|O_CREAT, MODE);
> >> +       fd = SAFE_OPEN(tc->fname, O_RDWR|O_CREAT, MODE);
> >> +
> >> +       lseek(fd, tc->write_off, SEEK_SET);
> >>
> >>         tst_dev_bytes_written(tst_device->dev);
> >>
> >> -       tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
> >> +       tst_fill_fd(fd, 0, TST_MB, tc->write_size_mb);
> >
> >
> > I'm just thinking that is probably more precise if we reverse the order
> of tst_fill_fd() and tst_dev_bytes_written()? Because that does counting
> the dev_bytes_writen only before and after sync_file_range(), we cann't
> garantee system does not wirte back to deviece when do fill_fd(), isn't it?
>
> There is another aspect to this if we move tst_dev_bytes_written()
> after tst_fill_fd() then we may miss count for actual data that may be
> written back during tst_fill_fd() operation.
>
>
Sounds reasonable, thanks for the clarification.


> AFAIU, LTP uses test-device for all device specific tests of which it
> has full control and also the tests run sequentially. So I think there
> are pretty rare chances to have such scenario that you referred too.
>
> -Sumit
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190418/ec9ddc16/attachment-0001.html>
