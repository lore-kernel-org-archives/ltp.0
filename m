From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Oct 2017 11:33:15 +0200
Subject: [LTP] [RFC PATCH 0/7] Remove network test for ancient software
In-Reply-To: <CAL+h-jATfeJYYLa26c8TR5msL+cr9SJBLjZX17OQpNuU5KVvyQ@mail.gmail.com>
References: <20171018135001.30382-1-pvorel@suse.cz>
 <CAL+h-jATfeJYYLa26c8TR5msL+cr9SJBLjZX17OQpNuU5KVvyQ@mail.gmail.com>
Message-ID: <20171019093315.d26zsipgrwyvodtn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mike,

> fwiw, rsh/rcp are still used in the embedded world where security is not a
> concern, but speed/size matters much more (e.g. development)
I used dropbear even on quite low power arm. But, ok I'd agree that rsh/rcp can be still
worth to test. But I'd really drop the rest (rwho, rdist, rlogin, finger, echo).

> -mike

Kind regards,
Petr
