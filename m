From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 14 Jun 2021 11:42:19 +0200
Subject: [LTP] [PATCH] ssh-stress: Convert to new api
In-Reply-To: <YMcB3Wcu0J9C3Z/Q@pevik>
References: <20210610101917.1251564-1-lkml@jv-coder.de>
 <YMcB3Wcu0J9C3Z/Q@pevik>
Message-ID: <5db0624b-a6ce-2c02-d1d4-52034c85b2f1@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I will send a v2 with the changes commented here.

On 6/14/2021 9:14 AM, Petr Vorel wrote:
> Hi Joerg,
>
> [ Cc Alexey ]
>> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>> Apart from pure conversion:
>>   - Use "StrictModes no" in ssh config, to get rid of
>>     access permission problems; All part of the path of the
>>     authorized_keys file must not be writeable by anyone but the owner.
>>     This allows writing the file to the default temp directory
>>   - Moved all rhost scripts into ssh-stress.sh
> +1
>
> Nice work, LGTM, few small notes (could be fixed before merge).
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Out of curiosity, did you test this on Two Host Configuration [2] (i.e. ssh)?
> Or just netns?
No, but should have...
I found two major problems with the test (will send a v2). But apart 
from that, either I was not able to find the documentation or it is not 
clear enough to me, how to run the two host setup.
I found network/README.md, but it only mentions to set RHOST, but for my 
setup (with ips different from the default ones, IPV{4,6}_{L,R}HOST is 
also required) and ltp must already be in the PATH on rhost, which was 
not possible for my rhost setup, where the filesystem is read-only and I 
had to hack setting the path into tst_rhost_run. It is not totally 
clear, that ltp in path is required to be set for the rhost ssh account 
(although it is hinted).
>
>>   cleanup()
>>   {
>> +	local pids
> Here needs to be pid as well.
done for v2
>> -	check_icmpv${TST_IPVER}_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
>> -		tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
>> +	check_icmpv${TST_IPVER}_connectivity $(tst_iface) $(tst_ipaddr rhost) \
>> +		|| tst_brk TBROK "Failed to ping $(tst_ipaddr rhost)"
> Anything from testcases/network/stress/ns-tools/ is deprecated,
> including check_icmpv{4,6}_connectivity. But this can be safely removed.
> Although I don't see any connectivity check in tst_net.sh, it should be handled
> there. IMHO it's needed at least for for two host based configuration, but it does not harm to test also netns based setup, thus somewhere after init_ltp_netspace.
There is tst_ping in tst_net.sh. Without arguments, it just tests 
connectivity to rhost.
Nevertheless, this is kind of useless in setup here. Other network tests 
do not check availability before execution, so I just dropped it for v2.
+1 on adding it to tst_net.sh initialization
>
>> -test01()
>> +test_ssh_connectivity()
>>   {
>> -	tst_resm TINFO "Creating '$CONNECTION_TOTAL' ssh sessions"
>> -
>> -	tst_rhost_run -s -c "ssh-stress01-rmt.sh $TST_IPVER $(tst_ipaddr) \
>> -		$rconfig $CONNECTION_TOTAL"
>> -
>> -	tst_resm TPASS "Test is finished successfully"
>> +	tst_rhost_run -c "$RHOST_SSH 'true >/dev/null 2>&1' >/dev/null"
>> +	[ $? -ne 0 ] && tst_res TFAIL "SSH not reachable"
> I guess you removed -s (security), to get more descriptive error.
> But then you IMHO need to use tst_brk to quit the test.
> Or if it was deliberate to keep other tests running, then test1
> would print TPASS "Test finished successfully" even it fails due this.
Right, this should be tst_brk and yes I did it without -s, to add a 
better error message.
There is no way the other subtests could pass, if the sshd started in 
setup is not reachable anymore, so no point in trying to continue.
Fixed for v2
>
>> -	tst_resm TPASS "Test is finished successfully"
>> +	test_ssh_connectivity
>> +
>> +	RHOST_PIDS=
>> +	num=0
>> +	while [ $num -lt $CONNECTION_TOTAL ]; do
>> +		pid=$(tst_rhost_run -c "$RHOST_SSH -N </dev/null 1>/dev/null 2>&1 \
>> +			& \echo \$!")
\echo is obviously wrong here. I messed this up while formatting the file...
> +			continue;
> nit: trailing ; unneeded (error from the original ssh-stress02-rmt.sh)
fixed for v2
>
>> +
>> +	tst_res TINFO "Waiting for all connections to terminate"
>> +	while [ -n "$RHOST_PIDS" ]; do
>> +		tst_sleep 1s
> nit: I'd be consistent with previous (1s vs. 1).
fixed for v2
>> -	tst_rhost_run -s -c "ssh-stress03-rmt.sh $TST_IPVER $(tst_ipaddr) \
>> -		$rconfig $port $NS_TIMES"
>> +	# Setup an ssh tunnel from the remote host to testhost
>> +	RHOST_PIDS=$(tst_rhost_run -c \
>> +		"$RHOST_SSH -N -L $lport:$rhost:$port </dev/null 1>/dev/null 2>&1 \
>> +		& echo \$!")
>> +	tst_sleep 1
>> -	tst_resm TPASS "Test is finished successfully"
>> -}
>> +	# Start the TCP traffic clients
>> +	tst_rhost_run -s -c "netstress -r $NS_TIMES -l -H $localhost -g $lport > /dev/null"
>> -setup
>> +	kill $RHOST_PIDS
This kills the ssh session setup on the remote host, so this must be 
executed on the remote host...

J?rg
