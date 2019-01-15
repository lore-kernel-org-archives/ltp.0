From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 15 Jan 2019 13:55:02 +0200
Subject: [LTP] LTP: fanotify11: ENOSYS: Function not implemented
In-Reply-To: <CA+G9fYvcLVds0t6Ayuewdfhmf-wXYe7DWqNY86u8SjkK-1-3pw@mail.gmail.com>
References: <CA+G9fYvcLVds0t6Ayuewdfhmf-wXYe7DWqNY86u8SjkK-1-3pw@mail.gmail.com>
Message-ID: <CAOQ4uxgE00WHjiedOTaAJa+KcyaL8u80g2z4Kv4EQ1cZO17HGg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 15, 2019 at 1:18 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> fanotify11 is newly added test case for upcoming LTP release.
>
> Pass on arm64.
> Failed on arm(32), x86_64 and i386.
> fanotify11.c:72: BROK: fanotify_init(0x0, 0) failed: ENOSYS ( Function
> not implemented )
>
> The reason for failure is pre-required Kconfigs not enabled for
> arm(32), x86_64 and i386.
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
>
> Best regards
> Naresh Kamboju

Wasn't this fixed by:

commit 2b37d84051ac2fa8e30f19d9024e5a7f3b4bcbb4
Author: Tommi Rantala <tommi.t.rantala@nokia.com>
Date:   Wed Dec 12 13:26:26 2018 +0200

    syscalls/fanotify11.c: check fanotify kernel support


Thanks,
Amir.
