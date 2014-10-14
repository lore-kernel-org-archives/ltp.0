Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XdyxL-00014M-9q
	for ltp-list@lists.sourceforge.net; Tue, 14 Oct 2014 10:03:51 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XdyxI-0004KS-CJ
	for ltp-list@lists.sourceforge.net; Tue, 14 Oct 2014 10:03:51 +0000
Date: Tue, 14 Oct 2014 06:03:42 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1672541685.8551030.1413281022003.JavaMail.zimbra@redhat.com>
In-Reply-To: <2053896520.50998554.1413221667648.JavaMail.zimbra@redhat.com>
References: <2053896520.50998554.1413221667648.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] Test case "netns_2children" fails under SELinux MLS
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





----- Original Message -----
> From: "Matus Marhefka" <mmarhefk@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "Jan Stancek" <jstancek@redhat.com>
> Sent: Monday, 13 October, 2014 7:34:27 PM
> Subject: Test case "netns_2children" fails under SELinux MLS
> 
> Hi,
> 
> I got fail for TC netns_2children (under kernel/containers/netns) when using
> SELinux policy MLS in enforcing mode:
> 
> netns_child_2.sh 1 TFAIL : FAIL: Unable to ping Child1NS from Child2NS !
> netns_child_1.sh 1 TFAIL : CHILD2 is unable to reach CHILD1
> netns_2children    1  TFAIL  :  netns_two_children_ns.c:125: waitpid()
> returns 22672, errno 255
> 
> ..but it passes for permissive mode (setenforce 0), so I can either report
> bug on SELinux policy
> or we must test this TC in permissive mode. I think reporting bug on SELinux
> policy is better solution,
> what do you think ?

I'm not sure, when I saw that "unlabeled_t" in your AVC, I was thinking maybe
you are missing some label.

How are you running it? I tried to run it by hand, and although it fails
to start sshd, pings seems to work:

1. install RHEL7 GA
2. yum install selinux-policy-mls
3. relabel all

and then:

# sestatus 
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             mls
Current mode:                   enforcing
Mode from config file:          enforcing
Policy MLS status:              enabled
Policy deny_unknown status:     denied
Max kernel policy version:      28

# cd /root/ltp/testcases/kernel/containers/netns
# env PATH=/root/ltp/testcases/lib:.:$PATH ./netns_two_children_ns
netns_child_1.sh: line 47: /usr/sbin/sshd: Permission denied
netns_child_2.sh: line 46: /usr/sbin/sshd: Permission denied
netns_child_2.sh 1 TINFO : PASS: CHILD1 is pinging from CHILD2 ! 
netns_child_1.sh 1 TINFO : PASS: Child2 is pinging from CHILD1 !
netns_2children    1  TPASS  :  two children ns

# cat /etc/redhat-release 
Red Hat Enterprise Linux Server release 7.0 (Maipo)

# rpm -qa selinux-policy*
selinux-policy-3.12.1-153.el7.noarch
selinux-policy-targeted-3.12.1-153.el7.noarch
selinux-policy-mls-3.12.1-153.el7.noarch

Regards,
Jan

> 
> More details (after test fail):
> # ausearch -m avc -ts recent | grep ping
> type=SYSCALL msg=audit(1413219951.925:1481): arch=c000003e syscall=46
> success=yes exit=64 a0=5 a1=7fc90a490160 a2=0 a3=0 items=0 ppid=21088
> pid=21167 auid=995 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
> tty=pts1 ses=17 comm="ping" exe="/usr/bin/pin "
> subj=staff_u:lspp_test_r:lspp_harness_t:s0-s15:c0.c1023 key=(null)
> type=AVC msg=audit(1413219951.925:1481): avc:  denied  { egress } for
> pid=21167 comm= ping" saddr=192.168.0.184 daddr=192.168.0.182 netif=veth0
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:object_r:netif_t:s0-s15:c0.c1023 tclass=netif
> 
> # ausearch -m avc -ts recent | grep ping | audit2allow
> 
> #============= unlabeled_t ==============
> allow unlabeled_t netif_t:netif egress;
> 
> 
> Thanks,
> Matus Marhefka
> 

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
