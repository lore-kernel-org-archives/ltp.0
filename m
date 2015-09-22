From: $rik@nth  <srikanth007m@gmail.com>
Date: Tue, 22 Sep 2015 17:49:19 +0530
Subject: [LTP] Fwd: About to cross compile LTP...
In-Reply-To: <CAO0kMxC-=Tc=TJg72sjVCD2e_R05gJTyMTSJjLx4NESyhbM-gQ@mail.gmail.com>
References: <CAO0kMxBSMF4fTMDSvzbQSsTnteSDoSE9ByCampY3AntKTe=62w@mail.gmail.com>
 <CAO0kMxC-=Tc=TJg72sjVCD2e_R05gJTyMTSJjLx4NESyhbM-gQ@mail.gmail.com>
Message-ID: <CANKSX+GtejYtqvzf8ys8KmNE2Bpc9n5qFqgC6mdBA6pwH_Uk+w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

You can cross compile LTP either in chroot environment or with ARM toolchain.

If it is with toolchain, then make sure you are setting them in the
environment before compiling.

configure AR=arm-linux-gnueabi-ar CC=arm-linux-gnueabi-gcc
RANLIB=arm-linux-gnueabi-gcc-ranlib-4.7 STRIP=arm-linux-gnueabi-strip
--host=arm-linux --target=arm-linux CFLAGS="-static" LDFLAGS="-static
-pthread"

On Tue, Sep 22, 2015 at 2:20 PM, kamal p <pkamalbhaskar@gmail.com> wrote:
>
>
> Hi,
>
>    I want to cross compile LTP test suite and test it on my target embedded
> linux system.can I compile like this?.If we can do please tell me the
> procedure ( i.e cross compilation tool & other components required) to
> accomplish these task.
>
> Regards,
> Kamal bhaskar.
>
>
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>



-- 
Thanks & Regards,
M.Srikanth Kumar.
