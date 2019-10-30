From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Oct 2019 13:41:23 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <20191030144649.GA25642@dell5510>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
 <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
 <1665612504.9724602.1572440600772.JavaMail.zimbra@redhat.com>
 <20191030144649.GA25642@dell5510>
Message-ID: <116299070.9793183.1572457283737.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> > > I'm seeing similar failure:
> 
> > > tst_kconfig.c:62: INFO: Parsing kernel config
> > > '/boot/config-3.10.0-1106.el7.cki.s390x'
> > > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > > tst_kconfig.c:62: INFO: Parsing kernel config
> > > '/boot/config-3.10.0-1106.el7.cki.s390x'
> > > acct02.c:239: INFO: Verifying using 'struct acct_v3'
> > > acct02.c:192: INFO: == entry 1 ==
> > > acct02.c:88: INFO: ac_btime < 1572367954 (1572367953)
> 
> > ^^ This is 'acct02_helper', which seemingly started before 'start_time'.
> 
> > ac_btime is calculated back from current time and elapsed time at
> > fill_ac():
> 
> >   ac->ac_btime = get_seconds() - elapsed;
> 
> > s390s are slower, so my guess is another second ticks before btime gets
> > calculated,
> > and it appears to have started later.
> Agree.
> 
> > > acct02.c:192: INFO: == entry 2 ==
> > > acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> > > acct02.c:88: INFO: ac_btime < 1572367954 (1572367953)
> > > acct02.c:133: INFO: ac_exitcode != 32768 (0)
> > > acct02.c:141: INFO: ac_ppid != 25608 (25607)
> 
> > The 2nd record is filled at acct(NULL), even though process still runs:
> 
> > [ 1156.025654] CPU: 0 PID: 11772 Comm: acct02_helper Tainted: G
> > OE  ------------   3.10.0-1106.el7.s390x #1
> > <>
> > [ 1156.027105]  [<00000000001dd630>] fill_ac+0x0/0x440
> > [ 1156.027108] ([<00000000001ddae8>] do_acct_process+0x78/0x1a0)
> > [ 1156.027110]  [<00000000001de3ae>] acct_process+0xf6/0x140
> > [ 1156.027112]  [<000000000014de32>] do_exit+0x752/0xa38
> > [ 1156.027116]  [<000000000014e216>] do_group_exit+0x66/0xf8
> > [ 1156.027118]  [<000000000014e2ea>] SyS_exit_group+0x42/0x48
> 
> > [ 1157.033294] CPU: 1 PID: 11771 Comm: acct02 Tainted: G           OE
> > ------------   3.10.0-1106.el7.s390x #1
> > <>
> > [ 1157.033384]  [<00000000001dd630>] fill_ac+0x0/0x440
> > [ 1157.033386] ([<00000000001ddae8>] do_acct_process+0x78/0x1a0)
> > [ 1157.033389]  [<00000000001ddcda>] acct_pin_kill+0x52/0xa8
> > [ 1157.033391]  [<000000000034a83e>] pin_kill+0xb6/0x178
> > [ 1157.033395]  [<00000000001ddfe8>] SyS_acct+0x2b8/0x350
> 
> Hm, did you reproduce it on 4.18 (rhel8)?

Above was RHEL7. Do you expect different outcome on RHEL8?
I was looking at upstream sources too and it looked similar.

Anyway, I don't think this part is an issue, test will skip it
because "comm" doesn't match.

We can tweak 'ac_btime' condition, but I think the test will remain
race-y in environments with higher steal time:

acct02.c:239: INFO: Verifying using 'struct acct_v3'
acct02.c:192: INFO: == entry 1 ==
acct02.c:127: INFO: elap_time/clock_ticks >= 2 (236/100: 2.00)
acct02.c:192: INFO: == entry 2 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:127: INFO: elap_time/clock_ticks >= 2 (236/100: 2.00)
acct02.c:133: INFO: ac_exitcode != 32768 (0)
acct02.c:141: INFO: ac_ppid != 43213 (43212)
acct02.c:182: FAIL: end of file reached

