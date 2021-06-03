From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 3 Jun 2021 13:57:17 +0200
Subject: [LTP] [RFC] Reduce LICENCE/COPYING files
In-Reply-To: <YLi3XqA3hLh7HWqn@yuki>
References: <YLeA8KOphpVg3IDP@pevik>
 <YLi3XqA3hLh7HWqn@yuki>
Message-ID: <YLjDnXeWib2KSILF@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > I suppose it's safe to keep only single licence in testcases/open_posix_testsuite/,
> > but could we keep only COPYING in the root directory and delete the rest?
> > Or keep COPYING and testcases/open_posix_testsuite/COPYING only?

> Do we even need these files? Isn't SPDX identifier enough these days?
It be nice we don't need it, but not sure. Looking into kernel tree, there is
LICENSES folder [1] and they describe how they use SPDX [2]:

Valid-License-Identifier: GPL-2.0
Valid-License-Identifier: GPL-2.0-only
Valid-License-Identifier: GPL-2.0+
Valid-License-Identifier: GPL-2.0-or-later
SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
Usage-Guide:
  To use this license in source code, put one of the following SPDX
  tag/value pairs into a comment according to the placement
  guidelines in the licensing rules documentation.
  For 'GNU General Public License (GPL) version 2 only' use:
    SPDX-License-Identifier: GPL-2.0
  or
    SPDX-License-Identifier: GPL-2.0-only
  For 'GNU General Public License (GPL) version 2 or any later version' use:
    SPDX-License-Identifier: GPL-2.0+
  or
    SPDX-License-Identifier: GPL-2.0-or-later
License-Text:

		    GNU GENERAL PUBLIC LICENSE
		       Version 2, June 1991
...

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred/GPL-2.0
