From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Dec 2018 15:26:29 +0100
Subject: [LTP] [PATCH] getcpu01: Rename getcpu to avoid conflict with
 glibc >= 2.29
In-Reply-To: <20181214225316.43732-1-raj.khem@gmail.com>
References: <20181214225316.43732-1-raj.khem@gmail.com>
Message-ID: <20181219142629.GA8369@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

> glibc has added getcpu() API starting with glibc 2.29 release, this
> makes the static function in conflict and signatures are not same as
> well.

> Renaming helps to keep ltp build going

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
Thanks, pushed.


Kind regards,
Petr
