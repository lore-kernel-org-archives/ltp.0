From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Aug 2018 09:51:32 +0200
Subject: [LTP] [PATCH v3] add new testcase for bind
In-Reply-To: <20180727123014.24435-1-mmoese@suse.de>
References: <20180727123014.24435-1-mmoese@suse.de>
Message-ID: <20180814075132.GA14622@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michael,

> With
>   0fb44559ffd6  af_unix: move unix_mknod() out of bindlock
> the behavior of bind() for STREAM UNIX sockets changed in
> case a socket that is already bound is passed to bind() again.

> This testcase fails for the new behavior and passes for the
> old one.

> Signed-off-by: Michael Moese <mmoese@suse.de>
> ---
Pushed (with slightly changed commit message), thanks!


Kind regards,
Petr
