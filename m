From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 9 Jul 2019 22:51:58 +0200
Subject: [LTP] [PATCH 1/5] lib: include <errno.h> in tst_test.h
In-Reply-To: <20190709105541.GB4914@rei.lan>
References: <20190707190016.27296-1-petr.vorel@gmail.com>
 <20190707190016.27296-2-petr.vorel@gmail.com>
 <20190709105541.GB4914@rei.lan>
Message-ID: <20190709205157.GA1854@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > tst_test.h is using errno variable, thus it should include <errno.h>.

> Acked, this should have been done quite some time ago...
Thanks, merged.

Kind regards,
Petr
