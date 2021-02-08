From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 8 Feb 2021 18:24:11 +0300
Subject: [LTP] [PATCH 0/3] lib/tst_net.sh: calc median instead of mean
 in tst_netload()
In-Reply-To: <YB0cRKmBcO4qgLf8@pevik>
References: <20210202133454.59224-1-alexey.kodanev@oracle.com>
 <YB0cRKmBcO4qgLf8@pevik>
Message-ID: <07a6d0f9-6bbc-63ff-5401-ab2d6af04364@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05.02.2021 13:21, Petr Vorel wrote:
> Hi Alexey,
> 
>> This series of patches is intended to improve the reliability
>> of results in network tests that using tst_netload().
> 
>> After TST_NETLOAD_RUN_COUNT was added, we get several results (5 by
>> default). The first patch allows all of them to be displayed along
>> with the final result. It helps to debug test performance failures.
> 
>> Further patches replace the mean calculation of such data set with
>> the median one. It allows to exclude extreme points from the final
>> result.
> 
> Thanks for improving stability of these tests!
> I've also noticed often failures in net.features and some of ipsec tests,
> this should help.
>
> FYI as TODO I'd like some of net.features have also as functional tests
> (ignoring the performance).
> 

Merged, thanks for review Petr!
