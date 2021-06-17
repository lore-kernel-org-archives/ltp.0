From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 17 Jun 2021 06:20:25 +0200
Subject: [LTP] [PATCH v3] ssh-stress: Convert to new api
In-Reply-To: <YMoMfS+cFx4aau01@pevik>
References: <20210616081856.3026223-1-lkml@jv-coder.de>
 <fb4b9d45-2cbb-5e5c-fefe-3ca429373a54@bell-sw.com> <YMoMfS+cFx4aau01@pevik>
Message-ID: <b092967d-2104-03d3-a95d-2042724ecca0@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 6/16/2021 4:36 PM, Petr Vorel wrote:
> Hi Joerg, Alexey,
>
> ...
>>>   cleanup()
>>>   {
>>> +	local pids
>>> +
>>>   	# Stop the ssh daemon
>>> -	test -s sshd.pid && kill $(cat sshd.pid)
>>> -	pkill 'netstress$'
>>> -	tst_rmdir
>>> -	[ "$rtmpdir" ] && tst_rhost_run -c "rm -rf $rtmpdir"
>>> -	TMPDIR=
>>> +	[ -s sshd.pid ] && kill $(cat sshd.pid)
>>> +	[ -n "$NETSTRESS_PID" ] && kill -2 $NETSTRESS_PID >/dev/null 2>&1
>>> +
>>> +	tst_rhost_run -c "kill $RHOST_PIDS"  >/dev/null 2>&1
> And check also $RHOST_PIDS, right?
> [ -n "$RHOST_PIDS" ] && tst_rhost_run -c "kill $RHOST_PIDS" >/dev/null 2>&1
Right... But actually doesn't matter. Just "kill" does nothing"
>
>>> +
>>> +	# Kill all remaining ssh processes
>>> +	tst_rhost_run -c "pkill -f '^ssh $RHOST_SSH_CONF'"
>> Perhaps we should check that $RHOST_SSH_CONF is set before running
>> pkill.
> [ -n "$RHOST_SSH_CONF" ] && tst_rhost_run -c "pkill -f '^ssh $RHOST_SSH_CONF'"
Yes, this should be done...
>
> No need to repost, I'll fix it before merge.
Thanks

J?rg
