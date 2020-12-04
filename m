From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Dec 2020 15:22:55 +0100
Subject: [LTP] [PATCH 5/5] syscalls/fanotify09: Add test case for events
 with filename info
In-Reply-To: <20201204095930.866421-6-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-6-amir73il@gmail.com>
Message-ID: <X8pGP7nWDfTpLoOA@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Kernel v5.9 has a bug when there is a mark on filesystem or mount
> interested in events with filename AND there is an additional
> mark on a parent watching children.

> In some situations the event is reported to filesystem or mount mark
> without the filename info.

> This bug is fixed by kernel commit 7372e79c9eb9:
>   fanotify: fix logic of reporting name info with watched parent

You forget to add {"linux-git", "7372e79c9eb9"}, but we add it
before merge.

Kind regards,
Petr
