From: jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Wed, 15 May 2019 13:21:21 +0800
Subject: [LTP] [PATCH] syscall/ioctl: fix compiler error
In-Reply-To: <20190514130234.GB31720@dell5510>
References: <1557711965-11638-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <20190514130234.GB31720@dell5510>
Message-ID: <5CDBA1D1.9010002@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/05/14 21:02, Petr Vorel wrote:

Hi,
> Hi Jinhui,
>
>> "CLONE_NEWPID" and "CLONE_NEWUSER" are not defined on some old distros,
>> so include "lapi/namespaces_constants.h" to fix it.
> Can you be more specific, which distros?
> CLONE_* has been added into glibc in 2008 (released in glibc 2.8).
>
The kernel version is 2.6.18-398.el5 and the glibc version is 
glibc-2.5-123.
>> Signed-off-by: Jinhui huang<huangjh.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> @Cyril: this could go before release as well.
>
> Kind regards,
> Petr
Kind regards,
Jinhui


