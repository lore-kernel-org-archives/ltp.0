Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NRysX-0007LR-2h
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 02:10:37 +0000
Received: from mail-yx0-f188.google.com ([209.85.210.188])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRysW-0001s5-Ak
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 02:10:37 +0000
Received: by yxe26 with SMTP id 26so15187547yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 18:10:31 -0800 (PST)
References: <4B41E55D.2020801@st.com>
Message-Id: <ECC1F2A4-FC8C-4626-904B-F29FB9CB209E@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4B41E55D.2020801@st.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Mon, 4 Jan 2010 18:10:10 -0800
Subject: Re: [LTP] mtest01: free memory allocated
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Jan 4, 2010, at 4:55 AM, Francesco RUNDO <francesco.rundo@st.com>  
wrote:

> Hi All,
>
> I'm running LTP (I'm using ltp-full-20090731....but asap I will  
> upgrade to latest)  on SH based platforms.
> Now, during a test-session. I've noted that the test "mtest01"  
> reduced drastically the system memory and after its execution this  
> memory wasn't de-allocated.
>
> I've analysed the mtest01.c code and I've noted that no "free()"  
> istruction was associated to the related malloc:
>
> ......
> if((mem = (char*)malloc(chunksize)) == NULL) {
> ......
>
> I've simply added a "free(mem)" of the allocated memory and the  
> issue was addressed successfully.
>
> I've attached the trivial patch I've developed.
>
> Best Regards,
> --
> Francesco
> Added missed "free" istruction to release memory previosuly allocated.
> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
> --- ltp-full-20090731/testcases/kernel/mem/mtest01/ 
> mtest01.c.origin    2009-02-26 13:02:27.000000000 +0100
> +++ ltp-full-20090731/testcases/kernel/mem/mtest01/mtest01.c     
> 2009-12-15 14:03:28.779240000 +0100
> @@ -258,5 +258,8 @@
>     else
>       tst_resm(TPASS, "%llu kbytes allocated only.",  
> original_maxbytes/1024);
>   }
> +
> +  free(mem);
> +
>   exit(0);
> }

1. Does the version off cvs still have this issue?
2. Unless the test exits the code block immediately, I'd definitely do:

if (mem)
     free (mem);

to avoid making a bad free call.

Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
