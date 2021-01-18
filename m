From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 18 Jan 2021 18:50:57 +0000
Subject: [LTP] [PATCH 0/5] Convert CAN tests to new LTP API
In-Reply-To: <AM0PR05MB4642C547F8E6A3D5C230B87DECA40@AM0PR05MB4642.eurprd05.prod.outlook.com>
References: <20210118155628.9248-1-rpalethorpe@suse.com>
 <AM0PR05MB4642C547F8E6A3D5C230B87DECA40@AM0PR05MB4642.eurprd05.prod.outlook.com>
Message-ID: <87h7neoz8u.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Oliver,

Hartkopp, Oliver, Dr. (EESC/5) <oliver.hartkopp@volkswagen.de> writes:

> Dear Richard,
>
> either I'm not using my VW-Email for OSS/SocketCAN anymore and the
> socketcan-users@berlios is also not used anymore.

Thanks, I will send a V2 with these addresses removed from our docs.

>
> Please resend you patch set with these updated mail addresses:
>
> Oliver Hartkopp <socketcan@hartkopp.net>
> Linux-CAN ML <linux-can@vger.kernel.org>
>
> Many thanks,
> Oliver
>
> -----Urspr?ngliche Nachricht-----
> Von: Richard Palethorpe <rpalethorpe@suse.com> 
> Gesendet: Montag, 18. Januar 2021 16:56
> An: ltp@lists.linux.it
> Cc: socketcan-users@lists.berlios.de; Hartkopp, Oliver, Dr. (EESC/5) <oliver.hartkopp@volkswagen.de>; Richard Palethorpe <rpalethorpe@suse.com>
> Betreff: [PATCH 0/5] Convert CAN tests to new LTP API
>
> Hello,
>
> This is an attempt to convert the CAN tests to the (modern) LTP API and removes the wrapper script. I have tried to keep the core test behaviour the same, but (for example) moving to the SAFE_ functions will naturally introduce some changes in error checking. Deliberate behavioral changes have been noted in the commit messages.
>
> Richard Palethorpe (5):
>   API: Add FILE_SCANF to new lib
>   can: Add can_common.h for vcan device setup
>   can_filter: Convert to new library
>   can_recv_own_msgs: Convert to new library
>   can: Remove obsolete test wrapper script
>
>  include/tst_safe_file_ops.h                   |   3 +
>  testcases/network/can/Makefile                |   2 -
>  .../can/filter-tests/00_Descriptions.txt      |   1 +
>  testcases/network/can/filter-tests/INSTALL    |   3 +-
>  testcases/network/can/filter-tests/Makefile   |   2 -
>  .../network/can/filter-tests/can_common.h     |  70 ++++
>  .../network/can/filter-tests/can_filter.c     | 317 +++++++-----------
>  .../can/filter-tests/can_rcv_own_msgs.c       | 273 +++++----------
>  .../network/can/filter-tests/can_run_tests.sh | 106 ------
>  9 files changed, 288 insertions(+), 489 deletions(-)  create mode 100644 testcases/network/can/filter-tests/can_common.h
>  delete mode 100755 testcases/network/can/filter-tests/can_run_tests.sh


-- 
Thank you,
Richard.
