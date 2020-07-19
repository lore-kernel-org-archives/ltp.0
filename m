From: Jan Stancek <jstancek@redhat.com>
Date: Sun, 19 Jul 2020 13:26:58 -0400 (EDT)
Subject: [LTP] [PATCH] lapi/io_uring.h: Add declaration of __kernel_rwf_t
In-Reply-To: <20200717112919.GB56792@x230>
References: <1594959191-25155-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200717073842.GA31254@dell5510> <20200717080840.GB32407@dell5510>
 <1eac1ed9-66dd-5141-0bc2-cc05312704c8@cn.fujitsu.com>
 <20200717103816.GA28835@yuki.lan> <20200717112919.GB56792@x230>
Message-ID: <541528424.3620946.1595179618230.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> 
> > > Also, I think we should replace _u32 with uint32 in lapi/loop.h if we
> > > don't want to include linux kernel header for single use.
> 
> > The whole __bitwise is used only by a sparse checker, there is no point
> > to include it in LTP. So we can just typedef the __kernel_rwf_t to int.

+1

> Merged. Thanks both of you for your comments.

Thanks. Sorry for late/no response, I have some time off with limited access to email.

