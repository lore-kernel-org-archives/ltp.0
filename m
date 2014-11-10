Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Xnkwf-0001Jr-1d
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 09:07:33 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xnkwe-0000xC-1g
	for ltp-list@lists.sourceforge.net; Mon, 10 Nov 2014 09:07:33 +0000
Message-ID: <54608048.4000201@oracle.com>
Date: Mon, 10 Nov 2014 12:07:20 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <20141031133917.GA3195@localhost.localdomain>
In-Reply-To: <20141031133917.GA3195@localhost.localdomain>
Subject: Re: [LTP] chown and 16 bit syscall testing
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
To: ltp-list@lists.sourceforge.net, hanpt@linux.vnet.ibm.com

Hi!

On 10/31/2014 04:39 PM, Han Pingtian wrote:
> Hey there,
>
> I found that looks like all chown test cases will be compiled to 16 bit
> compat test case, but they just call chown() something like
>
>      TEST(chown(fname, uid, gid));
>
> which won't test if there is a 16 bit chown() syscall. I think maybe we
> should change it to something like below:
>
>      TEST(CHOWN(fname, uid, guid));
>
> then define CHOWN like this
>
>      UID_T CHOWN(void (cleanup)(void))
>      {
>              LTP_CREATE_SYSCALL(chown, cleanup);
>      }
>
> ?

I think, this is a good idea.

And there are more such test cases, which are not fixed for the 16-bit 
compat case. For example, setresuid.

So if it's possible, fixing them will be good as well;)


>
> Thanks in advance!
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
