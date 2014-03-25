Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Message-ID: <5331A238.3020003@oracle.com>
Date: Tue, 25 Mar 2014 19:35:20 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: [LTP] svc_vc_create/clnt_vc_create and RPC_ANYFD
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
To: libtirpc List <libtirpc-devel@lists.sourceforge.net>
Cc: vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list <ltp-list@lists.sourceforge.net>

Hi!

Sorry, but yet another question regarding rpc-tirpc-full-test-suite.

Some binaries from this suite pass RPC_ANYFD to svc_vc_create() or 
clnt_vc_create().

Like this one - 
https://github.com/linux-test-project/ltp/blob/master/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/tirpc_svc_5/tirpc_svc_5.c 
:

transp = svc_vc_create(RPC_ANYFD, 1024, 1024);

And, of course, the tests using this fail.

I dig into the libtirpc sources and didn't found anything that could 
state that we may pass RPC_ANYFD to these functions.

 From svc_vc_create() comments:
"The filedescriptor passed in is expected to refer to a bound, but
not yet connected socket."

and from clnt_vc_create():
"fd should be an open socket"

So invoking svc_vc_create(RPC_ANYFD,...) or clnt_vc_create(RPC_ANYFD, 
...) is incorrect. Right?

Thank you.

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
