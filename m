From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 Dec 2020 12:57:41 +0100
Subject: [LTP] [PATCH 3/5] syscalls/fanotify09: Read variable length
 events
In-Reply-To: <X84VqaD4+FqAix5h@pevik>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-4-amir73il@gmail.com>
 <X84VqaD4+FqAix5h@pevik>
Message-ID: <X84YtUq/SNK1HJRY@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > In preparation of testing events with filename info, teach the
> > how to read variable length events and parse the name info.

> This commit broke umount() on old kernels. (LTP lib doing multiple attempts is
> useless here). Not sure what exactly is being used, it's not by staing in
> mounted directory. Any idea how to fix it?

Using umount2(MOUNT_NAME, MNT_DETACH) obviously fixes umount, but not sure if
fixing something in the test would allow to use tst_umount().

Kind regards,
Petr
