From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 12 Apr 2018 15:22:43 +0300
Subject: [LTP] [PATCH 1/2] lib/test_net.sh: lower default test parameters
In-Reply-To: <20180405134031.mabcwgdiihs4bd5z@dell5510>
References: <1522926355-18029-1-git-send-email-alexey.kodanev@oracle.com>
 <20180405134031.mabcwgdiihs4bd5z@dell5510>
Message-ID: <6d9a514e-d20c-9ed6-bc05-9c9352407e61@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05.04.2018 16:40, Petr Vorel wrote:
> Hi Alexey,
> 
>> Default scenario should not take hours to complete.
> Great, agree.
> 
>> Also export TST_NETLOAD_CLN_REQUESTS which is used by all
>> tst_netload tests and can control the test execution time.
> 
...
>> +export TST_NETLOAD_CLN_REQUESTS="${TST_NETLOAD_CLN_REQUESTS:-10000}"
> This variable is also in testcases/network/sockets/bind_noport01.sh, shouldn't you remove
> it from there (it uses test_net.sh).
> 
> Also, why not to handle the same way TST_NETLOAD_CLN_NUMBER ?
> (also used in tst_netload).
> 
> And I'd put it into separate commit.

Applied, the changes with TST_NETLOAD_CLN* are in the separate commit.

Thanks,
Alexey
