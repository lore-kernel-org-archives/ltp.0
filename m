From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 May 2019 21:58:05 +0200
Subject: [LTP] [PATCH] shmctl01: don't use hardcoded index == 0 for
 SHM_STAT test
In-Reply-To: <a5e65ca65d88177d9142cbd2d5a3ddf5dda174b5.1558379215.git.jstancek@redhat.com>
References: <a5e65ca65d88177d9142cbd2d5a3ddf5dda174b5.1558379215.git.jstancek@redhat.com>
Message-ID: <20190520195805.GA22932@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Test fails on SHM_STAT testcase:
>    shmctl01    5  TFAIL  :  shmctl01.c:173: shmctl01 call failed
>                             errno = 22 : Invalid argument
>    shmctl(0, SHM_STAT, 0x601060)           = -EINVAL

> since following commit:
>    commit 99db46ea292780cd978d56932d9445b1e8bdafe8
>    Author: Manfred Spraul <manfred@colorfullife.com>
>    Date:   Tue May 14 15:46:36 2019 -0700
>      ipc: do cyclic id allocation for the ipc object.

> Don't rely on index 0 being always available, but instead
> use (maximum) index returned by SHM_INFO.

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Good catch + further improvements.

Kind regards,
Petr
