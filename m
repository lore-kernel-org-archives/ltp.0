From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Apr 2018 15:45:36 +0200
Subject: [LTP] [RFC PATCH v6 0/7] Rewriting network tests into new shell
	API
In-Reply-To: <20180406123118.21309-1-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
Message-ID: <20180410134536.clbsznmco64mhcp5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> I spent some time with fixing dependencies for interface stress tests.
> I also fighted with getopts being passed to tst_net.sh and for other scripts
> I needed keep -6 for tst_net.sh, the rest is for scripts using
> tst_net.sh - tests themselves, "libraries" being called by scripts -
> tcp_fastopen_run.sh, vxlan03.sh and testscripts/network.sh).
> Sometimes tst_net.sh is loaded 3 times.

> For further development I'd like to move network setup from
> testscripts/network.sh to tst_net.sh to function tst_net_run(). This
> would allow to run tests with runltp (and keep our
> testscripts/network.sh helper). That would reduce one user of
> tst_net.sh.
> Another benefit I see to have unique way to run script (one day there
> might be runltp replaced by better implementation and I don't want
> network scripts to be missing it).

I overlooked simple fact that test itself doesn't need testscripts/network.sh helper to
setup network. They can be run by $LTPROOT/bin/ltp-pan itself or with one of the helpers
for non-networking tests (e.g. /opt/ltp/runltp). The difference is that is the setup is
being run again before each test, which is a bit slower, but we're sure the network setup
after previous test is restored (in case of previous test has bug and fail to restore it).

Here network setup done with TCID="network_settings", only once:

    # /opt/ltp/testscripts/network.sh -6
    network_settings 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    network_settings 1 TINFO: set local addr 10.0.0.2/24
    network_settings 1 TINFO: set local addr fd00:1:1:1::2/64
    network_settings 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    network_settings 1 TINFO: set remote addr 10.0.0.1/24
    network_settings 1 TINFO: set remote addr fd00:1:1:1::1/64
    network_settings 1 TINFO: wait for IPv6 DAD completion 1/5 sec
    network_settings 1 TINFO: Network config (local -- remote):
    network_settings 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
    network_settings 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
    network_settings 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
    ..
    cmdline="ping01.sh -6"
    ..
    <<<test_output>>>
    ping01 1 TINFO: ping6 with 8 16 32 64 128 256 512 1024 2048 4064 ICMP packets
    ping01 1 TPASS: ping6 -c 3 -s 8 fd00:1:1:1::1 >/dev/null passed as expected
    ...
    <<<test_end>>>
    <<<test_start>>>
    ...
    cmdline="ping02.sh -6"
    ...
    <<<test_output>>>
    ping02 1 TINFO: flood ping6: ICMP packets filled with pattern '000102030405060708090a0b0c0d0e0f'
    ping02 1 TPASS: ping6 -c 3 -f -s 8 fd00:1:1:1::1 -p 000102030405060708090a0b0c0d0e0f >/dev/null passed as expected


Here is network setup done each time, with TCID of particular test.
    # /opt/ltp/runltp -f net.ipv6
    ...
    cmdline="ping01.sh -6"
    ...
    <<<test_output>>>
    ping01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    ping01 1 TINFO: set local addr 10.0.0.2/24
    ping01 1 TINFO: set local addr fd00:1:1:1::2/64
    ping01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    ping01 1 TINFO: set remote addr 10.0.0.1/24
    ping01 1 TINFO: set remote addr fd00:1:1:1::1/64
    ping01 1 TINFO: wait for IPv6 DAD completion 1/5 sec
    ping01 1 TINFO: Network config (local -- remote):
    ping01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
    ping01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
    ping01 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
    ping01 1 TINFO: ping6 with 8 16 32 64 128 256 512 1024 2048 4064 ICMP packets
    ping01 1 TPASS: ping6 -c 3 -s 8 fd00:1:1:1::1 >/dev/null passed as expected
    ...
    <<<execution_status>>>
    ...
    <<<test_end>>>
    <<<test_start>>>
    ...
    cmdline="ping02.sh -6"
    ...
    <<<test_output>>>
    ping02 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    ping02 1 TINFO: set local addr 10.0.0.2/24
    ping02 1 TINFO: set local addr fd00:1:1:1::2/64
    ping02 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    ping02 1 TINFO: set remote addr 10.0.0.1/24
    ping02 1 TINFO: set remote addr fd00:1:1:1::1/64
    ping02 1 TINFO: wait for IPv6 DAD completion 1/5 sec
    ping02 1 TINFO: Network config (local -- remote):
    ping02 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
    ping02 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
    ping02 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
    ping02 1 TINFO: flood ping6: ICMP packets filled with pattern '000102030405060708090a0b0c0d0e0f'
    ping02 1 TPASS: ping6 -c 3 -f -s 8 fd00:1:1:1::1 -p 000102030405060708090a0b0c0d0e0f >/dev/null passed as expected

Maybe we should document it.


Kind regards,
Petr
