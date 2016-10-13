From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 13 Oct 2016 16:45:56 +0300
Subject: [LTP] [PATCH] test_net.sh: don't waste time waiting 1 sec in
 tst_ping()
In-Reply-To: <20161010152152.GE1684@rei>
References: <1475761814-14468-1-git-send-email-alexey.kodanev@oracle.com>
 <20161010152152.GE1684@rei>
Message-ID: <57FF9014.2090004@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 10/10/2016 06:21 PM, Cyril Hrubis wrote:
> Hi!
>> The current user of this function is 'icmp-uni-basic.sh' ipsec test
>> group that includes 17 tests. Usually, it takes about 50 seconds for
>> each test run. This change allows to run the same test in ~5 seconds
>> because interval is 0 and default number of packets transmitted for
>> each size parameter increased from 10 to 500.
> Looks like a great speed up.

Pushed patch. Thanks.
