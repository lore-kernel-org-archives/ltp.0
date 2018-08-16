From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 16 Aug 2018 14:54:44 +0300
Subject: [LTP] [PATCH RFC 1/4] lib/tst_test.c: add 'needs_drivers'
 option with tst_check_drivers cmd
In-Reply-To: <20180816105934.GA4829@rei>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
 <20180816105934.GA4829@rei>
Message-ID: <1e9e35dc-3f2f-0eb7-59aa-8f600bdf949f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/16/2018 01:59 PM, Cyril Hrubis wrote:
> Hi... 
> I do not like much that we change the behavir based on tst_test content.
> Maybe it would be cleaner to define a tst_check_driver(const char *name),
> then we can do the loop over tst_test->needs_drivers in the tst_test.c
> library and loop over argv in the shell helper.
> 
Hi Cyril,

OK, will send the 2nd version.

Thanks,
Alexey

