From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 4 Jan 2018 09:49:56 +0100
Subject: [LTP] Errored: linux-test-project/ltp#595 (master - 485276e)
In-Reply-To: <5a4de63626fd7_43fb43cdec6c018684fc@ece77943-5029-4f83-9b17-65cab6528af3.mail>
References: <linux-test-project/ltp+324934722+errored@travis-ci.org>
 <5a4de63626fd7_43fb43cdec6c018684fc@ece77943-5029-4f83-9b17-65cab6528af3.mail>
Message-ID: <20180104084956.xcq23wol66aahrfw@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Build Update for linux-test-project/ltp
> -------------------------------------

> Build: #595
> Status: Errored

> Duration: 15 minutes and 25 seconds
> Commit: 485276e (master)
> Author: Petr Vorel
> Message: lapi: Add dccp.h with definition moved from netstress.c

> and use lapi/dccp.h in netstress.c.

> + include <linux/dccp.h> in netstress.c.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>

> View the changeset: https://github.com/linux-test-project/ltp/compare/54951e6ba074...485276e36f6e

> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/324934722?utm_source=email&utm_medium=notification

This was error in travis itself.
Unable to connect to ppa.launchpad.net:http:

I restarted job and it's fixed now [1].

Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/324934728/log.txt
