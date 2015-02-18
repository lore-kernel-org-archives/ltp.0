Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YO8XZ-0004op-6R
	for ltp-list@lists.sourceforge.net; Wed, 18 Feb 2015 17:36:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YO8XX-0005Ki-La
	for ltp-list@lists.sourceforge.net; Wed, 18 Feb 2015 17:36:01 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1IHZqbe018472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 12:35:52 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t1IHZpgE004867
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Feb 2015 12:35:52 -0500
Message-ID: <54E4CD76.5010407@redhat.com>
Date: Wed, 18 Feb 2015 18:35:50 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
	<54E4C3C3.6080407@redhat.com>
In-Reply-To: <54E4C3C3.6080407@redhat.com>
Subject: Re: [LTP] network namespaces tests cleanup
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

On 02/18/2015 05:54 PM, Jiri Jaburek wrote:
> 
> # iproute pid support (possible bashisms follow)
> ip link add dummy123 type dummy
> nsenter --net=netnstest sleep 10 &
> ip link set dummy123 netns $!
> wait
> nsenter --net=netnstest ip link show

Should be rather:

# iproute pid support (possible bashisms follow)
ip link add dummy123 type dummy
nsenter --net=netnstest sleep 10 &
sleep 1
ip link set dummy123 netns $!
wait
nsenter --net=netnstest ip link show

(or so, I forgot about the race between nsenter calling setns(2) and
 ip-link reading the namespace of the child)


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
