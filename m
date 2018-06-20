From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jun 2018 12:48:14 +0200
Subject: [LTP] [RFC PATCH 9/9] syscalls/ipc: Fix Makefile
In-Reply-To: <20180613123519.2t6upag4kmcfvfwq@dell5510>
References: <20180612154631.435-1-chrubis@suse.cz>
 <20180612154631.435-10-chrubis@suse.cz>
 <20180613123519.2t6upag4kmcfvfwq@dell5510>
Message-ID: <20180620104814.GA23700@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I've noticed, that some commits from this patchset aren't bisectable, due
> dependency on new library (libnewipc.h).
> IMHO it's worth of fixing it.

I guess that the best I can do is to disable the directory from build
before the patchset and enable it with a new Makefile at the end as it's
nearly impossible to mix the new and old IPC library in one Makefile.

And yes I wanted to send this early, so I kind of ignored the build
problems.

-- 
Cyril Hrubis
chrubis@suse.cz
