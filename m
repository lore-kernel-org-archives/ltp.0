Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1Rf9FJ-0007Tx-Vr
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 12:01:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rf9FI-0008Hd-Qw
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 12:01:37 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBQC1Uij028150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Dec 2011 07:01:30 -0500
Message-ID: <4EF86212.8050103@redhat.com>
Date: Mon, 26 Dec 2011 20:01:22 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <1324899101-23034-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1324899101-23034-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] io/diotest4: Close open fd after testing
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/26/2011 07:31 PM, Eryu Guan wrote:
> 
> The 'silly rename' mechanism of NFS creates temporary file .nfsXXX in
> NFS mount. The tst_rmdir() in cleanup() in diotest4.c complains about
> "Device or resource busy"
> 
> Close open fd after each sub-test.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Hi, Committed, thanks.

-Caspar

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
