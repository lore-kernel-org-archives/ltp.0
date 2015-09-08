Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZZHxo-0000Bp-26
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 12:25:28 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZHxn-0007V7-2v
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 12:25:28 +0000
Message-ID: <55EED49C.8080309@oracle.com>
Date: Tue, 08 Sep 2015 15:29:16 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <201509081939589887103@sina.com>
In-Reply-To: <201509081939589887103@sina.com>
Subject: Re: [LTP] about testscript run
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
To: xcf733520 <xcf733520@sina.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,
On 09/08/2015 02:39 PM, xcf733520 wrote:
> Hi all,
>
>       I try to run testscript in the directory of /opt/ltp/testscripts, when try networkstress.sh/networktests.sh  it show as below,
>
>       ./network.sh: line 5: test_net.sh: No such file or directory

test_net.sh script should be in the PATH. Usually, installation 
directory /opt/ltp/testcases/bin is set to the PATH. Then you can run 
./networktests.sh.

Alternatively, you can try to set the PATH to networkstress.sh or 
networktests.sh:

$ PATH=/opt/ltp/testcases/bin:$PATH ./networktests.sh

Thanks,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
