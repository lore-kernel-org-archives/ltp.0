From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Apr 2020 15:30:20 +0200
Subject: [LTP] [PATCH v2] Add test for CVE 2018-9568
In-Reply-To: <20200416122023.20952-1-mdoucha@suse.cz>
References: <20200416122023.20952-1-mdoucha@suse.cz>
Message-ID: <20200416133020.GA15339@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +++ b/testcases/kernel/syscalls/connect/connect02.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0

Unless the original reproducer is under GPL-2.0 the default should be
GPL-2.0-or-later. I can change it before applying if it's OK to do so.

Also looking at spdx.org GPL-2.0 is not valid and it should be
GPL-2.0-only.

-- 
Cyril Hrubis
chrubis@suse.cz
