From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2019 16:30:31 +0300
Subject: [LTP] [PATCH] syscalls/getxattr05: skip userns test cases when
	not supported
In-Reply-To: <20190619142338.GA30900@rei.lan>
References: <20190619124707.2981-1-amir73il@gmail.com>
 <20190619142338.GA30900@rei.lan>
Message-ID: <CAOQ4uxi4L799rLLKQcVcChk5vM0RtgsjKzgH6iXNeMv7bXos0Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 19, 2019 at 5:23 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Pushed, thanks.

FYI, some more false positive failures I ran into.
I've put them in my skip list, if somebody has time to fix them...

ioctl_ns04 and ioctl_ns06 also fail when CONFIG_USER_NS is not defined:

ioctl_ns04.c:24: CONF: namespace not available
safe_macros.c:225: BROK: ioctl_ns04.c:31:
open(/proc/self/ns/user,0,034641644410) failed: ENOENT

oom03 and oom05 fail when CONFIG_MEMCG is not defined:

mem.c:757: BROK: mount /dev/cgroup: ENOENT

And also does not cleanup /dev/cgroup afterwards, so error them becomes:

safe_macros.c:169: BROK: mem.c:747: mkdir(/dev/cgroup,0777) failed: EEXIST

Thanks,
Amir.
