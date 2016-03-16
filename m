From: Hangbin Liu <haliu@redhat.com>
Date: Wed, 16 Mar 2016 22:10:26 +0800
Subject: [LTP] [PATCHv2 3/3] network/stress/icmp: use ip xfrm for
 icmp4-uni-basic01 ipsec testing
In-Reply-To: <56E91B20.3040107@oracle.com>
References: <1458035439-9143-1-git-send-email-haliu@redhat.com>
 <1458035439-9143-4-git-send-email-haliu@redhat.com>
 <56E91B20.3040107@oracle.com>
Message-ID: <20160316141026.GD29634@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 16, 2016 at 11:36:48AM +0300, Alexey Kodanev wrote:
> >+. ipsec_lib.sh
> >+
> >  # Test description
> >  tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message with the following conditions"
> >@@ -100,16 +103,12 @@ ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
> >  #-----------------------------------------------------------------------
> >  do_cleanup()
> >  {
> >-    # Kill the icmp traffic server
> >-    killall_icmp_traffic
> >-
> >      # Unset SAD/SPD
> >-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
> >-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
> >+    tst_ipsec flush
> >      # Clean up each interface
> >-    initialize_if lhost ${LINK_NUM}
> >-    initialize_if rhost ${LINK_NUM}
> >+    tst_init_iface lhost ${LINK_NUM}
> >+    tst_init_iface rhost ${LINK_NUM}
> 
> Again, we don't need it here.

Hi Alexey,

Thanks for your patient review. I will correct all the other problems you
mentioned. There only one thing. We will add the ip address before each test.
e.g.

tst_add_ipaddr lhost $LINK_NUM
if [ $? -ne 0 ]; then
    tst_brkm TBROK "Failed to add any IP address at the local host"
fi

If we do not remove the address after test. the next time we will get TBROK
when add address since there already have one.

I saw you use lhost_addr=$(tst_ipaddr) directly after source test_net.sh in
broken_ip4_lib.sh. But I didn't find when you init the iface addr. Could you
tell me the secret?

Thanks
Hangbin
