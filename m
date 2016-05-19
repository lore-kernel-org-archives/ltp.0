From: Hangbin Liu <haliu@redhat.com>
Date: Thu, 19 May 2016 21:55:15 +0800
Subject: [LTP] [PATCH 3/4] network/stress/icmp: add
 icmp-multi-diffnic.sh to implement diffnic stress test
In-Reply-To: <573AFE18.2080009@oracle.com>
References: <1462780623-26778-1-git-send-email-haliu@redhat.com>
 <1462780623-26778-3-git-send-email-haliu@redhat.com>
 <573AFE18.2080009@oracle.com>
Message-ID: <20160519135515.GF19992@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Tue, May 17, 2016 at 02:18:48PM +0300, Alexey Kodanev wrote:
> >+TCID=${TCID:-icmp-multi-diffnic}
> >+TST_TOTAL=1
> >+TST_COUNT=1
> >+TST_CLEANUP="do_cleanup"
> >+
> >+. ipsec_lib.sh
> >+
> >+while getopts "hl:m:n:N:p:s:S:6" opt; do
> there is no option 'n'

Ah, yes, thanks, will fix it.

> >+	case "$opt" in
> >+	h)
> >+		echo "Usage:"
> >+		echo "h        help"
> >+		echo "l n      n is the number of test link when tests run"
> >+		echo "m x      x is ipsec mode, could be transport / tunnel"
> >+		echo "N n      n is seconds of the network stress duration time"
> >+		echo "p x      x is ipsec protocol, could be ah / esp / ipcomp"
> >+		echo "s x      x is icmp messge size array"
> >+		echo "S n      n is IPsec SPI value"
> >+		echo "6        run over IPv6"
> >+		exit 0
> >+	;;
> >+	l) LINK_NUM=$OPTARG ;;
> >+	m) IPSEC_MODE=$OPTARG ;;
> >+	N) NS_DURATION=$OPTARG ;;
> >+	p) IPSEC_PROTO=$OPTARG ;;
> >+	s) ICMP_SIZE_ARRAY=$OPTARG ;;
> >+	S) SPI=$OPTARG ;;
> >+	6) # skip, test_net library already processed it
> >+	;;
> >+	*) tst_brkm TBROK "unknown option: $opt" ;;
> >+	esac
> >+done
> >+
> >+SPI=${SPI:-1000}
> >+LINK_NUM=${LINK_NUM:-0}
> >+DO_IPSEC=${DO_IPSEC:-false}
> >+NS_DURATION=${NS_DURATION:-"3600"}
> >+# Use large enough pkt size(65000) to fix each encapsulation
> >+ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65000"}
> >+[ -n "$IPSEC_MODE" -a -n "$IPSEC_PROTO" ] && DO_IPSEC=true || DO_IPSEC=false
> >+
> >+link_total=`echo $LHOST_HWADDRS | wc -w`
> >+rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
> >+if [ $link_total -ne $rhost_link_total ]; then
> >+	tst_brkm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
> >+elif [ $link_total -lt 2 ]; then
> >+	tst_brkm TBROK "This test case requires plural NICs."
> >+fi
> >+
> 
> Should we check that the number of interfaces more then 1, otherwise exit
> with TCONF?
> .. not TBROK

Yeah, that make sense.

> 
> Hmm, what is the difference between running those tests
> 
> LHOST_IFACE=eth1 ... ./icmp_uni_basic.sh &
> LHOST_IFACE=eth2 ... ./icmp_uni_basic.sh &
> ...
> 
> and running multinic script?

The uni_basic test is a basic, functional test, to verify we can handle all
kinds of message size with different configures. There is no much stress
actually.

And multi-diffnic will only check basic connectvity to make sure the
configuration is right. The main purpose of the test is to make sure system do
not break/crash under ping flood with various of messages. The same with
multi-diffip test.

Thanks
Hangbin
