Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TuYoD-0006M0-2G
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:25:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TuYo7-0006KX-PC
	for ltp-list@lists.sourceforge.net; Mon, 14 Jan 2013 01:25:53 +0000
Message-ID: <50F35EA4.6070508@cn.fujitsu.com>
Date: Mon, 14 Jan 2013 09:25:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <d586a4f2cfdf91b3e480c8e275f53fae34a00705.1357732655.git.zliu@redhat.com>
In-Reply-To: <d586a4f2cfdf91b3e480c8e275f53fae34a00705.1357732655.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH] numa/numa01.sh: fixed errors under noncontinuous
 numa nodes list
Reply-To: gaowanlong@cn.fujitsu.com
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 01/09/2013 07:58 PM, Zhouping Liu wrote:
>  
> -            col=2                       #column represents node0 in numastat o/p
> -        numnodes=$(ls /sys/devices/system/node | grep -Ec "node[0-9]*")
> -        Preferred_node=$[$[$numnodes/2]-1]
> -        col=$[$Preferred_node+2]
> +        if [ $COUNTER -eq $total_nodes ]; then
> +            Preferred_node=`echo $nodes_list | cut -d ' ' -f 1`

On my non-numa system, it shows that
$ numactl --show | grep nodebind | cut -d ':' -f 2
 0 
$ numactl --show | grep nodebind | cut -d ':' -f 2 | cut -d ' ' -f 1

Then the $Preferred_node is nothing.  Right?

Thanks,
Wanlong Gao

> +            col=2
> +        else
> +            Preferred_node=`echo $nodes_list | cut -d ' ' -f $[$COUNTER+1]`
> +            col=$[$COUNTER+2]
> +        fi
> +
>          numastat > $LTPTMP/numalog
>          extract_numastat other_node $other_node $col || return 1
>          Prev_value=$RC
> -        #echo $Preferred_node
> -        #numactl --cpunodebind=$Preferred_node --localalloc support_numa $ALLOC_1MB
> -        #numactl --preferred=$Preferred_node support_numa $ALLOC_1MB
> -        numactl --preferred=$Preferred_node support_numa $PAUSE &
> +        numactl --preferred=$node support_numa $PAUSE &
>          pid=$!


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
