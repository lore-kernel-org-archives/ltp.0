From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Apr 2020 10:30:55 +0200
Subject: [LTP] [PATCH v1 07/10] syscalls/ioctl_loop05: Add
 LOOP_SET_DIRECT_IO ioctl test
In-Reply-To: <1847306e-f00c-a484-9080-8d1b7f62ce60@163.com>
References: <1585839990-19923-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1585839990-19923-8-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200403164416.GA11850@yuki.lan>
 <1847306e-f00c-a484-9080-8d1b7f62ce60@163.com>
Message-ID: <20200406083055.GA1947@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +}
> >> +
> >> +static struct tst_test test = {
> >> +	.setup = setup,
> >> +	.cleanup = cleanup,
> >> +	.test_all = verify_ioctl_loop,
> >> +	.needs_root = 1,
> >> +//	.needs_tmpdir = 1,
> > 
> > Looks like a forgotten debug measure.
> > 
> Yes, because some distribution use tmpfs in tmp directory, then this 
> case will TCONF(tmpfs doesn't supprt DIO).  I am indecisive, or I should 
>   use all_filesystem =1, so it will not report TCONF? Or, keep it?

That will just create a loop device formatted with a filesystem and
another loop device in that filesystem in most cases. I doubt that it
will even work if we are doing all of that on the top of tmpfs anyways.

-- 
chrubis@suse.cz
