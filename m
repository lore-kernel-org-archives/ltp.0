From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 May 2018 13:34:42 +0200
Subject: [LTP] [RFC PATCH 1/1] net/ipsec: Fix getopts parsing -s
	parameter
In-Reply-To: <5AF2D525.7090401@cn.fujitsu.com>
References: <20180507193234.6810-1-pvorel@suse.cz>
 <20180507193234.6810-2-pvorel@suse.cz>
 <5AF11310.1010509@cn.fujitsu.com>
 <20180508075025.kiwhybpeticscmbh@dell5510>
 <5AF2D525.7090401@cn.fujitsu.com>
Message-ID: <20180509113442.o4nzv2tcfm7em2af@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Hi Petr,

> It seems that "$@" is treated as an array by default, and declaring TST_ARGS
> as an array could fix this issue.
Arrays are bashism, see explanation at your patch.

> Thanks,
> Xiao Yang


Kind regards,
Petr
