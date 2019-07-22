From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jul 2019 14:54:24 +0200
Subject: [LTP] [PATCH]syscalls/ioctl: bugfix for
 syscalls/ioctl/ioctl_ns05.c syscalls/ioctl/ioctl_ns06.c
In-Reply-To: <1563762541-89314-1-git-send-email-songjian15@huawei.com>
References: <1563762541-89314-1-git-send-email-songjian15@huawei.com>
Message-ID: <20190722125424.GA17745@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> fix ioctl_ns05, ioctl_ns06 timeout.
> signal() will return 0 if success, so it have no chance to equal
> nr_wake=1, use another api to to repalce the current api to ensure that
> nr_wark = 0.

I do not understand what is the problem here.

What do you mean by "signal() will return 0 if success" ?

The child has to be suspended in the futex until it's woken up so as far
as I can tell the checkpoint should be able to wake the child a the end
of the run() function.

-- 
Cyril Hrubis
chrubis@suse.cz
