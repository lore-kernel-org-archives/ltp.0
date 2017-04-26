From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Apr 2017 08:59:37 -0400 (EDT)
Subject: [LTP] LTP release
In-Reply-To: <20170426090805.GA16024@rei.lan>
References: <20170424162534.GA13616@rei.lan>
 <CAEemH2fOjPpfHrNy73q69whA8vX7ozN0ea=Hufr7CB-UZos6Lg@mail.gmail.com>
 <20170426090805.GA16024@rei.lan>
Message-ID: <1148677109.2856278.1493211577427.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > > It's about a time we should prepare for another release, hence as
> > > usuall, lets start with pointing out any patches that should be part of
> > > it and I would like to start with pre-release testing at the end of this
> > > week. Does that sound OK to everyone?
> > 
> > ioctl06 always failed on aarch64(others PASS) with upstream
> > kernel-4.11-rc[1-7]. Not sure if it is a bug or not, since i'm still
> > on debugging way. Just report here to let you know this.

I'm seeing it fail on ppc as well (64k pages), with older RHEL7 kernels:

> Looks like the value is rounded to be multiple of 128, that may be just
> intentional limitation, but we should better check with the kernel
> source or ask kernel devs.

block/ioctl.c:
        case BLKRASET:
        case BLKFRASET:
                if(!capable(CAP_SYS_ADMIN))
                        return -EACCES;
                bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
                return 0;

Regards,
Jan
