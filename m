From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 28 Jul 2016 16:12:49 +0800
Subject: [LTP] test specific command line options
Message-ID: <20160728081249.GA4664@bogon>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

From the doc I read:

... The 'arg' is where 'optarg' is stored upon match. If option has no 
parameter it's set to non-'NULL' value if option was present.

But looks like if a option was present which has no parameter, the 'arg'
will set to NULL?

Thanks in advance.

