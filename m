From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 6 Feb 2019 09:04:01 +0100
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190128134656.27979-1-metan@ucw.cz>
References: <20190128134656.27979-1-metan@ucw.cz>
Message-ID: <20190206080400.GB13396@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> +static void *nowait_reader(void *unused LTP_ATTRIBUTE_UNUSED)
...
> +		TEST(preadv2(fd, rd_iovec, 2, off, RWF_NOWAIT));
RWF_NOWAIT needs to be declared in lapi for old distros.

Kind regards,
Petr
