From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 31 Jan 2017 16:38:30 +0300
Subject: [LTP] [PATCH 1/2] test_net.sh: add tst_set_sysctl()
In-Reply-To: <20170131124128.GF29227@rei.lan>
References: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
 <20170131100744.GD29227@rei.lan>
 <4017cf9c-3957-0a91-4fa3-8bafdad2f4c4@oracle.com>
 <20170131124128.GF29227@rei.lan>
Message-ID: <22b74bd5-fb9d-83b5-d8c1-2934a23388b0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/31/2017 03:41 PM, Cyril Hrubis wrote:
> Hi!
>>>> +# tst_set_sysctl NAME VALUE [safe]
>>>> +# It can handle netns case when sysctl not namespaceified.
>>>> +tst_set_sysctl()
>>>> +{
>>>> +	local name="$1"
>>>> +	local value="$2"
>>>> +	local safe=
>>>> +	[ "$3" = "safe" ] && safe="-s" || safe=""
>>> Uh, this syntax is confusing, besides isn't safe set to empty string
>>> anyway?
>> What if we set TST_NO_CLEANUP just before calling cleanup()
>> or unset TST_CLEANUP... then we can use ROD, etc. in cleanup?
> You lost me here. How is this connected to the code I've commented?

In the 2nd patch, 'safe' option is used like this:

do_cleanup()
{
    tst_set_sysctl net.ipv4.tcp_cong...
}

do_test()
{
    tst_set_sysctl net.ipv4.tcp_cong... safe
}

So, the main reason for splitting the code with 'safe' option is to be
able to call this function inside cleanup. But if we handle cleanup
recursion inside the shell library, we can get rid of 'safe' option
and simplify tst_set_sysctls().

Thanks,
Alexey
