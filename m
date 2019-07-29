From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 29 Jul 2019 16:13:15 +0200
Subject: [LTP] [can] 60649d4e0a: ltp.can_rcv_own_msgs.fail
In-Reply-To: <20190729094112.GM22106@shao2-debian>
References: <20190729094112.GM22106@shao2-debian>
Message-ID: <786568d6-bd24-327a-8367-319efbe2cccb@hartkopp.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Marc,

On 29/07/2019 11.41, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 60649d4e0af6c26b6c423dea9c57f39e823fc0c5 ("can: remove obsolete empty ioctl() handler")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master

the kernel test robot is right.

The patch ("can: remove obsolete empty ioctl() handler") leads to a 
return value of -EOPNOTSUPP instead of the former -ENOIOCTLCMD.

As we can see in socket.c ...

https://elixir.bootlin.com/linux/v5.3-rc2/source/net/socket.c#L1041

         /*
          * If this ioctl is unknown try to hand it down
          * to the NIC driver.
          */
         if (err != -ENOIOCTLCMD)
                 return err;

... we need to return -ENOIOCTLCMD to pass the SIOCGIFINDEX ioctl to the 
NIC layer.

Therefore the entire commit needs to be *reverted* to restore the 
required functionality.

> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>

Many thanks,
Oliver
