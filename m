From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 07:33:50 +0100
Subject: [LTP] [PATCH 0/3] Build fix undefined struct file_handle
In-Reply-To: <5FFE59B2.1040903@cn.fujitsu.com>
References: <20210112193039.12506-1-pvorel@suse.cz>
 <5FFE59B2.1040903@cn.fujitsu.com>
Message-ID: <X/6UTkNHsjJ9xH2r@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> Hi Petr
> I think detecting file_handle struct(it is in fcntl.h) in configure.ac is
> correct instead of using HAVE_NAME_TO_HANDLE_AT macro directly.

You're right, using AC_CHECK_TYPES([struct, ],,,[#include <fcntl.h>]) is
probably safer. I'll send v2.

Kind regards,
Petr Vorel

> Best Regards
> Yang Xu
