From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 30 Oct 2019 05:06:55 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/acct02: Check read size.
In-Reply-To: <20190925135634.GA32581@dell5510>
References: <20190925094721.18932-1-chrubis@suse.cz>
 <20190925135634.GA32581@dell5510>
Message-ID: <575273995.9684474.1572426415443.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> OK, on s390 where it's failing it actually catches "incomplete read":
> 
> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
> acct02.c:234: INFO: Verifying using 'struct acct_v3'
> acct02.c:187: INFO: == entry 1 ==
> acct02.c:147: INFO: ac_version != 3 (131)
> acct02.c:187: INFO: == entry 2 ==
> acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> acct02.c:133: INFO: ac_exitcode != 32768 (0)
> acct02.c:141: INFO: ac_ppid != 54783 (54781)
> acct02.c:147: INFO: ac_version != 3 (131)
> acct02.c:183: FAIL: incomplete read 0 bytes, expected 64

I'm seeing similar failure:

tst_kconfig.c:62: INFO: Parsing kernel config '/boot/config-3.10.0-1106.el7.cki.s390x'
tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
tst_kconfig.c:62: INFO: Parsing kernel config '/boot/config-3.10.0-1106.el7.cki.s390x'
acct02.c:239: INFO: Verifying using 'struct acct_v3'
acct02.c:192: INFO: == entry 1 ==
acct02.c:88: INFO: ac_btime < 1572367954 (1572367953)
acct02.c:192: INFO: == entry 2 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
acct02.c:88: INFO: ac_btime < 1572367954 (1572367953)
acct02.c:133: INFO: ac_exitcode != 32768 (0)
acct02.c:141: INFO: ac_ppid != 25608 (25607)
acct02.c:182: FAIL: end of file reached

but I don't get what process is this record from.
I see 3 pids: library, main and 'acct02_helper'. What 'acct02' process
terminated?

