From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Jul 2016 14:02:36 +0300
Subject: [LTP] [PATCH 1/2] network/tcp_cmds/rwho: fix/cleanup test
In-Reply-To: <20160726141151.GF11679@rei.lan>
References: <1467033461-18797-1-git-send-email-alexey.kodanev@oracle.com>
 <20160726141151.GF11679@rei.lan>
Message-ID: <579894CC.6060506@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/26/2016 05:11 PM, Cyril Hrubis wrote:
> Hi!
>> +for i in $(seq 1 $TST_TOTAL); do
>> +	do_test
>> +	tst_resm TPASS "Test $i/$TST_COUNT complete"
>> +done
> I do not understand why we run the test in a loop now 25 times,
> otherwise it looks good.

We always do this, what we had before is a while loop:

     while [ $TST_COUNT -le $NUMLOOPS ]; do
        ...

     where NUMLOOPS was 25.

Thanks,
Alexey

