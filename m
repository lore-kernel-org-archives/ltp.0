From: Michael Moese <mmoese@suse.de>
Date: Wed, 20 Jun 2018 09:21:38 +0200
Subject: [LTP] LTP CVE cve-2017-17053 test failed on x86_64 device
In-Reply-To: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
References: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
Message-ID: <20180620072138.yrz76kmms3oviv7i@linux-d8ym>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Wed, Jun 20, 2018 at 12:14:22PM +0530, Naresh Kamboju wrote:
> Test FAIL case output,
> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> tst_taint.c:88: BROK: Kernel is already tainted: 512
The kernel is already tainted. In this case, the test refuses to run,
because it could not tell if the test is pass or fail.

Could you please check if you could run the test directly after a
reboot?

Regards,
Michael
-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
