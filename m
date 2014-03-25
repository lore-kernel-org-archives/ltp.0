Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSKs-0003yj-Ll
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:28:14 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSKr-00064G-Ne
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:28:14 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PES7Uh010629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:28:08 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2PES7Vg016101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:28:07 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s2PES6J6016087
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:28:06 GMT
Message-ID: <53319274.7020001@oracle.com>
Date: Tue, 25 Mar 2014 18:28:04 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] V2 rpc-tirpc-full-test-suite
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
Cc: vasily.isaenko@oracle.com

The first 2 patches need an approval (they do renaming and therefore are 
rather large).

On 03/25/2014 06:24 PM, Stanislav Kholmanskikh wrote:
> Hi!
>
> This is a second try of integration of rpc-tirpc-full-test-suite into LTP.
>
> It's done according our discussed plan.
>
> I still have the following failures of runtest/rpc_tests:
>   * rpc_clnt_broadcast - it fails if linked if -ltirpc. But, I suppose, it's
>     a test case error.
>   * rpc_svc_destroy - an issue regarding svcfd_create, which we discussed
>     in the libtirpc mailing list (no final decision yet)
>   * rpc_svcfd_create - the same
>   * rpc_xprt_register - the same
>   * rpc_xprt_unregister - the same
>
> and of runtest/tirpc_tests:
>   * tirpc_authsys_create
>   * tirpc_authdes_create
>   * tirpc_authdes_seccreate
>   * tirpc_clnt_dg_create - this is an issue with tirpc_svc_5
>   * tirpc_svc_dg_create - the same
>   * tirpc_clnt_vc_create - the same
>   * tirpc_svc_vc_create
>   * tirpc_bottomlevel_clnt_call - issue with tirpc_svc_5
>   * tirpc_rpcb_set
>
> I have a proposal how to fix most of these failures.
>
> For example, some of them use svc_vc_create/clnt_vc_create with RPC_ANYFD
> parameter (which should not work, as I understand).
> But before comitting any further fixes I want to discuss it in
> the libtirpc mailing list.
>
> Thank you.
>
>
>
> ------------------------------------------------------------------------------
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and their
> applications. Written by three acclaimed leaders in the field,
> this first edition is now available. Download your free book today!
> http://p.sf.net/sfu/13534_NeoTech
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
