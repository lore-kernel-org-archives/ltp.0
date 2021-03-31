From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Mar 2021 12:31:00 +0200
Subject: [LTP] [PATCH] bugfix for cpio/cpio_tests.sh
In-Reply-To: <20210330130115.26575-1-sujiaxun@uniontech.com>
References: <20210330130115.26575-1-sujiaxun@uniontech.com>
Message-ID: <YGRPZF+DJy/jAZRN@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> In cpio version 2.12 and 2.13,'cpio --help' create is lowercase

> -	if ! cpio --help 2>&1 | grep -q -- '-o.*Create'; then
> +	if ! cpio --help 2>&1 | grep -qi -- '-o.*Create'; then

First, are you talking about cpio implementation [1]
or busybox implementation [2] ?

I suppose cpio, but also busybox had in the past 2.12 and 2.13.
There is no lower case in cpio 2.12 [3] neither in 2.13 [4].

Looking at busybox, I'm not sure how help was printed ([5] [6]), as I'm not able
to install this version (1_13_4 tag is from 2009 - I guess you're not talking about it).

Kind regards,
Petr

[1] https://git.savannah.gnu.org/cgit/cpio.git
[2] https://git.busybox.net/busybox/
[3] https://git.savannah.gnu.org/cgit/cpio.git/tree/src/main.c?h=release_2_12#n101
[4] https://git.savannah.gnu.org/cgit/cpio.git/tree/src/main.c?h=release_2_13#n100
[5] https://git.busybox.net/busybox/tree/archival/cpio.c?h=1_12_stable#n185
[6] https://git.busybox.net/busybox/tree/archival/cpio.c?h=1_13_stable
