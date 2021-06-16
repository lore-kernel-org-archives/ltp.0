From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 16 Jun 2021 08:16:34 +0200
Subject: [LTP] [PATCH v2] ssh-stress: Convert to new api
In-Reply-To: <a2ad7106-3e96-48a0-d195-80d7d09c8613@bell-sw.com>
References: <20210614094338.125870-1-lkml@jv-coder.de>
 <a2ad7106-3e96-48a0-d195-80d7d09c8613@bell-sw.com>
Message-ID: <fae3c38e-ae64-05ac-264b-f11cae8c1c55@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thanks for your review. I will integrate the changes, test and send a v3.

>> +# SSH config file on the remote host
>> +RHOST_SSH_CONF=
>> +# SSG command to connect from the remote host to the test host
>        ^
>       SSH
Obviously, thanks
>
>> +RHOST_SSH=
>> +# Processes started on the remote host, killed at cleanup
>> +RHOST_PIDS=
>> +# Netstress process started on the test host, killed at cleanup
>> +NETSTRESS_PID=
>>   
>>   cleanup()
>>   {
>> +	local pids pid
>> +
>>   	# Stop the ssh daemon
>> -	test -s sshd.pid && kill $(cat sshd.pid)
>> -	pkill 'netstress$'
>> -	tst_rmdir
>> -	[ "$rtmpdir" ] && tst_rhost_run -c "rm -rf $rtmpdir"
>> -	TMPDIR=
>> +	[ -s sshd.pid ] && kill $(cat sshd.pid)
>> +	[ -n "$NETSTRESS_PID" ] && kill -2 $NETSTRESS_PID >/dev/null 2>&1
>> +
>> +	for pid in $RHOST_PIDS; do
>> +		tst_rhost_run -c "kill -- $pid"  >/dev/null 2>&1
>> +	done
> tst_rhost_run -c "kill $RHOST_PIDS"
I guess I did not use use it, because it might be a huge number of pids 
and I did not look at the actual limits, but now that I looked at it, it 
should be big enough...

>
>> +
>> +	# Kill all remaining ssh processes
>> +	tst_rhost_run -c "ps auwx | \
>> +		awk '\$0 ~ \"$RHOST_SSH_CONF\" && \$11 == \"ssh\" {print \$2}' | \
>> +		xargs -r -t kill -- >/dev/null 2>&1"
>>   }
>>   
> What about using pkill -f instead of ps|awk|kill?
I guess I did not use pkill for two reasons:
1. I wanted to be sure to really only kill ssh processes with 
$RHOST_SSH_CONF in their arguments
2. I did not want to use an extra tool, that is not necessarily 
available on all systems.

The first one could be solved by using "pkill -f "^ssh 
.*$RHOST_SSH_CONF", I guess. This still leaves a problem with unescaped 
regexp meta characters in RHOST_SSH_CONF, but my awk solution has the 
same problem. But I think this is only theoretical, it is extremely 
unlikely, that any regexp meta character apart from "." is used in 
RHOST_SSH_CONF and the dot will unlikely produce false positives.
The second point can be ignored. pkill is used in many locations 
throughout ltp already. It should probably be added as a runtime dependency.

>
>> -	tst_rhost_run -s -c "ssh-stress02-rmt.sh $TST_IPVER $(tst_ipaddr) \
>> -		$rconfig $CONNECTION_TOTAL $NS_DURATION"
>> +	tst_res TINFO "Verify the ssh connectivity over IPv4/IPv6 is not broken after creating many ssh sessions"
>                                                             ^
> The message may have indicated the exact IP version with $TST_IPVER
Yeah right, that was just copy and pasted from the original test 
description.
>
>> +	for pid in $RHOST_PIDS; do
>> +		tst_rhost_run -c "kill $pid" >/dev/null
>> +		[ $? -ne 0 ] && num=$((num + 1))
> Do we need $((num + 1)) here? At least it could be used in the
> message below instead of "some ssh"...
I think I just counted them here, because I wanted to keep the loop 
running, so all processes are killed before tst_brk is called.
But yes adding it to the message makes sense
>>   
>> -	netstress -R 3 -g $port > tcp_server.log 2>&1 &
>> +	# Start a tcp server
>> +	netstress -R 3 -g $port >/dev/null 2>&1 &
>> +	NETSTRESS_PID=$!
>
> We can now use netstress -B, it will go to background only after sucessfully
> performing bind()/listen(). The actual port number will be saved in the
> netstress_port file, i.e.:
>
> netstress -B .
> port=$(cat netstress_port)
I will try this
>
>>   
>> -	tst_rhost_run -s -c "ssh-stress03-rmt.sh $TST_IPVER $(tst_ipaddr) \
>> -		$rconfig $port $NS_TIMES"
>> +	# Setup an ssh tunnel from the remote host to testhost
>> +	RHOST_PIDS=$(tst_rhost_run -c \
>> +		"$RHOST_SSH -N -L $lport:$rhost:$port </dev/null 1>/dev/null 2>&1 \
>> +		& echo \$!")
>> +	tst_sleep 1
> Why you don't use -f option with ssh? I wouldn't rely on sleep 1 here.
Good idea, I did not think about -f.

J?rg
