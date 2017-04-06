From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 6 Apr 2017 17:42:36 +0300
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <20170405204418.3240-1-pvorel@suse.cz>
References: <20170405204418.3240-1-pvorel@suse.cz>
Message-ID: <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
On 05.04.2017 23:44, Petr Vorel wrote:
> Hi,
>
> hopefully last version.
> v3->v4:
> * Rewritten unused network generation. It uses 10.23 resp. fd00:23 as default,
>   in case of collision it's 10.x resp. fdxx:23, x is random value. BTW code in
>   previous version was wrong as it had the same size as network.
> * Forbidden prefixes are only 0 and 32 resp. 128, but they're rounded up by 8 resp. 16 anyway.

I tried to run several examples and got wrong results, e.g.

 ./tst_net_vars fd00::1/64 fd00::2/64
export IPV6_NETWORK='fd00:'
export IPV6_NET_REV='0.0.0.0.0.0.0.0.0.0.0.0.0.0.d.f'
export LHOST_IPV6_HOST='1'
export LHOST_IPV6_REV='1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0'
export RHOST_IPV6_HOST='2'
export RHOST_IPV6_REV='2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0'
export IPV6_NET32_UNUSED='fdb4:23' <--- got random one

fd00:23::/32 should suffice for unused network because fd00::/64
not overlap with it.

./tst_net_vars 10.2.0.1/22 10.2.1.1/22  <--- valid configuration
Please use the same network for both IP addresses

If we look at how IPV4/6_NETWORK and LHOST_IPV4/6_HOST used
inside test_net.sh:

tst_ipaddr()
{
        local type="${1:-lhost}"
        local ipv="${TST_IPV6:-4}"
        local tst_host=

        if [ "$type" = "lhost" ]; then
                eval "tst_host=\$LHOST_IPV${ipv}_HOST"
        else
                eval "tst_host=\$RHOST_IPV${ipv}_HOST"
        fi

        if [ "$TST_IPV6" ]; then
                echo "${IPV6_NETWORK}:${tst_host}"
        else
                echo "${IPV4_NETWORK}.${tst_host}"
        fi
}

it is a simple concatenation of two variables. The only reason that
we didn't remove them is that we still have some old tests which are
using these variables in the same way.

Given that the number of such tests are really small (stress/route,
stress/multicast) and they don't source test_net.sh (only through
network.sh), may be it is time to get rid of these variables inside
test_net.sh and use just one, for reverse addresses as well?

Regarding the usage of subnet mask in IP_HOST, it should really be
optional or not used@all, only a few tests might require it:

* when configuring netns ltp_ns, default will be /24 and /64,

* grep tst_restore_ipaddr -r .
./stress/interface/if4-addr-change:     tst_restore_ipaddr
./stress/interface/if-lib.sh:   tst_restore_ipaddr || return $?
./stress/interface/if-mtu-change:       tst_restore_ipaddr
./stress/interface/if-mtu-change:       tst_restore_ipaddr rhost


Please also use checkpatch and fix any errors/warnings reported:
    total: 5 errors, 37 warnings

Got compiler errors as well:
tst_net_vars.c: In function ‘get_ipv4_host’:
tst_net_vars.c:317: error: ‘for’ loop initial declarations are only
allowed in C99 mode
tst_net_vars.c:317: note: use option -std=c99 or -std=gnu99 to compile
your code
tst_net_vars.c: In function ‘get_ipv4_net_rev’:
tst_net_vars.c:349: error: ‘for’ loop initial declarations are only
allowed in C99 mode
tst_net_vars.c: In function ‘get_ipv4_network’:
tst_net_vars.c:385: error: ‘for’ loop initial declarations are only
allowed in C99 mode

Thanks,
Alexey

