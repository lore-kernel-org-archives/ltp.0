From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 3 Apr 2020 17:58:57 +0800
Subject: [LTP] Fw: LIBTIRPC Error
In-Reply-To: <5E870461.1010307@cn.fujitsu.com>
References: <MAXPR0101MB14688E4E7604C8BD9D17CB40EEC70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <MAXPR0101MB1468C63FD2BF7CD9AF9051E6EEC70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <5E870461.1010307@cn.fujitsu.com>
Message-ID: <5E8708E1.7020103@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/4/3 17:39, Xiao Yang wrote:
> On 2020/4/3 17:29, Pankaj Vinadrao Joshi wrote:
>> Hi,
>> As i already mentioned in previous mail, i already installed *pkg-config
>> libtirpc-dev libtirpc1 *but still**i am facing same.
> Hi,
>
> Could you do the following steps after installing these packages:
> 1) make maintainer-clean
> 2) make autotools
> 3) ./configure
> 3) make

Hi Pankaj,

Did it solve your problem?

Thanks,
Xiao Yang


