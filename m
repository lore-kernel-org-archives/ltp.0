From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Jan 2019 16:47:59 +0530
Subject: [LTP] LTP: fanotify11: ENOSYS: Function not implemented
Message-ID: <CA+G9fYvcLVds0t6Ayuewdfhmf-wXYe7DWqNY86u8SjkK-1-3pw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fanotify11 is newly added test case for upcoming LTP release.

Pass on arm64.
Failed on arm(32), x86_64 and i386.
fanotify11.c:72: BROK: fanotify_init(0x0, 0) failed: ENOSYS ( Function
not implemented )

The reason for failure is pre-required Kconfigs not enabled for
arm(32), x86_64 and i386.
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y

Best regards
Naresh Kamboju
