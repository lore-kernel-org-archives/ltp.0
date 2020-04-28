From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2020 14:36:21 +0200
Subject: [LTP] [PATCH 1/2] inotify: Add SAFE_MYINOTIFY_INIT{,
 1}() helpers
In-Reply-To: <20190613131018.GA29926@rei.lan>
References: <20190605072126.19856-1-pvorel@suse.cz>
 <20190613131018.GA29926@rei.lan>
Message-ID: <20200428123621.GA32116@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> These two patches are obviously OK.

> Well I we were pedantic the licence change should be in a separate
> patch, but I guess that it's fine as it is.

> Also we should probably switch to the inotify_init() from sys/inotify.h
> and drop the my from the functions and macros, but that could be done in
> a subsequent patch.
Looking into this old TODO for inotify tests. I have similar question to
fanotify: do you consider worth of testing both raw syscall and inotify_init()?

Kind regards,
Petr
