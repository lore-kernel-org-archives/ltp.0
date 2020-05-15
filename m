From: Li Wang <liwang@redhat.com>
Date: Fri, 15 May 2020 11:37:02 +0800
Subject: [LTP] LTP release
In-Reply-To: <20200514095444.GB18592@yuki.lan>
References: <20200504104907.GA3567@yuki.lan> <20200514095444.GB18592@yuki.lan>
Message-ID: <CAEemH2dGpJzRTnn-n26cDBQUhZeX7UK5wtq=fSdVO8HUtJCzAQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I have finished the latest LTP test around RHEL7/8 and mainline kernel
across arches. Apart from many known issues/bugs the test looks good.

The only failure to catch my attention is the ioctl_loop05 still getting
fail on s390x with RHEL8.2 or kernel-v5.7-rc5. I haven't dig into the
details since it looks insignificant.
@Yang Xu <xuyang2018.jy@cn.fujitsu.com> Xu, do you have any idea about that?

# ./ioctl_loop05
tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
tst_device.c:88: INFO: Found free device 0 '/dev/loop0'
ioctl_loop05.c:116: INFO: /dev/loop0 default logical_block_size is 512
ioctl_loop05.c:62: INFO: Without setting lo_offset or sizelimit
ioctl_loop05.c:63: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed: EINVAL (22)


On Thu, May 14, 2020 at 5:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> This is a last call, if you think that something has to be included in
> the release speak up today.
>
> The last thing on my radar is the "syscalls: Fix issues around calling
> syscalls with old timespec" patch that should get in, after that I would
> like to proceed with the release.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200515/28f395a7/attachment-0001.htm>
