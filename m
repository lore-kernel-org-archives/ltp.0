From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 8 Aug 2018 19:42:20 +0300
Subject: [LTP] [PATCH v2 1/1] network/route: Rewrite route-change-dst
 into new API
In-Reply-To: <25966119-9937-727a-9df0-c5a636d22582@oracle.com>
References: <20180723072332.22179-1-pvorel@suse.cz>
 <25966119-9937-727a-9df0-c5a636d22582@oracle.com>
Message-ID: <5149c3da-b24f-877d-6608-4d713f69b951@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 07/27/2018 04:01 PM, Alexey Kodanev wrote:
> On 07/23/2018 10:23 AM, Petr Vorel wrote:
>> Drop route command (use just ip command), simplify.
>>
>> Use "unused" IP for routes (not affect real traffic).
>>
>> Validate connection with UDP, sent over tst_netload.
>>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
...
>> +
>> +	tst_netload -T udp -r 1 -a 1 -H $addr
> 
> 
> Unfortunately, it won't work this way. tst_netload is using requests/response
> model for UDP. You have to make sure the server can send responses.
> 
> Also, netstress UDP/DCCP client allows to pass 'max_etime_cnt' (12) failed
> requests after which it will double receive timeout, starting from 100ms up to
> 3.2s. This is about 30 sec if there is no connection. With a single request or
> below max_etime_cnt + 1 value it will always pass. I guess we need to set the
> proper request parameter limit for UDP/DCCP protocol or check whether the
> number of timeout errors is equal or greater than the number of requests.

Applied the fix for this bug:
4ceb442b56ad ("netstress: handle timeout errors for a small number of requests")
