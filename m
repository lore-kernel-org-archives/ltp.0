From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jan 2020 12:35:35 +0100
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200108112537.GA22954@dell5510>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510>
Message-ID: <20200108113535.GA17272@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This broke build with -Werror=implicit-function-declaration [1]:
> 
> ../include/tst_device.h:78:2: error: implicit declaration of function 'syncfs'; did you mean 'sync'? [-Werror=implicit-function-declaration]
> 2770  syncfs(fd);
> 2771  ^~~~~~
> 2772  sync
> 
> The problem is that syncfs() is guarded with __USE_GNU (in glibc, in musl
> directly _GNU_SOURCE), so this requires to use _GNU_SOURCE (before including
> first header).
> Because it's in tst_device.h, we effectively need to build with -D_GNU_SOURCE.
> Is that what we want? Or should we always use tst_syscall(__NR_syncfs, fd)
> (without conditional check #ifndef HAVE_SYNCFS) ?

I guess calling raw syscall in the tst_device.h would be easiest fix.

-- 
Cyril Hrubis
chrubis@suse.cz
