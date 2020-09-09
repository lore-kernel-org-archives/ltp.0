From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Sep 2020 09:06:20 -0400 (EDT)
Subject: [LTP] [Patch v2] ioctl: take use of TST_RETRY_FN* macro
In-Reply-To: <20200909125753.7724-1-liwang@redhat.com>
References: <20200909125753.7724-1-liwang@redhat.com>
Message-ID: <1322097859.11602601.1599656780160.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> To avoid of race with udev, let's use TST_RETRY_FN* macro to loop
> access() function for more times.
> 
> ---Errors---
> ioctl_loop01.c:59: PASS: /sys/block/loop0/loop/partscan = 1
> ioctl_loop01.c:60: PASS: /sys/block/loop0/loop/autoclear = 0
> ioctl_loop01.c:71: FAIL: access /dev/loop0p1 fails
> ioctl_loop01.c:77: FAIL: access /sys/block/loop0/loop0p1 fails
> 
> ioctl09.c:41: PASS: access /sys/block/loop0/loop0p1 succeeds
> ioctl09.c:52: FAIL: access /dev/loop0p1 fails
> 
> Fixes: #718
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Cc: Jan Stancek <jstancek@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

