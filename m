From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Mon, 23 Apr 2018 16:08:06 +0800
Subject: [LTP] [PATCH] add ip6tables test case
In-Reply-To: <20180423075212.o5yifzur2rtvolrt@dell5510>
References: <42e1043e-a0b0-a55c-d55f-be5561bbcdb1@cn.fujitsu.com>
 <20180423075212.o5yifzur2rtvolrt@dell5510>
Message-ID: <c15ccacb-3f65-ae87-a6d5-d7d929ae81e3@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr

On 04/23/2018 03:52 PM, Petr Vorel wrote:
> Hi Lianwen Sun,
> 
>> Add ip6tables test case base on case of iptables
> 
>> Signed-off-by: sunlw <sunlw.fnst@cn.fujitsu.com>
>> ---
>>  runtest/net.tcp_cmds                          |   1 +
>>  testcases/network/iptables/Makefile           |   2 +-
>>  testcases/network/iptables/ip6tables_tests.sh | 386 ++++++++++++++++++
>>  3 files changed, 388 insertions(+), 1 deletion(-)
>>  create mode 100755 testcases/network/iptables/ip6tables_tests.sh
> 
> Thanks for your patch. IMHO instead of adding ip6tables_tests.sh, file iptables_tests.sh
> could be easily extended to support both IPv4/IPv6, using TST_IPV6 to distinguish. Most of
> other network tests is using that. This reduces duplicity of code and helps further
> changes (e.g. migration to new shell API).
>
Thanks your advise, I will try to rewrite this patch.

Best Wishes,
Lianwen Sun



