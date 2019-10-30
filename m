From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Oct 2019 09:03:20 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
 <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
Message-ID: <1665612504.9724602.1572440600772.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> ----- Original Message -----
> > 
> > OK, on s390 where it's failing it actually catches "incomplete read":
> > 
> > tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> > acct02.c:234: INFO: Verifying using 'struct acct_v3'
> > acct02.c:187: INFO: == entry 1 ==
> > acct02.c:147: INFO: ac_version != 3 (131)
> > acct02.c:187: INFO: == entry 2 ==
> > acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> > acct02.c:133: INFO: ac_exitcode != 32768 (0)
> > acct02.c:141: INFO: ac_ppid != 54783 (54781)
> > acct02.c:147: INFO: ac_version != 3 (131)
> > acct02.c:183: FAIL: incomplete read 0 bytes, expected 64
> 
> I'm seeing similar failure:
> 
> tst_kconfig.c:62: INFO: Parsing kernel config
> '/boot/config-3.10.0-1106.el7.cki.s390x'
> tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> tst_kconfig.c:62: INFO: Parsing kernel config
> '/boot/config-3.10.0-1106.el7.cki.s390x'
> acct02.c:239: INFO: Verifying using 'struct acct_v3'
> acct02.c:192: INFO: == entry 1 ==
> acct02.c:88: INFO: ac_btime < 1572367954 (1572367953)

^^ This is 'acct02_helper', which seemingly started before 'start_time'.

ac_btime is calculated back from current time and elapsed time@fill_ac():

  ac->ac_btime = get_seconds() - elapsed;

s390s are slower, so my guess is another second ticks before btime gets calculated,
and it appears to have started later.

> acct02.c:192: INFO: == entry 2 ==
> acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> acct02.c:88: INFO: ac_btime < 1572367954 (1572367953)
> acct02.c:133: INFO: ac_exitcode != 32768 (0)
> acct02.c:141: INFO: ac_ppid != 25608 (25607)

The 2nd record is filled at acct(NULL), even though process still runs:

[ 1156.025654] CPU: 0 PID: 11772 Comm: acct02_helper Tainted: G           OE  ------------   3.10.0-1106.el7.s390x #1
<>
[ 1156.027105]  [<00000000001dd630>] fill_ac+0x0/0x440
[ 1156.027108] ([<00000000001ddae8>] do_acct_process+0x78/0x1a0)
[ 1156.027110]  [<00000000001de3ae>] acct_process+0xf6/0x140
[ 1156.027112]  [<000000000014de32>] do_exit+0x752/0xa38
[ 1156.027116]  [<000000000014e216>] do_group_exit+0x66/0xf8
[ 1156.027118]  [<000000000014e2ea>] SyS_exit_group+0x42/0x48

[ 1157.033294] CPU: 1 PID: 11771 Comm: acct02 Tainted: G           OE  ------------   3.10.0-1106.el7.s390x #1
<>
[ 1157.033384]  [<00000000001dd630>] fill_ac+0x0/0x440
[ 1157.033386] ([<00000000001ddae8>] do_acct_process+0x78/0x1a0)
[ 1157.033389]  [<00000000001ddcda>] acct_pin_kill+0x52/0xa8
[ 1157.033391]  [<000000000034a83e>] pin_kill+0xb6/0x178
[ 1157.033395]  [<00000000001ddfe8>] SyS_acct+0x2b8/0x350

