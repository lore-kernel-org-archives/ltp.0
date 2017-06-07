From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 7 Jun 2017 12:48:26 +0300
Subject: [LTP] [RFC PATCH v6 00/11] Simplify network setup + fix some
 network stress tests
In-Reply-To: <20170606132233.fpotse6pwwgp7xsb@dell5510>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <a3f5cc71-bd91-3de2-4951-ac853e1106e4@oracle.com>
 <20170606132233.fpotse6pwwgp7xsb@dell5510>
Message-ID: <02da2118-d0d2-7c72-007a-bceb46a48bd2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/06/2017 04:23 PM, Petr Vorel wrote:
> Hi Alexey,
>
> thanks for your input.
>
>> tst_rhost_run() with "two hosts" setup is using just RHOST
>> variable (management link) for rsh/ssh, it can have the same
>> route as IP_RHOST or better something different that won't be
>> affected by the tests.
> Ok, for ssh/rsh, if prefix isn't defined in IPV{4,6}_LHOST I'll read it with
> tst_rhost_run, using RHOST. That means to have separate binary for rtnetlink code.
>
> I'll move default prefix values (24 and 64) from tst_net_vars.c to test_net.sh, these
> values will be used as default for netns and used for rsh/ssh only if prefixes aren't
> specified in IPV{4,6}_LHOST and nothing found with rtnetlink.
> I also want to find via rtnetlink getting lhost and rhost iface. I wonder whether founded
> ifaces (rhost and lhost) should be also added into {L,R}HOST_IFACES even if variables are
> already specified by user and don't contain them.

It's better to leave interfaces unchanged if a user has already defined
them.
The rest sounds good to me.

Thanks,
Alexey

