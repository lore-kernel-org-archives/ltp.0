From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Sep 2021 15:53:30 +0200
Subject: [LTP] [PATCH] syscalls/pread01: Convert to new API
In-Reply-To: <YS998a/fPdH5aZh8@pevik>
References: <1629294657-28375-1-git-send-email-daisl.fnst@fujitsu.com>
 <YS998a/fPdH5aZh8@pevik>
Message-ID: <YS+F2vm0SVSLvyjU@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Dai,

> ...
> > +static void verify_pwrite(void)
...

> your code:
> static void verify_pread(void)
> {
> 	SAFE_PREAD(1, fildes, read_buf[2], K1, K2);

> 	l_seek(fildes, 0, SEEK_CUR, K4);

> 	l_seek(fildes, 0, SEEK_SET, 0);

> 	SAFE_PREAD(1, fildes, read_buf[3], K1, K3);

> 	l_seek(fildes, 0, SEEK_CUR, 0);

> 	SAFE_READ(1, fildes, read_buf[0], K1);

> 	l_seek(fildes, 0, SEEK_CUR, K1);

> 	SAFE_PREAD(1, fildes, read_buf[1], K1, K1);

> 	l_seek(fildes, 0, SEEK_CUR, K1);

> 	compare_bufers();

> 	l_seek(fildes, K4, SEEK_SET, K4);
> }

> nit: having blank line after each line?

> how about something like:

> static void verify_pread(void)
> {
> 	SAFE_PREAD(1, fildes, read_buf[2], K1, K2);
> 	l_seek(fildes, 0, SEEK_CUR, K4);
> 	l_seek(fildes, 0, SEEK_SET, 0);

> 	SAFE_PREAD(1, fildes, read_buf[3], K1, K3);
> 	l_seek(fildes, 0, SEEK_CUR, 0);

> 	SAFE_READ(1, fildes, read_buf[0], K1);
> 	l_seek(fildes, 0, SEEK_CUR, K1);

> 	SAFE_PREAD(1, fildes, read_buf[1], K1, K1);
> 	l_seek(fildes, 0, SEEK_CUR, K1);

> 	compare_bufers();

> 	l_seek(fildes, K4, SEEK_SET, K4);
> }

I'm sorry, this was meant to be mentioned at patch, which changes pread01.c [1],
not here. I got confused by your wrong subject. But most of the code is similar,
thus can apply here.

[1] https://patchwork.ozlabs.org/project/ltp/patch/1629200697-14878-1-git-send-email-daisl.fnst@fujitsu.com/

> The rest LGTM.

> Kind regards,
> Petr
