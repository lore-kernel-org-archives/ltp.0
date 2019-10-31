From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Oct 2019 10:06:03 +0100
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <116299070.9793183.1572457283737.JavaMail.zimbra@redhat.com>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
 <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
 <1665612504.9724602.1572440600772.JavaMail.zimbra@redhat.com>
 <20191030144649.GA25642@dell5510>
 <116299070.9793183.1572457283737.JavaMail.zimbra@redhat.com>
Message-ID: <20191031090603.GA15784@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > Hm, did you reproduce it on 4.18 (rhel8)?

> Above was RHEL7. Do you expect different outcome on RHEL8?
> I was looking at upstream sources too and it looked similar.
I know it was RHEL7. Good it's not affected by old kernel code,
but rather by overloaded host. Agree, that some tolerance is needed.

> Anyway, I don't think this part is an issue, test will skip it
> because "comm" doesn't match.

> We can tweak 'ac_btime' condition, but I think the test will remain
> race-y in environments with higher steal time:

> acct02.c:239: INFO: Verifying using 'struct acct_v3'
> acct02.c:192: INFO: == entry 1 ==
> acct02.c:127: INFO: elap_time/clock_ticks >= 2 (236/100: 2.00)
> acct02.c:192: INFO: == entry 2 ==
> acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> acct02.c:127: INFO: elap_time/clock_ticks >= 2 (236/100: 2.00)
> acct02.c:133: INFO: ac_exitcode != 32768 (0)
> acct02.c:141: INFO: ac_ppid != 43213 (43212)
> acct02.c:182: FAIL: end of file reached

Kind regards,
Petr
