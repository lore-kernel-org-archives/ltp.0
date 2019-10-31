From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 10:09:34 +0100
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <2003376860.9886044.1572511989903.JavaMail.zimbra@redhat.com>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
 <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
 <1665612504.9724602.1572440600772.JavaMail.zimbra@redhat.com>
 <20191030144649.GA25642@dell5510>
 <116299070.9793183.1572457283737.JavaMail.zimbra@redhat.com>
 <CAEemH2dO95d2_CZyMpE4fM8CcC+p0ou9XfA43sS9fX0LmQBWoQ@mail.gmail.com>
 <2003376860.9886044.1572511989903.JavaMail.zimbra@redhat.com>
Message-ID: <20191031090934.GB15784@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > How much time of the ac_btime shaking to be tolerated is proper?

> I wanted to go with 1 sec:

> @@ -83,7 +83,7 @@ static int verify_acct(void *acc, int elap_time)
>                 ret = 1;
>         }

> -       if (ACCT_MEMBER(ac_btime) < start_time) {
> +       if (ACCT_MEMBER(ac_btime) + 1 < start_time) {
>                 tst_res(TINFO, "ac_btime < %d (%d)", start_time,
>                         ACCT_MEMBER(ac_btime));
>                 ret = 1;

Ack.

> > > race-y in environments with higher steal time:


> > I'm sorry, what does it mean here?

> I was referring to failed check below. s390 is scarce resource
> and when over-committed, sleeps are less consistent.
> E.g. sleep(1) taking 2+ seconds:
>   nanosleep({1, 0}, NULL) = 0 <1.926617>

Lol :)

Kind regards,
Petr
