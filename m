From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Mar 2019 10:51:23 +0100
Subject: [LTP] [PATCH 1/1] msgrcv/msgrcv08.c: Use struct msgbuf defined
 in <sys/msg.h>
In-Reply-To: <20190320215707.30268-1-petr.vorel@gmail.com>
References: <20190320215707.30268-1-petr.vorel@gmail.com>
Message-ID: <20190321095123.GA1252@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> which requires to define _GNU_SOURCE.
> This fixes MUSL build.
> 
> NOTE: char array from struct has usually length 1, the one from test had 16,
> but that's not a limitation.
> 
> Fixes: eccd238da ("ipc/msgrcv: add new testcase msgrcv08")

It does not matter much here, but actually the structure is supposed to
be user defined, see the msgrcv manual page and you are supposed to pick
the message buffer length accordingly to your needs.

I guess that slightly better fix would be renaming the structure name,
the rest of the msgctl tests uses struct mbuf instead.

-- 
Cyril Hrubis
chrubis@suse.cz
