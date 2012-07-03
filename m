Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SlzOp-00066G-Gw
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 09:27:59 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SlzOl-0000Bi-6h
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 09:27:59 +0000
Date: Tue, 03 Jul 2012 05:27:45 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <73d79569-277e-4e13-a932-73b9fc1575d5@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <8f888fa5-849f-44d8-972c-cfb1ea59eeb0@zmail13.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, CAI Qian <caiqian@redhat.com>



----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>, "Caspar Zhang" <caspar@casparzhang.com>, "CAI Qian"
> <caiqian@redhat.com>, gaowanlong@cn.fujitsu.com
> Sent: Tuesday, 3 July, 2012 10:43:35 AM
> Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
> 
> > Zhouping,
> > 
> > Are other tests, such as move_pages also failing on this setup?
> 
> no, I tested move_pages* on the setup, all passed, so this setup
> didn't affect move_pages.
> but it blocked oom0[2|4] & ksm0[2|4] cases, I will prepare a patch
> for it,
> 

So, we have tests with different expectation when node is 'available'.
Some are happy with memory being available, others want associated cpus.

numa_node_to_cpus() is likely what we need. We can either make new function,
or add some flag to existing one, depending on flag it would return nodes
with available memory/cpus or both.

> BTW, I'm interested in the various different NUMA setups in previous
> mail[1],
> I'm not sure these setups are faked or real, if they are faked, could
> you tell me
> how you can setup? (I have only one NUMA machine in my hands, and
> it's an normal one,
> if I can imitate more special NUMA setup, it will be big help for me
> to test other cases.
> and I tried kernel cmdline 'numa=fake=N', but I couldn't get what I
> expected,
> so please share your ideas if you have different methods, many
> thanks!)

2,4,5 were real
1 and 3 were fake with CONFIG_NUMA_EMU=Y and patched kernel to allow zero-size nodes.
I ran that as KVM guest with kernel params "numa=fake=2*0,1*512"

# numactl -H
available: 2 nodes (2-3)
node 2 cpus: 0
node 2 size: 511 MB
node 2 free: 33 MB
node 3 cpus:
node 3 size: 511 MB
node 3 free: 102 MB

I can't find the patch, but it was quite simple so I can recreate it if needed.

Regards,
Jan

> 
> [1]
> http://sourceforge.net/mailarchive/forum.php?thread_name=4FC48906.6030109%40redhat.com&forum_name=ltp-list
> 
> Thanks,
> Zhouping
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
