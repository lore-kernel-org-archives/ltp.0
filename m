From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Jul 2019 12:55:41 +0200
Subject: [LTP] [PATCH 1/5] lib: include <errno.h> in tst_test.h
In-Reply-To: <20190707190016.27296-2-petr.vorel@gmail.com>
References: <20190707190016.27296-1-petr.vorel@gmail.com>
 <20190707190016.27296-2-petr.vorel@gmail.com>
Message-ID: <20190709105541.GB4914@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> tst_test.h is using errno variable, thus it should include <errno.h>.

Acked, this should have been done quite some time ago...

-- 
Cyril Hrubis
chrubis@suse.cz
