From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 May 2017 15:05:43 +0200
Subject: [LTP] [PATCH 02/10] Test for vulnerability CVE-2016-7117 in
 recvmmsg error return path
In-Reply-To: <20170519123156.8462-2-rpalethorpe@suse.com>
References: <20170519123156.8462-1-rpalethorpe@suse.com>
 <20170519123156.8462-2-rpalethorpe@suse.com>
Message-ID: <20170519130543.GB17258@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +AC_DEFUN([LTP_CHECK_MMSGHDR],[
> +AC_CHECK_TYPES([struct mmsghdr],,,[
> +#include <sys/types.h>
> +#define __USE_GNU

Don't do that, the double underscore one is library internal macro. The
correct way is to define _GNU_SOURCE before you include any glibc
header.

-- 
Cyril Hrubis
chrubis@suse.cz
