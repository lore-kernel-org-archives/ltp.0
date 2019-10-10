From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Oct 2019 13:39:04 +0200
Subject: [LTP] [PATCH v2] acct: fix version check on big endian system
In-Reply-To: <20191010110602.GB2508@rei.lan>
References: <20191010081752.11334-1-pifang@redhat.com>
 <20191010110602.GB2508@rei.lan>
Message-ID: <20191010113904.GB23153@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > ac_version = ACCT_VERION | ACCT_BYTEORDER
> > which is 0x83 (131) on big endian system.

> > failure output:
> > tst_kconfig.c:62: INFO: Parsing kernel config
> > '/boot/config-4.18.0-147.el8.s390x'
> > tst_test.c:1118: INFO: Timeout per run is 0h 05m 00s
> > tst_kconfig.c:62: INFO: Parsing kernel config
> > '/boot/config-4.18.0-147.el8.s390x'
> > acct02.c:239: INFO: Verifying using 'struct acct_v3'
> > acct02.c:192: INFO: == entry 1 ==
> > acct02.c:147: INFO: ac_version != 3 (131)
> > acct02.c:192: INFO: == entry 2 ==
> > acct02.c:82: INFO: ac_comm != 'acct02_helper' ('acct02')
> > acct02.c:133: INFO: ac_exitcode != 32768 (0)
> > acct02.c:141: INFO: ac_ppid != 34501 (34500)
> > acct02.c:147: INFO: ac_version != 3 (131)
> > acct02.c:182: FAIL: end of file reached

> Looks good, acked.

> Also please consider a patch to the man 5 acct, it says that the version
> is always set to 3 for acct_v3 structure.
+1.

Kind regards,
Petr
