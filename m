From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 31 Oct 2019 04:53:09 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <CAEemH2dO95d2_CZyMpE4fM8CcC+p0ou9XfA43sS9fX0LmQBWoQ@mail.gmail.com>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
 <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
 <1665612504.9724602.1572440600772.JavaMail.zimbra@redhat.com>
 <20191030144649.GA25642@dell5510>
 <116299070.9793183.1572457283737.JavaMail.zimbra@redhat.com>
 <CAEemH2dO95d2_CZyMpE4fM8CcC+p0ou9XfA43sS9fX0LmQBWoQ@mail.gmail.com>
Message-ID: <2003376860.9886044.1572511989903.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> > Above was RHEL7. Do you expect different outcome on RHEL8?
> > I was looking at upstream sources too and it looked similar.
> >
> > Anyway, I don't think this part is an issue, test will skip it
> > because "comm" doesn't match.
> >
> > We can tweak 'ac_btime' condition, but I think the test will remain
> >
> 
> How much time of the ac_btime shaking to be tolerated is proper?

I wanted to go with 1 sec:

@@ -83,7 +83,7 @@ static int verify_acct(void *acc, int elap_time)
                ret = 1;
        }
 
-       if (ACCT_MEMBER(ac_btime) < start_time) {
+       if (ACCT_MEMBER(ac_btime) + 1 < start_time) {
                tst_res(TINFO, "ac_btime < %d (%d)", start_time,
                        ACCT_MEMBER(ac_btime));
                ret = 1;

> 
> > race-y in environments with higher steal time:
> >
> 
> I'm sorry, what does it mean here?

I was referring to failed check below. s390 is scarce resource
and when over-committed, sleeps are less consistent.
E.g. sleep(1) taking 2+ seconds:
  nanosleep({1, 0}, NULL) = 0 <1.926617>

> 
> 
> 
> >
> > acct02.c:239: INFO: Verifying using 'struct acct_v3'
> > acct02.c:192: INFO: == entry 1 ==
> > acct02.c:127: INFO: elap_time/clock_ticks >= 2 (236/100: 2.00)
> > acct02.c:192: INFO: == entry 2 ==
> > acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> > acct02.c:127: INFO: elap_time/clock_ticks >= 2 (236/100: 2.00)
> > acct02.c:133: INFO: ac_exitcode != 32768 (0)
> > acct02.c:141: INFO: ac_ppid != 43213 (43212)
> > acct02.c:182: FAIL: end of file reached

