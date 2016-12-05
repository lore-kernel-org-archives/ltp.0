From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Dec 2016 09:17:54 +0100
Subject: [LTP] about libipc
In-Reply-To: <CAJ5Dnr1XF-jzn7FYfJZGXJjdMUjhma6TPnu5ApzY6euOAH-33w@mail.gmail.com>
References: <CAJ5Dnr1XF-jzn7FYfJZGXJjdMUjhma6TPnu5ApzY6euOAH-33w@mail.gmail.com>
Message-ID: <20161205081754.GA15793@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> In our current libipc,it will use shmctl and shmget to operate a piece of
> share memory,but android has a different implement of share memory .So how
> about to add support for ashmem(Android share memory)?

The whole syscalls/ipc/ directory contains only System V IPC testcases
so it does not make much sense to add a support for android or anything
else there as that would only make the code much more complicated for no
real gain. It would be probably much easier to write ashmem testcases
from a scratch.

-- 
Cyril Hrubis
chrubis@suse.cz
