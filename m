Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YqbzU-00019y-Lk
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 06:42:32 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqbzS-0008WC-KT
	for ltp-list@lists.sourceforge.net; Fri, 08 May 2015 06:42:32 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Fri, 8 May 2015 06:42:26 +0000
Message-ID: <1431067342.1760.10.camel@localhost>
References: <1430907502-30493-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1430907502-30493-3-git-send-email-weijg.fnst@cn.fujitsu.com>
	<554B7127.7000606@oracle.com>
In-Reply-To: <554B7127.7000606@oracle.com>
Content-Language: en-US
Content-ID: <6771667695CB3F49B880A0FC7A8C8416@fujitsu.local>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 3/3] kernel/mem/mmapstress: fix resource leak
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

On Thu, 2015-05-07 at 17:05 +0300, Alexey Kodanev wrote:
> On 05/06/2015 01:18 PM, Wei,Jiangang wrote:
> > Including memory and fd leak.
> >
> > Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> > ---
> >   testcases/kernel/mem/mmapstress/mmapstress01.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
> > index 0baf0e2..1db8147 100644
> > --- a/testcases/kernel/mem/mmapstress/mmapstress01.c
> > +++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
> > @@ -657,6 +657,8 @@ int fileokay(char *file, uchar_t * expbuf)
> >   			perror("read error");
> >   			/***** LTP Port *****/
> >   			local_flag = FAILED;
> > +			free(readbuf);
> 
> We could allocate readbuf on the stack... readbuf[pagesize] so free() 
> not needed.
Thanks for your comments.
Yes, That's right.
I accept it.
> 
> > +			close(fd);
> >   			anyfail();
> 
> anyfail() calls tst_brkm() - the program terminates and closes fd.
> 
> >   			/*****	**	*****/
> >   			return 0;
> > @@ -668,6 +670,8 @@ int fileokay(char *file, uchar_t * expbuf)
> >   				(void)fprintf(stderr, "read %d of %ld bytes\n",
> >   					      (i * pagesize) + cnt,
> >   					      (long)mapsize);
> > +				free(readbuf);
> > +				close(fd);
> >   				return 0;
> >   			}
> >   		}
> > @@ -688,10 +692,13 @@ int fileokay(char *file, uchar_t * expbuf)
> >   					      "(fsize %ld)\n", i, j,
> >   					      statbuf.st_size);
> >   #endif /* LARGE_FILE */
> > +				free(readbuf);
> > +				close(fd);
> >   				return 0;
> 
> In both above cases it'll call anyfail() after checking fileokay()'s 
> return value.
> If it seems not obvious we can close 'fd' here and it'd be better to use 
> SAFE_CLOSE() macro from safe_macros.h.
There's no cleanup function for SAFE_CLOSE().
so,
close() is the same as SAFE_CLOSE(NULL, fd).

And close(fd) had been used at mmapstress01.c.
if i adopt SAFE_CLOSE(NULL, fd),
It looks a bit odd...

Thanks,
Wei
> 
> >   			}
> >   		}
> >   	}
> > +	free(readbuf);
> >   	close(fd);
> >   
> >   	return 1;
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
