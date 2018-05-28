From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 28 May 2018 07:47:25 +0200
Subject: [LTP] [PATCH 4/6] network/tcp_cc/lib: add a function to set
 qdisc and txqueuelen
In-Reply-To: <20180528054425.GD21980@x230>
References: <1526903310-2833-1-git-send-email-alexey.kodanev@oracle.com>
 <1526903310-2833-5-git-send-email-alexey.kodanev@oracle.com>
 <20180528054425.GD21980@x230>
Message-ID: <20180528054723.GG21980@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Forget to add
Acked-by: Petr Vorel <pvorel@suse.cz>
> > ---
...
> > +qdisc_list="pfifo_fast codel pfifo fq hfsc hhf htb pie prio sfb sfq"

> Maybe just one thing: wouldn't be better to have this upper case as it's
> library variable shared in tests? But it's only a minor nit.

Kind regards,
Petr
