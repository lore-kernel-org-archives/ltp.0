From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 3 Mar 2017 14:43:43 +0100
Subject: [LTP] [PATCH v2 1/1] syscalls/mq_timedreceive: convert to new
	API
In-Reply-To: <20170303130342.GA16323@rei.lan>
References: <20170301201331.22402-1-pvorel@suse.cz>
 <20170303130342.GA16323@rei.lan>
Message-ID: <20170303134342.qmzaxdgrwmlviom7@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> This is still too ugly.
Sorry :-(. Thanks for review and tips!


> Also we should use SAFE_OPEN() for opening the file. And we may as well
> add safe_posix_ipc.h with SAFE_MQ_OPEN().
Ok I'll do it. I was thinking about it some time ago, but thought it wouldn't be worth
just for these few mq_* related tests.

BTW: I suppose tests in testcases/kernel/containers/mqns/ which are using mq_open() via
ltp_syscall should use mq_open() directly, don't they?


Kind regards,
Petr
