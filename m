From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Sun, 28 Jun 2020 11:36:04 +0800
Subject: [LTP] [RESENT PATCH 1/5] tst_net.sh: Remove rsh support
In-Reply-To: <746f495c-b079-4ead-147a-ab21bb357464@oracle.com>
References: <20200622070911.16123-1-petr.vorel@suse.com>
 <20200622070911.16123-2-petr.vorel@suse.com>
 <3c3327ea-3132-255c-f853-c5c2d3f3c338@oracle.com>
 <746f495c-b079-4ead-147a-ab21bb357464@oracle.com>
Message-ID: <5EF81024.4050502@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/6/26 14:27, Alexey Kodanev wrote:
> On 25.06.2020 19:42, Alexey Kodanev wrote:
>> On 22.06.2020 10:09, Petr Vorel wrote:
>>> From: Petr Vorel<pvorel@suse.cz>
>>>
>> Hi Petr,
>>
>>> rsh is not used nowadays. When was the first network library version
>>> added in 18739ff06 (2014), it was a default + and ssh replacement was
>>> optional. Netns based single machine testing was added in 5f8ca6cf0
>>> (2016). After 6 years it's time to drop legacy rsh.
>>>
>>> ssh based testing setup requires only RHOST variable, TST_USE_SSH has
>>> been removed as unneeded. Also check for ssh in tst_rhost_run().
>>>
>>> We still keep $LTP_RSH for some of the network stress tests, which has
>>> not been ported to tst_net.sh yet.
>> But tst_net.sh not used in such tests, so why keeping LTP_RSH there?
> Ok, tst_net.sh included in testscripts/network.sh, we could change it
> to ssh too:
>
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 41938b1ac..0e10945da 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -856,7 +856,7 @@ tst_default_max_pkt()
>   export RHOST="$RHOST"
>   export PASSWD="${PASSWD:-}"
>   # Don't use it in new tests, use tst_rhost_run() from tst_net.sh instead.
> -export LTP_RSH="${LTP_RSH:-rsh -n}"
> +export LTP_RSH="${LTP_RSH:-ssh -nq -l root}"
Hi,

I also prefer to init it to ssh directly. :-)

BTW: Is it necessary to add fixed 'root' user? we can choose the user by 
current login user.

Best Regards,
Xiao Yang
>
>   # Test Links
>   # IPV{4,6}_{L,R}HOST can be set with or without prefix (e.g. IP or IP/prefix),
>
>>> Suggested-by: Alexey Kodanev<alexey.kodanev@oracle.com>
>>> Signed-off-by: Petr Vorel<pvorel@suse.cz>
>>> ---
>>>   testcases/lib/tst_net.sh | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
>>> index 806b540cd..1b96b3bf4 100644
>>> --- a/testcases/lib/tst_net.sh
>>> +++ b/testcases/lib/tst_net.sh
>>> @@ -136,7 +136,7 @@ init_ltp_netspace()
>>>   # -b run in background
>>>   # -c CMD specify command to run (this must be binary, not shell builtin/function)
>>>   # -s safe option, if something goes wrong, will exit with TBROK
>>> -# -u USER for ssh/rsh (default root)
>>> +# -u USER for ssh (default root)
>>>   # RETURN: 0 on success, 1 on failure
>>>   tst_rhost_run()
>>>   {
>>> @@ -166,14 +166,12 @@ tst_rhost_run()
>>>   		return 1
>>>   	fi
>>>
>>> -	if [ -n "${TST_USE_SSH:-}" ]; then
>>> -		output=`ssh -n -q $user@$RHOST "sh -c \
>>> -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
>>> -	elif [ -n "${TST_USE_NETNS:-}" ]; then
>>> +	if [ -n "${TST_USE_NETNS:-}" ]; then
>>>   		output=`$LTP_NETNS sh -c \
>>>   			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
>>>   	else
>>> -		output=`rsh -n -l $user $RHOST "sh -c \
>>> +		tst_require_cmds ssh
>>> +		output=`ssh -n -q $user@$RHOST "sh -c \
>>>   			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
>>>   	fi
>>>   	echo "$output" | grep -q 'RTERR$'&&  ret=1
>>>
>>
>



