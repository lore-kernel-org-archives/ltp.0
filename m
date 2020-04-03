From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Apr 2020 16:51:59 +0800
Subject: [LTP] LIBTIRPC Error
In-Reply-To: <MAXPR0101MB14688E4E7604C8BD9D17CB40EEC70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14688E4E7604C8BD9D17CB40EEC70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <5E86F92F.9080200@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/4/3 16:32, Pankaj Vinadrao Joshi wrote:
> Hi,
> I am trying to run ltp on 5.4.3 kernel with our custom yocto distro but
> i am facing following issue , i have installed
>
> pkg-config libtirpc-dev libtirpc1 but still the same error is getting
> encountered,can someone help us to solve it??
>
>
> .*/configure: line 6794: syntax error near unexpected token `LIBTIRPC,'
> **./configure: line 6794: ` PKG_CHECK_MODULES(LIBTIRPC, libtirpc >*
Hi,

It seems that pkg-config package(it provides pkg-config command) is not 
installed on your enviroment.

Thanks,
Xiao Yang
>
> Thanks!
>
>
>
>



