From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Nov 2018 16:29:38 +0100
Subject: [LTP] Errored: linux-test-project/ltp#1136 (master - 158f68e)
In-Reply-To: <5beacaabd184d_43fb8a2c4a0f0530bc@6dfdcd38-92da-4cca-909d-abbeade9a958.mail>
References: <linux-test-project/ltp+454470293+errored@travis-ci.org>
 <5beacaabd184d_43fb8a2c4a0f0530bc@6dfdcd38-92da-4cca-909d-abbeade9a958.mail>
Message-ID: <20181113152938.GB3712@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Build Update for linux-test-project/ltp
> -------------------------------------

> Build: #1136
> Status: Errored

> Duration: 7 mins and 10 secs
> Commit: 158f68e (master)
> Author: Steve Muckle
> Message: syscalls/sighold02: ignore reserved signals

> Some signals may be internally used by the C library. Do not attempt to
> verify these.

> Signed-off-by: Steve Muckle <smuckle@google.com>
> Acked-by: Cyril Hrubis <chrubis@suse.cz>

> View the changeset: https://github.com/linux-test-project/ltp/compare/f6a2a47feeaa...158f68e5561d

> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/454470293?utm_medium=notification&utm_source=email

False positive (timeout to ubuntu repositories, as usual).
Fixed by restarting.
I wish travis fixed it as I don't know about any other service which we could
use instead of travis.

Kind regards,
Petr
