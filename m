From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Apr 2021 09:52:04 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: Bugfix for heartbeat
In-Reply-To: <20210323135604.24504-1-zhaogongyi@huawei.com>
References: <20210323135604.24504-1-zhaogongyi@huawei.com>
Message-ID: <YHfwpO1VZ9OBJ3Ii@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> When main process has been killed, its son process will be reaped by
=> nit: son/child

> init, and son process will send SIGUSR1 to the init process.

Kind regards,
Petr
