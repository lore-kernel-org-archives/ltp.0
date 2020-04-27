From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 19:27:17 +0200
Subject: [LTP] [PATCH 1/4] syscalls/fanotify09: Check merging of events
 on directories
In-Reply-To: <20200421065002.12417-2-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-2-amir73il@gmail.com>
Message-ID: <20200427172717.GA13629@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> In a setup of mount mark and directory inode mark the FAN_ONDIR flag
> set on one mark should not imply that all events in the other mark mask
> are expected on directories as well.

> Add a regression test case for commit 55bf882c7f13:
>    fanotify: fix merging marks masks with FAN_ONDIR

Merged this one (with simple change: added {"linux-git", "55bf882c7f13"},).
Thanks for your work!

Kind regards,
Petr
