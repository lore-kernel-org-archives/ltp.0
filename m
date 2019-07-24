From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Jul 2019 10:38:38 +0200
Subject: [LTP] [PATCH] setdomainname: use strlen() to get length of
 string
In-Reply-To: <5D36E6F1.7090008@cn.fujitsu.com>
References: <20190723102826.9679-1-liwang@redhat.com>
 <5D36E6F1.7090008@cn.fujitsu.com>
Message-ID: <20190724083838.GA17437@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> On 2019/07/23 18:28, Li Wang wrote:
> > The sizeof(new) is only to get the size of char *, and it's not corret to pass
> > it as 'len' in setdomainname(). Here replace by strlen() to get the correct number
> > of characters for string.
> Hi Li,

> As setdomainname(2) manpage mentions, name does not require a terminating
> null byte.
> It looks good to me. :-)

> Best Regards,
> Xiao Yang
> > On x86_64, we get this failures if the LTP compilied in 32bit.

> >    -----Error Log-----
> >    setdomainname.h:24: INFO: Testing libc setdomainname()
> >    setdomainname01.c:24: FAIL: getdomainname() returned wrong domainname: 'test'
> >    setdomainname.h:27: INFO: Testing __NR_setdomainname syscall
> >    setdomainname01.c:24: FAIL: getdomainname() returned wrong domainname: 'test'
> >    -------------------

Thanks for fixing it and sorry for introducing obvious error.
Merged into master.

Kind regards,
Petr
