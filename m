From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2020 15:17:42 +0800
Subject: [LTP] [PATCH v6 2/2] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <20200216131723.GA2725117@x230>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207144105.19947-2-pvorel@suse.cz>
 <CAEemH2f0db1i7Tpg-4jqa5h5j9KZpH+d4aRg-M3Xn3Mw9NU1eA@mail.gmail.com>
 <20200216131723.GA2725117@x230>
Message-ID: <CAEemH2cqvBnUQPpQdER0QhPc2mka47SDHoMNDqB_0wwo_S-bgQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel <pvorel@suse.cz> wrote:

...
> > >  include/lapi/syscalls/powerpc64.in            |  4 +
> > Is there any reason why only add syscall num for ppc64?
> The other numbers are already there:
> 01e4dc222 lapi/syscalls: Add MIPS support
> c2f27f6e9 Add syscall numbers for new file-system related syscalls
>

[sorry, forget to mention in last email]

I have checked the powerpc64.in, the series syscall number already exists
there, so this patch also includes the redundant work for powerpc64 :).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200217/4c86c347/attachment.htm>
