Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pca9F-0003T3-TA
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 09:04:13 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1Pca9F-0003Px-4X
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 09:04:13 +0000
Received: by iwn8 with SMTP id 8so19828425iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Jan 2011 01:04:07 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1306180210.43013.1294736237011.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Tue, 11 Jan 2011 01:04:03 -0800
Message-Id: <95E78125-2C7F-4FC1-B547-C700EAA923B0@gmail.com>
References: <1306180210.43013.1294736237011.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 13/13] oom04: check root
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
To: CAI Qian <caiqian@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Jan 11, 2011, at 12:57 AM, CAI Qian wrote:

> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> testcases/kernel/mem/oom/oom04.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
> index 5b403f4..befb7e9 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -133,6 +133,8 @@ void setup(void)
> {
> 	int fd;
> 
> +	tst_require_root(tst_exit);
> +
> 	tst_sig(FORK, DEF_HANDLER, cleanup);
> 	TEST_PAUSE;

tst_require_root(NULL) is what you want for all of these patches. Makes me wonder if there's any value in having a cleanup argument or not...
HTH,
-Garrett
------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
