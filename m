From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Jul 2018 14:51:33 +0200
Subject: [LTP] [PATCH v2 ltp] net/virt_lib.sh: Remove possibility to
 pass custom sizes
Message-ID: <20180702125133.2hofhdopu5xcbtss@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,


Sorry for late reply, I didn't get your email, just noticed your answers in
patchwork.
Comment are bellow, I'm going to send v3.

> On 22.06.2018 18:10, Petr Vorel wrote:
> > to virt_netperf_msg_sizes(). Custom sizes haven't been used yet.

> > This is a preparation for next commit, which (while rewriting tests into
> > new shell API) start using virt_netperf_msg_sizes() as test functions
> > directly (as in new API it gets $1 for test number since 4bcc0addf.

> >     TST_TESTFUNC="virt_netperf_msg_sizes"

> > instead of wrapping it into function:

> >     TST_TESTFUNC="do_test"
> >     do_test()
> >     {
> > 	virt_netperf_msg_sizes
> >     }

> > Actually the best would be to replace sizes array in function with
> > TST_TEST_DATA, but that would require split tests cases, which use
> > virt_netperf_msg_sizes() with other functions, which are without arrays
> > (e.g. virt_compare_netperf() and virt_minimize_timeout() in vlan03.sh,
> > geneve01.sh abd vxlan03.sh)


> Do you mean using TST_CNT for different options (e.g. in vxlan03.sh " ,gbp"),
> and TST_TEST_DATA for sizes?

No, as in the test bellow virt_netperf_msg_sizes() run 4 times (using array sizes)
and virt_setup runs just once.

# vlan03.sh
do_test()
{
    virt_check_cmd virt_add ltp_v0 id 0 $2 || return

    tst_res TINFO "networks with the same VLAN ID must work"
    virt_setup "id 4094 $2" "id 4094 $2"
    virt_netperf_msg_sizes
    virt_cleanup_rmt

    tst_res TINFO "different VLAN ID shall not work together"
    virt_setup "id 4093 $2" "id 4094 $2"
    virt_minimize_timeout
    virt_compare_netperf "fail"
    virt_cleanup_rmt
}

So the solution would have to be split it into files

# vlan03_ok.sh
do_test()
{
    virt_check_cmd virt_add ltp_v0 id 0 $2 || return

    tst_res TINFO "networks with the same VLAN ID must work"
    virt_setup "id 4094 $2" "id 4094 $2"
    virt_netperf_msg_sizes
    virt_cleanup_rmt
}


# vlan03_ok.sh
do_test()
    virt_check_cmd virt_add ltp_v0 id 0 $2 || return

    tst_res TINFO "different VLAN ID shall not work together"
    virt_setup "id 4093 $2" "id 4094 $2"
    virt_minimize_timeout
    virt_compare_netperf "fail"
    virt_cleanup_rmt
}

But even with that, we just have 2 levels of data for virt_netperf_msg_sizes:
sizes array and options. So I guess we need to have it how it is.
I suppose we don't want to patch tst_test.sh to have one more data level.
The motivation for this is to have TST_CNT updated (and not having just "1").


Kind regards,
Petr
