From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Apr 2018 12:08:22 +0300
Subject: [LTP] [RFC PATCH v6 6/7] tst_net_stress.sh: Migrate with
 dependencies to new API + rename
In-Reply-To: <20180410173715.pssexrwrxmfvvw53@dell5510>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <20180406123118.21309-7-pvorel@suse.cz>
 <2fe8858d-81a3-bb1c-12f6-447dd30464e4@oracle.com>
 <20180410173715.pssexrwrxmfvvw53@dell5510>
Message-ID: <12b040ea-626d-d9f5-6e2c-26d76cbe78bc@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10.04.2018 20:37, Petr Vorel wrote:
>> On 04/06/2018 03:31 PM, Petr Vorel wrote:
>>> Rename library to tst_net_stress.sh, new name states that library
>>> supports new shell API.
> 
>>> Removed ipver variable (as it's set in tst_net.sh and here, outside of
>>> setup/run/test functions isn't valid anyway).
> 
>>> Minor fix: remove space and dot in TCONF messages.
> 
>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>> ---
>>>  testcases/network/stress/interface/if-addr-adddel  | 33 ++++++++----------
>>>  .../network/stress/interface/if-addr-addlarge      | 39 ++++++++++------------
>>>  testcases/network/stress/interface/if-mtu-change   | 37 ++++++++++----------
>>>  testcases/network/stress/interface/if-route-adddel | 29 +++++++---------
>>>  .../network/stress/interface/if-route-addlarge     | 31 ++++++++---------
>>>  testcases/network/stress/interface/if-updown       | 29 +++++++---------
>>>  testcases/network/stress/interface/if4-addr-change | 21 +++++-------
>>>  .../grp-operation/mcast-group-multiple-socket      | 16 +++++----
>>>  .../multicast/grp-operation/mcast-group-same-group | 17 +++++++---
>>>  .../grp-operation/mcast-group-single-socket        | 17 +++++++---
>>>  .../grp-operation/mcast-group-source-filter        | 17 +++++++---
>>>  .../stress/multicast/grp-operation/mcast-lib.sh    | 29 ++++++++--------
>>>  testcases/network/stress/ns-tools/Makefile         |  2 +-
>>>  .../{test_net_stress.sh => tst_net_stress.sh}      | 29 +++++++++++-----
>>>  14 files changed, 177 insertions(+), 169 deletions(-)
>>>  rename testcases/network/stress/ns-tools/{test_net_stress.sh => tst_net_stress.sh} (90%)
> 
>>> diff --git a/testcases/network/stress/interface/if-addr-adddel b/testcases/network/stress/interface/if-addr-adddel
>>> index 4a0501e09..634e9d8a4 100644
>>> --- a/testcases/network/stress/interface/if-addr-adddel
>>> +++ b/testcases/network/stress/interface/if-addr-adddel
>>> @@ -1,4 +1,5 @@
>>>  #!/bin/sh
>>> +# Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
>>>  # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
>>>  # Copyright (c) International Business Machines  Corp., 2005
> 
>>> @@ -17,11 +18,11 @@
> 
>>>  # Author: Mitsuru Chinen <mitch@jp.ibm.com>
> 
>>> -TST_TOTAL=2
>>> -
>>> +TST_CNT=2
> 
>> may be TST_CNT=1? otherwise it will run TST_TESTFUNC twice...
> It should be run twice: first for ifconfig, second for ip. With TST_CNT=1 it would skip
> testing with 'ip':

I thought you divide the tests into ip and ifconfig here,
there is still TST_CNT=2 in if-lib.sh, in the last patch.

Thanks,
Alexey
