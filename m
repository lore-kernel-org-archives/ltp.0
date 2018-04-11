From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Apr 2018 12:29:08 +0300
Subject: [LTP] [RFC PATCH v6 3/7] network.sh: Migrate to new shell API
In-Reply-To: <20180410170029.dpl6q3ytkvqataql@dell5510>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <20180406123118.21309-4-pvorel@suse.cz>
 <fcdbaf75-7003-ff02-4fb6-6acfc0b504a2@oracle.com>
 <20180410170029.dpl6q3ytkvqataql@dell5510>
Message-ID: <55a187f9-9ff1-8bcb-bf54-0164d488fafb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10.04.2018 20:00, Petr Vorel wrote:
> Hi Alexey,
> 
>>> --- a/testscripts/network.sh
>>> +++ b/testscripts/network.sh
>>> @@ -89,7 +89,7 @@ shift $(($OPTIND - 1))
>>>  TST_TOTAL=1
>>>  TCID="network_settings"
>> Do we need these variables in the new API?
> 
> Yes, good catch, both are redundant.
> 
> TCID is invalid, it was required, but with the fix you pointed out (see below) TCID is
> redundant.
> 
> TST_ID:
>  TST_ID="network_settings" would keep previous name:
> network_settings 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> 
> without TST_ID is the name of the script (set by tst_test.sh: filename=$(basename $0) ):
> network 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> 
> Unless you have any preference I'd user the later (removing TST_ID)
> + removing TST_TOTAL.


There is one more occurrence of TCID in tst_net_stress.sh, is it needed?


Thanks,
Alexey
