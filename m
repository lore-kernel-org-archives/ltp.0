From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Mar 2019 17:37:04 +0300
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: use SO_BINDTODEVICE in
 tst_netload()
In-Reply-To: <20190314133338.GA29729@dell5510>
References: <1551198213-10024-1-git-send-email-alexey.kodanev@oracle.com>
 <1551198213-10024-2-git-send-email-alexey.kodanev@oracle.com>
 <20190226182709.GC27937@dell5510> <20190314133338.GA29729@dell5510>
Message-ID: <5129c4d6-6246-be45-a3ff-3bdf1ab691bf@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 3/14/19 4:33 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>>> Since we have the information about the device, enable the
>>> usage of the option, when starting netstress.
> 
>>> It can be disabled with TST_NETLOAD_BINDTODEVICE=0.
> 
> Having any reason not to push this patch?
> 

Yes, at least this patch breaks mpls and ipsec/vti tests.

For mpls the fix can be:

diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 84b3236..4ac7995 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -8,7 +8,7 @@ TST_NEEDS_ROOT=1
 TST_NEEDS_DRIVERS="mpls_router mpls_iptunnel mpls_gso"
 TST_NEEDS_CMDS="sysctl modprobe"
 TST_TEST_DATA="icmp tcp udp"
-
+TST_NETLOAD_BINDTODEVICE=0
 . tst_net.sh


For ipsec/vti we have to set the vti device:

diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index fe6135a..9c57471 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -17,7 +17,7 @@ do_test()

        [ "$2" != "$rand_opt" ] && opts="-A $rand_opt"
        tst_netload -H $ip_rmt_tun -T sctp $opts -r $IPSEC_REQUESTS \
-               -S $ip_loc_tun
+               -S $ip_loc_tun -D $tst_vti
 }



Moreover, since the "-D" is rather optional, may be it would be good
to control it with TST_NELOAD_BINDTODEVICE too?

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 7e16d58..e017321 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -565,7 +565,7 @@ tst_netload()
                f) cs_opts="${cs_opts}-f " ;;
                F) cs_opts="${cs_opts}-F " ;;
                e) expect_res="$OPTARG" ;;
-               D) cs_opts="${cs_opts}-D $OPTARG "
+               D) [ "$TST_NETLOAD_BINDTODEVICE" = 1 ] && cs_opts="${cs_opts}-D $OPTARG "
                   bind_to_device=0 ;;
                *) tst_brk_ TBROK "tst_netload: unknown option: $OPTARG" ;;
                esac



> Kind regards,
> Petr
> 

