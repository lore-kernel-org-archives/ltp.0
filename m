Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YqDo6-0001DA-Lx
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 04:53:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqDo5-0002Os-EK
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 04:53:10 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Thu, 7 May 2015 04:53:05 +0000
Message-ID: <1430974387.1907.0.camel@localhost>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430907502-30493-2-git-send-email-weijg.fnst@cn.fujitsu.com>
	<554A7CCB.5030601@oracle.com>
In-Reply-To: <554A7CCB.5030601@oracle.com>
Content-Language: en-US
Content-ID: <251B994CEAE24F44AEAF524909233CE2@fujitsu.local>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] kernel/syscalls/fallocate: specify size needs
 check
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
To: "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Thanks for your comments.
I will update it.

Thanks,
wei
On Wed, 2015-05-06 at 23:42 +0300, Alexey Kodanev wrote:
> Hi,
> On 05/06/2015 01:18 PM, Wei,Jiangang wrote:
> > Compare size_t size elements with file data and check
> > if it's excpeted.
> > This patch depends on bff5968.
> >
> > Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> > ---
> >   testcases/kernel/syscalls/fallocate/fallocate04.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> > index a6d1159..2da0bcd 100644
> > --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> > +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> > @@ -174,7 +174,7 @@ static void test02(void)
> >   	fill_tst_buf(exp_buf);
> >   	memset(exp_buf + block_size, 0, block_size);
> >   
> > -	check_file_data(exp_buf);
> > +	check_file_data(exp_buf, sizeof(exp_buf)/sizeof(exp_buf[0]));
> 
> Thank you for fixing it.
> 
> We could you use size variables already defined for 'exp_buf[buf_size]'.
> 
> >   
> >   	tst_resm(TPASS, "test-case succeeded");
> >   }
> > @@ -214,7 +214,7 @@ static void test03(void)
> >   	fill_tst_buf(exp_buf);
> >   	memset(exp_buf + block_size - 1, 0, block_size + 2);
> >   
> > -	check_file_data(exp_buf);
> > +	check_file_data(exp_buf, sizeof(exp_buf)/sizeof(exp_buf[0]));
> >   
> 
> Also buf_size variable here.
> 
> >   	tst_resm(TPASS, "test-case succeeded");
> >   }
> > @@ -250,7 +250,7 @@ static void test04(void)
> >   	memcpy(exp_buf, tmp_buf, block_size);
> >   	memcpy(exp_buf + block_size, tmp_buf + size, block_size);
> >   
> > -	check_file_data(exp_buf);
> > +	check_file_data(exp_buf, sizeof(exp_buf)/sizeof(exp_buf[0]));
> >   
> 
> 'size' variable here.
> >   	tst_resm(TPASS, "test-case succeeded");
> >   }
> 
> 
> Now test04 fails because I forgot to set adjacent two bytes in 'exp_buf' 
> to zero in test04(), it could be fixed as follows:
> 
> @@ -250,8 +249,8 @@ static void test04(void)
> 
>          memcpy(exp_buf, tmp_buf, block_size);
>          memcpy(exp_buf + block_size, tmp_buf + size, block_size);
> -
> -       check_file_data(exp_buf);
> +       exp_buf[block_size - 1] = exp_buf[block_size] = '\0';
> +       check_file_data(exp_buf, size);
> 
>          tst_resm(TPASS, "test-case succeeded");
>   }
> 
> 
> I think it would be better to merge fallocate04 fixes in a single patch.
> 
> Thanks,
> Alexey

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
