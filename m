From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Apr 2017 10:51:01 +0800
Subject: [LTP] LTP release
In-Reply-To: <1148677109.2856278.1493211577427.JavaMail.zimbra@redhat.com>
References: <20170424162534.GA13616@rei.lan>
 <CAEemH2fOjPpfHrNy73q69whA8vX7ozN0ea=Hufr7CB-UZos6Lg@mail.gmail.com>
 <20170426090805.GA16024@rei.lan>
 <1148677109.2856278.1493211577427.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2c1Chx4pR38JUG1Gqz2q6DWNsdq6krJwkPOuP6rRG6cyg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 26, 2017 at 8:59 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
>> Hi!
>> > > It's about a time we should prepare for another release, hence as
>> > > usuall, lets start with pointing out any patches that should be part of
>> > > it and I would like to start with pre-release testing at the end of this
>> > > week. Does that sound OK to everyone?
>> >
>> > ioctl06 always failed on aarch64(others PASS) with upstream
>> > kernel-4.11-rc[1-7]. Not sure if it is a bug or not, since i'm still
>> > on debugging way. Just report here to let you know this.
>
> I'm seeing it fail on ppc as well (64k pages), with older RHEL7 kernels:
>
>> Looks like the value is rounded to be multiple of 128, that may be just
>> intentional limitation, but we should better check with the kernel
>> source or ask kernel devs.
>
> block/ioctl.c:
>         case BLKRASET:
>         case BLKFRASET:
>                 if(!capable(CAP_SYS_ADMIN))
>                         return -EACCES;
>                 bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
>                 return 0;
>


how about makes change as:

--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -31,12 +31,13 @@ static int fd;
 static void verify_ioctl(void)
 {
        unsigned long ra, rab, rao;
+       unsigned long ra_shift = getpagesize() / 512;

        SAFE_IOCTL(fd, BLKRAGET, &rao);

        tst_res(TINFO, "BLKRAGET original value %lu", rao);

-       for (ra = 0; ra <= 512; ra += 64) {
+       for (ra = 0; ra <= ra_shift * 8; ra += ra_shift) {
                SAFE_IOCTL(fd, BLKRASET, ra);
                SAFE_IOCTL(fd, BLKRAGET, &rab);




-- 
Regards,
Li Wang
Email: liwang@redhat.com
