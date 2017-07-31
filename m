From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 31 Jul 2017 19:53:51 +0300
Subject: [LTP] [RFC PATCH v7 11/11] network: Use tools to set up IPv4
 and IPv6 related variables
In-Reply-To: <20170727090331.olg3buhrhhs6h532@dell5510>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-12-pvorel@suse.cz>
 <2255e31f-0d8f-5aed-e288-6dde615d98a4@oracle.com>
 <20170727090331.olg3buhrhhs6h532@dell5510>
Message-ID: <022c99bb-86d0-494a-ec0b-a4a53dafaa72@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 07/27/2017 12:03 PM, Petr Vorel wrote:
> Hi Alexey,
>
>>> +# For full list of exported environment variables see:
>>> +# tst_net_ip_prefix -h
>>> +# tst_net_iface_prefix -h
>>> +# tst_net_vars -h
>>> +if [ -z "$TST_PARSE_VARIABLES" ]; then
>>> +	tst_resm TINFO "Parsing IP and prefixes"
>>> +	set -x
>> It might be useful just for debugging, please remove it.
> OK, I'll remove it, because you don't like it. But I have to admit, I think it's important
> to see values of automatic setup.
> If user reports a bug/problem we have ver_linux, which is suitable for most of the
> scripts, but not for networking.  And printing values of automatic configuration doesn't
> have to be by 'set -x', that was just a quick way how to achieve it.
>
>>> +	eval "$(tst_net_ip_prefix $IPV4_LHOST)" || exit $?
>> Not quite right, if you want to deal with the status of
>> tst_net_ip_prefix, you have to set 'exit' on error inside $(...)
>> eval "$(tst_net_ip_prefix $IPV4_LHOST || echo 'exit $?')"
> Am I missing something? Are you sure, you're right? POSIX defines [1]:
> EXIT STATUS
> If there are no arguments, or only null arguments, eval shall return a zero exit status;
> otherwise, it shall return the exit status of the command defined by the string of
> concatenated arguments separated by <space> characters, or a non-zero exit status if the
> concatenation could not be parsed as a command and the shell is interactive (and therefore
> did not abort).


eval executes the output of tst_net_ip_prefix command there, not $(...),
so basically it's the same as if we write:

cmd="$(tst_net_ip_prefix)"

On error $cmd is empty because you write to stderr, so eval returns 0.

eval "$cmd"

Or you could use '$(...)' instead of "$(...)", but in that case eval is
kind of redundant.


>
> [1]: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_19
>
> And bash, dash and busybox shell all implement this behaviour correctly. So both ways
> deals correctly with tst_net_ip_prefix exit status and I consider mine form a bit clearer.
>
>
>>> +	if [ "$TST_USE_NETNS" != "yes" ]; then
>>> +		tst_resm TINFO "Parsing prefixes and ifaces from rtnetlink"
>>> +		set -x
>>> +		eval "$(tst_net_iface_prefix $IPV4_LHOST)" || exit $?
>>> +		eval "$(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST)" || exit $?
>>> +		eval "$(tst_net_iface_prefix $IPV6_LHOST)" || exit $?
>>> +		eval "$(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST)" || exit $?
>>> +		set +x
>>> +	fi
>> Why netns is not working in the above case or it's an optimization?
> Chicken or the egg problem. We need tst_rhost_run, but it requires LTP_NETNS being set =>
> that requires init_ltp_netspace() call. But in init_ltp_netspace() we set remote IP. Does
> it make sense to move tst_net_iface_prefix behind netns initialization and call 'tst_restore_ipaddr'
> and 'tst_restore_ipaddr rhost' again?

I see, it could be solved by moving init_ltp_netspace() between
tst_net_ip_prefix() calls and "parsing prefixes and ifaces from rtnetlink".

Thanks,
Alexey

