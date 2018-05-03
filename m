From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 May 2018 15:06:08 +0200
Subject: [LTP] [PATCH v3 1/3] lib/tst_checksum: add crc32c checksum
In-Reply-To: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
References: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180503130608.fv43iyrtep2diwzz@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> It will be used to make a SCTP packet in the test.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v3: use SPDX License-Identifier

> v2: As suggested by Cyril:
>     * updated the docs, added section 2.2.25
>     * added 'tst_' prefix
>     * changed type 'int' to 'size_t' for the buffer length

>  doc/test-writing-guidelines.txt |    6 +++
>  include/tst_checksum.h          |   16 ++++++++
>  lib/tst_checksum.c              |   81 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 103 insertions(+), 0 deletions(-)
>  create mode 100644 include/tst_checksum.h
>  create mode 100644 lib/tst_checksum.c

Whole patchset LGTM.

BTW sctp_big_chunk still uses crazy big load on kernels before 4.17 rc2 :(.


Kind regards,
Petr
