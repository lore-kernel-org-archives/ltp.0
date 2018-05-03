From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 May 2018 15:16:05 +0200
Subject: [LTP] [PATCH v3 3/3] sctp_big_chunk: use
 SPDX-License-Identifier GPL-2.0
In-Reply-To: <1524914997-27080-3-git-send-email-alexey.kodanev@oracle.com>
References: <1524914997-27080-1-git-send-email-alexey.kodanev@oracle.com>
 <1524914997-27080-3-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180503131605.iurkwsnranneymvb@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
...
> +// SPDX-License-Identifier: GPL-2.0
Shouldn't it be:
// SPDX-License-Identifier: GPL-2.0-or-later

As this was stated in previous license?
https://spdx.org/licenses/GPL-2.0-or-later.html
https://spdx.org/licenses/


Kind regards,
Petr

