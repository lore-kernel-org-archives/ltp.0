From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Mar 2021 15:18:01 +0200
Subject: [LTP] [PATCH] bugfix for cpio/cpio_tests.sh
In-Reply-To: <762779324.75038.1617189402948.JavaMail.xmail@bj-wm-cp-5>
References: <20210330130115.26575-1-sujiaxun@uniontech.com>
 <YGRPZF+DJy/jAZRN@pevik>
 <762779324.75038.1617189402948.JavaMail.xmail@bj-wm-cp-5>
Message-ID: <YGR2iTMUNUTuhbMw@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > In cpio version 2.12 and 2.13,'cpio --help' create is lowercase ?
> ?
> > - if ! cpio --help 2>&1 | grep -q -- '-o.*Create'; then ?
> > + if ! cpio --help 2>&1 | grep -qi -- '-o.*Create'; then ?

> Sorry, I thought the search was ?--create? after ?-o?. In the English
> environment, there is indeed ?Create? in the description.

> ??-i,?--extract??????????????Extract?files?from?an?archive
> ??-o,?--create? ? ? ? ? ? ? Create?the?archive

Thanks for clarification.  No, long option --create does not exist in busybox
implementation, there is only short option -o. I mean it wouldn't harm to have
'grep -i', but until needed, I prefer to not adding it.

cpio implementation:
  -o, --create               Create the archive (run in copy-out mode)

busybox implementation:
	-o	Create (requires -H newc)

Kind regards,
Petr
