From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 13:08:23 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_ns: Fix failures on -m32
In-Reply-To: <20190515095230.12585-1-chrubis@suse.cz>
References: <20190515095230.12585-1-chrubis@suse.cz>
Message-ID: <20190515110822.GA21441@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> These are not apparently implemented in the 32bit compat layer so the
> test were failing with ENOTTY there.

> Reported-by: Richard Palethorpe <rpalethorpe@suse.de>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
