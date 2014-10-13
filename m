Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XdjW0-0006mg-On
	for ltp-list@lists.sourceforge.net; Mon, 13 Oct 2014 17:34:36 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XdjVy-0002Ia-1L
	for ltp-list@lists.sourceforge.net; Mon, 13 Oct 2014 17:34:36 +0000
Date: Mon, 13 Oct 2014 13:34:27 -0400 (EDT)
From: Matus Marhefka <mmarhefk@redhat.com>
Message-ID: <2053896520.50998554.1413221667648.JavaMail.zimbra@redhat.com>
In-Reply-To: <375295843.50995847.1413221141839.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] Test case "netns_2children" fails under SELinux MLS
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
To: ltp-list@lists.sourceforge.net

Hi,

I got fail for TC netns_2children (under kernel/containers/netns) when using SELinux policy MLS in enforcing mode:

netns_child_2.sh 1 TFAIL : FAIL: Unable to ping Child1NS from Child2NS !
netns_child_1.sh 1 TFAIL : CHILD2 is unable to reach CHILD1
netns_2children    1  TFAIL  :  netns_two_children_ns.c:125: waitpid() returns 22672, errno 255

..but it passes for permissive mode (setenforce 0), so I can either report bug on SELinux policy
or we must test this TC in permissive mode. I think reporting bug on SELinux policy is better solution,
what do you think ?

More details (after test fail):
# ausearch -m avc -ts recent | grep ping
type=SYSCALL msg=audit(1413219951.925:1481): arch=c000003e syscall=46 success=yes exit=64 a0=5 a1=7fc90a490160 a2=0 a3=0 items=0 ppid=21088 pid=21167 auid=995 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 ses=17 comm="ping" exe="/usr/bin/pin " subj=staff_u:lspp_test_r:lspp_harness_t:s0-s15:c0.c1023 key=(null)
type=AVC msg=audit(1413219951.925:1481): avc:  denied  { egress } for  pid=21167 comm= ping" saddr=192.168.0.184 daddr=192.168.0.182 netif=veth0 scontext=system_u:object_r:unlabeled_t:s0 tcontext=system_u:object_r:netif_t:s0-s15:c0.c1023 tclass=netif

# ausearch -m avc -ts recent | grep ping | audit2allow

#============= unlabeled_t ==============
allow unlabeled_t netif_t:netif egress;


Thanks,
Matus Marhefka

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
