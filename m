From: Li Wang <liwang@redhat.com>
Date: Fri, 30 Aug 2019 10:39:02 +0800
Subject: [LTP] [PATCH] memcg_stress_test.sh: Respect LTP_TIMEOUT_MUL set
 by user
In-Reply-To: <20190829181146.20261-1-pvorel@suse.cz>
References: <20190829181146.20261-1-pvorel@suse.cz>
Message-ID: <CAEemH2dzn92GYwiw2tP101wNkYfM30rfL=cmPU+B1iH-8UWoDw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 30, 2019 at 2:12 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> While it's good to increase the default LTP_TIMEOUT_MUL value, give user
> a chance to change it.

It's a good proposal, but one thing we need to consider that there is
possible to pass a small timeout value(<5mins) from the user. So what
about set a condition judgment which only accepts time value which >=
7?

>  # Each test case runs for 900 secs when everything fine
>  # therefore the default 5 mins timeout is not enough.

Here the code comments reminder this.

-- 
Regards,
Li Wang
