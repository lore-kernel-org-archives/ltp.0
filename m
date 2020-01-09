From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 09:37:52 +0100
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E9-rc1-3abd3b2=2Ecki_=28stable=29?=
In-Reply-To: <cki.7B6FDEE6C3.9EE0H2AAP8@redhat.com>
References: <cki.7B6FDEE6C3.9EE0H2AAP8@redhat.com>
Message-ID: <20200109083752.GA17247@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> One or more kernel tests failed:

>     ppc64le:
>      ? LTP
It'd be nice if there were info which LTP tests failed (or even direct link to
files which has the failure).
There are 20 files related to LTP for ppc64le.

Nothing in dmesg, grep for usual LTP errors didn't find anything
grep -r -e FAIL -e TFAIL -e TBROK -e BROK |grep -v 'FAILED COMMAND File:'

Or am I blind?

Kind regards,
Petr
