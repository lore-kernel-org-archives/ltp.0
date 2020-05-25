From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 May 2020 21:02:33 +0200
Subject: [LTP] [PATCH] hugemmap05: check if the reserving hpages as
 expected
In-Reply-To: <20200525105410.4328-1-liwang@redhat.com>
References: <20200525105410.4328-1-liwang@redhat.com>
Message-ID: <20200525190233.GA21052@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> To get rid of TBROK on small box:
>   hugemmap05.c:88: BROK: mmap((nil),201326592,3,1,6,0) failed: ENOMEM (12)

> And, reduce the reserved testing huge pages to 2, it also works well.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Nice speedup :)
Maybe add some constant for size (2), as it's used on 3 places?

Kind regards,
Petr
