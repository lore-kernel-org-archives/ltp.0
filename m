From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Jul 2019 13:32:30 +0200
Subject: [LTP] [PATCH 2/2] check for RES_USE_INET6 during configure
In-Reply-To: <20190726182524.43149-2-raj.khem@gmail.com>
References: <20190726182524.43149-1-raj.khem@gmail.com>
 <20190726182524.43149-2-raj.khem@gmail.com>
Message-ID: <20190729113230.GA29906@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,


> glibc 2.30 has remove RES_USE_INET6 define which has been on its way out
> since 2.26 release, this check ensures that we detect it before using it
Thank you for your patch. Good point, but mc_gethost.c was actually unused,
so I removed it in 5a07ccea5.

There is no other RES_USE_INET6 use (otherwise I'd be for removing it)
therefore autotools checks aren't needed.

Kind regards,
Petr
