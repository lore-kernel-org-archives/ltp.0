From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 15:46:48 +0200
Subject: [LTP] [PATCH 1/2] fanotify: Move safe_fanotify_init() + safe
 macro into fanotify.h
In-Reply-To: <20200428113501.24711-1-pvorel@suse.cz>
References: <20200428113501.24711-1-pvorel@suse.cz>
Message-ID: <20201014134648.GA13224@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fanotify code is used only in testcases/kernel/syscalls/fanotify/, which
> justify breaking rule of having safe function and macro outside of
> library. This will be further cleaned in next commit.

I guess that this is OK, I doubt that we will need a fanotify_init()
anywhere else but the fanotify testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
