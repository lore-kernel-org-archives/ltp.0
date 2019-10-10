From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Oct 2019 13:36:26 +0200
Subject: [LTP] [PATCH v2] acct: fix version check on big endian system
In-Reply-To: <CAEemH2e-ASzAAPgkh2JFn8qZLgAL=2em5kZWk=2G0CYrAnuMAg@mail.gmail.com>
References: <20191010081752.11334-1-pifang@redhat.com>
 <CAEemH2dNjGXpw87wLqLc8jcEoT_Zc6yap4CfjPxmU=y1JyZ9oA@mail.gmail.com>
 <CAEemH2e-ASzAAPgkh2JFn8qZLgAL=2em5kZWk=2G0CYrAnuMAg@mail.gmail.com>
Message-ID: <20191010113626.GA23153@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Ping, Cyril,

> On Thu, Oct 10, 2019 at 4:33 PM Li Wang <liwan@redhat.com> wrote:

> > Ping Fang <pifang@redhat.com> wrote:

> > ac_version = ACCT_VERION | ACCT_BYTEORDER
> >> which is 0x83 (131) on big endian system.

> >> failure output:
> >> tst_kconfig.c:62: INFO: Parsing kernel config
> >> '/boot/config-4.18.0-147.el8.s390x'
> >> tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> >> tst_kconfig.c:62: INFO: Parsing kernel config
> >> '/boot/config-4.18.0-147.el8.s390x'
> >> acct02.c:239: INFO: Verifying using 'struct acct_v3'
> >> acct02.c:192: INFO: == entry 1 ==
> >> acct02.c:147: INFO: ac_version != 3 (131)
> >> acct02.c:192: INFO: == entry 2 ==
> >> acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> >> acct02.c:133: INFO: ac_exitcode != 32768 (0)
> >> acct02.c:141: INFO: ac_ppid != 34501 (34500)
> >> acct02.c:147: INFO: ac_version != 3 (131)
> >> acct02.c:182: FAIL: end of file reached


> > I'm wondering that is there any necessary to use do{}...while loop for
> > entry many times? Since the verify_acct() only check the dummy
> > program(acct02_helper) accounting struct. So in the error logs, we could
> > see some meaningless data(acct02) in entry 2.


> It turns out I was wrong, if accounting is turned on, system records for
> each terminating process but not only for that process, so we need to pick
> up the correct acct_struct in acct_file via the while loop.

> Sorry for making noise, I pull back my comments here.

Thanks for a fix, merged.

Petr
