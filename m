From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Jun 2020 16:16:20 +0200
Subject: [LTP] i386: fanotify01.c:115: BROK: fanotify_mark () failed:
 EFAULT (14)
In-Reply-To: <CA+G9fYvU3g1HqOT8UbNBzXCjCD7Ot1pAFjv-8PGee9ObdbYksg@mail.gmail.com>
References: <CA+G9fYvU3g1HqOT8UbNBzXCjCD7Ot1pAFjv-8PGee9ObdbYksg@mail.gmail.com>
Message-ID: <20200601141620.GB8417@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> fanotify01.c:115: BROK: fanotify_mark (6, FAN_MARK_ADD, FAN_ACCESS |
> FAN_MARK_INODE | FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD,
> fs_mnt/tfile_19115) failed: EFAULT (14)

Looking at these failures we do not pass anything that may cause EFAULT,
the only pointer we pass is the path at the end but that thing is null
terminated properly. In a case of fanotify09.c it's even constant string.

-- 
Cyril Hrubis
chrubis@suse.cz
