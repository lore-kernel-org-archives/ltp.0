From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Nov 2019 14:30:18 +0100
Subject: [LTP] [PATCH] acct02: relax ac_btime checks
In-Reply-To: <1574856631.11670519.1573563157342.JavaMail.zimbra@redhat.com>
References: <95d94fede00533a07fc604de3252636b094fc8f8.1573550061.git.jstancek@redhat.com>
 <20191112123744.GA760@dell5510>
 <1574856631.11670519.1573563157342.JavaMail.zimbra@redhat.com>
Message-ID: <20191112133018.GA11433@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> > > ac_btime is calculated back from current time and isn't accurate.
> > > Problems include nanoseconds accumulation (lags behind gettimeofday),
> > > suspend/resume isn't taken into account and any adjtime() (like DST
> > > change) will cause ac_btime to jump as well.

> > > Relax the condition to ~2h around gettimeofday value at start of
> > > the test. That should be enough to cover usual DST time jumps.

> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Tested-by: Petr Vorel <pvorel@suse.cz>
> > on both 390x and intel.

> > LGTM, although on in intel I got quite a lot of entries:

> > acct02.c:202: INFO: Number of accounting file entries tested: 159

> That could be normal if there was something running in the background.
> Do you have full output? What was the ac_comm string in those entries?

OK, this is caused only by compiling LTP on background.
Thus not relevant to us.

Just if you're curious, sending part of output with 530 entries.

Kind regards,
Petr

tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
acct02.c:238: INFO: Verifying using 'struct acct_v3'
acct02.c:191: INFO: == entry 1 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('cc1')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (256)
acct02.c:139: INFO: ac_ppid != 755 (760)
acct02.c:191: INFO: == entry 2 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('gcc')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (256)
acct02.c:139: INFO: ac_ppid != 755 (759)
acct02.c:191: INFO: == entry 3 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (256)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 4 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('grep')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 5 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('cat')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 6 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('mv')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 7 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('sed')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 8 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('rm')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 9 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('grep')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (768)
acct02.c:191: INFO: == entry 10 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 11 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)

...
acct02.c:191: INFO: == entry 522 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (1285)
acct02.c:191: INFO: == entry 523 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('cat')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 524 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (1290)
acct02.c:191: INFO: == entry 525 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('sed')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (1292)
acct02.c:191: INFO: == entry 526 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (1290)
acct02.c:191: INFO: == entry 527 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('configure')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 528 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('cat')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 529 ==
acct02.c:82: INFO: ac_comm != 'acct02_helper' ('rm')
acct02.c:98: INFO: ac_uid != 0 (1000)
acct02.c:104: INFO: ac_gid != 0 (100)
acct02.c:131: INFO: ac_exitcode != 32768 (0)
acct02.c:139: INFO: ac_ppid != 755 (393)
acct02.c:191: INFO: == entry 530 ==
acct02.c:202: INFO: Number of accounting file entries tested: 530
acct02.c:208: PASS: acct() wrote correct file contents!

Summary:
passed   1
failed   0
skipped  0
warnings 0
