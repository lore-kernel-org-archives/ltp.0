Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1ZUGHK-0007aT-M7
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 15:36:50 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUGHI-00048J-Mo
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2015 15:36:50 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 92F7C461D7
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Aug 2015 15:36:42 +0000 (UTC)
References: <1440513962-10908-1-git-send-email-mmarhefk@redhat.com>
From: Jiri Jaburek <jjaburek@redhat.com>
Message-ID: <55DC8B88.3050605@redhat.com>
Date: Tue, 25 Aug 2015 17:36:40 +0200
MIME-Version: 1.0
In-Reply-To: <1440513962-10908-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] containers/netns: added one more test case for
 netns_sysfs.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 08/25/2015 04:46 PM, Matus Marhefka wrote:
> * renamed "dummy0" to "dummy_test0" to not collide with existing
>   interfaces
> * added test case which checks that only "localhost" and "dummy"
>   interfaces are seen in /sys/class/net/ after mounting sysfs
>   in a new namespace
> 
> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  testcases/kernel/containers/netns/netns_sysfs.sh | 39 +++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
> index c10fa36..a58495e 100755
> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
> @@ -23,13 +23,14 @@
>  #==============================================================================
>  
>  TCID="netns_sysfs"
> -TST_TOTAL=2
> +TST_TOTAL=3
> +DUMMYDEV="dummy_test0"
>  . test.sh
>  
>  cleanup()
>  {
>  	tst_rmdir
> -	ip link del dummy0 2>/dev/null
> +	ip link del $DUMMYDEV 2>/dev/null
>  	kill -9 $NS_HANDLE 2>/dev/null
>  }
>  
> @@ -43,23 +44,45 @@ TST_CLEANUP=cleanup
>  ls /sys/class/net >sysfs_before
>  
>  
> -ns_exec $NS_HANDLE ip link add dummy0 type dummy || \
> +ns_exec $NS_HANDLE ip link add $DUMMYDEV type dummy || \
>  	tst_brkm TBROK "failed to add a new dummy device"
>  ns_exec $NS_HANDLE mount -t sysfs none /sys 2>/dev/null
>  
> -ns_exec $NS_HANDLE test -d /sys/class/net/dummy0
> +
> +# TEST CASE #1
> +ns_exec $NS_HANDLE test -d "/sys/class/net/$DUMMYDEV"
>  if [ $? -eq 0 ]; then
> -	tst_resm TPASS "sysfs in new namespace has dummy0 interface"
> +	tst_resm TPASS "sysfs in new namespace has $DUMMYDEV interface"
> +else
> +	tst_resm TFAIL "sysfs in new namespace does not have $DUMMYDEV interface"
> +fi
> +
> +
> +# TEST CASE #2
> +res=0
> +classnet=$(ns_exec $NS_HANDLE ls /sys/class/net/)
> +for d in $classnet; do
> +	if [ "$d" != "lo" ]; then
> +		if [ "$d" != $DUMMYDEV ]; then
> +			tst_resm TINFO "sysfs in new namespace should not contain: $d"
> +			res=1
> +		fi
> +	fi
> +done

What about

for d in $(ns_exec $NS_HANDLE ls /sys/class/net/); do
    case "$d" in
        lo|$DUMMYDEV)
            ;;
        *)
            tst_resm TINFO "sysfs in new namespace should not contain: $d"
            res=1
        ;;
    esac
done

?

> +if [ $res -eq 0 ]; then
> +	tst_resm TPASS "sysfs in new namespace has only lo and $DUMMYDEV interfaces"
>  else
> -	tst_resm TFAIL "sysfs in new namespace does not have dummy0 interface"
> +	tst_resm TFAIL "sysfs in new namespace has more than lo and $DUMMYDEV interfaces"
>  fi
>  
> +
> +# TEST CASE #3
>  ls /sys/class/net >sysfs_after
>  diff sysfs_before sysfs_after
>  if [ $? -eq 0 ]; then
> -	tst_resm TPASS "sysfs not affected by a separate namespace"
> +	tst_resm TPASS "main sysfs not affected by a separate namespace"
>  else
> -	tst_resm TFAIL "sysfs affected by a separate namespace"
> +	tst_resm TFAIL "main sysfs affected by a separate namespace"
>  fi
>  
>  tst_exit
> 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
