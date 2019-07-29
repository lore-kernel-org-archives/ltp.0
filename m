From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 13:21:52 +0200
Subject: [LTP] [PATCH v2] syscalls/timer_create: Add test for
 CVE-2017-18344
In-Reply-To: <20190726083701.9682-1-camann@suse.com>
References: <20190726083701.9682-1-camann@suse.com>
Message-ID: <20190729112152.GA26236@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> In kernels prior to 4.14.8 (missing commit cef31d9af908)
> the sigevent.sigev_notify field is not properly checked
> when creating a timer using timer_create(2).
> This can be used to read arbitrary kernel memory.

Thanks for your patch, merged into master (with Cyril's and Li's ack).

Kind regards,
Petr
