From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Sep 2018 00:42:32 +0200
Subject: [LTP] [PATCH 1/1] runltp: Remove RHOST setup
In-Reply-To: <20180903105017.31106-1-pvorel@suse.cz>
References: <20180903105017.31106-1-pvorel@suse.cz>
Message-ID: <20180910224232.GB10554@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> as RSH is deprecated. The default management link of network tests are
> network namespaces. For remote management is better to setup SSH via:
> TST_USE_SSH=1

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Pushed.


Kind regards,
Petr
