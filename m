Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1TuZGt-0007ei-1U
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:55:31 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TuZGq-00083r-U0
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:55:31 +0000
Date: Sun, 13 Jan 2013 20:55:19 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1178258988.5385396.1358128519932.JavaMail.root@redhat.com>
In-Reply-To: <50F35EA4.6070508@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] numa/numa01.sh: fixed errors under noncontinuous
 numa nodes list
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Monday, January 14, 2013 9:25:56 AM
> Subject: Re: [LTP] [PATCH] numa/numa01.sh: fixed errors under noncontinuous numa nodes list
> 
> On 01/09/2013 07:58 PM, Zhouping Liu wrote:
> >  
> > -            col=2                       #column represents node0
> > in numastat o/p
> > -        numnodes=$(ls /sys/devices/system/node | grep -Ec
> > "node[0-9]*")
> > -        Preferred_node=$[$[$numnodes/2]-1]
> > -        col=$[$Preferred_node+2]
> > +        if [ $COUNTER -eq $total_nodes ]; then
> > +            Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`
> 
> On my non-numa system, it shows that
> $ numactl --show | grep nodebind | cut -d ':' -f 2
>  0
> $ numactl --show | grep nodebind | cut -d ':' -f 2 | cut -d ' ' -f 1
> 
> Then the $Preferred_node is nothing.  Right?

Hi Wanlong,

The command's result executing between inside terminate and file script is different.
here `echo` command eat the first blank space ' '

please try the following in non-numa:
$ nodes_list=`numactl --show | grep nodebind | cut -d ':' -f 2`
$ echo $nodes_list | cut -d ' ' -f 1
 0

> 
> Thanks,
> Wanlong Gao

-- 
Thanks,
Zhouping

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
