From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Feb 2019 00:51:20 +0100
Subject: [LTP] [PATCH] adding s390x tests to ltp
In-Reply-To: <20190204161328.4616-1-elas@linux.vnet.ibm.com>
References: <20190204161328.4616-1-elas@linux.vnet.ibm.com>
Message-ID: <20190204235120.GA30268@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Elif,

these tests are just user space tests for vmcp, LTP would not benefit from it.
I guess you should try to contribute test to s390-tools, where vmcp belongs to.

LTP tests are concern about kernel related tests. There are some user space
tests, but these are related to kernel (e.g. insmod, keyctl) or able to trigger
kernel oops (e.g. filesystem related tools).

Kind regards,
Petr
