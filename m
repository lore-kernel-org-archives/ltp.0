From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:21:54 +0100
Subject: [LTP] [PATCH V2 28/32] rt_sigaction.h: Use sighandler_t instead
 of __sighandler_t
In-Reply-To: <1452302060-103643-28-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-28-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202172153.GR19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When _GNU_SOURCE is used then both typedefs are same and using
> sighandler_t makes it work on musl too

Eh, what is the _GNU_SOURCE needed for?

Is there a difference between __sighandler_t and sighandler_t without
it?

-- 
Cyril Hrubis
chrubis@suse.cz
