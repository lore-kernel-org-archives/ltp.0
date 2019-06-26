From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Jun 2019 17:40:48 +0800
Subject: [LTP] [PATCH v4 2/2] pkey: add test for memory protection keys
In-Reply-To: <285629943.30156546.1561537194409.JavaMail.zimbra@redhat.com>
References: <20190626071538.29486-1-liwang@redhat.com>
 <20190626071538.29486-2-liwang@redhat.com>
 <285629943.30156546.1561537194409.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2d_7fq2RxEwZEMSUgErM7XG26RTsV1ogLTiLvALc810Gw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 26, 2019 at 4:20 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > +
> > +static void setup(void)
> > +{
> > +     int i, fd;
> > +
> > +     if (access(PATH_VM_NRHPS, F_OK)) {
> > +             tst_res(TINFO, "Huge page is not supported");
> > +             size = getpagesize();
> > +             no_hugepage = 1;
> > +     } else {
> > +             int val;
> > +
> > +             SAFE_FILE_PRINTF(PATH_VM_NRHPS, "%d", 1);
>
> This is still SAFE write, which may trigger TBROK:
>
> # ./pkey01
> tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
> safe_file_ops.c:301: BROK: Failed to close FILE
> '/proc/sys/vm/nr_hugepages' at pkey01.c:67: EOPNOTSUPP
> safe_macros.c:773: WARN: pkey01.c:91: umount(tmp_pkey) failed: ENOENT
> safe_macros.c:184: WARN: pkey01.c:92: rmdir(tmp_pkey) failed: ENOENT
>

Er, sorry about still not working here.

If a system(e.g PowerKVM guest) configured with NO huge page support, then
the file '/proc/sys/vm/nr_hugepages' exist but EOPNOTSUPP to read/write. In
this key01, perhaps I shouldn't use the "/proc/.../nr_hugepages" to detect
that at the beginning.

Seems the correct way is to use "/sys/kernel/mm/hugepages/" for huge page
detecting and leave the SAFE_FILE_* still in setup(). Because we need to
catch the "/proc/.../nr_hugepages" open/close or read/write issue in
testing.

What do you think? Should we mask the EOPNOTSUPP as a TCONF skipping or
others?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190626/8ce26f4e/attachment-0001.htm>
