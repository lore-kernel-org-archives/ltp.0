From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 16 Dec 2020 14:10:34 +0300
Subject: [LTP] [PATCH] ipsec_lib.sh: test xfrm_user driver locally
 before rhost
In-Reply-To: <20201216115558.2964253d@kmaincent-XPS-13-7390>
References: <20201216094037.5886-1-kory.maincent@bootlin.com>
 <6abb1c7a-47d7-97dd-96c2-665c1030a554@oracle.com>
 <20201216115558.2964253d@kmaincent-XPS-13-7390>
Message-ID: <adc0cd36-8b6b-7323-7d08-d997f2f146e2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16.12.2020 13:55, K?ry Maincent wrote:
> Hello Alexey,
> 
> On Wed, 16 Dec 2020 13:31:36 +0300
> Alexey Kodanev <alexey.kodanev@oracle.com> wrote:
> 
>> On 16.12.2020 12:40, Kory Maincent wrote:
>>> First, test the presence of the driver locally to avoid a misleading TWARN
>>> from tst_net_run in case of driver not present.
>>>
>>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>>> ---
>>>  testcases/network/stress/ipsec/ipsec_lib.sh | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh
>>> b/testcases/network/stress/ipsec/ipsec_lib.sh index 198c9315d..1db5fc6af
>>> 100644 --- a/testcases/network/stress/ipsec/ipsec_lib.sh
>>> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
>>> @@ -83,8 +83,9 @@ ipsec_lib_setup()
>>>  	ALGR=
>>>  
>>>  	if [ -n "$IPSEC_MODE" ]; then
>>> -		tst_net_run "tst_check_drivers xfrm_user" || \
>>> -			tst_brk TCONF "xfrm_user driver not available on
>>> lhost or rhost"
>>> +		tst_check_drivers xfrm_user || tst_brk TCONF "xfrm_user
>>> driver not available"
>>> +		tst_rhost_run -c "tst_check_drivers xfrm_user" || \
>>> +			tst_brk TCONF "xfrm_user driver not available on
>>> rhost"  
>>
>> Hi Kory,
>>
>> tst_net_run() checks the driver locally first, so I don't
>> quite understand why do exactly the same what tst_net_run()
>> supposed to do?
> 
> Indeed but it returns a TWARN because the command "tst_check_drivers xfrm_user"
> not end properly, but in fact it should return a TCONF due to the missing
> xfrm_drivers.
> In the final result file we got a FAIL error with the value 36 in place of a
> CONF with value 32 which should be the right message.
> 

Perhaps it needs -q option here:

tst_net_run -q "tst_check_drivers xfrm_user" ... so it skips TWARN?

