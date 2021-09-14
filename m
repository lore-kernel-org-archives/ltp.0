From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 14 Sep 2021 11:35:18 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/setresuid01: Convert to new API
In-Reply-To: <20210913144454.22992-2-mdoucha@suse.cz>
References: <20210913144454.22992-1-mdoucha@suse.cz>
 <20210913144454.22992-2-mdoucha@suse.cz>
Message-ID: <3a764f27-b453-0aab-4938-7b7b34496885@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13. 09. 21 16:44, Martin Doucha wrote:
> The original test needs user "bin" which may not exist on some systems. Use
> any non-root UID instead.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1: None
> 
>  .../kernel/syscalls/setresuid/setresuid01.c   | 256 ++++--------------
>  1 file changed, 59 insertions(+), 197 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setresuid/setresuid01.c b/testcases/kernel/syscalls/setresuid/setresuid01.c
> index 9f448896b..e9eb8517e 100644
> --- a/testcases/kernel/syscalls/setresuid/setresuid01.c
> +++ b/testcases/kernel/syscalls/setresuid/setresuid01.c
> @@ -1,221 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.

Oops, I've accidentally copy-pasted the wrong SPDX header to all three
setresuid tests. Patch 1 is correct as is but patches 2-4 should have
GPL-2.0-or-later instead. Please update it before merge.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
