From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jul 2019 11:03:26 +0200
Subject: [LTP] [PATCH] snd_timer: check if file /dev/snd/timer exist
 before opening
In-Reply-To: <20190717072109.7077-1-liwang@redhat.com>
References: <20190717072109.7077-1-liwang@redhat.com>
Message-ID: <20190717090326.GA25480@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1. check if /dev/snd/timer exist
> 
> 2. add tst_fzsync_pair_reset(&fzsync_pair, NULL) to reset variables
> needed by fzsync. Especially for pair->exec_time_start, we use it to
> control the test time in case that the execution loops timed out on
> slow machine.

This is obviously OK, acked.

-- 
Cyril Hrubis
chrubis@suse.cz
